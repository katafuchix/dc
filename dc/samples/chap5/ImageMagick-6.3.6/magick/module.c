/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%                  M   M   OOO   DDDD   U   U  L      EEEEE                   %
%                  MM MM  O   O  D   D  U   U  L      E                       %
%                  M M M  O   O  D   D  U   U  L      EEE                     %
%                  M   M  O   O  D   D  U   U  L      E                       %
%                  M   M   OOO   DDDD    UUU   LLLLL  EEEEE                   %
%                                                                             %
%                                                                             %
%                         ImageMagick Module Methods                          %
%                                                                             %
%                              Software Design                                %
%                              Bob Friesenhahn                                %
%                                March 2000                                   %
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
#include "magick/coder.h"
#include "magick/client.h"
#include "magick/configure.h"
#include "magick/exception.h"
#include "magick/exception-private.h"
#include "magick/log.h"
#include "magick/hashmap.h"
#include "magick/magic.h"
#include "magick/magick.h"
#include "magick/memory_.h"
#include "magick/module.h"
#include "magick/semaphore.h"
#include "magick/splay-tree.h"
#include "magick/static.h"
#include "magick/string_.h"
#include "magick/token.h"
#include "magick/utility.h"
#if defined(SupportMagickModules)
#if defined(HasLTDL)
#include "ltdl.h"
typedef lt_dlhandle ModuleHandle;
#else
typedef void *ModuleHandle;
#endif

/*
  Define declarations.
*/
#if defined(HasLTDL)
#  define ModuleGlobExpression "*.la"
#else
#  if defined(_DEBUG)
#    define ModuleGlobExpression "IM_MOD_DB_*.dll"
#  else
#    define ModuleGlobExpression "IM_MOD_RL_*.dll"
#  endif
#endif

/*
  Global declarations.
*/
static SemaphoreInfo
  *module_semaphore = (SemaphoreInfo *) NULL;

static SplayTreeInfo
  *module_list = (SplayTreeInfo *) NULL;

static volatile MagickBooleanType
  instantiate_module = MagickFalse;

/*
  Forward declarations.
*/
static const ModuleInfo
  *RegisterModule(const ModuleInfo *,ExceptionInfo *);

static MagickBooleanType
  GetMagickModulePath(const char *,MagickModuleType,char *,ExceptionInfo *),
  InitializeModuleList(ExceptionInfo *),
  UnregisterModule(const ModuleInfo *,ExceptionInfo *);

static void
  TagToCoderModuleName(const char *,char *),
  TagToFilterModuleName(const char *,char *),
  TagToModuleName(const char *,const char *,char *);

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   D e s t r o y M o d u l e L i s t                                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  DestroyMagickList() unregisters any previously loaded modules and exits
%  the module loaded environment.
%
%  The format of the DestroyMagickList module is:
%
%      void DestroyMagickList(void)
%
*/
MagickExport void DestroyModuleList(void)
{
  /*
    Deestroy magick modules.
  */
  AcquireSemaphoreInfo(&module_semaphore);
#if defined(SupportMagickModules)
  if (module_list != (SplayTreeInfo *) NULL)
    module_list=DestroySplayTree(module_list);
  if (instantiate_module != MagickFalse)
    (void) lt_dlexit();
#endif
  instantiate_module=MagickFalse;
  RelinquishSemaphoreInfo(module_semaphore);
  module_semaphore=DestroySemaphoreInfo(module_semaphore);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   G e t M o d u l e I n f o                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetModuleInfo() returns a pointer to a ModuleInfo structure that matches the
%  specified tag.  If tag is NULL, the head of the module list is returned. If
%  no modules are loaded, or the requested module is not found, NULL is
%  returned.
%
%  The format of the GetModuleInfo module is:
%
%      const ModuleInfo *GetModuleInfo(const char *tag,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o tag: a character string that represents the image format we are
%      looking for.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport const ModuleInfo *GetModuleInfo(const char *tag,
  ExceptionInfo *exception)
{
  if ((module_list == (SplayTreeInfo *) NULL) ||
      (instantiate_module == MagickFalse))
    if (InitializeModuleList(exception) == MagickFalse)
      return((const ModuleInfo *) NULL);
  if ((module_list == (SplayTreeInfo *) NULL) ||
      (GetNumberOfNodesInSplayTree(module_list) == 0))
    return((const ModuleInfo *) NULL);
  if ((tag == (const char *) NULL) || (LocaleCompare(tag,"*") == 0))
    {
#if defined(SupportMagickModules)
      if (LocaleCompare(tag,"*") == 0)
        (void) OpenModules(exception);
#endif
      ResetSplayTreeIterator(module_list);
      return((const ModuleInfo *) GetNextValueInSplayTree(module_list));
    }
  return((const ModuleInfo *) GetValueFromSplayTree(module_list,tag));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   G e t M o d u l e I n f o L i s t                                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetModuleInfoList() returns any modules that match the specified pattern.
%
%  The format of the GetModuleInfoList function is:
%
%      const ModuleInfo **GetModuleInfoList(const char *pattern,
%        unsigned long *number_modules,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o pattern: Specifies a pointer to a text string containing a pattern.
%
%    o number_modules:  This integer returns the number of modules in the list.
%
%    o exception: Return any errors or warnings in this structure.
%
*/

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

static int ModuleInfoCompare(const void *x,const void *y)
{
  const ModuleInfo
    **p,
    **q;

  p=(const ModuleInfo **) x,
  q=(const ModuleInfo **) y;
  if (LocaleCompare((*p)->path,(*q)->path) == 0)
    return(LocaleCompare((*p)->tag,(*q)->tag));
  return(LocaleCompare((*p)->path,(*q)->path));
}

#if defined(__cplusplus) || defined(c_plusplus)
}
#endif

MagickExport const ModuleInfo **GetModuleInfoList(const char *pattern,
  unsigned long *number_modules,ExceptionInfo *exception)
{
  const ModuleInfo
    **modules;

  register const ModuleInfo
    *p;

  register long
    i;

  /*
    Allocate module list.
  */
  assert(pattern != (char *) NULL);
  (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",pattern);
  assert(number_modules != (unsigned long *) NULL);
  *number_modules=0;
  p=GetModuleInfo("*",exception);
  if (p == (const ModuleInfo *) NULL)
    return((const ModuleInfo **) NULL);
  modules=(const ModuleInfo **) AcquireQuantumMemory((size_t)
    GetNumberOfNodesInSplayTree(module_list)+1UL,sizeof(*modules));
  if (modules == (const ModuleInfo **) NULL)
    return((const ModuleInfo **) NULL);
  /*
    Generate module list.
  */
  AcquireSemaphoreInfo(&module_semaphore);
  ResetSplayTreeIterator(module_list);
  p=(const ModuleInfo *) GetNextValueInSplayTree(module_list);
  for (i=0; p != (const ModuleInfo *) NULL; )
  {
    if ((p->stealth == MagickFalse) &&
        (GlobExpression(p->tag,pattern,MagickFalse) != MagickFalse))
      modules[i++]=p;
    p=(const ModuleInfo *) GetNextValueInSplayTree(module_list);
  }
  RelinquishSemaphoreInfo(module_semaphore);
  qsort((void *) modules,(size_t) i,sizeof(*modules),ModuleInfoCompare);
  modules[i]=(ModuleInfo *) NULL;
  *number_modules=(unsigned long) i;
  return(modules);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   G e t M o d u l e L i s t                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetModuleList() returns any image format modules that match the specified
%  pattern.
%
%  The format of the GetModuleList function is:
%
%      char **GetModuleList(const char *pattern,unsigned long *number_modules,
%        ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o pattern: Specifies a pointer to a text string containing a pattern.
%
%    o number_modules:  This integer returns the number of modules in the
%      list.
%
%    o exception: Return any errors or warnings in this structure.
%
*/

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

static int ModuleCompare(const void *x,const void *y)
{
  register const char
    **p,
    **q;

   p=(const char **) x;
  q=(const char **) y;
  return(LocaleCompare(*p,*q));
}

#if defined(__cplusplus) || defined(c_plusplus)
}
#endif

MagickExport char **GetModuleList(const char *pattern,
  unsigned long *number_modules,ExceptionInfo *exception)
{
  char
    **modules,
    filename[MaxTextExtent],
    module_path[MaxTextExtent],
    path[MaxTextExtent];

  DIR
    *directory;

  register long
    i;

  size_t
    length;

  struct dirent
    *entry;

  unsigned long
    max_entries;

  /*
    Locate all modules in the coder path.
  */
  TagToCoderModuleName("magick",filename);
  length=GetMagickModulePath(filename,MagickImageCoderModule,module_path,
    exception);
  if (length == 0)
    return((char **) NULL);
  GetPathComponent(module_path,HeadPath,path);
  max_entries=255;
  modules=(char **) AcquireQuantumMemory((size_t) max_entries+1UL,
    sizeof(*modules));
  if (modules == (char **) NULL)
    return((char **) NULL);
  *modules=(char *) NULL;
  directory=opendir(path);
  if (directory == (DIR *) NULL)
    return((char **) NULL);
  i=0;
  entry=readdir(directory);
  while (entry != (struct dirent *) NULL)
  {
    if (GlobExpression(entry->d_name,ModuleGlobExpression,MagickFalse) == MagickFalse)
      {
        entry=readdir(directory);
        continue;
      }
    if (GlobExpression(entry->d_name,pattern,MagickFalse) == MagickFalse)
      continue;
    if (i >= (long) max_entries)
      {
        modules=(char **) NULL;
        if (~max_entries > max_entries)
          modules=(char **) ResizeQuantumMemory(modules,(size_t)
            (max_entries << 1),sizeof(*modules));
        max_entries<<=1;
        if (modules == (char **) NULL)
          break;
      }
    /*
      Add new module name to list.
    */
    modules[i]=AcquireString((char *) NULL);
    GetPathComponent(entry->d_name,BasePath,modules[i]);
    LocaleUpper(modules[i]);
    if (LocaleNCompare("IM_MOD_",modules[i],7) == 0)
      {
        (void) CopyMagickString(modules[i],modules[i]+10,MaxTextExtent);
        modules[i][strlen(modules[i])-1]='\0';
      }
    i++;
    entry=readdir(directory);
  }
  (void) closedir(directory);
  if (modules == (char **) NULL)
    {
      ThrowMagickException(exception,GetMagickModule(),ConfigureError,
        "MemoryAllocationFauled","`%s'",pattern);
      return((char **) NULL);
    }
  qsort((void *) modules,(size_t) i,sizeof(*modules),ModuleCompare);
  modules[i]=(char *) NULL;
  *number_modules=(unsigned long) i;
  return(modules);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%  G e t M a g i c k M o d u l e P a t h                                      %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetMagickModulePath() finds a module with the specified module type and
%  filename.
%
%  The format of the GetMagickModulePath module is:
%
%      MagickBooleanType GetMagickModulePath(const char *filename,
%        MagickModuleType module_type,char *path,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o filename: The module file name.
%
%    o module_type: The module type: MagickImageCoderModule or
%      MagickImageFilterModule.
%
%    o path: The path associated with the filename.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
static MagickBooleanType GetMagickModulePath(const char *filename,
  MagickModuleType module_type,char *path,ExceptionInfo *exception)
{
  char
    *module_path;

  assert(filename != (const char *) NULL);
  (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",filename);
  assert(path != (char *) NULL);
  assert(exception != (ExceptionInfo *) NULL);
  (void) CopyMagickString(path,filename,MaxTextExtent);
  module_path=(char *) NULL;
  switch (module_type)
  {
    case MagickImageCoderModule:
    default:
    {
      (void) LogMagickEvent(ModuleEvent,GetMagickModule(),
        "Searching for coder module file \"%s\" ...",filename);
      module_path=GetEnvironmentValue("MAGICK_CODER_MODULE_PATH");
      break;
    }
    case MagickImageFilterModule:
    {
      (void) LogMagickEvent(ModuleEvent,GetMagickModule(),
        "Searching for filter module file \"%s\" ...",filename);
      module_path=GetEnvironmentValue("MAGICK_CODER_FILTER_PATH");
      break;
    }
  }
  if (module_path != (char *) NULL)
    {
      register char
        *p,
        *q;

      for (p=module_path-1; p != (char *) NULL; )
      {
        (void) CopyMagickString(path,p+1,MaxTextExtent);
        q=strchr(path,DirectoryListSeparator);
        if (q != (char *) NULL)
          *q='\0';
        q=path+strlen(path)-1;
        if ((q >= path) && (*q != *DirectorySeparator))
          (void) ConcatenateMagickString(path,DirectorySeparator,MaxTextExtent);
        (void) ConcatenateMagickString(path,filename,MaxTextExtent);
        if (IsAccessible(path) != MagickFalse)
          {
            module_path=DestroyString(module_path);
            return(MagickTrue);
          }
        p=strchr(p+1,DirectoryListSeparator);
      }
      module_path=DestroyString(module_path);
    }
#if defined(UseInstalledMagick)
#if defined(MagickImageCodersPath)
  {
    const char
      *directory;

    /*
      Search hard coded paths.
    */
    switch (module_type)
    {
      case MagickImageCoderModule:
      default:
      {
        directory=MagickImageCodersPath;
        break;
      }
      case MagickImageFilterModule:
      {
        directory=MagickImageFiltersPath;
        break;
      }
    }
    (void) FormatMagickString(path,MaxTextExtent,"%s%s",directory,filename);
    if (IsAccessible(path) == MagickFalse)
      {
        ThrowFileException(exception,ConfigureWarning,"UnableToOpenModuleFile",
          path);
        return(MagickFalse);
      }
    return(MagickTrue);
  }
#else
#if defined(__WINDOWS__)
  {
    const char
      *key,
      *value;

    /*
      Locate path via registry key.
    */
    switch (module_type)
    {
      case MagickImageCoderModule:
      default:
      {
        key="CoderModulesPath";
        break;
      }
      case MagickImageFilterModule:
      {
        key="FilterModulesPath";
        break;
      }
    }
    value=NTRegistryKeyLookup(key);
    if (value == (char *) NULL)
      {
        ThrowMagickException(exception,GetMagickModule(),ConfigureError,
          "RegistryKeyLookupFailed","`%s'",key);
        return(MagickFalse);
      }
    (void) FormatMagickString(path,MaxTextExtent,"%s%s%s",value,
      DirectorySeparator,filename);
    if (IsAccessible(path) == MagickFalse)
      {
        ThrowFileException(exception,ConfigureWarning,"UnableToOpenModuleFile",
          path);
        return(MagickFalse);
      }
    return(MagickTrue);
  }
#endif
#endif
#if !defined(MagickImageCodersPath) && !defined(__WINDOWS__)
# error MagickImageCodersPath or __WINDOWS__ must be defined when UseInstalledMagick is defined
#endif
#else
  {
    char
      *home;

    home=GetEnvironmentValue("MAGICK_HOME");
    if (home != (char *) NULL)
      {
        /*
          Search MAGICK_HOME.
        */
#if !defined(POSIX)
        (void) FormatMagickString(path,MaxTextExtent,"%s%s%s",home,
          DirectorySeparator,filename);
#else
        const char
          *directory;

        switch (module_type)
        {
          case MagickImageCoderModule:
          default:
          {
            directory=MagickImageCoderModulesSubdir;
            break;
          }
          case MagickImageFilterModule:
          {
            directory=MagickImageFilterModulesSubdir;
            break;
          }
        }
        (void) FormatMagickString(path,MaxTextExtent,"%s/lib/%s/%s",home,
          directory,filename);
#endif
        home=DestroyString(home);
        if (IsAccessible(path) != MagickFalse)
          return(MagickTrue);
      }
  }
  if (*GetClientPath() != '\0')
    {
      /*
        Search based on executable directory.
      */
#if !defined(POSIX)
      (void) FormatMagickString(path,MaxTextExtent,"%s%s%s",GetClientPath(),
        DirectorySeparator,filename);
#else
      char
        prefix[MaxTextExtent];

      const char
        *directory;

      switch (module_type)
      {
        case MagickImageCoderModule:
        default:
        {
          directory="modules";
          break;
        }
        case MagickImageFilterModule:
        {
          directory="filters";
          break;
        }
      }
      (void) CopyMagickString(prefix,GetClientPath(),MaxTextExtent);
      ChopPathComponents(prefix,1);
      (void) FormatMagickString(path,MaxTextExtent,
        "%s/lib/%s/modules-Q%d/%s/%s",prefix,MagickLibSubdir,QuantumDepth,
        directory,filename);
#endif
      if (IsAccessible(path) != MagickFalse)
        return(MagickTrue);
    }
#if defined(__WINDOWS__)
  {
    /*
      Search module path.
    */
    if (NTGetModulePath("CORE_RL_magick_.dll",path) != MagickFalse)
      if (IsAccessible(path) != MagickFalse)
        return(MagickTrue);
    if (NTGetModulePath("Magick.dll",path) != MagickFalse)
      if (IsAccessible(path) != MagickFalse)
        return(MagickTrue);
  }
#endif
  {
    char
      *home;

    home=GetEnvironmentValue("HOME");
    if (home == (char *) NULL)
      home=GetEnvironmentValue("USERPROFILE");
    if (home != (char *) NULL)
      {
        /*
          Search $HOME/.magick.
        */
        (void) FormatMagickString(path,MaxTextExtent,"%s%s%s%s",home,
          *home == '/' ? "/.magick" : "",DirectorySeparator,filename);
        home=DestroyString(home);
        if (IsAccessible(path) != MagickFalse)
          return(MagickTrue);
      }
  }
  /*
    Search current directory.
  */
  if (IsAccessible(path) != MagickFalse)
    return(MagickTrue);
  if (exception->severity < ConfigureError)
    ThrowFileException(exception,ConfigureWarning,"UnableToOpenModuleFile",
      path);
  return(MagickFalse);
#endif
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   I n i t i a l i z e M o d u l e L i s t                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  InitializeModuleList() initializes the module loader.
%
%  The format of the InitializeModuleList() method is:
%
%      InitializeModuleList(Exceptioninfo *exception)
%
%  A description of each parameter follows.
%
%    o exception: Return any errors or warnings in this structure.
%
*/

static void *DestroyModuleNode(void *module_info)
{
  ExceptionInfo
    *exception;

  register ModuleInfo
    *p;

  exception=AcquireExceptionInfo();
  p=(ModuleInfo *) module_info;
  if (UnregisterModule(p,exception) == MagickFalse)
    CatchException(exception);
  if (p->tag != (char *) NULL)
    p->tag=DestroyString(p->tag);
  if (p->path != (char *) NULL)
    p->path=DestroyString(p->path);
  exception=DestroyExceptionInfo(exception);
  return(RelinquishMagickMemory(p));
}

static MagickBooleanType InitializeModuleList(
  ExceptionInfo *magick_unused(exception))
{
  if ((module_list == (SplayTreeInfo *) NULL) &&
      (instantiate_module == MagickFalse))
    {
      AcquireSemaphoreInfo(&module_semaphore);
      if ((module_list == (SplayTreeInfo *) NULL) &&
          (instantiate_module == MagickFalse))
        {
          MagickBooleanType
            status;

          ModuleInfo
            *module_info;

          module_list=NewSplayTree(CompareSplayTreeString,
            (void *(*)(void *)) NULL,DestroyModuleNode);
          if (module_list == (SplayTreeInfo *) NULL)
            ThrowFatalException(ResourceLimitFatalError,
              "MemoryAllocationFailed");
          module_info=(ModuleInfo *) AcquireMagickMemory(sizeof(*module_info));
          if (module_info == (ModuleInfo *) NULL)
            ThrowFatalException(ResourceLimitFatalError,
              "MemoryAllocationFailed");
          (void) ResetMagickMemory(module_info,0,sizeof(*module_info));
          module_info->tag=ConstantString("[boot-strap]");
          module_info->stealth=MagickTrue;
          (void) time(&module_info->load_time);
          module_info->signature=MagickSignature;
          status=AddValueToSplayTree(module_list,module_info->tag,module_info);
          if (status == MagickFalse)
            ThrowFatalException(ResourceLimitFatalError,
              "MemoryAllocationFailed");
          if (lt_dlinit() != 0)
            ThrowFatalException(ModuleFatalError,
              "UnableToInitializeModuleLoader");
          instantiate_module=MagickTrue;
        }
      RelinquishSemaphoreInfo(module_semaphore);
    }
  return(module_list != (SplayTreeInfo *) NULL ? MagickTrue : MagickFalse);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   I n v o k e D y n a m i c I m a g e F i l t e r                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  InvokeDynamicImageFilter() invokes a dynamic image filter.
%
%  The format of the InvokeDynamicImageFilter module is:
%
%      MagickBooleanType InvokeDynamicImageFilter(const char *tag,Image **image,
%        const int argc,char **argv,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o tag: a character string that represents the name of the particular
%      module.
%
%    o image: The image.
%
%    o argc: Specifies a pointer to an integer describing the number of
%      elements in the argument vector.
%
%    o argv: Specifies a pointer to a text array containing the command line
%      arguments.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport MagickBooleanType InvokeDynamicImageFilter(const char *tag,
  Image **images,const int argc,char **argv,ExceptionInfo *exception)
{
  char
    name[MaxTextExtent],
    path[MaxTextExtent];

  ImageFilterHandler
    *image_filter;

  MagickBooleanType
    status;

  ModuleHandle
    handle;

  size_t
    length;

  /*
    Find the module.
  */
  assert(images != (Image **) NULL);
  assert((*images)->signature == MagickSignature);
  if ((*images)->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",
      (*images)->filename);
#if !defined(BuildMagickModules)
  status=InvokeStaticImageFilter(tag,images,argc,argv,exception);
  if (status != MagickFalse)
    return(status);
#endif
  status=MagickFalse;
  TagToFilterModuleName(tag,name);
  length=GetMagickModulePath(name,MagickImageFilterModule,path,exception);
  if (length == 0)
    return(MagickFalse);
  /*
    Open the module.
  */
  handle=lt_dlopen(path);
  if (handle == (ModuleHandle) NULL)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),ModuleError,
        "UnableToLoadModule","`%s': %s",name,lt_dlerror());
      return(status);
    }
  /*
    Locate the module.
  */
#if !defined(MagickMethodPrefix)
  (void) FormatMagickString(name,MaxTextExtent,"%sImage",tag);
#else
  (void) FormatMagickString(name,MaxTextExtent,"%s%sImage",MagickMethodPrefix,
    tag);
#endif
  /*
    Execute the module.
  */
  image_filter=(ImageFilterHandler *) lt_dlsym(handle,name);
  if (image_filter == (ImageFilterHandler *) NULL)
    (void) ThrowMagickException(exception,GetMagickModule(),ModuleError,
      "UnableToLoadModule","`%s': %s",name,lt_dlerror());
  else
    {
      unsigned long
        signature;

      if ((*images)->debug != MagickFalse)
        (void) LogMagickEvent(ModuleEvent,GetMagickModule(),
          "Invoking \"%s\" dynamic image filter",tag);
      signature=image_filter(images,argc,argv,exception);
      if ((*images)->debug != MagickFalse)
        (void) LogMagickEvent(ModuleEvent,GetMagickModule(),"\"%s\" completes",
          tag);
      if (signature != MagickImageFilterSignature)
        {
          (void) ThrowMagickException(exception,GetMagickModule(),ModuleError,
            "ImageFilterSignatureMismatch","`%s': %8lx != %8lx",tag,signature,
            MagickImageFilterSignature);
          return(MagickFalse);
        }
    }
  /*
    Close the module.
  */
  (void) lt_dlclose(handle);
  return(status);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%  L i s t M o d u l e I n f o                                                %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ListModuleInfo() lists the module info to a file.
%
%  The format of the ListModuleInfo module is:
%
%      MagickBooleanType ListModuleInfo(FILE *file,ExceptionInfo *exception)
%
%  A description of each parameter follows.
%
%    o file:  An pointer to a FILE.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport MagickBooleanType ListModuleInfo(FILE *file,
  ExceptionInfo *exception)
{
  const ModuleInfo
    **module_info;

  register long
    i;

  unsigned long
    number_modules;

  if (file == (const FILE *) NULL)
    file=stdout;
  module_info=GetModuleInfoList("*",&number_modules,exception);
  if (module_info == (const ModuleInfo **) NULL)
    return(MagickFalse);
  if (module_info[0]->path != (char *) NULL)
    {
      char
        path[MaxTextExtent];

      GetPathComponent(module_info[0]->path,HeadPath,path);
      (void) fprintf(file,"\nPath: %s\n\n",path);
    }
  (void) fprintf(file,"Module\n");
  (void) fprintf(file,"-------------------------------------------------"
    "------------------------------\n");
  for (i=0; i < (long) number_modules; i++)
  {
    if (module_info[i]->stealth != MagickFalse)
      continue;
    (void) fprintf(file,"%s",module_info[i]->tag);
    (void) fprintf(file,"\n");
  }
  (void) fflush(file);
  module_info=(const ModuleInfo **)
    RelinquishMagickMemory((void *) module_info);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   O p e n M o d u l e                                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  OpenModule() loads a module, and invokes its registration module.  It
%  returns MagickTrue on success, and MagickFalse if there is an error.
%
%  The format of the OpenModule module is:
%
%      MagickBooleanType OpenModule(const char *module,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o module: a character string that indicates the module to load.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport MagickBooleanType OpenModule(const char *module,
  ExceptionInfo *exception)
{
  char
    filename[MaxTextExtent],
    module_name[MaxTextExtent],
    name[MaxTextExtent],
    path[MaxTextExtent];

  ModuleHandle
    handle;

  ModuleInfo
    *module_info;

  register const CoderInfo
    *p;

  size_t
    length;

  unsigned long
    signature;

  /*
    Assign module name from alias.
  */
  assert(module != (const char *) NULL);
  module_info=(ModuleInfo *) GetModuleInfo(module,exception);
  if (module_info != (ModuleInfo *) NULL)
    return(MagickTrue);
  AcquireSemaphoreInfo(&module_semaphore);
  (void) CopyMagickString(module_name,module,MaxTextExtent);
  p=GetCoderInfo(module,exception);
  if (p != (CoderInfo *) NULL)
    (void) CopyMagickString(module_name,p->name,MaxTextExtent);
  if (GetValueFromSplayTree(module_list,module_name) != (void *) NULL)
    {
      RelinquishSemaphoreInfo(module_semaphore);
      return(MagickTrue);  /* module alread opened, return */
    }
  /*
    Locate module.
  */
  handle=(ModuleHandle) NULL;
  TagToCoderModuleName(module_name,filename);
  (void) LogMagickEvent(ModuleEvent,GetMagickModule(),
    "Searching for module \"%s\" using filename \"%s\"",module_name,filename);
  *path='\0';
  length=GetMagickModulePath(filename,MagickImageCoderModule,path,exception);
  if (length == 0)
    {
      RelinquishSemaphoreInfo(module_semaphore);
      return(MagickFalse);
    }
  /*
    Load module
  */
  handle=lt_dlopen(path);
  if (handle == (ModuleHandle) NULL)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),ModuleError,
        "UnableToLoadModule","`%s': %s",path,lt_dlerror());
      RelinquishSemaphoreInfo(module_semaphore);
      return(MagickFalse);
    }
  (void) LogMagickEvent(ModuleEvent,GetMagickModule(),
    "Opening module at path \"%s\"",path);
  /*
    Register module.
  */
  module_info=(ModuleInfo *) AcquireMagickMemory(sizeof(*module_info));
  if (module_info == (ModuleInfo *) NULL)
    {
      RelinquishSemaphoreInfo(module_semaphore);
      ThrowFatalException(ResourceLimitFatalError,"MemoryAllocationFailed");
    }
  (void) ResetMagickMemory(module_info,0,sizeof(*module_info));
  module_info->path=ConstantString(path);
  module_info->tag=ConstantString(module_name);
  module_info->handle=handle;
  (void) time(&module_info->load_time);
  module_info->signature=MagickSignature;
  if (RegisterModule(module_info,exception) == (ModuleInfo *) NULL)
    {
      RelinquishSemaphoreInfo(module_semaphore);
      return(MagickFalse);
    }
  /*
    Define RegisterFORMATImage method.
  */
  TagToModuleName(module_name,"Register%sImage",name);
  module_info->register_module=(unsigned long (*)(void)) lt_dlsym(handle,name);
  if (module_info->register_module == (unsigned long (*)(void)) NULL)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),ModuleError,
        "UnableToRegisterImageFormat","`%s': %s",module_name,lt_dlerror());
      RelinquishSemaphoreInfo(module_semaphore);
      return(MagickFalse);
    }
  (void) LogMagickEvent(ModuleEvent,GetMagickModule(),
    "Method \"%s\" in module \"%s\" at address %p",name,module_name,
    (void *) module_info->register_module);
  /*
    Define UnregisterFORMATImage method.
  */
  TagToModuleName(module_name,"Unregister%sImage",name);
  module_info->unregister_module=(void (*)(void)) lt_dlsym(handle,name);
  if (module_info->unregister_module == (void (*)(void)) NULL)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),ModuleError,
        "UnableToRegisterImageFormat","`%s': %s",module_name,lt_dlerror());
      RelinquishSemaphoreInfo(module_semaphore);
      return(MagickFalse);
    }
  (void) LogMagickEvent(ModuleEvent,GetMagickModule(),
    "Method \"%s\" in module \"%s\" at address %p",name,module_name,
    (void *) module_info->unregister_module);
  signature=module_info->register_module();
  if (signature != MagickImageCoderSignature)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),ModuleError,
        "CoderSignatureMismatch","`%s': %8lx != %8lx",module_name,signature,
        MagickImageCoderSignature);
      module_info->unregister_module();
      RelinquishSemaphoreInfo(module_semaphore);
      return(MagickFalse);
    }
  RelinquishSemaphoreInfo(module_semaphore);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   O p e n M o d u l e s                                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  OpenModules() loads all available modules.
%
%  The format of the OpenModules module is:
%
%      MagickBooleanType OpenModules(ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport MagickBooleanType OpenModules(ExceptionInfo *exception)
{
  char
    **modules;

  register long
    i;

  unsigned long
    number_modules;

  /*
    Load all modules.
  */
  (void) GetMagickInfo((char *) NULL,exception);
  number_modules=0;
  modules=GetModuleList("*",&number_modules,exception);
  if (modules == (char **) NULL)
    return(MagickFalse);
  for (i=0; i < (long) number_modules; i++)
    (void) OpenModule(modules[i],exception);
  /*
    Free resources.
  */
  for (i=0; i < (long) number_modules; i++)
    modules[i]=DestroyString(modules[i]);
  modules=(char **) RelinquishMagickMemory(modules);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   R e g i s t e r M o d u l e                                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  RegisterModule() adds an entry to the module list.  It returns a pointer to
%  the registered entry on success.
%
%  The format of the RegisterModule module is:
%
%      ModuleInfo *RegisterModule(const ModuleInfo *module_info,
%        ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o info: a pointer to the registered entry is returned.
%
%    o module_info: a pointer to the ModuleInfo structure to register.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
static const ModuleInfo *RegisterModule(const ModuleInfo *module_info,
  ExceptionInfo *exception)
{
  MagickBooleanType
    status;

  assert(module_info != (ModuleInfo *) NULL);
  assert(module_info->signature == MagickSignature);
  (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",module_info->tag);
  if (module_list == (SplayTreeInfo *) NULL)
    return((const ModuleInfo *) NULL);
  status=AddValueToSplayTree(module_list,module_info->tag,module_info);
  if (status == MagickFalse)
    (void) ThrowMagickException(exception,GetMagickModule(),ResourceLimitError,
      "MemoryAllocationFailed","`%s'",module_info->tag);
  return(module_info);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%  T a g T o C o d e r M o d u l e N a m e                                    %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  TagToCoderModuleName() munges a module tag and obtains the filename of the
%  corresponding module module.
%
%  The format of the TagToCoderModuleName module is:
%
%      char *TagToCoderModuleName(const char *tag,char *name)
%
%  A description of each parameter follows:
%
%    o tag: a character string representing the module tag.
%
%    o name: return the module module name here.
%
*/
static void TagToCoderModuleName(const char *tag,char *name)
{
  assert(tag != (char *) NULL);
  (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",tag);
  assert(name != (char *) NULL);
#if defined(HasLTDL)
  (void) FormatMagickString(name,MaxTextExtent,"%s.la",tag);
  (void) LocaleLower(name);
#else
#if defined(__WINDOWS__)
  if (LocaleNCompare("IM_MOD_",tag,7) == 0)
    (void) CopyMagickString(name,tag,MaxTextExtent);
  else
    {
#if defined(_DEBUG)
      (void) FormatMagickString(name,MaxTextExtent,"IM_MOD_DB_%s_.dll",tag);
#else
      (void) FormatMagickString(name,MaxTextExtent,"IM_MOD_RL_%s_.dll",tag);
#endif
    }
#endif
#endif
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%  T a g T o F i l t e r M o d u l e N a m e                                  %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  TagToFilterModuleName() munges a module tag and returns the filename of the
%  corresponding filter module.
%
%  The format of the TagToFilterModuleName module is:
%
%      void TagToFilterModuleName(const char *tag,char name)
%
%  A description of each parameter follows:
%
%    o tag: a character string representing the module tag.
%
%    o name: return the filter name here.
%
*/
static void TagToFilterModuleName(const char *tag,char *name)
{
  assert(tag != (char *) NULL);
  (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",tag);
  assert(name != (char *) NULL);
#if !defined(HasLTDL)
  (void) FormatMagickString(name,MaxTextExtent,"%s.dll",tag);
#else
  (void) FormatMagickString(name,MaxTextExtent,"%s.la",tag);
  (void) LocaleLower(name);
#endif
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   T a g T o M o d u l e N a m e                                             %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  TagToModuleName() munges the module tag name and returns an upper-case tag
%  name as the input string, and a user-provided format.
%
%  The format of the TagToModuleName module is:
%
%      TagToModuleName(const char *tag,const char *format,char *module)
%
%  A description of each parameter follows:
%
%    o tag: the module tag.
%
%    o format: a sprintf-compatible format string containing %s where the
%      upper-case tag name is to be inserted.
%
%    o module: pointer to a destination buffer for the formatted result.
%
*/
static void TagToModuleName(const char *tag,const char *format,char *module)
{
  char
    name[MaxTextExtent];

  assert(tag != (const char *) NULL);
  (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",tag);
  assert(format != (const char *) NULL);
  assert(module != (char *) NULL);
  (void) CopyMagickString(name,tag,MaxTextExtent);
  LocaleUpper(name);
#if !defined(MagickMethodPrefix)
  (void) FormatMagickString(module,MaxTextExtent,format,name);
#else
  {
    char
      prefix_format[MaxTextExtent];

    (void) FormatMagickString(prefix_format,MaxTextExtent,"%s%s",
      MagickMethodPrefix,format);
    (void) FormatMagickString(module,MaxTextExtent,prefix_format,name);
  }
#endif
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   U n r e g i s t e r M o d u l e                                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  UnregisterModule() unloads a module, and invokes its de-registration module.
%  Returns MagickTrue on success, and MagickFalse if there is an error.
%
%  The format of the UnregisterModule module is:
%
%      MagickBooleanType UnregisterModule(const ModuleInfo *module_info,
%        ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o module_info: The module info.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
static MagickBooleanType UnregisterModule(const ModuleInfo *module_info,
  ExceptionInfo *exception)
{
  /*
    Locate and execute UnregisterFORMATImage module.
  */
  assert(module_info != (const ModuleInfo *) NULL);
  (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",module_info->tag);
  assert(exception != (ExceptionInfo *) NULL);
  if (module_info->unregister_module == NULL)
    return(MagickTrue);
  module_info->unregister_module();
  if (lt_dlclose((ModuleHandle) module_info->handle) != 0)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),ModuleWarning,
        "UnableToCloseModule","`%s': %s",module_info->tag,lt_dlerror());
      return(MagickFalse);
    }
  return(MagickTrue);
}
#else
MagickExport MagickBooleanType ListModuleInfo(FILE *magick_unused(file),
  ExceptionInfo *magick_unused(exception))
{
  return(MagickTrue);
}

MagickExport MagickBooleanType InvokeDynamicImageFilter(const char *tag,
  Image **image,const int argc,char **argv,ExceptionInfo *exception)
{
#if !defined(BuildMagickModules)
  {
    extern unsigned long
      analyzeImage(Image **,const int,char **,ExceptionInfo *);

    ImageFilterHandler
      *image_filter;

    image_filter=(ImageFilterHandler *) NULL;
    if (LocaleCompare("analyze",tag) == 0)
      image_filter=analyzeImage;
    if (image_filter != (ImageFilterHandler *) NULL)
      {
        unsigned long
          signature;

        signature=image_filter(image,argc,argv,exception);
        if (signature != MagickImageFilterSignature)
          {
            (void) ThrowMagickException(exception,GetMagickModule(),ModuleError,
              "ImageFilterSignatureMismatch","`%s': %8lx != %8lx",tag,signature,
              MagickImageFilterSignature);
            return(MagickFalse);
          }
      }
  }
#endif
  return(MagickTrue);
}
#endif
