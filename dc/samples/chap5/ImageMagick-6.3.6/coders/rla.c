/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%                            RRRR   L       AAA                               %
%                            R   R  L      A   A                              %
%                            RRRR   L      AAAAA                              %
%                            R R    L      A   A                              %
%                            R  R   LLLLL  A   A                              %
%                                                                             %
%                                                                             %
%                      Read Alias/Wavefront Image Format.                     %
%                                                                             %
%                              Software Design                                %
%                                John Cristy                                  %
%                                 July 1992                                   %
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
*/

/*
  Include declarations.
*/
#include "magick/studio.h"
#include "magick/property.h"
#include "magick/blob.h"
#include "magick/blob-private.h"
#include "magick/exception.h"
#include "magick/exception-private.h"
#include "magick/image.h"
#include "magick/image-private.h"
#include "magick/list.h"
#include "magick/magick.h"
#include "magick/memory_.h"
#include "magick/monitor.h"
#include "magick/quantum-private.h"
#include "magick/static.h"
#include "magick/string_.h"
#include "magick/module.h"

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   R e a d R L A I m a g e                                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ReadRLAImage() reads a run-length encoded Wavefront RLA image file
%  and returns it.  It allocates the memory necessary for the new Image
%  structure and returns a pointer to the new image.
%
%  Note:  This module was contributed by Lester Vecsey (master@internexus.net).
%
%  The format of the ReadRLAImage method is:
%
%      Image *ReadRLAImage(const ImageInfo *image_info,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image_info: The image info.
%
%    o exception: return any errors or warnings in this structure.
%
%
*/
static Image *ReadRLAImage(const ImageInfo *image_info,ExceptionInfo *exception)
{
  typedef struct _WindowFrame
  {
    short
      left,
      right,
      bottom,
      top;
  } WindowFrame;

  typedef struct _RLAInfo
  {
    WindowFrame
      window,
      active_window;

    short
      frame,
      storage_type,
      number_channels,
      number_matte_channels,
      number_auxiliary_channels,
      revision;

    char
      gamma[16],
      red_primary[24],
      green_primary[24],
      blue_primary[24],
      white_point[24];

    long
      job_number;

    char
      name[128],
      description[128],
      program[64],
      machine[32],
      user[32],
      date[20],
      aspect[24],
      aspect_ratio[8],
      chan[32];

    short
      field;

    char
      time[12],
      filter[32];

    short
      bits_per_channel,
      matte_type,
      matte_bits,
      auxiliary_type,
      auxiliary_bits;

    char
      auxiliary[32],
      space[36];

    long
      next;
  } RLAInfo;

  Image
    *image;

  int
    channel,
    length,
    runlength;

  long
    y;

  long
    *scanlines;

  MagickBooleanType
    status;

  MagickOffsetType
    offset;

  register long
    i,
    x;

  register PixelPacket
    *q;

  ssize_t
    count;

  RLAInfo
    rla_info;

  unsigned char
    byte;

  /*
    Open image file.
  */
  assert(image_info != (const ImageInfo *) NULL);
  assert(image_info->signature == MagickSignature);
  if (image_info->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",
      image_info->filename);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);
  image=AllocateImage(image_info);
  status=OpenBlob(image_info,image,ReadBinaryBlobMode,exception);
  if (status == MagickFalse)
    {
      image=DestroyImageList(image);
      return((Image *) NULL);
    }
  rla_info.window.left=(short) ReadBlobMSBShort(image);
  rla_info.window.right=(short) ReadBlobMSBShort(image);
  rla_info.window.bottom=(short) ReadBlobMSBShort(image);
  rla_info.window.top=(short) ReadBlobMSBShort(image);
  rla_info.active_window.left=(short) ReadBlobMSBShort(image);
  rla_info.active_window.right=(short) ReadBlobMSBShort(image);
  rla_info.active_window.bottom=(short) ReadBlobMSBShort(image);
  rla_info.active_window.top=(short) ReadBlobMSBShort(image);
  rla_info.frame=(short) ReadBlobMSBShort(image);
  rla_info.storage_type=(short) ReadBlobMSBShort(image);
  rla_info.number_channels=(short) ReadBlobMSBShort(image);
  rla_info.number_matte_channels=(short) ReadBlobMSBShort(image);
  if (rla_info.number_channels == 0)
    rla_info.number_channels=3;
  rla_info.number_channels+=rla_info.number_matte_channels;
  rla_info.number_auxiliary_channels=(short) ReadBlobMSBShort(image);
  rla_info.revision=(short) ReadBlobMSBShort(image);
  count=ReadBlob(image,16,(unsigned char *) rla_info.gamma);
  count=ReadBlob(image,24,(unsigned char *) rla_info.red_primary);
  count=ReadBlob(image,24,(unsigned char *) rla_info.green_primary);
  count=ReadBlob(image,24,(unsigned char *) rla_info.blue_primary);
  count=ReadBlob(image,24,(unsigned char *) rla_info.white_point);
  rla_info.job_number=(long) ReadBlobMSBLong(image);
  count=ReadBlob(image,128,(unsigned char *) rla_info.name);
  count=ReadBlob(image,128,(unsigned char *) rla_info.description);
  count=ReadBlob(image,64,(unsigned char *) rla_info.program);
  count=ReadBlob(image,32,(unsigned char *) rla_info.machine);
  count=ReadBlob(image,32,(unsigned char *) rla_info.user);
  count=ReadBlob(image,20,(unsigned char *) rla_info.date);
  count=ReadBlob(image,24,(unsigned char *) rla_info.aspect);
  count=ReadBlob(image,8,(unsigned char *) rla_info.aspect_ratio);
  count=ReadBlob(image,32,(unsigned char *) rla_info.chan);
  rla_info.field=(short) ReadBlobMSBShort(image);
  count=ReadBlob(image,12,(unsigned char *) rla_info.time);
  count=ReadBlob(image,32,(unsigned char *) rla_info.filter);
  rla_info.bits_per_channel=(short) ReadBlobMSBShort(image);
  rla_info.matte_type=(short) ReadBlobMSBShort(image);
  rla_info.matte_bits=(short) ReadBlobMSBShort(image);
  rla_info.auxiliary_type=(short) ReadBlobMSBShort(image);
  rla_info.auxiliary_bits=(short) ReadBlobMSBShort(image);
  count=ReadBlob(image,32,(unsigned char *) rla_info.auxiliary);
  count=ReadBlob(image,36,(unsigned char *) rla_info.space);
  rla_info.next=(long) ReadBlobMSBLong(image);
  /*
    Initialize image structure.
  */
  image->matte=rla_info.number_matte_channels != 0 ? MagickTrue : MagickFalse;
  image->columns=1UL*rla_info.active_window.right-rla_info.active_window.left+1;
  image->rows=1UL*rla_info.active_window.top-rla_info.active_window.bottom+1;
  if (image_info->ping != MagickFalse)
    {
      CloseBlob(image);
      return(GetFirstImageInList(image));
    }
  if (SetImageExtent(image,0,0) == MagickFalse)
    {
      InheritException(exception,&image->exception);
      return(DestroyImageList(image));
    }
  scanlines=(long *) AcquireQuantumMemory(image->rows,sizeof(*scanlines));
  if (scanlines == (long *) NULL)
    ThrowReaderException(ResourceLimitError,"MemoryAllocationFailed");
  if (*rla_info.description != '\0')
    (void) SetImageProperty(image,"comment",rla_info.description);
  /*
    Read offsets to each scanline data.
  */
  for (i=0; i < (long) image->rows; i++)
    scanlines[i]=(long) ReadBlobMSBLong(image);
  /*
    Read image data.
  */
  x=0;
  for (y=0; y < (long) image->rows; y++)
  {
    offset=SeekBlob(image,scanlines[image->rows-y-1],SEEK_SET);
    if (offset < 0)
      ThrowReaderException(CorruptImageError,"ImproperImageHeader");
    for (channel=0; channel < (int) rla_info.number_channels; channel++)
    {
      length=(int) ReadBlobMSBShort(image);
      while (length > 0)
      {
        byte=(unsigned char) ReadBlobByte(image);
        runlength=byte;
        if (byte > 127)
          runlength=byte-256;
        length--;
        if (length == 0)
          break;
        if (runlength < 0)
          {
            while (runlength < 0)
            {
              q=GetImagePixels(image,(long) (x % image->columns),
                (long) (y % image->rows),1,1);
              if (q == (PixelPacket *) NULL)
                break;
              byte=(unsigned char) ReadBlobByte(image);
              length--;
              switch (channel)
              {
                case 0:
                {
                  q->red=ScaleCharToQuantum(byte);
                  break;
                }
                case 1:
                {
                  q->green=ScaleCharToQuantum(byte);
                  break;
                }
                case 2:
                {
                  q->blue=ScaleCharToQuantum(byte);
                  break;
                }
                case 3:
                default:
                {
                  q->opacity=(Quantum) (QuantumRange-ScaleCharToQuantum(byte));
                  break;
                }
              }
              if (SyncImagePixels(image) == MagickFalse)
                break;
              x++;
              runlength++;
            }
            continue;
          }
        byte=(unsigned char) ReadBlobByte(image);
        length--;
        runlength++;
        do
        {
          q=GetImagePixels(image,(long) (x % image->columns),
            (long) (y % image->rows),1,1);
          if (q == (PixelPacket *) NULL)
            break;
          switch (channel)
          {
            case 0:
            {
              q->red=ScaleCharToQuantum(byte);
              break;
            }
            case 1:
            {
              q->green=ScaleCharToQuantum(byte);
              break;
            }
            case 2:
            {
              q->blue=ScaleCharToQuantum(byte);
              break;
            }
            case 3:
            default:
            {
              q->opacity=(Quantum) (QuantumRange-ScaleCharToQuantum(byte));
              break;
            }
          }
          if (SyncImagePixels(image) == MagickFalse)
            break;
          x++;
          runlength--;
        }
        while (runlength > 0);
      }
    }
    if (QuantumTick(y,image->rows) != MagickFalse)
      if ((image->progress_monitor != (MagickProgressMonitor) NULL) &&
          (QuantumTick(y,image->rows) != MagickFalse))
        {
          status=image->progress_monitor(LoadImageTag,y,image->rows,
            image->client_data);
          if (status == MagickFalse)
            break;
        }
  }
  if (EOFBlob(image) != MagickFalse)
    ThrowFileException(exception,CorruptImageError,"UnexpectedEndOfFile",
      image->filename);
  CloseBlob(image);
  return(GetFirstImageInList(image));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   R e g i s t e r R L A I m a g e                                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  RegisterRLAImage() adds attributes for the RLA image format to
%  the list of supported formats.  The attributes include the image format
%  tag, a method to read and/or write the format, whether the format
%  supports the saving of more than one frame to the same file or blob,
%  whether the format supports native in-memory I/O, and a brief
%  description of the format.
%
%  The format of the RegisterRLAImage method is:
%
%      unsigned long RegisterRLAImage(void)
%
*/
ModuleExport unsigned long RegisterRLAImage(void)
{
  MagickInfo
    *entry;

  entry=SetMagickInfo("RLA");
  entry->decoder=(DecodeImageHandler *) ReadRLAImage;
  entry->adjoin=MagickFalse;
  entry->description=ConstantString("Alias/Wavefront image");
  entry->module=ConstantString("RLA");
  (void) RegisterMagickInfo(entry);
  return(MagickImageCoderSignature);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   U n r e g i s t e r R L A I m a g e                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  UnregisterRLAImage() removes format registrations made by the
%  RLA module from the list of supported formats.
%
%  The format of the UnregisterRLAImage method is:
%
%      UnregisterRLAImage(void)
%
*/
ModuleExport void UnregisterRLAImage(void)
{
  (void) UnregisterMagickInfo("RLA");
}
