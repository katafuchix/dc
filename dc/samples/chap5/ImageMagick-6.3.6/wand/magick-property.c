/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%                 M   M   AAA    GGGG  IIIII   CCCC  K   K                    %
%                 MM MM  A   A  G        I    C      K  K                     %
%                 M M M  AAAAA  G GGG    I    C      KKK                      %
%                 M   M  A   A  G   G    I    C      K  K                     %
%                 M   M  A   A   GGGG  IIIII   CCCC  K   K                    %
%                                                                             %
%           PPPP    RRRR     OOO   PPPP   EEEEE  RRRR   TTTTT  Y   Y          %
%           P   P   R   R   O   O  P   P  E      R   R    T     Y Y           %
%           PPPP    RRRR    O   O  PPPP   EEE    RRRR     T      Y            %
%           P       R R     O   O  P      E      R R      T      Y            %
%           P       R  R     OOO   P      EEEEE  R  R     T      Y            %
%                                                                             %
%                                                                             %
%            Set or Get MagickWand Properties, Options, or Profiles           %
%                                                                             %
%                               Software Design                               %
%                                 John Cristy                                 %
%                                 August 2003                                 %
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
#include "wand/studio.h"
#include "wand/MagickWand.h"
#include "wand/magick-wand-private.h"
#include "wand/wand.h"

/*
  Define declarations.
*/
#define ThrowWandException(severity,tag,context) \
{ \
  (void) ThrowMagickException(wand->exception,GetMagickModule(),severity, \
    tag,"`%s'",context); \
  return(MagickFalse); \
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k D e l e t e I m a g e P r o p e r t y                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickDeleteImageProperty() deletes a wand property.
%
%  The format of the MagickDeleteImageProperty method is:
%
%      MagickBooleanType MagickDeleteImageProperty(MagickWand *wand,
%        const char *property)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o property: The image property.
%
*/
WandExport MagickBooleanType MagickDeleteImageProperty(MagickWand *wand,
  const char *property)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->images == (Image *) NULL)
    {
      (void) ThrowMagickException(wand->exception,GetMagickModule(),WandError,
        "ContainsNoImages","`%s'",wand->name);
      return(MagickFalse);
    }
  return(DeleteImageProperty(wand->images,property));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k D e l e t e O p t i o n                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickDeleteOption() deletes a wand option.
%
%  The format of the MagickDeleteOption method is:
%
%      MagickBooleanType MagickDeleteOption(MagickWand *wand,
%        const char *option)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o option: The image option.
%
*/
WandExport MagickBooleanType MagickDeleteOption(MagickWand *wand,
  const char *option)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  return(DeleteImageOption(wand->image_info,option));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t A n t i a l i a s                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetAntialias() returns the antialias property associated with the
%  wand.
%
%  The format of the MagickGetAntialias method is:
%
%      MagickBooleanType MagickGetAntialias(const MagickWand *wand)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport MagickBooleanType MagickGetAntialias(const MagickWand *wand)
{
  assert(wand != (const MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  return(wand->image_info->antialias);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t B a c k g r o u n d C o l o r                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetBackgroundColor() returns the wand background color.
%
%  The format of the MagickGetBackgroundColor method is:
%
%      PixelWand *MagickGetBackgroundColor(MagickWand *wand)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport PixelWand *MagickGetBackgroundColor(MagickWand *wand)
{
  PixelWand
    *background_color;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  background_color=NewPixelWand();
  PixelSetQuantumColor(background_color,&wand->image_info->background_color);
  return(background_color);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t C o m p r e s s i o n                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetCompression() gets the wand compression type.
%
%  The format of the MagickGetCompression method is:
%
%      CompressionType MagickGetCompression(MagickWand *wand)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport CompressionType MagickGetCompression(MagickWand *wand)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  return(wand->image_info->compression);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t C o m p r e s s i o n Q u a l i t y                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetCompressionQuality() gets the wand compression quality.
%
%  The format of the MagickGetCompressionQuality method is:
%
%      unsigned long MagickGetCompressionQuality(MagickWand *wand)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport unsigned long MagickGetCompressionQuality(MagickWand *wand)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  return(wand->image_info->quality);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t C o p y r i g h t                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetCopyright() returns the ImageMagick API copyright as a string
%  constant.
%
%  The format of the MagickGetCopyright method is:
%
%      const char *MagickGetCopyright(void)
%
*/
WandExport const char *MagickGetCopyright(void)
{
  return(GetMagickCopyright());
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t F i l e n a m e                                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetFilename() returns the filename associated with an image sequence.
%
%  The format of the MagickGetFilename method is:
%
%      const char *MagickGetFilename(const MagickWand *wand)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%
*/
WandExport char *MagickGetFilename(const MagickWand *wand)
{
  assert(wand != (const MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  return(AcquireString(wand->image_info->filename));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t F o r m a t                                             %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetFormat() returns the format of the magick wand.
%
%  The format of the MagickGetFormat method is:
%
%      const char MagickGetFormat(MagickWand *wand)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport char *MagickGetFormat(MagickWand *wand)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  return(AcquireString(wand->image_info->magick));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t H o m e U R L                                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetHomeURL() returns the ImageMagick home URL.
%
%  The format of the MagickGetHomeURL method is:
%
%      char *MagickGetHomeURL(void)
%
*/
WandExport char *MagickGetHomeURL(void)
{
  return(GetMagickHomeURL());
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t I m a g e P r o f i l e                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetImageProfile() returns the named image profile.
%
%  The format of the MagickGetImageProfile method is:
%
%      unsigned char *MagickGetImageProfile(MagickWand *wand,const char *name,
%        size_t *length)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o name: Name of profile to return: ICC, IPTC, or generic profile.
%
%    o length: The length of the profile.
%
*/
WandExport unsigned char *MagickGetImageProfile(MagickWand *wand,
  const char *name,size_t *length)
{
  const StringInfo
    *profile;

  unsigned char
    *datum;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->images == (Image *) NULL)
    {
      (void) ThrowMagickException(wand->exception,GetMagickModule(),WandError,
        "ContainsNoImages","`%s'",wand->name);
      return((unsigned char *) NULL);
    }
  *length=0;
  if (wand->images->profiles == (SplayTreeInfo *) NULL)
    return((unsigned char *) NULL);
  profile=GetImageProfile(wand->images,name);
  if (profile == (StringInfo *) NULL)
    return((unsigned char *) NULL);
  datum=(unsigned char *) AcquireQuantumMemory(GetStringInfoLength(profile),
    sizeof(*datum));
  if (datum == (unsigned char *) NULL)
    return((unsigned char *) NULL);
  (void) CopyMagickMemory(datum,GetStringInfoDatum(profile),
    GetStringInfoLength(profile));
  *length=(unsigned long) GetStringInfoLength(profile);
  return(datum);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t I m a g e P r o f i l e s                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetImageProfiles() returns all the profile names that match the
%  specified pattern associated with a wand.  Use MagickGetImageProfile() to
%  return the value of a particular property.  Use MagickRelinquishMemory() to
%  free the value when you are finished with it.
%
%  The format of the MagickGetImageProfiles method is:
%
%      char *MagickGetImageProfiles(MagickWand *wand,
%        unsigned long *number_profiles)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o pattern: Specifies a pointer to a text string containing a pattern.
%
%    o number_profiles: The number profiles associated with this wand.
%
*/
WandExport char **MagickGetImageProfiles(MagickWand *wand,const char *pattern,
  unsigned long *number_profiles)
{
  char
    **profiles;

  const char
    *property;

  register long
    i;

  size_t
    length;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->images == (Image *) NULL)
    {
      (void) ThrowMagickException(wand->exception,GetMagickModule(),WandError,
        "ContainsNoImages","`%s'",wand->name);
      return((char **) NULL);
    }
  (void) GetImageProfile(wand->images,"exif:*");
  length=1024;
  profiles=(char **) AcquireQuantumMemory(length,sizeof(*profiles));
  if (profiles == (char **) NULL)
    return((char **) NULL);
  ResetImageProfileIterator(wand->images);
  property=GetNextImageProfile(wand->images);
  for (i=0; property != (const char *) NULL; )
  {
    if ((*property != '[') &&
        (GlobExpression(property,pattern,MagickFalse) != MagickFalse))
      {
        if ((i+1) >= (long) length)
          {
            length<<=1;
            profiles=(char **) ResizeQuantumMemory(profiles,length,
              sizeof(*profiles));
            if (profiles == (char **) NULL)
              {
                (void) ThrowMagickException(wand->exception,GetMagickModule(),
                  ResourceLimitError,"MemoryAllocationFailed","`%s'",
                  wand->name);
                return((char **) NULL);
              }
          }
        profiles[i]=ConstantString(property);
        i++;
      }
    property=GetNextImageProfile(wand->images);
  }
  profiles[i]=(char *) NULL;
  *number_profiles=(unsigned long) i;
  return(profiles);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t I m a g e P r o p e r t y                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetImageProperty() returns a value associated with the specified
%  property.  Use MagickRelinquishMemory() to free the value when you are
%  finished with it.
%
%  The format of the MagickGetImageProperty method is:
%
%      char *MagickGetImageProperty(MagickWand *wand,const char *property)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o property: The property.
%
*/
WandExport char *MagickGetImageProperty(MagickWand *wand,const char *property)
{
  const char
    *value;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->images == (Image *) NULL)
    {
      (void) ThrowMagickException(wand->exception,GetMagickModule(),WandError,
        "ContainsNoImages","`%s'",wand->name);
      return((char *) NULL);
    }
  value=GetImageProperty(wand->images,property);
  if (value == (const char *) NULL)
    return((char *) NULL);
  return(ConstantString(value));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t I m a g e P r o p e r t i e s                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetImageProperties() returns all the property names that match the
%  specified pattern associated with a wand.  Use MagickGetImageProperty() to
%  return the value of a particular property.  Use MagickRelinquishMemory() to
%  free the value when you are finished with it.
%
%  The format of the MagickGetImageProperties method is:
%
%      char *MagickGetImageProperties(MagickWand *wand,
%        const char *pattern,unsigned long *number_properties)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o pattern: Specifies a pointer to a text string containing a pattern.
%
%    o number_properties: The number properties associated with this wand.
%
*/
WandExport char **MagickGetImageProperties(MagickWand *wand,
  const char *pattern,unsigned long *number_properties)
{
  char
    **properties;

  const char
    *property;

  register long
    i;

  size_t
    length;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->images == (Image *) NULL)
    {
      (void) ThrowMagickException(wand->exception,GetMagickModule(),WandError,
        "ContainsNoImages","`%s'",wand->name);
      return((char **) NULL);
    }
  (void) GetImageProperty(wand->images,"exif:*");
  length=1024;
  properties=(char **) AcquireQuantumMemory(length,sizeof(*properties));
  if (properties == (char **) NULL)
    return((char **) NULL);
  ResetImagePropertyIterator(wand->images);
  property=GetNextImageProperty(wand->images);
  for (i=0; property != (const char *) NULL; )
  {
    if ((*property != '[') &&
        (GlobExpression(property,pattern,MagickFalse) != MagickFalse))
      {
        if ((i+1) >= (long) length)
          {
            length<<=1;
            properties=(char **) ResizeQuantumMemory(properties,length,
              sizeof(*properties));
            if (properties == (char **) NULL)
              {
                (void) ThrowMagickException(wand->exception,GetMagickModule(),
                  ResourceLimitError,"MemoryAllocationFailed","`%s'",
                  wand->name);
                return((char **) NULL);
              }
          }
        properties[i]=ConstantString(property);
        i++;
      }
    property=GetNextImageProperty(wand->images);
  }
  properties[i]=(char *) NULL;
  *number_properties=(unsigned long) i;
  return(properties);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t I n t e r l a c e S c h e m e                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetInterlaceScheme() gets the wand interlace scheme.
%
%  The format of the MagickGetInterlaceScheme method is:
%
%      InterlaceType MagickGetInterlaceScheme(MagickWand *wand)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport InterlaceType MagickGetInterlaceScheme(MagickWand *wand)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  return(wand->image_info->interlace);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t I n t e r p o l a t e M e t h o d                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetInterpolateMethod() gets the wand compression.
%
%  The format of the MagickGetInterpolateMethod method is:
%
%      InterpolatePixelMethod MagickGetInterpolateMethod(MagickWand *wand)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport InterpolatePixelMethod MagickGetInterpolateMethod(MagickWand *wand)
{
  const char
    *option;

  InterpolatePixelMethod
    method;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  option=GetImageOption(wand->image_info,"interpolate");
  if (option == (const char *) NULL)
    return(UndefinedInterpolatePixel);
  method=(InterpolatePixelMethod) ParseMagickOption(MagickInterpolateOptions,
    MagickFalse,option);
  return(method);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t O p t i o n                                             %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetOption() returns a value associated with a wand and the specified
%  key.  Use MagickRelinquishMemory() to free the value when you are finished
%  with it.
%
%  The format of the MagickGetOption method is:
%
%      char *MagickGetOption(MagickWand *wand,const char *key)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o key: The key.
%
*/
WandExport char *MagickGetOption(MagickWand *wand,const char *key)
{
  const char
    *option;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  option=GetImageOption(wand->image_info,key);
  return(ConstantString(option));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t O p t i o n                                             %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetOptions() returns all the option names that match the specified
%  pattern associated with a wand.  Use MagickGetOption() to return the value
%  of a particular option.  Use MagickRelinquishMemory() to free the value
%  when you are finished with it.
%
%  The format of the MagickGetOptions method is:
%
%      char *MagickGetOptions(MagickWand *wand,unsigned long *number_options)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o pattern: Specifies a pointer to a text string containing a pattern.
%
%    o number_options: The number options associated with this wand.
%
*/
WandExport char **MagickGetOptions(MagickWand *wand,const char *pattern,
  unsigned long *number_options)
{
  char
    **options;

  const char
    *option;

  register long
    i;

  size_t
    length;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->images == (Image *) NULL)
    {
      (void) ThrowMagickException(wand->exception,GetMagickModule(),WandError,
        "ContainsNoImages","`%s'",wand->name);
      return((char **) NULL);
    }
  length=1024;
  options=(char **) AcquireQuantumMemory(length,sizeof(*options));
  if (options == (char **) NULL)
    return((char **) NULL);
  ResetImageOptionIterator(wand->image_info);
  option=GetNextImageOption(wand->image_info);
  for (i=0; option != (const char *) NULL; )
  {
    if ((*option != '[') &&
        (GlobExpression(option,pattern,MagickFalse) != MagickFalse))
      {
        if ((i+1) >= (long) length)
          {
            length<<=1;
            options=(char **) ResizeQuantumMemory(options,length,
              sizeof(*options));
            if (options == (char **) NULL)
              {
                (void) ThrowMagickException(wand->exception,GetMagickModule(),
                  ResourceLimitError,"MemoryAllocationFailed","`%s'",
                  wand->name);
                return((char **) NULL);
              }
          }
        options[i]=ConstantString(option);
        i++;
      }
    option=GetNextImageOption(wand->image_info);
  }
  options[i]=(char *) NULL;
  *number_options=(unsigned long) i;
  return(options);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t O r i e n t a t i o n                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetOrientation() gets the wand orientation type.
%
%  The format of the MagickGetOrientation method is:
%
%      OrientationType MagickGetOrientation(MagickWand *wand)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport OrientationType MagickGetOrientation(MagickWand *wand)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  return(wand->image_info->orientation);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t P a c k a g e N a m e                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetPackageName() returns the ImageMagick package name as a string
%  constant.
%
%  The format of the MagickGetPackageName method is:
%
%      const char *MagickGetPackageName(void)
%
%
*/
WandExport const char *MagickGetPackageName(void)
{
  return(GetMagickPackageName());
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t P a g e                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetPage() returns the page geometry associated with the magick wand.
%
%  The format of the MagickGetPage method is:
%
%      MagickBooleanType MagickGetPage(const MagickWand *wand,
%        unsigned long *width,unsigned long *height,long *x,long *y)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o width: The page width.
%
%    o height: page height.
%
%    o x: The page x-offset.
%
%    o y: The page y-offset.
%
*/
WandExport MagickBooleanType MagickGetPage(const MagickWand *wand,
  unsigned long *width,unsigned long *height,long *x,long *y)
{
  RectangleInfo
    geometry;

  assert(wand != (const MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  (void) ResetMagickMemory(&geometry,0,sizeof(geometry));
  (void) ParseAbsoluteGeometry(wand->image_info->page,&geometry);
  *width=geometry.width;
  *height=geometry.height;
  *x=geometry.x;
  *y=geometry.y;
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t Q u a n t u m D e p t h                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetQuantumDepth() returns the ImageMagick quantum depth as a string
%  constant.
%
%  The format of the MagickGetQuantumDepth method is:
%
%      const char *MagickGetQuantumDepth(unsigned long *depth)
%
%  A description of each parameter follows:
%
%    o depth: The quantum depth is returned as a number.
%
%
*/
WandExport const char *MagickGetQuantumDepth(unsigned long *depth)
{
  return(GetMagickQuantumDepth(depth));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t Q u a n t u m R a n g e                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetQuantumRange() returns the ImageMagick quantum range as a string
%  constant.
%
%  The format of the MagickGetQuantumRange method is:
%
%      const char *MagickGetQuantumRange(unsigned long *range)
%
%  A description of each parameter follows:
%
%    o range: The quantum range is returned as a number.
%
%
*/
WandExport const char *MagickGetQuantumRange(unsigned long *range)
{
  return(GetMagickQuantumRange(range));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t R e l e a s e D a t e                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetReleaseDate() returns the ImageMagick release date as a string
%  constant.
%
%  The format of the MagickGetReleaseDate method is:
%
%      const char *MagickGetReleaseDate(void)
%
*/
WandExport const char *MagickGetReleaseDate(void)
{
  return(GetMagickReleaseDate());
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t R e s o u r c e                                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetResource() returns the specified resource in megabytes.
%
%  The format of the MagickGetResource method is:
%
%      unsigned long MagickGetResource(const ResourceType type)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport unsigned long MagickGetResource(const ResourceType type)
{
  return(GetMagickResource(type));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t R e s o u r c e L i m i t                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetResourceLimit() returns the specified resource limit in megabytes.
%
%  The format of the MagickGetResourceLimit method is:
%
%      unsigned long MagickGetResourceLimit(const ResourceType type)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport unsigned long MagickGetResourceLimit(const ResourceType type)
{
  return(GetMagickResourceLimit(type));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t S a m p l i n g F a c t o r s                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetSamplingFactors() gets the horizontal and vertical sampling factor.
%
%  The format of the MagickGetSamplingFactors method is:
%
%      double *MagickGetSamplingFactor(MagickWand *wand,
%        unsigned long *number_factors)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o number_factors: The number of factors in the returned array.
%
*/
WandExport double *MagickGetSamplingFactors(MagickWand *wand,
  unsigned long *number_factors)
{
  double
    *sampling_factors;

  register const char
    *p;

  register long
    i;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  *number_factors=0;
  sampling_factors=(double *) NULL;
  if (wand->image_info->sampling_factor == (char *) NULL)
    return(sampling_factors);
  i=0;
  for (p=wand->image_info->sampling_factor; p != (char *) NULL; p=strchr(p,','))
  {
    while (((int) *p != 0) && ((isspace((int) ((unsigned char) *p)) != 0) ||
           (*p == ',')))
      p++;
    i++;
  }
  sampling_factors=(double *) AcquireQuantumMemory((size_t) i,
    sizeof(*sampling_factors));
  if (sampling_factors == (double *) NULL)
    ThrowWandFatalException(ResourceLimitFatalError,"MemoryAllocationFailed",
      wand->image_info->filename);
  i=0;
  for (p=wand->image_info->sampling_factor; p != (char *) NULL; p=strchr(p,','))
  {
    while (((int) *p != 0) && ((isspace((int) ((unsigned char) *p)) != 0) ||
           (*p == ',')))
      p++;
    sampling_factors[i]=atof(p);
    i++;
  }
  *number_factors=(unsigned long) i;
  return(sampling_factors);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t S i z e                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetSize() returns the size associated with the magick wand.
%
%  The format of the MagickGetSize method is:
%
%      MagickBooleanType MagickGetSize(const MagickWand *wand,
%        unsigned long *columns,unsigned long *rows)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o columns: The width in pixels.
%
%    o height: The height in pixels.
%
*/
WandExport MagickBooleanType MagickGetSize(const MagickWand *wand,
  unsigned long *columns,unsigned long *rows)
{
  RectangleInfo
    geometry;

  assert(wand != (const MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  (void) ResetMagickMemory(&geometry,0,sizeof(geometry));
  (void) ParseAbsoluteGeometry(wand->image_info->size,&geometry);
  *columns=geometry.width;
  *rows=geometry.height;
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t S i z e O f f s e t                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetSizeOffset() returns the size offset associated with the magick
%  wand.
%
%  The format of the MagickGetSizeOffset method is:
%
%      MagickBooleanType MagickGetSizeOffset(const MagickWand *wand,
%        long *offset)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o offset: The image offset.
%
*/
WandExport MagickBooleanType MagickGetSizeOffset(const MagickWand *wand,
  long *offset)
{
  RectangleInfo
    geometry;

  assert(wand != (const MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  (void) ResetMagickMemory(&geometry,0,sizeof(geometry));
  (void) ParseAbsoluteGeometry(wand->image_info->size,&geometry);
  *offset=geometry.x;
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t T y p e                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetType() returns the wand type.
%
%  The format of the MagickGetType method is:
%
%      ImageType MagickGetType(MagickWand *wand)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
*/
WandExport ImageType MagickGetType(MagickWand *wand)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  return(wand->image_info->type);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k G e t V e r s i o n                                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickGetVersion() returns the ImageMagick API version as a string constant
%  and as a number.
%
%  The format of the MagickGetVersion method is:
%
%      const char *MagickGetVersion(unsigned long *version)
%
%  A description of each parameter follows:
%
%    o version: The ImageMagick version is returned as a number.
%
*/
WandExport const char *MagickGetVersion(unsigned long *version)
{
  return(GetMagickVersion(version));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k P r o f i l e I m a g e                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickProfileImage() adds or removes a ICC, IPTC, or generic profile
%  from an image.  If the profile is NULL, it is removed from the image
%  otherwise added.  Use a name of '*' and a profile of NULL to remove all
%  profiles from the image.
%
%  The format of the MagickProfileImage method is:
%
%      MagickBooleanType MagickProfileImage(MagickWand *wand,const char *name,
%        const void *profile,const size_t length)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o name: Name of profile to add or remove: ICC, IPTC, or generic profile.
%
%    o profile: The profile.
%
%    o length: The length of the profile.
%
*/
WandExport MagickBooleanType MagickProfileImage(MagickWand *wand,
  const char *name,const void *profile,const size_t length)
{
  MagickBooleanType
    status;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->images == (Image *) NULL)
    ThrowWandException(WandError,"ContainsNoImages",wand->name);
  status=ProfileImage(wand->images,name,profile,length,MagickTrue);
  if (status == MagickFalse)
    InheritException(wand->exception,&wand->images->exception);
  return(status);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k R e m o v e I m a g e P r o f i l e                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickRemoveImageProfile() removes the named image profile and returns it.
%
%  The format of the MagickRemoveImageProfile method is:
%
%      unsigned char *MagickRemoveImageProfile(MagickWand *wand,
%        const char *name,size_t *length)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o name: Name of profile to return: ICC, IPTC, or generic profile.
%
%    o length: The length of the profile.
%
*/
WandExport unsigned char *MagickRemoveImageProfile(MagickWand *wand,
  const char *name,size_t *length)
{
  StringInfo
    *profile;

  unsigned char
    *datum;
  
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->images == (Image *) NULL)
    {
      (void) ThrowMagickException(wand->exception,GetMagickModule(),WandError,
        "ContainsNoImages","`%s'",wand->name);
      return((unsigned char *) NULL);
    }
  *length=0;
  profile=RemoveImageProfile(wand->images,name);
  if (profile == (StringInfo *) NULL)
    return((unsigned char *) NULL);
  datum=(unsigned char *) AcquireQuantumMemory(GetStringInfoLength(profile),
    sizeof(*datum));
  if (datum == (unsigned char *) NULL)
    return((unsigned char *) NULL);
  (void) CopyMagickMemory(datum,GetStringInfoDatum(profile),
    GetStringInfoLength(profile));
  *length=GetStringInfoLength(profile);
  profile=DestroyStringInfo(profile);
  return(datum);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t A n t i a l i a s                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetAntialias() sets the antialias propery of the wand.
%
%  The format of the MagickSetAntialias method is:
%
%      MagickBooleanType MagickSetAntialias(MagickWand *wand,
%        const MagickBooleanType antialias)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o antialias: The antialias property.
%
*/
WandExport MagickBooleanType MagickSetAntialias(MagickWand *wand,
  const MagickBooleanType antialias)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  wand->image_info->antialias=antialias;
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t B a c k g r o u n d C o l o r                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetBackgroundColor() sets the wand background color.
%
%  The format of the MagickSetBackgroundColor method is:
%
%      MagickBooleanType MagickSetBackgroundColor(MagickWand *wand,
%        const PixelWand *background)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o background: The background pixel wand.
%
*/
WandExport MagickBooleanType MagickSetBackgroundColor(MagickWand *wand,
  const PixelWand *background)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  PixelGetQuantumColor(background,&wand->image_info->background_color);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t C o m p r e s s i o n                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetCompression() sets the wand compression type.
%
%  The format of the MagickSetCompression method is:
%
%      MagickBooleanType MagickSetCompression(MagickWand *wand,
%        const CompressionType compression)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o compression: The wand compression.
%
*/
WandExport MagickBooleanType MagickSetCompression(MagickWand *wand,
  const CompressionType compression)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  wand->image_info->compression=compression;
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t C o m p r e s s i o n Q u a l i t y                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetCompressionQuality() sets the wand compression quality.
%
%  The format of the MagickSetCompressionQuality method is:
%
%      MagickBooleanType MagickSetCompressionQuality(MagickWand *wand,
%        const unsigned long quality)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o quality: The wand compression quality.
%
*/
WandExport MagickBooleanType MagickSetCompressionQuality(MagickWand *wand,
  const unsigned long quality)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  wand->image_info->quality=quality;
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t D e p t h                                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetDepth() sets the wand pixel depth.
%
%  The format of the MagickSetDepth method is:
%
%      MagickBooleanType MagickSetDepth(MagickWand *wand,
%        const unsigned long depth)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o depth: The wand pixel depth.
%
*/
WandExport MagickBooleanType MagickSetDepth(MagickWand *wand,
  const unsigned long depth)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  wand->image_info->depth=depth;
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t F i l e n a m e                                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetFilename() sets the filename before you read or write an image file.
%
%  The format of the MagickSetFilename method is:
%
%      MagickBooleanType MagickSetFilename(MagickWand *wand,
%        const char *filename)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o filename: The image filename.
%
*/
WandExport MagickBooleanType MagickSetFilename(MagickWand *wand,
  const char *filename)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (filename != (const char *) NULL)
    (void) CopyMagickString(wand->image_info->filename,filename,MaxTextExtent);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t F o r m a t                                             %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetFormat() sets the format of the magick wand.
%
%  The format of the MagickSetFormat method is:
%
%      MagickBooleanType MagickSetFormat(MagickWand *wand,const char *format)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o format: The image format.
%
*/
WandExport MagickBooleanType MagickSetFormat(MagickWand *wand,
  const char *format)
{
  const MagickInfo
    *magick_info;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if ((format == (char *) NULL) || (*format == '\0'))
    {
      *wand->image_info->magick='\0';
      return(MagickTrue);
    }
  magick_info=GetMagickInfo(format,wand->exception);
  if (magick_info == (const MagickInfo *) NULL)
    return(MagickFalse);
  ClearMagickException(wand->exception);
  (void) CopyMagickString(wand->image_info->magick,format,MaxTextExtent);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t P r o f i l e I m a g e                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetImageProfile() adds a named profile to the magick wand.  If a
%  profile with the same name already exists, it is replaced.  This method
%  differs from the MagickProfileImage() method in that it does not apply any
%  CMS color profiles.
%
%  The format of the MagickSetImageProfile method is:
%
%      MagickBooleanType MagickSetImageProfile(MagickWand *wand,
%        const char *name,const void *profile,const size_t length)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o name: Name of profile to add or remove: ICC, IPTC, or generic profile.
%
%    o profile: The profile.
%
%    o length: The length of the profile.
%
*/
WandExport MagickBooleanType MagickSetImageProfile(MagickWand *wand,
  const char *name,const void *profile,const size_t length)
{
  MagickBooleanType
    status;

  StringInfo
    *profile_info;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->images == (Image *) NULL)
    ThrowWandException(WandError,"ContainsNoImages",wand->name);
  profile_info=AcquireStringInfo((size_t) length);
  SetStringInfoDatum(profile_info,(unsigned char *) profile);
  status=SetImageProfile(wand->images,name,profile_info);
  if (status == MagickFalse)
    InheritException(wand->exception,&wand->images->exception);
  return(status);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t I m a g e P r o p e r t y                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetImageProperty() associates a property with an image.
%
%  The format of the MagickSetImageProperty method is:
%
%      MagickBooleanType MagickSetImageProperty(MagickWand *wand,
%        const char *property,const char *value)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o property: The property.
%
%    o value: The value.
%
*/
WandExport MagickBooleanType MagickSetImageProperty(MagickWand *wand,
  const char *property,const char *value)
{
  MagickBooleanType
    status;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->images == (Image *) NULL)
    ThrowWandException(WandError,"ContainsNoImages",wand->name);
  status=SetImageProperty(wand->images,property,value);
  if (status == MagickFalse)
    InheritException(wand->exception,&wand->images->exception);
  return(status);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t I n t e r l a c e S c h e m e                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetInterlaceScheme() sets the image compression.
%
%  The format of the MagickSetInterlaceScheme method is:
%
%      MagickBooleanType MagickSetInterlaceScheme(MagickWand *wand,
%        const InterlaceType interlace_scheme)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o interlace_scheme: The image interlace scheme: NoInterlace, LineInterlace,
%      PlaneInterlace, PartitionInterlace.
%
*/
WandExport MagickBooleanType MagickSetInterlaceScheme(MagickWand *wand,
  const InterlaceType interlace_scheme)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  wand->image_info->interlace=interlace_scheme;
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t I n t e r p o l a t e M e t h o d                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetInterpolateMethod() sets the interpolate pixel method.
%
%  The format of the MagickSetInterpolateMethod method is:
%
%      MagickBooleanType MagickSetInterpolateMethod(MagickWand *wand,
%        const InterpolateMethodPixel method)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o method: The interpolate pixel method.
%
*/
WandExport MagickBooleanType MagickSetInterpolateMethod(MagickWand *wand,
  const InterpolatePixelMethod method)
{
  MagickBooleanType
    status;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  status=SetImageOption(wand->image_info,"interpolate",
    MagickOptionToMnemonic(MagickInterpolateOptions,(long) method));
  return(status);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t O p t i o n                                             %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetOption() associates one or options with the wand (.e.g
%  MagickSetOption(wand,"jpeg:perserve","yes")).
%
%  The format of the MagickSetOption method is:
%
%      MagickBooleanType MagickSetOption(MagickWand *wand,const char *key,
%        const char *value)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o key:  The key.
%
%    o value:  The value.
%
*/
WandExport MagickBooleanType MagickSetOption(MagickWand *wand,const char *key,
  const char *value)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  return(SetImageOption(wand->image_info,key,value));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t O r i e n t a t i o n                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetOrientation() sets the wand orientation type.
%
%  The format of the MagickSetOrientation method is:
%
%      MagickBooleanType MagickSetOrientation(MagickWand *wand,
%        const OrientationType orientation)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o orientation: The wand orientation.
%
*/
WandExport MagickBooleanType MagickSetOrientation(MagickWand *wand,
  const OrientationType orientation)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  wand->image_info->orientation=orientation;
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t P a g e                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetPage() sets the page geometry of the magick wand.
%
%  The format of the MagickSetPage method is:
%
%      MagickBooleanType MagickSetPage(MagickWand *wand,
%        const unsigned long width,const unsigned long height,const long x,
%        const long y)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o width: The page width.
%
%    o height: The page height.
%
%    o x: The page x-offset.
%
%    o y: The page y-offset.
%
*/
WandExport MagickBooleanType MagickSetPage(MagickWand *wand,
  const unsigned long width,const unsigned long height,const long x,
  const long y)
{
  char
    geometry[MaxTextExtent];

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  (void) FormatMagickString(geometry,MaxTextExtent,"%lux%lu%+ld%+ld",
    width,height,x,y);
  (void) CloneString(&wand->image_info->page,geometry);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t P a s s p h r a s e                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetPassphrase() sets the passphrase.
%
%  The format of the MagickSetPassphrase method is:
%
%      MagickBooleanType MagickSetPassphrase(MagickWand *wand,
%        const char *passphrase)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o passphrase: The passphrase.
%
*/
WandExport MagickBooleanType MagickSetPassphrase(MagickWand *wand,
  const char *passphrase)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  (void) CloneString(&wand->image_info->authenticate,passphrase);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t P r o g r e s s M o n i t o r                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetProgressMonitor() sets the wand progress monitor to the specified
%  method and returns the previous progress monitor if any.  The progress
%  monitor method looks like this:
%
%    MagickBooleanType MagickProgressMonitor(const char *text,
%      const MagickOffsetType offset,const MagickSizeType span,
%      void *client_data)
%
%  If the progress monitor returns MagickFalse, the current operation is
%  interrupted.
%
%  The format of the MagickSetProgressMonitor method is:
%
%      MagickProgressMonitor MagickSetProgressMonitor(MagickWand *wand
%        const MagickProgressMonitor progress_monitor,void *client_data)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o progress_monitor: Specifies a pointer to a method to monitor progress
%      of an image operation.
%
%    o client_data: Specifies a pointer to any client data.
%
*/
WandExport MagickProgressMonitor MagickSetProgressMonitor(MagickWand *wand,
  const MagickProgressMonitor progress_monitor,void *client_data)
{
  MagickProgressMonitor
    previous_monitor;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  previous_monitor=SetImageInfoProgressMonitor(wand->image_info,
    progress_monitor,client_data);
  return(previous_monitor);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t R e s o u r c e L i m i t                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetResourceLimit() sets the limit for a particular resource in
%  megabytes.
%
%  The format of the MagickSetResourceLimit method is:
%
%      MagickBooleanType MagickSetResourceLimit(const ResourceType type,
%        const unsigned long *limit)
%
%  A description of each parameter follows:
%
%    o type: The type of resource: AreaResource, MemoryResource, MapResource,
%      DiskResource, FileResource.
%
%    o The maximum limit for the resource.
%
*/
WandExport MagickBooleanType MagickSetResourceLimit(const ResourceType type,
  const unsigned long limit)
{
  return(SetMagickResourceLimit(type,limit));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t R e s o l u t i o n                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetResolution() sets the image resolution.
%
%  The format of the MagickSetResolution method is:
%
%      MagickBooleanType MagickSetResolution(MagickWand *wand,
%        const double x_resolution,const doubtl y_resolution)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o x_resolution: The image x resolution.
%
%    o y_resolution: The image y resolution.
%
*/
WandExport MagickBooleanType MagickSetResolution(MagickWand *wand,
  const double x_resolution,const double y_resolution)
{
  char
    density[MaxTextExtent];

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  (void) FormatMagickString(density,MaxTextExtent,"%gx%g",x_resolution,
    y_resolution);
  (void) CloneString(&wand->image_info->density,density);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t S a m p l i n g F a c t o r s                           %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetSamplingFactors() sets the image sampling factors.
%
%  The format of the MagickSetSamplingFactors method is:
%
%      MagickBooleanType MagickSetSamplingFactors(MagickWand *wand,
%        const unsigned long number_factors,const double *sampling_factors)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o number_factoes: The number of factors.
%
%    o sampling_factors: An array of doubles representing the sampling factor
%      for each color component (in RGB order).
%
*/
WandExport MagickBooleanType MagickSetSamplingFactors(MagickWand *wand,
  const unsigned long number_factors,const double *sampling_factors)
{
  char
    sampling_factor[MaxTextExtent];

  register long
    i;

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  if (wand->image_info->sampling_factor != (char *) NULL)
    wand->image_info->sampling_factor=(char *)
      RelinquishMagickMemory(wand->image_info->sampling_factor);
  if (number_factors == 0)
    return(MagickTrue);
  for (i=0; i < (long) (number_factors-1); i++)
  {
    (void) FormatMagickString(sampling_factor,MaxTextExtent,"%g,",
      sampling_factors[i]);
    (void) ConcatenateString(&wand->image_info->sampling_factor,
      sampling_factor);
  }
  (void) FormatMagickString(sampling_factor,MaxTextExtent,"%g",
    sampling_factors[i]);
  (void) ConcatenateString(&wand->image_info->sampling_factor,sampling_factor);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t S i z e                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetSize() sets the size of the magick wand.  Set it before you
%  read a raw image format such as RGB, GRAY, or CMYK.
%
%  The format of the MagickSetSize method is:
%
%      MagickBooleanType MagickSetSize(MagickWand *wand,
%        const unsigned long columns,const unsigned long rows)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o columns: The width in pixels.
%
%    o rows: The rows in pixels.
%
*/
WandExport MagickBooleanType MagickSetSize(MagickWand *wand,
  const unsigned long columns,const unsigned long rows)
{
  char
    geometry[MaxTextExtent];

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  (void) FormatMagickString(geometry,MaxTextExtent,"%lux%lu",columns,rows);
  (void) CloneString(&wand->image_info->size,geometry);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t S i z e O f f s e t                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetSizeOffset() sets the size and offset of the magick wand.  Set it
%  before you read a raw image format such as RGB, GRAY, or CMYK.
%
%  The format of the MagickSetSizeOffset method is:
%
%      MagickBooleanType MagickSetSizeOffset(MagickWand *wand,
%        const unsigned long columns,const unsigned long rows,
%        const long offset)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o columns: The width in pixels.
%
%    o rows: The rows in pixels.
%
*/
WandExport MagickBooleanType MagickSetSizeOffset(MagickWand *wand,
  const unsigned long columns,const unsigned long rows,const long offset)
{
  char
    geometry[MaxTextExtent];

  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  (void) FormatMagickString(geometry,MaxTextExtent,"%lux%lu%+ld",columns,rows,
    offset);
  (void) CloneString(&wand->image_info->size,geometry);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g i c k S e t T y p e                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagickSetType() sets the image type attribute.
%
%  The format of the MagickSetType method is:
%
%      MagickBooleanType MagickSetType(MagickWand *wand,
%        const ImageType image_type)
%
%  A description of each parameter follows:
%
%    o wand: The magick wand.
%
%    o image_type: The image type:   UndefinedType, BilevelType, GrayscaleType,
%      GrayscaleMatteType, PaletteType, PaletteMatteType, TrueColorType,
%      TrueColorMatteType, ColorSeparationType, ColorSeparationMatteType,
%      or OptimizeType.
%
*/
WandExport MagickBooleanType MagickSetType(MagickWand *wand,
  const ImageType image_type)
{
  assert(wand != (MagickWand *) NULL);
  assert(wand->signature == WandSignature);
  if (wand->debug != MagickFalse)
    (void) LogMagickEvent(WandEvent,GetMagickModule(),"%s",wand->name);
  wand->image_info->type=image_type;
  return(MagickTrue);
}
