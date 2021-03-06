/*
  Copyright 1999-2007 ImageMagick Studio LLC, a non-profit organization
  dedicated to making software imaging solutions freely available.
  
  You may not use this file except in compliance with the License.
  obtain a copy of the License at
  
    http://www.imagemagick.org/script/license.php
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

  MagickCore image threshold methods.
*/
#ifndef _MAGICKCORE_THRESHOLD_H
#define _MAGICKCORE_THRESHOLD_H

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

typedef struct _ThresholdMap
  ThresholdMap;

extern MagickExport Image
  *AdaptiveThresholdImage(const Image *,const unsigned long,const unsigned long,
    const long,ExceptionInfo *);

extern MagickExport ThresholdMap
  *DestroyThresholdMap(ThresholdMap *),
  *GetThresholdMap(const char *,ExceptionInfo *);

extern MagickExport MagickBooleanType
  BilevelImage(Image *,const double),
  BilevelImageChannel(Image *,const ChannelType,const double),
  BlackThresholdImage(Image *,const char *),
  ListThresholdMaps(FILE *,ExceptionInfo *),
  OrderedDitherImage(Image *),  /* depreciated */
  OrderedDitherImageChannel(Image *,const ChannelType,ExceptionInfo *),
  OrderedPosterizeImage(Image *,const char *,ExceptionInfo *),
  OrderedPosterizeImageChannel(Image *,const ChannelType,const char *,
    ExceptionInfo *),
  RandomThresholdImage(Image *,const char *,ExceptionInfo *),
  RandomThresholdImageChannel(Image *,const ChannelType,const char *,
    ExceptionInfo *),
  WhiteThresholdImage(Image *,const char *);

#if defined(__cplusplus) || defined(c_plusplus)
}
#endif

#endif
