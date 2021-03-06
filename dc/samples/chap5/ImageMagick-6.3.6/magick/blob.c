/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%                         BBBB   L       OOO   BBBB                           %
%                         B   B  L      O   O  B   B                          %
%                         BBBB   L      O   O  BBBB                           %
%                         B   B  L      O   O  B   B                          %
%                         BBBB   LLLLL   OOO   BBBB                           %
%                                                                             %
%                                                                             %
%                    ImageMagick Binary Large OBjectS Methods                 %
%                                                                             %
%                              Software Design                                %
%                                John Cristy                                  %
%                                 July 1999                                   %
%                                                                             %
%                                                                             %
%  Copyright 1999-2007 ImageMagick Studio LLC, a non-profit organization      %
%  dedicated to making software imaging solutions freely available.           %
%                                                                             %
%  You may not use this file except in compliance with the License.  You may  %
%  obtain a copy of the License at                                            %
%                                                                             %
%    http://www.imagemagick.org/script/license.php                            %
%                                                                             %
%  Unless required by applicable law or agreed to in writing, software        %
%  distributed under the License is distributed on an "AS IS" BASIS,          %
%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   %
%  See the License for the specific language governing permissions and        %
%  limitations under the License.                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
*/

/*
  Include declarations.
*/
#include "magick/studio.h"
#include "magick/blob.h"
#include "magick/blob-private.h"
#include "magick/cache.h"
#include "magick/client.h"
#include "magick/constitute.h"
#include "magick/delegate.h"
#include "magick/exception.h"
#include "magick/exception-private.h"
#include "magick/image-private.h"
#include "magick/list.h"
#include "magick/log.h"
#include "magick/magick.h"
#include "magick/memory_.h"
#include "magick/resource_.h"
#include "magick/semaphore.h"
#include "magick/string_.h"
#include "magick/utility.h"
#if defined(HAVE_MMAP_FILEIO) && !defined(__WINDOWS__)
# include <sys/mman.h>
#endif
#if defined(HasZLIB)
#include "zlib.h"
#endif
#if defined(HasBZLIB)
#include "bzlib.h"
#endif

/*
  Define declarations.
*/
#if defined(HAVE_FSEEKO)
# define fseek  fseeko
# define ftell  ftello
#endif
#if !defined(MAP_ANONYMOUS) && defined(MAP_ANON)
# define MAP_ANONYMOUS  MAP_ANON
#endif
#if !defined(MAP_FAILED)
#define MAP_FAILED  ((void *) -1)
#endif
#if !defined(MS_SYNC)
#define MS_SYNC  0x04
#endif

/*
  Typedef declarations.
*/
typedef enum
{
  UndefinedStream,
  FileStream,
  StandardStream,
  PipeStream,
  ZipStream,
  BZipStream,
  FifoStream,
  BlobStream
} StreamType;

struct _BlobInfo
{
  size_t
    length,
    extent,
    quantum;

  MagickBooleanType
    mapped,
    eof;

  MagickOffsetType
    offset;

  MagickSizeType
    size;

  MagickBooleanType
    exempt,
    status,
    temporary;

  StreamType
    type;

  FILE
    *file;

  StreamHandler
    stream;

  unsigned char
    *data;

  MagickBooleanType
    debug;

  SemaphoreInfo
    *semaphore;

  long
    reference_count;

  unsigned long
    signature;
};

/*
  Forward declarations.
*/
static int
  SyncBlob(Image *);

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   A t t a c h B l o b                                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  AttachBlob() attaches a blob to the BlobInfo structure.
%
%  The format of the AttachBlob method is:
%
%      void AttachBlob(BlobInfo *blob_info,const void *blob,const size_t length)
%
%  A description of each parameter follows:
%
%    o blob_info: Specifies a pointer to a BlobInfo structure.
%
%    o blob: The address of a character stream in one of the image formats
%      understood by ImageMagick.
%
%    o length: This size_t integer reflects the length in bytes of the blob.
%
*/
MagickExport void AttachBlob(BlobInfo *blob_info,const void *blob,
  const size_t length)
{
  assert(blob_info != (BlobInfo *) NULL);
  if (blob_info->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"...");
  blob_info->length=length;
  blob_info->extent=length;
  blob_info->quantum=(size_t) MagickMaxBufferSize;
  blob_info->offset=0;
  blob_info->type=BlobStream;
  blob_info->file=(FILE *) NULL;
  blob_info->data=(unsigned char *) blob;
  blob_info->mapped=MagickFalse;
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   B l o b T o F i l e                                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  BlobToFile() writes a blob to a file.  It returns MagickFalse if an error
%  occurs otherwise MagickTrue.
%
%  The format of the BlobToFile method is:
%
%       MagickBooleanType BlobToFile(char *filename,const void *blob,
%        const size_t length,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o filename: Write the blob to this file.
%
%    o blob: The address of a blob.
%
%    o length: This length in bytes of the blob.
%
%    o exception: Return any errors or warnings in this structure.
%
*/

static inline size_t MagickMin(const size_t x,const size_t y)
{
  if (x < y)
    return(x);
  return(y);
}

MagickExport MagickBooleanType BlobToFile(char *filename,const void *blob,
  const size_t length,ExceptionInfo *exception)
{
  int
    file;

  register size_t
    i;

  ssize_t
    count;

  assert(filename != (const char *) NULL);
  (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",filename);
  assert(blob != (const void *) NULL);
  if (*filename == '\0')
    file=AcquireUniqueFileResource(filename);
  else
    file=open(filename,O_RDWR | O_CREAT | O_EXCL | O_BINARY,S_MODE);
  if (file == -1)
    {
      ThrowFileException(exception,BlobError,"UnableToWriteBlob",filename);
      return(MagickFalse);
    }
  for (i=0; i < length; i+=count)
  {
    count=(ssize_t) write(file,(const char *) blob+i,MagickMin(length-i,(size_t)
      SSIZE_MAX));
    if (count <= 0)
      {
        count=0;
        if (errno != EINTR)
          break;
      }
  }
  file=close(file)-1;
  if (i < length)
    {
      ThrowFileException(exception,BlobError,"UnableToWriteBlob",filename);
      return(MagickFalse);
    }
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   B l o b T o I m a g e                                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  BlobToImage() implements direct to memory image formats.  It returns the
%  blob as an image.
%
%  The format of the BlobToImage method is:
%
%      Image *BlobToImage(const ImageInfo *image_info,const void *blob,
%        const size_t length,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image_info: The image info.
%
%    o blob: The address of a character stream in one of the image formats
%      understood by ImageMagick.
%
%    o length: This size_t integer reflects the length in bytes of the blob.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport Image *BlobToImage(const ImageInfo *image_info,const void *blob,
  const size_t length,ExceptionInfo *exception)
{
  const MagickInfo
    *magick_info;

  Image
    *image;

  ImageInfo
    *blob_info;

  MagickBooleanType
    status;

  assert(image_info != (ImageInfo *) NULL);
  assert(image_info->signature == MagickSignature);
  if (image_info->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",
      image_info->filename);
  assert(exception != (ExceptionInfo *) NULL);
  if ((blob == (const void *) NULL) || (length == 0))
    {
      (void) ThrowMagickException(exception,GetMagickModule(),BlobError,
        "ZeroLengthBlobNotPermitted","`%s'",image_info->filename);
      return((Image *) NULL);
    }
  blob_info=CloneImageInfo(image_info);
  blob_info->blob=(void *) blob;
  blob_info->length=length;
  if (*blob_info->magick == '\0')
    (void) SetImageInfo(blob_info,MagickFalse,exception);
  magick_info=GetMagickInfo(blob_info->magick,exception);
  if (magick_info == (const MagickInfo *) NULL)
    {
      blob_info=DestroyImageInfo(blob_info);
      return((Image *) NULL);
    }
  if (GetMagickBlobSupport(magick_info) != MagickFalse)
    {
      /*
        Native blob support for this image format.
      */
      (void) CopyMagickString(blob_info->filename,image_info->filename,
        MaxTextExtent);
      (void) CopyMagickString(blob_info->magick,image_info->magick,
        MaxTextExtent);
      image=ReadImage(blob_info,exception);
      if (image != (Image *) NULL)
        (void) DetachBlob(image->blob);
      blob_info=DestroyImageInfo(blob_info);
      return(image);
    }
  /*
    Write blob to a temporary file on disk.
  */
  blob_info->blob=(void *) NULL;
  blob_info->length=0;
  *blob_info->filename='\0';
  status=BlobToFile(blob_info->filename,blob,length,exception);
  if (status == MagickFalse)
    {
      (void) RelinquishUniqueFileResource(blob_info->filename);
      blob_info=DestroyImageInfo(blob_info);
      return((Image *) NULL);
    }
  image=ReadImage(blob_info,exception);
  (void) RelinquishUniqueFileResource(blob_info->filename);
  blob_info=DestroyImageInfo(blob_info);
  return(image);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   C l o n e B l o b I n f o                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  CloneBlobInfo() makes a duplicate of the given blob info structure, or if
%  blob info is NULL, a new one.
%
%  The format of the CloneBlobInfo method is:
%
%      BlobInfo *CloneBlobInfo(const BlobInfo *blob_info)
%
%  A description of each parameter follows:
%
%    o blob_info: The blob info.
%
*/
MagickExport BlobInfo *CloneBlobInfo(const BlobInfo *blob_info)
{
  BlobInfo
    *clone_info;

  clone_info=(BlobInfo *) AcquireMagickMemory(sizeof(*clone_info));
  if (clone_info == (BlobInfo *) NULL)
    ThrowFatalException(ResourceLimitFatalError,"MemoryAllocationFailed");
  GetBlobInfo(clone_info);
  if (blob_info == (BlobInfo *) NULL)
    return(clone_info);
  clone_info->length=blob_info->length;
  clone_info->extent=blob_info->extent;
  clone_info->quantum=blob_info->quantum;
  clone_info->mapped=blob_info->mapped;
  clone_info->eof=blob_info->eof;
  clone_info->offset=blob_info->offset;
  clone_info->size=blob_info->size;
  clone_info->exempt=blob_info->exempt;
  clone_info->status=blob_info->status;
  clone_info->temporary=blob_info->temporary;
  clone_info->type=blob_info->type;
  clone_info->file=blob_info->file;
  clone_info->stream=blob_info->stream;
  clone_info->data=blob_info->data;
  clone_info->debug=IsEventLogging();
  clone_info->reference_count=1;
  clone_info->semaphore=(SemaphoreInfo *) NULL;
  return(clone_info);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   C l o s e B l o b                                                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  CloseBlob() closes a stream associated with the image.
%
%  The format of the CloseBlob method is:
%
%      void CloseBlob(Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport void CloseBlob(Image *image)
{
  int
    status;

  /*
    Close image file.
  */
  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(image->blob != (BlobInfo *) NULL);
  if (image->blob->type == UndefinedStream)
    return;
  (void) SyncBlob(image);
  image->blob->size=GetBlobSize(image);
  image->blob->eof=MagickFalse;
  if (image->blob->exempt != MagickFalse)
    return;
  status=0;
  switch (image->blob->type)
  {
    case UndefinedStream:
      break;
    case FileStream:
    case StandardStream:
    case PipeStream:
    {
      status=ferror(image->blob->file);
      break;
    }
    case ZipStream:
    {
#if defined(HasZLIB)
      (void) gzerror(image->blob->file,&status);
#endif
      break;
    }
    case BZipStream:
    {
#if defined(HasBZLIB)
      (void) BZ2_bzerror((BZFILE *) image->blob->file,&status);
#endif
      break;
    }
    case FifoStream:
    case BlobStream:
      break;
  }
  image->blob->status=status < 0 ? MagickTrue : MagickFalse;
  switch (image->blob->type)
  {
    case UndefinedStream:
      break;
    case FileStream:
    case StandardStream:
    {
      status=fclose(image->blob->file);
      break;
    }
    case PipeStream:
    {
#if defined(HAVE_POPEN)
      status=pclose(image->blob->file);
#endif
      break;
    }
    case ZipStream:
    {
#if defined(HasZLIB)
      status=gzclose(image->blob->file);
#endif
      break;
    }
    case BZipStream:
    {
#if defined(HasBZLIB)
      BZ2_bzclose((BZFILE *) image->blob->file);
#endif
      break;
    }
    case FifoStream:
    case BlobStream:
      break;
  }
  (void) DetachBlob(image->blob);
  image->blob->status=status < 0  ? MagickTrue : MagickFalse;
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   D e s t r o y B l o b                                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  DestroyBlob() deallocates memory associated with a blob.
%
%  The format of the DestroyBlob method is:
%
%      void DestroyBlob(Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport void DestroyBlob(Image *image)
{
  MagickBooleanType
    destroy;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  destroy=MagickFalse;
  AcquireSemaphoreInfo(&image->blob->semaphore);
  image->blob->reference_count--;
  if (image->blob->reference_count == 0)
    destroy=MagickTrue;
  RelinquishSemaphoreInfo(image->blob->semaphore);
  if (destroy == MagickFalse)
    return;
  CloseBlob(image);
  if (image->blob->mapped != MagickFalse)
    (void) UnmapBlob(image->blob->data,image->blob->length);
  if (image->blob->semaphore != (SemaphoreInfo *) NULL)
    image->blob->semaphore=DestroySemaphoreInfo(image->blob->semaphore);
  image->blob->signature=(~MagickSignature);
  image->blob=(BlobInfo *) RelinquishMagickMemory(image->blob);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   D e t a c h B l o b                                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  DetachBlob() detaches a blob from the BlobInfo structure.
%
%  The format of the DetachBlob method is:
%
%      unsigned char *DetachBlob(BlobInfo *blob_info)
%
%  A description of each parameter follows:
%
%    o blob_info: Specifies a pointer to a BlobInfo structure.
%
*/
MagickExport unsigned char *DetachBlob(BlobInfo *blob_info)
{
  unsigned char
    *data;

  assert(blob_info != (BlobInfo *) NULL);
  if (blob_info->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"...");
  if (blob_info->mapped != MagickFalse)
    (void) UnmapBlob(blob_info->data,blob_info->length);
  blob_info->mapped=MagickFalse;
  blob_info->length=0;
  blob_info->offset=0;
  blob_info->eof=MagickFalse;
  blob_info->exempt=MagickFalse;
  blob_info->type=UndefinedStream;
  blob_info->file=(FILE *) NULL;
  data=blob_info->data;
  blob_info->data=(unsigned char *) NULL;
  blob_info->stream=(StreamHandler) NULL;
  return(data);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  E O F B l o b                                                              %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  EOFBlob() returns a non-zero value when EOF has been detected reading from
%  a blob or file.
%
%  The format of the EOFBlob method is:
%
%      int EOFBlob(const Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport int EOFBlob(const Image *image)
{
  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"...");
  assert(image->blob != (BlobInfo *) NULL);
  assert(image->blob->type != UndefinedStream);
  switch (image->blob->type)
  {
    case UndefinedStream:
      break;
    case FileStream:
    case StandardStream:
    case PipeStream:
    {
      image->blob->eof=feof(image->blob->file) != 0 ? MagickTrue : MagickFalse;
      break;
    }
    case ZipStream:
    {
      image->blob->eof=MagickFalse;
      break;
    }
    case BZipStream:
    {
#if defined(HasBZLIB)
      int
        status;

      status=0;
      (void) BZ2_bzerror((BZFILE *) image->blob->file,&status);
      image->blob->eof=status == BZ_UNEXPECTED_EOF ? MagickTrue : MagickFalse;
#endif
      break;
    }
    case FifoStream:
    {
      image->blob->eof=MagickFalse;
      break;
    }
    case BlobStream:
      break;
  }
  return((int) image->blob->eof);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   F i l e T o B l o b                                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  FileToBlob() returns the contents of a file as a blob.  It returns the
%  file as a blob and its length.  If an error occurs, NULL is returned.
%
%  The format of the FileToBlob method is:
%
%      unsigned char *FileToBlob(const char *filename,const size_t extent,
%        size_t *length,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o blob:  FileToBlob() returns the contents of a file as a blob.  If
%      an error occurs NULL is returned.
%
%    o filename: The filename.
%
%    o extent:  The maximum length of the blob.
%
%    o length: On return, this reflects the actual length of the blob.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport unsigned char *FileToBlob(const char *filename,const size_t extent,
  size_t *length,ExceptionInfo *exception)
{
  int
    file;

  MagickOffsetType
    offset;

  register size_t
    i;

  ssize_t
    count;

  unsigned char
    *blob;

  void
    *map;

  assert(filename != (const char *) NULL);
  (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",filename);
  assert(exception != (ExceptionInfo *) NULL);
  *length=0;
  file=fileno(stdin);
  if (LocaleCompare(filename,"-") != 0)
    file=open(filename,O_RDONLY | O_BINARY);
  if (file == -1)
    {
      ThrowFileException(exception,BlobError,"UnableToOpenFile",filename);
      return((unsigned char *) NULL);
    }
  offset=(MagickOffsetType) MagickSeek(file,0,SEEK_END);
  count=0;
  if ((offset < 0) || (offset != (MagickOffsetType) ((ssize_t) offset)))
    {
      size_t
        quantum;

      struct stat
        file_info;

      /*
        Stream is not seekable.
      */
      quantum=(size_t) MagickMaxBufferSize;
      if ((fstat(file,&file_info) == 0) && (file_info.st_size != 0))
        quantum=MagickMin((size_t) file_info.st_size,MagickMaxBufferSize);
      blob=(unsigned char *) AcquireQuantumMemory(quantum,sizeof(*blob));
      for (i=0; blob != (unsigned char *) NULL; i+=count)
      {
        count=(ssize_t) read(file,blob+i,quantum);
        if (count <= 0)
          {
            count=0;
            if (errno != EINTR)
              break;
          }
        if (~(1UL*i) < (quantum+1))
          {
            blob=(unsigned char *) RelinquishMagickMemory(blob);
            break;
          }
        blob=(unsigned char *) ResizeQuantumMemory(blob,i+quantum+1,
          sizeof(*blob));
        if ((size_t) (i+count) >= extent)
          break;
      }
      file=close(file)-1;
      if (blob == (unsigned char *) NULL)
        {
          (void) ThrowMagickException(exception,GetMagickModule(),
            ResourceLimitError,"MemoryAllocationFailed","`%s'",filename);
          return((unsigned char *) NULL);
        }
      *length=MagickMin(i+count,extent);
      blob[*length]='\0';
      return(blob);
    }
  *length=MagickMin((size_t) offset,extent);
  blob=(unsigned char *) NULL;
  if (~(*length) >= MaxTextExtent)
    blob=(unsigned char *) AcquireQuantumMemory(*length+MaxTextExtent,
      sizeof(*blob));
  if (blob == (unsigned char *) NULL)
    {
      file=close(file)-1;
      (void) ThrowMagickException(exception,GetMagickModule(),
        ResourceLimitError,"MemoryAllocationFailed","`%s'",filename);
      return((unsigned char *) NULL);
    }
  map=MapBlob(file,ReadMode,0,*length);
  if (map != (unsigned char *) NULL)
    {
      (void) CopyMagickMemory(blob,map,*length);
      (void) UnmapBlob(map,*length);
    }
  else
    {
      (void) MagickSeek(file,0,SEEK_SET);
      for (i=0; i < *length; i+=count)
      {
        count=(ssize_t) read(file,blob+i,MagickMin(*length-i,(size_t)
          SSIZE_MAX));
        if (count <= 0)
          {
            count=0;
            if (errno != EINTR)
              break;
          }
      }
      if (i < *length)
        {
          file=close(file)-1;
          blob=(unsigned char *) RelinquishMagickMemory(blob);
          ThrowFileException(exception,BlobError,"UnableToReadBlob",filename);
          return((unsigned char *) NULL);
        }
    }
  file=close(file)-1;
  blob[*length]='\0';
  return(blob);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   F i l e T o I m a g e                                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  FileToImage() write the contents of a file to an image.
%
%  The format of the FileToImage method is:
%
%      MagickBooleanType FileToImage(Image *,const char *filename)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o filename: The filename.
%
*/

static inline ssize_t WriteBlobStream(Image *image,const size_t length,
  const unsigned char *data)
{
  register unsigned char
    *q;

  assert(image->blob != (BlobInfo *) NULL);
  if (image->blob->type != BlobStream)
    return(WriteBlob(image,length,data));
  assert(image->blob->type != UndefinedStream);
  assert(data != (void *) NULL);
  if ((image->blob->offset+(MagickOffsetType) length) >=
      (MagickOffsetType) image->blob->extent)
    {
      if (image->blob->mapped != MagickFalse)
        return(0);
      image->blob->quantum<<=1;
      image->blob->extent+=length+image->blob->quantum;
      image->blob->data=(unsigned char *) ResizeQuantumMemory(image->blob->data,
        image->blob->extent+1,sizeof(*image->blob->data));
      (void) SyncBlob(image);
      if (image->blob->data == (unsigned char *) NULL)
        {
          (void) DetachBlob(image->blob);
          return(0);
        }
    }
  q=image->blob->data+image->blob->offset;
  switch (length)
  {
    default:
    {
      (void) CopyMagickMemory(q,data,length);
      break;
    }
    case 7: *q++=(*data++);
    case 6: *q++=(*data++);
    case 5: *q++=(*data++);
    case 4: *q++=(*data++);
    case 3: *q++=(*data++);
    case 2: *q++=(*data++);
    case 1: *q++=(*data++);
    case 0: break;
  }
  image->blob->offset+=length;
  if (image->blob->offset >= (MagickOffsetType) image->blob->length)
    image->blob->length=(size_t) image->blob->offset;
  return((ssize_t) length);
}

MagickExport MagickBooleanType FileToImage(Image *image,const char *filename)
{
  int
    file;
    
  size_t
    length,
    quantum;

  ssize_t
    count;

  struct stat
    file_info;

  unsigned char
    *blob;

  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  assert(filename != (const char *) NULL);
  (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",filename);
  file=open(filename,O_RDONLY | O_BINARY);
  if (file == -1)
    {
      ThrowFileException(&image->exception,BlobError,"UnableToOpenBlob",
        filename);
      return(MagickFalse);
    }
  quantum=(size_t) MagickMaxBufferSize;
  if ((fstat(file,&file_info) == 0) && (file_info.st_size != 0))
    quantum=MagickMin((size_t) file_info.st_size,MagickMaxBufferSize);
  blob=(unsigned char *) AcquireQuantumMemory(quantum,sizeof(*blob));
  if (blob == (unsigned char *) NULL)
    {
      ThrowFileException(&image->exception,ResourceLimitError,
        "MemoryAllocationFailed",filename);
      return(MagickFalse);
    }
  for ( ; ; )
  {
    count=(ssize_t) read(file,blob,quantum);
    if (count <= 0)
      {
        count=0;
        if (errno != EINTR)
          break;
      }
    length=(size_t) count;
    count=WriteBlobStream(image,length,blob);
    if (count != (ssize_t) length)
      {
        ThrowFileException(&image->exception,BlobError,"UnableToWriteBlob",
          filename);
        break;
      }
  }
  file=close(file)-1;
  blob=(unsigned char *) RelinquishMagickMemory(blob);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   G e t B l o b E r r o r                                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetBlobError() returns MagickTrue if the blob associated with the specified
%  image encountered an error.
%
%  The format of the GetBlobError method is:
%
%       MagickBooleanType GetBlobError(const Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport MagickBooleanType GetBlobError(const Image *image)
{
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  return(image->blob->status);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   G e t B l o b F i l e H a n d l e                                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetBlobFileHandle() returns the file handle associated with the image blob.
%
%  The format of the GetBlobFile method is:
%
%      FILE *GetBlobFileHandle(const Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport FILE *GetBlobFileHandle(const Image *image)
{
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  return(image->blob->file);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   G e t B l o b I n f o                                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetBlobInfo() initializes the BlobInfo structure.
%
%  The format of the GetBlobInfo method is:
%
%      void GetBlobInfo(BlobInfo *blob_info)
%
%  A description of each parameter follows:
%
%    o blob_info: Specifies a pointer to a BlobInfo structure.
%
*/
MagickExport void GetBlobInfo(BlobInfo *blob_info)
{
  assert(blob_info != (BlobInfo *) NULL);
  (void) ResetMagickMemory(blob_info,0,sizeof(*blob_info));
  blob_info->type=UndefinedStream;
  blob_info->quantum=(size_t) MagickMaxBufferSize;
  blob_info->debug=IsEventLogging();
  blob_info->reference_count=1;
  blob_info->signature=MagickSignature;
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  G e t B l o b S i z e                                                      %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetBlobSize() returns the current length of the image file or blob; zero is
%  returned if the size cannot be determined.
%
%  The format of the GetBlobSize method is:
%
%      MagickSizeType GetBlobSize(const Image *image)
%
%  A description of each parameter follows:
%
%    o size:  Method GetBlobSize returns the current length of the image file
%      or blob.
%
%    o image: The image.
%
*/
MagickExport MagickSizeType GetBlobSize(const Image *image)
{
  MagickSizeType
    length;

  struct stat
    file_info;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(image->blob != (BlobInfo *) NULL);
  length=0;
  switch (image->blob->type)
  {
    case UndefinedStream:
    {
      length=image->blob->size;
      break;
    }
    case FileStream:
    {
      if (fstat(fileno(image->blob->file),&file_info) == 0)
        length=(MagickSizeType) file_info.st_size;
      break;
    }
    case StandardStream:
    case PipeStream:
      break;
    case ZipStream:
    {
#if defined(HasZLIB)
      if (stat(image->filename,&file_info) == 0)
        length=(MagickSizeType) file_info.st_size;
#endif
      break;
    }
    case BZipStream:
    {
#if defined(HasBZLIB)
      if (stat(image->filename,&file_info) == 0)
        length=(MagickSizeType) file_info.st_size;
#endif
      break;
    }
    case FifoStream:
      break;
    case BlobStream:
    {
      length=(MagickSizeType) image->blob->length;
      break;
    }
  }
  return(length);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   G e t B l o b S t r e a m D a t a                                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetBlobStreamData() returns the stream data for the image.
%
%  The format of the GetBlobStreamData method is:
%
%      unsigned char *GetBlobStreamData(const Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport unsigned char *GetBlobStreamData(const Image *image)
{
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  return(image->blob->data);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   G e t B l o b S t r e a m H a n d l e r                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetBlobStreamHandler() returns the stream handler for the image.
%
%  The format of the GetBlobStreamHandler method is:
%
%      StreamHandler GetBlobStreamHandler(const Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport StreamHandler GetBlobStreamHandler(const Image *image)
{
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  return(image->blob->stream);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   I m a g e T o B l o b                                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ImageToBlob() implements direct to memory image formats.  It returns the
%  image as a blob and its length.  The magick member of the ImageInfo structure
%  determines the format of the returned blob (GIF, JPEG,  PNG, etc.)
%
%  The format of the ImageToBlob method is:
%
%      unsigned char *ImageToBlob(const ImageInfo *image_info,Image *image,
%        size_t *length,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image_info: The image info.
%
%    o image: The image.
%
%    o length: This pointer to a size_t integer sets the initial length of the
%      blob.  On return, it reflects the actual length of the blob.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport unsigned char *ImageToBlob(const ImageInfo *image_info,
  Image *image,size_t *length,ExceptionInfo *exception)
{
  const MagickInfo
    *magick_info;

  ImageInfo
    *blob_info;

  MagickBooleanType
    status;

  unsigned char
    *blob;

  assert(image_info != (const ImageInfo *) NULL);
  assert(image_info->signature == MagickSignature);
  if (image_info->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",
      image_info->filename);
  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  assert(exception != (ExceptionInfo *) NULL);
  *length=0;
  blob=(unsigned char *) NULL;
  blob_info=CloneImageInfo(image_info);
  blob_info->adjoin=MagickFalse;
  (void) SetImageInfo(blob_info,MagickTrue,exception);
  if (*blob_info->magick != '\0')
    (void) CopyMagickString(image->magick,blob_info->magick,MaxTextExtent);
  magick_info=GetMagickInfo(image->magick,exception);
  if (magick_info == (const MagickInfo *) NULL)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),
        MissingDelegateError,"NoDecodeDelegateForThisImageFormat","`%s'",
        image->filename);
      return(blob);
    }
  (void) CopyMagickString(blob_info->magick,image->magick,MaxTextExtent);
  if (GetMagickBlobSupport(magick_info) != MagickFalse)
    {
      /*
        Native blob support for this image format.
      */
      blob_info->length=0;
      blob_info->blob=(void *) AcquireQuantumMemory(MagickMaxBufferSize,
        sizeof(unsigned char));
      if (blob_info->blob == (void *) NULL)
        (void) ThrowMagickException(exception,GetMagickModule(),
          ResourceLimitError,"MemoryAllocationFailed","`%s'",image->filename);
      else
        {
          image->blob->exempt=MagickTrue;
          *image->filename='\0';
          status=WriteImage(blob_info,image);
          if ((status == MagickFalse) || (image->blob->length == 0))
            {
              blob_info->blob=(void *) RelinquishMagickMemory(blob_info->blob);
              InheritException(exception,&image->exception);
            }
          else
            {
              image->blob->data=(unsigned char *) ResizeQuantumMemory(
                image->blob->data,image->blob->length,
                sizeof(*image->blob->data));
              blob=image->blob->data;
              *length=image->blob->length;
              (void) DetachBlob(image->blob);
            }
        }
    }
  else
    {
      char
        unique[MaxTextExtent];

      int
        file;

      /*
        Write file to disk in blob image format.
      */
      file=AcquireUniqueFileResource(unique);
      if (file == -1)
        {
          ThrowFileException(exception,BlobError,"UnableToWriteBlob",
            image_info->filename);
        }
      else
        {
          blob_info->file=fdopen(file,"wb");
          (void) FormatMagickString(image->filename,MaxTextExtent,"%s:%s",
            image->magick,unique);
          status=WriteImage(blob_info,image);
          if (status == MagickFalse)
            InheritException(exception,&image->exception);
          else
            blob=FileToBlob(image->filename,~0UL,length,exception);
          (void) RelinquishUniqueFileResource(unique);
        }
    }
  blob_info=DestroyImageInfo(blob_info);
  return(blob);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   I m a g e T o F i l e                                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ImageToFile() writes an image to a file.  It returns MagickFalse if an error
%  occurs otherwise MagickTrue.
%
%  The format of the ImageToFile method is:
%
%       MagickBooleanType ImageToFile(Image *image,char *filename,
%        ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o filename: Write the image to this file.
%
%    o exception: Return any errors or warnings in this structure.
%
*/

static inline const unsigned char *ReadBlobStream(Image *image,
  const size_t length,unsigned char *data,ssize_t *count)
{
  assert(count != (ssize_t *) NULL);
  assert(image->blob != (BlobInfo *) NULL);
  if (image->blob->type != BlobStream)
    {
      *count=ReadBlob(image,length,data);
      return(data);
    }
  if (image->blob->offset >= (MagickOffsetType) image->blob->length)
    {
      *count=0;
      image->blob->eof=MagickTrue;
      return(data);
    }
  data=image->blob->data+image->blob->offset;
  *count=(ssize_t) MagickMin(length,(size_t) (image->blob->length-
    image->blob->offset));
  image->blob->offset+=(*count);
  if (*count != (ssize_t) length)
    image->blob->eof=MagickTrue;
  return(data);
}

MagickExport MagickBooleanType ImageToFile(Image *image,char *filename,
  ExceptionInfo *exception)
{
  int
    file;

  register const unsigned char
    *p;

  register size_t
    i;

  size_t
    length,
    quantum;

  ssize_t
    count;

  struct stat
    file_info;

  unsigned char
    *buffer;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  assert(image->blob != (BlobInfo *) NULL);
  assert(image->blob->type != UndefinedStream);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",filename);
  assert(filename != (const char *) NULL);
  if (*filename == '\0')
    file=AcquireUniqueFileResource(filename);
  else
    if (LocaleCompare(filename,"-") == 0)
      file=fileno(stdout);
    else
      file=open(filename,O_RDWR | O_CREAT | O_EXCL | O_BINARY,S_MODE);
  if (file == -1)
    {
      ThrowFileException(exception,BlobError,"UnableToWriteBlob",filename);
      return(MagickFalse);
    }
  quantum=(size_t) MagickMaxBufferSize;
  if ((fstat(file,&file_info) == 0) && (file_info.st_size != 0))
    quantum=MagickMin((size_t) file_info.st_size,MagickMaxBufferSize);
  buffer=(unsigned char *) AcquireQuantumMemory(quantum,sizeof(*buffer));
  if (buffer == (unsigned char *) NULL)
    {
      file=close(file)-1;
      (void) ThrowMagickException(exception,GetMagickModule(),
        ResourceLimitError,"MemoryAllocationError","`%s'",filename);
      return(MagickFalse);
    }
  length=0;
  p=ReadBlobStream(image,quantum,buffer,&count);
  for (i=0; count > 0; p=ReadBlobStream(image,quantum,buffer,&count))
  {
    length=(size_t) count;
    for (i=0; i < length; i+=count)
    {
      count=write(file,p+i,(size_t) (length-i));
      if (count <= 0)
        {
          count=0;
          if (errno != EINTR)
            break;
        }
    }
    if (i < length)
      break;
  }
  file=close(file)-1;
  buffer=(unsigned char *) RelinquishMagickMemory(buffer);
  if (i < length)
    {
      ThrowFileException(exception,BlobError,"UnableToWriteBlob",filename);
      return(MagickFalse);
    }
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   I m a g e s T o B l o b                                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ImagesToBlob() implements direct to memory image formats.  It returns the
%  image sequence as a blob and its length.  The magick member of the ImageInfo
%  structure determines the format of the returned blob (GIF, JPEG,  PNG, etc.)
%
%  Note, some image formats do not permit multiple images to the same image
%  stream (e.g. JPEG).  in this instance, just the first image of the
%  sequence is returned as a blob.
%
%  The format of the ImagesToBlob method is:
%
%      unsigned char *ImagesToBlob(const ImageInfo *image_info,Image *images,
%        size_t *length,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image_info: The image info.
%
%    o images: The image list.
%
%    o length: This pointer to a size_t integer sets the initial length of the
%      blob.  On return, it reflects the actual length of the blob.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport unsigned char *ImagesToBlob(const ImageInfo *image_info,
  Image *images,size_t *length,ExceptionInfo *exception)
{
  const MagickInfo
    *magick_info;

  ImageInfo
    *blob_info;

  MagickBooleanType
    status;

  unsigned char
    *blob;

  assert(image_info != (const ImageInfo *) NULL);
  assert(image_info->signature == MagickSignature);
  if (image_info->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",
      image_info->filename);
  assert(images != (Image *) NULL);
  assert(images->signature == MagickSignature);
  assert(exception != (ExceptionInfo *) NULL);
  *length=0;
  blob=(unsigned char *) NULL;
  blob_info=CloneImageInfo(image_info);
  (void) SetImageInfo(blob_info,MagickTrue,exception);
  if (*blob_info->magick != '\0')
    (void) CopyMagickString(images->magick,blob_info->magick,MaxTextExtent);
  if (blob_info->adjoin == MagickFalse)
    {
      blob_info=DestroyImageInfo(blob_info);
      return(ImageToBlob(image_info,images,length,exception));
    }
  magick_info=GetMagickInfo(images->magick,exception);
  if (magick_info == (const MagickInfo *) NULL)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),
        MissingDelegateError,"NoDecodeDelegateForThisImageFormat","`%s'",
        images->filename);
      return(blob);
    }
  (void) CopyMagickString(blob_info->magick,images->magick,MaxTextExtent);
  if (GetMagickBlobSupport(magick_info) != MagickFalse)
    {
      /*
        Native blob support for this images format.
      */
      blob_info->length=0;
      blob_info->blob=(void *) AcquireQuantumMemory(MagickMaxBufferSize,
        sizeof(unsigned char));
      if (blob_info->blob == (void *) NULL)
        (void) ThrowMagickException(exception,GetMagickModule(),
          ResourceLimitError,"MemoryAllocationFailed","`%s'",images->filename);
      else
        {
          images->blob->exempt=MagickTrue;
          *images->filename='\0';
          status=WriteImages(blob_info,images,images->filename,exception);
          if ((status == MagickFalse) || (images->blob->length == 0))
            InheritException(exception,&images->exception);
          else
            {
              images->blob->data=(unsigned char *) ResizeQuantumMemory(
                images->blob->data,images->blob->length,
                sizeof(*images->blob->data));
              blob=images->blob->data;
              *length=images->blob->length;
              (void) DetachBlob(images->blob);
            }
        }
    }
  else
    {
      char
        filename[MaxTextExtent],
        unique[MaxTextExtent];

      int
        file;

      /*
        Write file to disk in blob images format.
      */
      file=AcquireUniqueFileResource(unique);
      if (file == -1)
        {
          ThrowFileException(exception,FileOpenError,"UnableToWriteBlob",
            image_info->filename);
        }
      else
        {
          blob_info->file=fdopen(file,"wb");
          (void) FormatMagickString(filename,MaxTextExtent,"%s:%s",
            images->magick,unique);
          status=WriteImages(blob_info,images,filename,exception);
          if (status == MagickFalse)
            InheritException(exception,&images->exception);
          else
            blob=FileToBlob(images->filename,~0UL,length,exception);
          (void) RelinquishUniqueFileResource(unique);
        }
    }
  blob_info=DestroyImageInfo(blob_info);
  return(blob);
}
/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   I n j e c t I m a g e B l o b                                             %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  InjectImageBlob() injects the image with a copy of itself in the specified
%  format (e.g. inject JPEG into a PDF image).
%
%  The format of the InjectImageBlob method is:
%
%      MagickBooleanType InjectImageBlob(const ImageInfo *image_info,
%        Image *image,const char *format)
%
%  A description of each parameter follows:
%
%    o image_info: The image info..
%
%    o image: The image.
%
%    o format: The image format.
%
*/
MagickExport MagickBooleanType InjectImageBlob(const ImageInfo *image_info,
  Image *image,const char *format)
{
  char
    filename[MaxTextExtent];

  FILE
    *unique_file;

  Image
    *inject_image;

  ImageInfo
    *write_info;

  int
    file;

  MagickBooleanType
    status;

  register long
    i;

  size_t
    quantum;

  ssize_t
    count;

  struct stat
    file_info;

  unsigned char
    *buffer;

  /*
    Write image as JPEG to a temporary file.
  */
  assert(image_info != (ImageInfo *) NULL);
  assert(image_info->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  unique_file=(FILE *) NULL;
  file=AcquireUniqueFileResource(filename);
  if (file != -1)
    unique_file=fdopen(file,"wb");
  if ((file == -1) || (unique_file == (FILE *) NULL))
    {
      (void) CopyMagickString(image->filename,filename,MaxTextExtent);
      ThrowFileException(&image->exception,FileOpenError,
        "UnableToCreateTemporaryFile",image->filename);
      return(MagickFalse);
    }
  inject_image=CloneImage(image,0,0,MagickTrue,&image->exception);
  if (inject_image == (Image *) NULL)
    {
      (void) fclose(unique_file);
      (void) RelinquishUniqueFileResource(filename);
      return(MagickFalse);
    }
  (void) FormatMagickString(inject_image->filename,MaxTextExtent,"%s:%s",format,
    filename);
  DestroyBlob(inject_image);
  inject_image->blob=CloneBlobInfo((BlobInfo *) NULL);
  write_info=CloneImageInfo(image_info);
  SetImageInfoFile(write_info,unique_file);
  status=WriteImage(write_info,inject_image);
  write_info=DestroyImageInfo(write_info);
  inject_image=DestroyImage(inject_image);
  (void) fclose(unique_file);
  if (status == MagickFalse)
    {
      (void) RelinquishUniqueFileResource(filename);
      return(MagickFalse);
    }
  /*
    Inject into image stream.
  */
  file=open(filename,O_RDONLY | O_BINARY);
  if (file == -1)
    {
      (void) RelinquishUniqueFileResource(filename);
      ThrowFileException(&image->exception,FileOpenError,"UnableToOpenFile",
        image_info->filename);
      return(MagickFalse);
    }
  quantum=(size_t) MagickMaxBufferSize;
  if ((fstat(file,&file_info) == 0) && (file_info.st_size != 0))
    quantum=MagickMin((size_t) file_info.st_size,MagickMaxBufferSize);
  buffer=(unsigned char *) AcquireQuantumMemory(quantum,sizeof(*buffer));
  if (buffer == (unsigned char *) NULL)
    {
      (void) RelinquishUniqueFileResource(filename);
      ThrowBinaryException(ResourceLimitError,"MemoryAllocationFailed",
        image->filename);
    }
  for (i=0; ; i+=count)
  {
    count=(ssize_t) read(file,buffer,quantum);
    if (count <= 0)
      {
        count=0;
        if (errno != EINTR)
          break;
      }
    status=WriteBlobStream(image,(size_t) count,buffer) == count ? MagickTrue :
      MagickFalse;
  }
  file=close(file)-1;
  (void) RelinquishUniqueFileResource(filename);
  buffer=(unsigned char *) RelinquishMagickMemory(buffer);
  return(status);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   I s B l o b E x e m p t                                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  IsBlobExempt() returns true if the blob is exempt.
%
%  The format of the IsBlobExempt method is:
%
%       MagickBooleanType IsBlobExempt(const Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport MagickBooleanType IsBlobExempt(const Image *image)
{
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  return(image->blob->exempt);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   I s B l o b S e e k a b l e                                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  IsBlobSeekable() returns true if the blob is seekable.
%
%  The format of the IsBlobSeekable method is:
%
%       MagickBooleanType IsBlobSeekable(const Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport MagickBooleanType IsBlobSeekable(const Image *image)
{
  MagickBooleanType
    seekable;

  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  seekable=(image->blob->type == FileStream) ||
    (image->blob->type == BlobStream) ? MagickTrue : MagickFalse;
  return(seekable);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   I s B l o b T e m p o r a r y                                             %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  IsBlobTemporary() returns true if the blob is temporary.
%
%  The format of the IsBlobTemporary method is:
%
%       MagickBooleanType IsBlobTemporary(const Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport MagickBooleanType IsBlobTemporary(const Image *image)
{
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  return(image->blob->temporary);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  M a p B l o b                                                              %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MapBlob() creates a mapping from a file to a binary large object.
%
%  The format of the MapBlob method is:
%
%      unsigned char *MapBlob(int file,const MapMode mode,
%        const MagickOffsetType offset,const size_t length)
%
%  A description of each parameter follows:
%
%    o file: map this file descriptor.
%
%    o mode: ReadMode, WriteMode, or IOMode.
%
%    o offset: starting at this offset within the file.
%
%    o length: the length of the mapping is returned in this pointer.
%
*/
MagickExport unsigned char *MapBlob(int file,const MapMode mode,
  const MagickOffsetType offset,const size_t length)
{
#if defined(HAVE_MMAP_FILEIO)
  int
    flags,
    protection;

  unsigned char
    *map;

  /*
    Map file.
  */
  flags=0;
  if (file == -1)
#if defined(MAP_ANONYMOUS)
    flags|=MAP_ANONYMOUS;
#else
    return((unsigned char *) NULL);
#endif
  switch (mode)
  {
    case ReadMode:
    default:
    {
      protection=PROT_READ;
      flags|=MAP_PRIVATE;
      map=(unsigned char *) mmap((char *) NULL,length,protection,flags,file,
        (off_t) offset);
      break;
    }
    case WriteMode:
    {
      protection=PROT_WRITE;
      flags|=MAP_SHARED;
      map=(unsigned char *) mmap((char *) NULL,length,protection,flags,file,
        (off_t) offset);
      break;
    }
    case IOMode:
    {
      protection=PROT_READ | PROT_WRITE;
      flags|=MAP_SHARED;
      map=(unsigned char *) mmap((char *) NULL,length,protection,flags,file,
        (off_t) offset);
      break;
    }
  }
  if (map == (unsigned char *) MAP_FAILED)
    return((unsigned char *) NULL);
  return(map);
#else
  return((unsigned char *) NULL);
#endif
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  M S B O r d e r L o n g                                                    %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MSBOrderLong() converts a least-significant byte first buffer of integers to
%  most-significant byte first.
%
%  The format of the MSBOrderLong method is:
%
%      void MSBOrderLong(unsigned char *buffer,const size_t length)
%
%  A description of each parameter follows.
%
%   o  buffer:  Specifies a pointer to a buffer of integers.
%
%   o  length:  Specifies the length of the buffer.
%
*/
MagickExport void MSBOrderLong(unsigned char *buffer,const size_t length)
{
  int
    c;

  register unsigned char
    *p,
    *q;

  assert(buffer != (unsigned char *) NULL);
  q=buffer+length;
  while (buffer < q)
  {
    p=buffer+3;
    c=(int) (*p);
    *p=(*buffer);
    *buffer++=(unsigned char) c;
    p=buffer+1;
    c=(int) (*p);
    *p=(*buffer);
    *buffer++=(unsigned char) c;
    buffer+=2;
  }
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  M S B O r d e r S h o r t                                                  %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MSBOrderShort() converts a least-significant byte first buffer of integers
%  to most-significant byte first.
%
%  The format of the MSBOrderShort method is:
%
%      void MSBOrderShort(unsigned char *p,const size_t length)
%
%  A description of each parameter follows.
%
%   o  p:  Specifies a pointer to a buffer of integers.
%
%   o  length:  Specifies the length of the buffer.
%
*/
MagickExport void MSBOrderShort(unsigned char *p,const size_t length)
{
  int
    c;

  register unsigned char
    *q;

  assert(p != (unsigned char *) NULL);
  q=p+length;
  while (p < q)
  {
    c=(int) (*p);
    *p=(*(p+1));
    p++;
    *p++=(unsigned char) c;
  }
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   O p e n B l o b                                                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  OpenBlob() opens a file associated with the image.  A file name of '-' sets
%  the file to stdin for type 'r' and stdout for type 'w'.  If the filename
%  suffix is '.gz' or '.Z', the image is decompressed for type 'r' and
%  compressed for type 'w'.  If the filename prefix is '|', it is piped to or
%  from a system command.
%
%  The format of the OpenBlob method is:
%
%       MagickBooleanType OpenBlob(const ImageInfo *image_info,Image *image,
%        const BlobMode mode,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image_info: The image info.
%
%    o image: The image.
%
%    o mode: The mode for opening the file.
%
*/
MagickExport MagickBooleanType OpenBlob(const ImageInfo *image_info,
  Image *image,const BlobMode mode,ExceptionInfo *exception)
{
  char
    filename[MaxTextExtent];

  const char
    *type;

  MagickBooleanType
    status;

  struct stat
    file_info;

  assert(image_info != (ImageInfo *) NULL);
  assert(image_info->signature == MagickSignature);
  if (image_info->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",
      image_info->filename);
  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image_info->blob != (void *) NULL)
    {
      if (image_info->stream != (StreamHandler) NULL)
        image->blob->stream=(StreamHandler) image_info->stream;
      AttachBlob(image->blob,image_info->blob,image_info->length);
      return(MagickTrue);
    }
  (void) DetachBlob(image->blob);
  switch (mode)
  {
    default: type="r"; break;
    case ReadBlobMode: type="r"; break;
    case ReadBinaryBlobMode: type="rb"; break;
    case WriteBlobMode: type="w"; break;
    case WriteBinaryBlobMode: type="w+b"; break;
  }
  if (image_info->stream != (StreamHandler) NULL)
    {
      image->blob->stream=(StreamHandler) image_info->stream;
      if (*type == 'w')
        {
          image->blob->type=FifoStream;
          return(MagickTrue);
        }
    }
  /*
    Open image file.
  */
  *filename='\0';
  (void) CopyMagickString(filename,image->filename,MaxTextExtent);
  if ((LocaleCompare(filename,"-") == 0) ||
      ((*filename == '\0') && (image_info->file == (FILE *) NULL)))
    {
      image->blob->file=(*type == 'r') ? stdin : stdout;
#if defined(__WINDOWS__)
      if (strchr(type,'b') != (char *) NULL)
        setmode(_fileno(image->blob->file),_O_BINARY);
#endif
      image->blob->type=StandardStream;
      image->blob->exempt=MagickTrue;
      if (*type == 'r')
        {
          image->next=NewImageList();
          image->previous=NewImageList();
        }
      return(MagickTrue);
    }
#if defined(HAVE_POPEN)
  if (*filename == '|')
    {
      char
        mode[MaxTextExtent];

      /*
        Pipe image to or from a system command.
      */
#if defined(SIGPIPE)
      if (*type == 'w')
        (void) signal(SIGPIPE,SIG_IGN);
#endif
      *mode=(*type);
      mode[1]='\0';
      image->blob->file=(FILE *) popen(filename+1,mode);
      if (image->blob->file == (FILE *) NULL)
        {
          ThrowFileException(exception,BlobError,"UnableToOpenBlob",filename);
          return(MagickFalse);
        }
      image->blob->type=PipeStream;
      image->blob->exempt=MagickTrue;
      if (*type == 'r')
        {
          image->next=NewImageList();
          image->previous=NewImageList();
        }
      return(MagickTrue);
    }
#endif
  status=stat(filename,&file_info) == 0 ? MagickTrue : MagickFalse;
#if defined(S_ISFIFO)
  if ((status == MagickTrue) && S_ISFIFO(file_info.st_mode))
    {
      image->blob->file=(FILE *) MagickOpenStream(filename,type);
      if (image->blob->file == (FILE *) NULL)
        {
          ThrowFileException(exception,BlobError,"UnableToOpenBlob",filename);
          return(MagickFalse);
        }
      image->blob->type=FileStream;
      image->blob->exempt=MagickTrue;
      if (*type == 'r')
        {
          image->next=NewImageList();
          image->previous=NewImageList();
        }
      return(MagickTrue);
    }
#endif
  if (*type == 'w')
    {
      /*
        Form filename for multi-part images.
      */
      (void) InterpretImageFilename(filename,MaxTextExtent,image->filename,
        (int) image->scene);
      if (image_info->adjoin == MagickFalse)
        if ((image->previous != (Image *) NULL) ||
            (GetNextImageInList(image) != (Image *) NULL))
          {
            if (LocaleCompare(filename,image->filename) == 0)
              {
                char
                  extension[MaxTextExtent],
                  path[MaxTextExtent];

                GetPathComponent(image->filename,RootPath,path);
                GetPathComponent(image->filename,ExtensionPath,extension);
                if (*extension == '\0')
                  (void) FormatMagickString(filename,MaxTextExtent,"%s-%lu",
                    path,image->scene);
                else
                  (void) FormatMagickString(filename,MaxTextExtent,"%s-%lu.%s",
                    path,image->scene,extension);
              }
          }
      (void) CopyMagickString(image->filename,filename,MaxTextExtent);
#if defined(macintosh)
      SetApplicationType(filename,image_info->magick,'8BIM');
#endif
    }
#if defined(HasZLIB)
  if (((strlen(filename) > 2) &&
       (LocaleCompare(filename+strlen(filename)-2,".Z") == 0)) ||
      ((strlen(filename) > 3) &&
       (LocaleCompare(filename+strlen(filename)-3,".gz") == 0)) ||
      ((strlen(filename) > 4) &&
       (LocaleCompare(filename+strlen(filename)-4,".wmz") == 0)) ||
      ((strlen(filename) > 5) &&
       (LocaleCompare(filename+strlen(filename)-5,".svgz") == 0)))
    {
      image->blob->file=(FILE *) gzopen(filename,type);
      if (image->blob->file != (FILE *) NULL)
        image->blob->type=ZipStream;
    }
  else
#endif
#if defined(HasBZLIB)
    if ((strlen(filename) > 4) &&
        (LocaleCompare(filename+strlen(filename)-4,".bz2") == 0))
      {
        image->blob->file=(FILE *) BZ2_bzopen(filename,type);
        if (image->blob->file != (FILE *) NULL)
          image->blob->type=BZipStream;
      }
    else
#endif
      if (image_info->file != (FILE *) NULL)
        {
          image->blob->file=image_info->file;
          image->blob->type=FileStream;
          image->blob->exempt=MagickTrue;
        }
      else
        {
          image->blob->file=(FILE *) MagickOpenStream(filename,type);
          if (image->blob->file != (FILE *) NULL)
            {
              image->blob->type=FileStream;
#if defined(HAVE_SETVBUF)
              (void) setvbuf(image->blob->file,(char *) NULL,(int) _IOFBF,
                MagickMaxBufferSize);
#endif
              if (*type == 'r')
                {
                  size_t
                    count;

                  unsigned char
                    magick[MaxTextExtent];

                  (void) ResetMagickMemory(magick,0,sizeof(magick));
                  count=fread(magick,1,MaxTextExtent,image->blob->file);
                  (void) rewind(image->blob->file);
                  (void) LogMagickEvent(BlobEvent,GetMagickModule(),
                     "  read %ld magic header bytes",(long) count);
#if defined(HasZLIB)
                  if (((int) magick[0] == 0x1F) &&
                      ((int) magick[1] == 0x8B) &&
                      ((int) magick[2] == 0x08))
                    {
                      (void) fclose(image->blob->file);
                      image->blob->file=(FILE *) gzopen(filename,type);
                      if (image->blob->file != (FILE *) NULL)
                        image->blob->type=ZipStream;
                     }
#endif
#if defined(HasBZLIB)
                  if (strncmp((char *) magick,"BZh",3) == 0)
                    {
                      (void) fclose(image->blob->file);
                      image->blob->file=(FILE *) BZ2_bzopen(filename,type);
                      if (image->blob->file != (FILE *) NULL)
                        image->blob->type=BZipStream;
                    }
#endif
                }
            }
        }
    if ((image->blob->type == FileStream) && (*type == 'r'))
      {
        const MagickInfo
          *magick_info;

        ExceptionInfo
          *sans_exception;

        sans_exception=AcquireExceptionInfo();
        magick_info=GetMagickInfo(image_info->magick,sans_exception);
        sans_exception=DestroyExceptionInfo(sans_exception);
        if ((magick_info != (const MagickInfo *) NULL) &&
            (GetMagickBlobSupport(magick_info) != MagickFalse))
          if (file_info.st_size <= (off_t) MagickMaxBufferSize)
            {
              size_t
                length;

              void
                *blob;

              length=(size_t) file_info.st_size;
              blob=MapBlob(fileno(image->blob->file),ReadMode,0,length);
              if (blob != (void *) NULL)
                {
                  /*
                    Format supports blobs-- use memory-mapped I/O.
                  */
                  if (image_info->file != (FILE *) NULL)
                    image->blob->exempt=MagickFalse;
                  else
                    {
                      (void) fclose(image->blob->file);
                      image->blob->file=(FILE *) NULL;
                    }
                  AttachBlob(image->blob,blob,length);
                  image->blob->mapped=MagickTrue;
                }
          }
      }
  image->blob->status=MagickFalse;
  if (image->blob->type == UndefinedStream)
    image->blob->size=GetBlobSize(image);
  if (image->blob->type == UndefinedStream)
    {
      ThrowFileException(exception,BlobError,"UnableToOpenBlob",filename);
      return(MagickFalse);
    }
  if (*type == 'r')
    {
      image->next=NewImageList();
      image->previous=NewImageList();
    }
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   P i n g B l o b                                                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  PingBlob() returns all the attributes of an image or image sequence except
%  for the pixels.  It is much faster and consumes far less memory than
%  BlobToImage().  On failure, a NULL image is returned and exception
%  describes the reason for the failure.
%
%  The format of the PingBlob method is:
%
%      Image *PingBlob(const ImageInfo *image_info,const void *blob,
%        const size_t length,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image_info: The image info.
%
%    o blob: The address of a character stream in one of the image formats
%      understood by ImageMagick.
%
%    o length: This size_t integer reflects the length in bytes of the blob.
%
%    o exception: Return any errors or warnings in this structure.
%
*/

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

static size_t PingStream(const Image *magick_unused(image),
  const void *magick_unused(pixels),const size_t columns)
{
  return(columns);
}

#if defined(__cplusplus) || defined(c_plusplus)
}
#endif

MagickExport Image *PingBlob(const ImageInfo *image_info,const void *blob,
  const size_t length,ExceptionInfo *exception)
{
  Image
    *image;

  ImageInfo
    *ping_info;

  assert(image_info != (ImageInfo *) NULL);
  assert(image_info->signature == MagickSignature);
  if (image_info->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",
      image_info->filename);
  assert(exception != (ExceptionInfo *) NULL);
  if ((blob == (const void *) NULL) || (length == 0))
    {
      (void) ThrowMagickException(exception,GetMagickModule(),BlobError,
        "UnrecognizedImageFormat","`%s'",image_info->magick);
      return((Image *) NULL);
    }
  ping_info=CloneImageInfo(image_info);
  ping_info->blob=(void *) AcquireQuantumMemory(length,sizeof(unsigned char));
  if (ping_info->blob == (const void *) NULL)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),
        ResourceLimitFatalError,"MemoryAllocationFailed","`%s'","");
      return((Image *) NULL);
    }
  (void) CopyMagickMemory(ping_info->blob,blob,length);
  ping_info->length=length;
  ping_info->ping=MagickTrue;
  image=ReadStream(ping_info,&PingStream,exception);
  ping_info->blob=(void *) RelinquishMagickMemory(ping_info->blob);
  ping_info=DestroyImageInfo(ping_info);
  return(image);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b                                                            %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlob() reads data from the blob or image file and returns it.  It
%  returns the number of bytes read.
%
%  The format of the ReadBlob method is:
%
%      ssize_t ReadBlob(Image *image,const size_t length,unsigned char *data)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o length:  Specifies an integer representing the number of bytes to read
%      from the file.
%
%    o data:  Specifies an area to place the information requested from the
%      file.
%
*/
MagickExport ssize_t ReadBlob(Image *image,const size_t length,
  unsigned char *data)
{
  int
    c;

  register unsigned char
    *q;

  ssize_t
    count;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  assert(image->blob != (BlobInfo *) NULL);
  assert(image->blob->type != UndefinedStream);
  assert(data != (void *) NULL);
  if (length == 0)
    return(0);
  count=0;
  q=data;
  switch (image->blob->type)
  {
    case UndefinedStream:
      break;
    case FileStream:
    case StandardStream:
    case PipeStream:
    {
      switch (length)
      {
        default:
        {
          count=(ssize_t) fread(q,1,length,image->blob->file);
          break;
        }
        case 2:
        {
          c=getc(image->blob->file);
          if (c == EOF)
            break;
          *q++=(unsigned char) c;
          count++;
        }
        case 1:
        {
          c=getc(image->blob->file);
          if (c == EOF)
            break;
          *q++=(unsigned char) c;
          count++;
        }
        case 0:
          break;
      }
      break;
    }
    case ZipStream:
    {
#if defined(HasZLIB)
      switch (length)
      {
        default:
        {
          count=(ssize_t) gzread(image->blob->file,q,(unsigned int) length);
          break;
        }
        case 2:
        {
          c=gzgetc(image->blob->file);
          if (c == EOF)
            break;
          *q++=(unsigned char) c;
          count++;
        }
        case 1:
        {
          c=gzgetc(image->blob->file);
          if (c == EOF)
            break;
          *q++=(unsigned char) c;
          count++;
        }
        case 0:
          break;
      }
#endif
      break;
    }
    case BZipStream:
    {
#if defined(HasBZLIB)
      count=(ssize_t) BZ2_bzread((BZFILE *) image->blob->file,q,(int) length);
#endif
      break;
    }
    case FifoStream:
      break;
    case BlobStream:
    {
      register const unsigned char
        *p;

      if (image->blob->offset >= (MagickOffsetType) image->blob->length)
        {
          image->blob->eof=MagickTrue;
          break;
        }
      p=image->blob->data+image->blob->offset;
      count=(ssize_t) MagickMin(length,(size_t) (image->blob->length-
        image->blob->offset));
      image->blob->offset+=count;
      if (count != (ssize_t) length)
        image->blob->eof=MagickTrue;
      switch (count)
      {
        default:
        {
          (void) CopyMagickMemory(q,p,(size_t) count);
          break;
        }
        case 7: *q++=(*p++);
        case 6: *q++=(*p++);
        case 5: *q++=(*p++);
        case 4: *q++=(*p++);
        case 3: *q++=(*p++);
        case 2: *q++=(*p++);
        case 1: *q++=(*p++);
        case 0: break;
      }
      break;
    }
  }
  return(count);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b B y t e                                                    %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobByte() reads a single byte from the image file and returns it.
%
%  The format of the ReadBlobByte method is:
%
%      int ReadBlobByte(Image *image)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
*/
MagickExport int ReadBlobByte(Image *image)
{
  register const unsigned char
    *p;

  ssize_t
    count;

  unsigned char
    buffer[1];

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  p=ReadBlobStream(image,1,buffer,&count);
  if (count != 1)
    return(EOF);
  return((int) (*p));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b D o u b l e                                                %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobDouble() reads a double value as a 64-bit quantity in the byte-order
%  specified by the endian member of the image structure.
%
%  The format of the ReadBlobDouble method is:
%
%      unsigned long ReadBlobDouble(Image *image)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
*/
MagickExport double ReadBlobDouble(Image *image)
{
  union
  {
    MagickSizeType
      unsigned_value;

    double
      double_value;
  } quantum;

  quantum.unsigned_value=ReadBlobLongLong(image);
  return(quantum.double_value);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b F l o a t                                                  %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobFloat() reads a float value as a 32-bit quantity in the byte-order
%  specified by the endian member of the image structure.
%
%  The format of the ReadBlobFloat method is:
%
%      unsigned long ReadBlobFloat(Image *image)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
*/
MagickExport float ReadBlobFloat(Image *image)
{
  union
  {
    unsigned long
      unsigned_value;

    float
      float_value;
  } quantum;

  quantum.unsigned_value=ReadBlobLong(image);
  return(quantum.float_value);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b L o n g                                                    %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobLong() reads a long value as a 32-bit quantity in the byte-order
%  specified by the endian member of the image structure.
%
%  The format of the ReadBlobLong method is:
%
%      unsigned long ReadBlobLong(Image *image)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
*/
MagickExport unsigned long ReadBlobLong(Image *image)
{
  register const unsigned char
    *p;

  ssize_t
    count;

  unsigned char
    buffer[4];

  unsigned long
    value;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  *buffer='\0';
  p=ReadBlobStream(image,4,buffer,&count);
  if (count != 4)
    return(0UL);
  if (image->endian == LSBEndian)
    {
      value=(unsigned long) (*p++);
      value|=((unsigned long) (*p++)) << 8;
      value|=((unsigned long) (*p++)) << 16;
      value|=((unsigned long) (*p++)) << 24;
      return(value & 0xffffffff);
    }
  value=((unsigned long) (*p++)) << 24;
  value|=((unsigned long) (*p++)) << 16;
  value|=((unsigned long) (*p++)) << 8;
  value|=((unsigned long) (*p++));
  return(value & 0xffffffff);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b L o n g L o n g                                            %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobLongLong() reads a long value as a 64-bit quantity in the byte-order
%  specified by the endian member of the image structure.
%
%  The format of the ReadBlobLong method is:
%
%      MagickSizeType ReadBlobLong(Image *image)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
*/
MagickExport MagickSizeType ReadBlobLongLong(Image *image)
{
  register const unsigned char
    *p;

  ssize_t
    count;

  unsigned char
    buffer[8];

  MagickSizeType
    value;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  *buffer='\0';
  p=ReadBlobStream(image,8,buffer,&count);
  if (count != 8)
    return(MagickULLConstant(0));
  if (image->endian == LSBEndian)
    {
      value=(MagickSizeType) (*p++);
      value|=((MagickSizeType) (*p++)) << 8;
      value|=((MagickSizeType) (*p++)) << 16;
      value|=((MagickSizeType) (*p++)) << 24;
      value|=((MagickSizeType) (*p++)) << 32;
      value|=((MagickSizeType) (*p++)) << 40;
      value|=((MagickSizeType) (*p++)) << 48;
      value|=((MagickSizeType) (*p++)) << 56;
      return(value & MagickULLConstant(0xffffffffffffffff));
    }
  value=((MagickSizeType) (*p++)) << 56;
  value|=((MagickSizeType) (*p++)) << 48;
  value|=((MagickSizeType) (*p++)) << 40;
  value|=((MagickSizeType) (*p++)) << 32;
  value|=((MagickSizeType) (*p++)) << 24;
  value|=((MagickSizeType) (*p++)) << 16;
  value|=((MagickSizeType) (*p++)) << 8;
  value|=((MagickSizeType) (*p++));
  return(value & MagickULLConstant(0xffffffffffffffff));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b S h o r t                                                  %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobShort() reads a short value as a 16-bit quantity in the byte-order
%  specified by the endian member of the image structure.
%
%  The format of the ReadBlobShort method is:
%
%      unsigned short ReadBlobShort(Image *image)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
*/
MagickExport unsigned short ReadBlobShort(Image *image)
{
  register const unsigned char
    *p;

  ssize_t
    count;

  unsigned char
    buffer[2];

  unsigned short
    value;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  *buffer='\0';
  p=ReadBlobStream(image,2,buffer,&count);
  if (count != 2)
    return((unsigned short) 0U);
  if (image->endian == LSBEndian)
    {
      value=(unsigned short) (*p++);
      value|=((unsigned short) (*p++)) << 8;
      return((unsigned short) (value & 0xffff));
    }
  value=(*p++) << 8;
  value|=(*p++);
  return((unsigned short) (value & 0xffff));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b L S B L o n g                                              %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobLSBLong() reads a long value as a 32-bit quantity in
%  least-significant byte first order.
%
%  The format of the ReadBlobLSBLong method is:
%
%      unsigned long ReadBlobLSBLong(Image *image)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
*/
MagickExport unsigned long ReadBlobLSBLong(Image *image)
{
  register const unsigned char
    *p;

  ssize_t
    count;

  unsigned char
    buffer[4];

  unsigned long
    value;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  *buffer='\0';
  p=ReadBlobStream(image,4,buffer,&count);
  if (count != 4)
    return(0UL);
  value=(unsigned long) (*p++);
  value|=((unsigned long) (*p++)) << 8;
  value|=((unsigned long) (*p++)) << 16;
  value|=((unsigned long) (*p++)) << 24;
  return(value & 0xffffffff);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b L S B S h o r t                                            %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobLSBShort() reads a short value as a 16-bit quantity in
%  least-significant byte first order.
%
%  The format of the ReadBlobLSBShort method is:
%
%      unsigned short ReadBlobLSBShort(Image *image)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
*/
MagickExport unsigned short ReadBlobLSBShort(Image *image)
{
  register const unsigned char
    *p;

  ssize_t
    count;

  unsigned char
    buffer[2];

  unsigned short
    value;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  *buffer='\0';
  p=ReadBlobStream(image,2,buffer,&count);
  if (count != 2)
    return((unsigned short) 0U);
  value=(unsigned short) (*p++);
  value|=((unsigned short) (*p++)) << 8;
  return((unsigned short) (value & 0xffff));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b M S B L o n g                                              %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobMSBLong() reads a long value as a 32-bit quantity in
%  most-significant byte first order.
%
%  The format of the ReadBlobMSBLong method is:
%
%      unsigned long ReadBlobMSBLong(Image *image)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
*/
MagickExport unsigned long ReadBlobMSBLong(Image *image)
{
  register const unsigned char
    *p;

  ssize_t
    count;

  unsigned char
    buffer[4];

  unsigned long
    value;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  *buffer='\0';
  p=ReadBlobStream(image,4,buffer,&count);
  if (count != 4)
    return(0UL);
  value=((unsigned long) (*p++) << 24);
  value|=((unsigned long) (*p++) << 16);
  value|=((unsigned long) (*p++) << 8);
  value|=(unsigned long) (*p++);
  return(value & 0xffffffff);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  R e a d B l o b M S B S h o r t                                            %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobMSBShort() reads a short value as a 16-bit quantity in
%  most-significant byte first order.
%
%  The format of the ReadBlobMSBShort method is:
%
%      unsigned short ReadBlobMSBShort(Image *image)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
*/
MagickExport unsigned short ReadBlobMSBShort(Image *image)
{
  register const unsigned char
    *p;

  ssize_t
    count;

  unsigned char
    buffer[2];

  unsigned short
    value;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  *buffer='\0';
  p=ReadBlobStream(image,2,buffer,&count);
  if (count != 2)
    return((unsigned short) 0U);
  value=(unsigned short) ((*p++) << 8);
  value|=(unsigned short) (*p++);
  return((unsigned short) (value & 0xffff));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   R e a d B l o b S t r i n g                                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadBlobString() reads characters from a blob or file until a newline
%  character is read or an end-of-file condition is encountered.
%
%  The format of the ReadBlobString method is:
%
%      char *ReadBlobString(Image *image,char *string)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o string: The address of a character buffer.
%
*/
MagickExport char *ReadBlobString(Image *image,char *string)
{
  register const unsigned char
    *p;

  register long
    i;

  ssize_t
    count;

  unsigned char
    buffer[1];

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  for (i=0; i < (MaxTextExtent-1L); i++)
  {
    p=ReadBlobStream(image,1,buffer,&count);
    if (count != 1)
      {
        if (i == 0)
          return((char *) NULL);
        break;
      }
    string[i]=(char) (*p);
    if ((string[i] == '\n') || (string[i] == '\r'))
      break;
  }
  string[i]='\0';
  return(string);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   R e f e r e n c e B l o b                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReferenceBlob() increments the reference count associated with the pixel
%  blob returning a pointer to the blob.
%
%  The format of the ReferenceBlob method is:
%
%      BlobInfo ReferenceBlob(BlobInfo *blob_info)
%
%  A description of each parameter follows:
%
%    o blob_info: The blob_info.
%
*/
MagickExport BlobInfo *ReferenceBlob(BlobInfo *blob)
{
  assert(blob != (BlobInfo *) NULL);
  assert(blob->signature == MagickSignature);
  if (blob->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"...");
  AcquireSemaphoreInfo(&blob->semaphore);
  blob->reference_count++;
  RelinquishSemaphoreInfo(blob->semaphore);
  return(blob);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  S e e k B l o b                                                            %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  SeekBlob() sets the offset in bytes from the beginning of a blob or file
%  and returns the resulting offset.
%
%  The format of the SeekBlob method is:
%
%      MagickOffsetType SeekBlob(Image *image,const MagickOffsetType offset,
%        const int whence)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o offset:  Specifies an integer representing the offset in bytes.
%
%    o whence:  Specifies an integer representing how the offset is
%      treated relative to the beginning of the blob as follows:
%
%        SEEK_SET  Set position equal to offset bytes.
%        SEEK_CUR  Set position to current location plus offset.
%        SEEK_END  Set position to EOF plus offset.
%
*/
MagickExport MagickOffsetType SeekBlob(Image *image,
  const MagickOffsetType offset,const int whence)
{
  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(image->blob != (BlobInfo *) NULL);
  assert(image->blob->type != UndefinedStream);
  switch (image->blob->type)
  {
    case UndefinedStream:
      break;
    case FileStream:
    {
      if (fseek(image->blob->file,(off_t) offset,whence) < 0)
        return(-1);
      image->blob->offset=TellBlob(image);
      break;
    }
    case StandardStream:
    case PipeStream:
    case ZipStream:
    {
#if defined(HasZLIB)
      if (gzseek(image->blob->file,(off_t) offset,whence) < 0)
        return(-1);
#endif
      image->blob->offset=TellBlob(image);
      break;
    }
    case BZipStream:
      return(-1);
    case FifoStream:
      return(-1);
    case BlobStream:
    {
      switch (whence)
      {
        case SEEK_SET:
        default:
        {
          if (offset < 0)
            return(-1);
          image->blob->offset=offset;
          break;
        }
        case SEEK_CUR:
        {
          if ((image->blob->offset+offset) < 0)
            return(-1);
          image->blob->offset+=offset;
          break;
        }
        case SEEK_END:
        {
          if (((MagickOffsetType) image->blob->length+offset) < 0)
            return(-1);
          image->blob->offset=image->blob->length+offset;
          break;
        }
      }
      if (image->blob->offset <= (MagickOffsetType)
          ((off_t) image->blob->length))
        image->blob->eof=MagickFalse;
      else
        if (image->blob->mapped != MagickFalse)
          return(-1);
        else
          {
            image->blob->extent=(size_t) (image->blob->offset+
              image->blob->quantum);
            image->blob->data=(unsigned char *) ResizeQuantumMemory(
              image->blob->data,image->blob->extent+1,
              sizeof(*image->blob->data));
            (void) SyncBlob(image);
            if (image->blob->data == (unsigned char *) NULL)
              {
                (void) DetachBlob(image->blob);
                return(-1);
              }
          }
      break;
    }
  }
  return(image->blob->offset);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   S e t B l o b E x e m p t                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  SetBlobExempt() sets the blob exempt status.
%
%  The format of the SetBlobExempt method is:
%
%      MagickBooleanType SetBlobExempt(const Image *image,
%        const MagickBooleanType exempt)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o exempt: Set to true if this blob is exempt from being closed.
%
*/
MagickExport void SetBlobExempt(Image *image,const MagickBooleanType exempt)
{
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  image->blob->exempt=exempt;
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  S y n c B l o b                                                            %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  SyncBlob() flushes the datastream if it is a file or synchonizes the data
%  attributes if it is an blob.
%
%  The format of the SyncBlob method is:
%
%      int SyncBlob(Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
static int SyncBlob(Image *image)
{
  int
    status;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(image->blob != (BlobInfo *) NULL);
  assert(image->blob->type != UndefinedStream);
  status=0;
  switch (image->blob->type)
  {
    case UndefinedStream:
      break;
    case FileStream:
    case StandardStream:
    case PipeStream:
    {
      status=fflush(image->blob->file);
      break;
    }
    case ZipStream:
    {
#if defined(HasZLIB)
      status=gzflush(image->blob->file,Z_SYNC_FLUSH);
#endif
      break;
    }
    case BZipStream:
    {
#if defined(HasBZLIB)
      status=BZ2_bzflush((BZFILE *) image->blob->file);
#endif
      break;
    }
    case FifoStream:
      break;
    case BlobStream:
    {
#if defined(HAVE_MMAP_FILEIO)
      if (image->blob->mapped != MagickFalse)
        status=msync(image->blob->data,image->blob->length,MS_SYNC);
#endif
      break;
    }
  }
  return(status);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  T e l l B l o b                                                            %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  TellBlob() obtains the current value of the blob or file position.
%
%  The format of the TellBlob method is:
%
%      MagickOffsetType TellBlob(const Image *image)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
*/
MagickExport MagickOffsetType TellBlob(const Image *image)
{
  MagickOffsetType
    offset;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(image->blob != (BlobInfo *) NULL);
  assert(image->blob->type != UndefinedStream);
  offset=(-1);
  switch (image->blob->type)
  {
    case UndefinedStream:
      break;
    case FileStream:
    {
      offset=ftell(image->blob->file);
      break;
    }
    case StandardStream:
    case PipeStream:
      break;
    case ZipStream:
    {
#if defined(HasZLIB)
      offset=(MagickOffsetType) gztell(image->blob->file);
#endif
      break;
    }
    case BZipStream:
      break;
    case FifoStream:
      break;
    case BlobStream:
    {
      offset=image->blob->offset;
      break;
    }
  }
  return(offset);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  U n m a p B l o b                                                          %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  UnmapBlob() deallocates the binary large object previously allocated with
%  the MapBlob method.
%
%  The format of the UnmapBlob method is:
%
%       MagickBooleanType UnmapBlob(void *map,const size_t length)
%
%  A description of each parameter follows:
%
%    o map: The address  of the binary large object.
%
%    o length: The length of the binary large object.
%
*/
MagickExport MagickBooleanType UnmapBlob(void *map,const size_t length)
{
#if defined(HAVE_MMAP_FILEIO)
  int
    status;

  status=munmap(map,length);
  return(status == -1 ? MagickFalse : MagickTrue);
#else
  return(MagickFalse);
#endif
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  W r i t e B l o b                                                          %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  WriteBlob() writes data to a blob or image file.  It returns the number of
%  bytes written.
%
%  The format of the WriteBlob method is:
%
%      ssize_t WriteBlob(Image *image,const size_t length,
%        const unsigned char *data)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o length:  Specifies an integer representing the number of bytes to
%      write to the file.
%
%    o data:  The address of the data to write to the blob or file.
%
*/
MagickExport ssize_t WriteBlob(Image *image,const size_t length,
  const unsigned char *data)
{
  int
    c;

  register const unsigned char
    *p;

  ssize_t
    count;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  assert(data != (const unsigned char *) NULL);
  assert(image->blob != (BlobInfo *) NULL);
  assert(image->blob->type != UndefinedStream);
  if (length == 0)
    return(0);
  count=0;
  p=data;
  switch (image->blob->type)
  {
    case UndefinedStream:
      break;
    case FileStream:
    case StandardStream:
    case PipeStream:
    {
      switch (length)
      {
        default:
        {
          count=(ssize_t) fwrite((const char *) data,1,length,
            image->blob->file);
          break;
        }
        case 2:
        {
          c=putc((int) *p++,image->blob->file);
          if (c == EOF)
            break;
          count++;
        }
        case 1:
        {
          c=putc((int) *p++,image->blob->file);
          if (c == EOF)
            break;
          count++;
        }
        case 0:
          break;
      }
      break;
    }
    case ZipStream:
    {
#if defined(HasZLIB)
      switch (length)
      {
        default:
        {
          count=(ssize_t) gzwrite(image->blob->file,(void *) data,
            (unsigned int) length);
          break;
        }
        case 2:
        {
          c=gzputc(image->blob->file,(int) *p++);
          if (c == EOF)
            break;
          count++;
        }
        case 1:
        {
          c=gzputc(image->blob->file,(int) *p++);
          if (c == EOF)
            break;
          count++;
        }
        case 0:
          break;
      }
#endif
      break;
    }
    case BZipStream:
    {
#if defined(HasBZLIB)
      count=(ssize_t) BZ2_bzwrite((BZFILE *) image->blob->file,(void *) data,
        (int) length);
#endif
      break;
    }
    case FifoStream:
    {
      count=(ssize_t) image->blob->stream(image,data,length);
      break;
    }
    case BlobStream:
    {
      register unsigned char
        *q;

      if ((image->blob->offset+(MagickOffsetType) length) >=
          (MagickOffsetType) image->blob->extent)
        {
          if (image->blob->mapped != MagickFalse)
            return(0);
          image->blob->quantum<<=1;
          image->blob->extent+=length+image->blob->quantum;
          image->blob->data=(unsigned char *) ResizeQuantumMemory(
            image->blob->data,image->blob->extent+1,
            sizeof(*image->blob->data));
          (void) SyncBlob(image);
          if (image->blob->data == (unsigned char *) NULL)
            {
              (void) DetachBlob(image->blob);
              return(0);
            }
        }
      q=image->blob->data+image->blob->offset;
      switch (length)
      {
        default:
        {
          (void) CopyMagickMemory(q,p,length);
          break;
        }
        case 7: *q++=(*p++);
        case 6: *q++=(*p++);
        case 5: *q++=(*p++);
        case 4: *q++=(*p++);
        case 3: *q++=(*p++);
        case 2: *q++=(*p++);
        case 1: *q++=(*p++);
        case 0: break;
      }
      image->blob->offset+=length;
      if (image->blob->offset >= (MagickOffsetType) image->blob->length)
        image->blob->length=(size_t) image->blob->offset;
      count=(ssize_t) length;
    }
  }
  return(count);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  W r i t e B l o b B y t e                                                  %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  WriteBlobByte() write an integer to a blob.  It returns the number of bytes
%  written (either 0 or 1);
%
%  The format of the WriteBlobByte method is:
%
%      ssize_t WriteBlobByte(Image *image,const unsigned char value)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
%    o value: Specifies the value to write.
%
*/
MagickExport ssize_t WriteBlobByte(Image *image,const unsigned char value)
{
  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  return(WriteBlobStream(image,1,&value));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  W r i t e B l o b F l o a t                                                %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  WriteBlobFloat() writes a float value as a 32-bit quantity in the byte-order
%  specified by the endian member of the image structure.
%
%  The format of the WriteBlobFloat method is:
%
%      ssize_t WriteBlobFloat(Image *image,const float value)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
%    o value: Specifies the value to write.
%
*/
MagickExport ssize_t WriteBlobFloat(Image *image,const float value)
{
  union
  {
    unsigned long
      unsigned_value;

    float
      float_value;
  } quantum;

  quantum.float_value=value;
  return(WriteBlobLong(image,quantum.unsigned_value));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  W r i t e B l o b L o n g                                                  %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  WriteBlobLong() writes a long value as a 32-bit quantity in the byte-order
%  specified by the endian member of the image structure.
%
%  The format of the WriteBlobLong method is:
%
%      ssize_t WriteBlobLong(Image *image,const unsigned long value)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
%    o value: Specifies the value to write.
%
*/
MagickExport ssize_t WriteBlobLong(Image *image,const unsigned long value)
{
  unsigned char
    buffer[4];

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->endian == LSBEndian)
    {
      buffer[0]=(unsigned char) value;
      buffer[1]=(unsigned char) (value >> 8);
      buffer[2]=(unsigned char) (value >> 16);
      buffer[3]=(unsigned char) (value >> 24);
      return(WriteBlobStream(image,4,buffer));
    }
  buffer[0]=(unsigned char) (value >> 24);
  buffer[1]=(unsigned char) (value >> 16);
  buffer[2]=(unsigned char) (value >> 8);
  buffer[3]=(unsigned char) value;
  return(WriteBlobStream(image,4,buffer));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   W r i t e B l o b S h o r t                                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  WriteBlobShort() writes a short value as a 16-bit quantity in the
%  byte-order specified by the endian member of the image structure.
%
%  The format of the WriteBlobShort method is:
%
%      ssize_t WriteBlobShort(Image *image,const unsigned short value)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
%    o value:  Specifies the value to write.
%
*/
MagickExport ssize_t WriteBlobShort(Image *image,const unsigned short value)
{
  unsigned char
    buffer[2];

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->endian == LSBEndian)
    {
      buffer[0]=(unsigned char) value;
      buffer[1]=(unsigned char) (value >> 8);
      return(WriteBlobStream(image,2,buffer));
    }
  buffer[0]=(unsigned char) (value >> 8);
  buffer[1]=(unsigned char) value;
  return(WriteBlobStream(image,2,buffer));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  W r i t e B l o b L S B L o n g                                            %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  WriteBlobLSBLong() writes a long value as a 32-bit quantity in
%  least-significant byte first order.
%
%  The format of the WriteBlobLSBLong method is:
%
%      ssize_t WriteBlobLSBLong(Image *image,const unsigned long value)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
%    o value: Specifies the value to write.
%
*/
MagickExport ssize_t WriteBlobLSBLong(Image *image,const unsigned long value)
{
  unsigned char
    buffer[4];

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  buffer[0]=(unsigned char) value;
  buffer[1]=(unsigned char) (value >> 8);
  buffer[2]=(unsigned char) (value >> 16);
  buffer[3]=(unsigned char) (value >> 24);
  return(WriteBlobStream(image,4,buffer));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   W r i t e B l o b L S B S h o r t                                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  WriteBlobLSBShort() writes a long value as a 16-bit quantity in
%  least-significant byte first order.
%
%  The format of the WriteBlobLSBShort method is:
%
%      ssize_t WriteBlobLSBShort(Image *image,const unsigned short value)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
%    o value:  Specifies the value to write.
%
*/
MagickExport ssize_t WriteBlobLSBShort(Image *image,const unsigned short value)
{
  unsigned char
    buffer[2];

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  buffer[0]=(unsigned char) value;
  buffer[1]=(unsigned char) (value >> 8);
  return(WriteBlobStream(image,2,buffer));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  W r i t e B l o b M S B L o n g                                            %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  WriteBlobMSBLong() writes a long value as a 32-bit quantity in
%  most-significant byte first order.
%
%  The format of the WriteBlobMSBLong method is:
%
%      ssize_t WriteBlobMSBLong(Image *image,const unsigned long value)
%
%  A description of each parameter follows.
%
%    o value:  Specifies the value to write.
%
%    o image: The image.
%
*/
MagickExport ssize_t WriteBlobMSBLong(Image *image,const unsigned long value)
{
  unsigned char
    buffer[4];

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  buffer[0]=(unsigned char) (value >> 24);
  buffer[1]=(unsigned char) (value >> 16);
  buffer[2]=(unsigned char) (value >> 8);
  buffer[3]=(unsigned char) value;
  return(WriteBlobStream(image,4,buffer));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  W r i t e B l o b M S B S h o r t                                          %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  WriteBlobMSBShort() writes a long value as a 16-bit quantity in
%  most-significant byte first order.
%
%  The format of the WriteBlobMSBShort method is:
%
%      ssize_t WriteBlobMSBShort(Image *image,const unsigned short value)
%
%  A description of each parameter follows.
%
%   o  value:  Specifies the value to write.
%
%   o  file:  Specifies the file to write the data to.
%
*/
MagickExport ssize_t WriteBlobMSBShort(Image *image,const unsigned short value)
{
  unsigned char
    buffer[2];

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  buffer[0]=(unsigned char) (value >> 8);
  buffer[1]=(unsigned char) value;
  return(WriteBlobStream(image,2,buffer));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+  W r i t e B l o b S t r i n g                                              %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  WriteBlobString() write a string to a blob.  It returns the number of
%  characters written.
%
%  The format of the WriteBlobString method is:
%
%      ssize_t WriteBlobString(Image *image,const char *string)
%
%  A description of each parameter follows.
%
%    o image: The image.
%
%    o string: Specifies the string to write.
%
*/
MagickExport ssize_t WriteBlobString(Image *image,const char *string)
{
  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  assert(string != (const char *) NULL);
  return(WriteBlobStream(image,strlen(string),(const unsigned char *) string));
}
