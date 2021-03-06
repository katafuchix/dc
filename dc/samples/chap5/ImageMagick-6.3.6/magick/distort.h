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

  MagickCore image distortion methods.
*/
#ifndef _MAGICKCORE_DISTORT_H
#define _MAGICKCORE_DISTORT_H

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

#include <magick/draw.h>

typedef enum
{
  UndefinedDistortion,
  AffineDistortion,
  AffineProjectionDistortion,
  ArcDistortion,
  BilinearDistortion,
  PerspectiveDistortion,
  PerspectiveProjectionDistortion,
  ScaleRotateTranslateDistortion
} DistortImageMethod;

extern MagickExport Image
  *DistortImage(Image *image,const DistortImageMethod,const unsigned long,
    const double *,const MagickBooleanType,ExceptionInfo *exception);

#if defined(__cplusplus) || defined(c_plusplus)
}
#endif

#endif
