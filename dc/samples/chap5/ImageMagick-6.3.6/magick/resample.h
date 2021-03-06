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

  MagickCore graphic resample methods.
*/
#ifndef _MAGICKCORE_RESAMPLE_H
#define _MAGICKCORE_RESAMPLE_H

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

#include <magick/cache-view.h>

typedef enum
{
  UndefinedInterpolatePixel,
  AverageInterpolatePixel,
  BicubicInterpolatePixel,
  BilinearInterpolatePixel,
  FilterInterpolatePixel,
  IntegerInterpolatePixel,
  MeshInterpolatePixel,
  NearestNeighborInterpolatePixel,
  SplineInterpolatePixel
} InterpolatePixelMethod;

typedef struct _ResampleFilter
  ResampleFilter;

extern MagickExport MagickBooleanType
  SetResampleFilterInterpolateMethod(ResampleFilter *,
    const InterpolatePixelMethod),
  SetResampleFilterVirtualPixelMethod(ResampleFilter *,
    const VirtualPixelMethod);

extern MagickExport ResampleFilter
  *AcquireResampleFilter(const Image *,ExceptionInfo *),
  *DestroyResampleFilter(ResampleFilter *);

extern MagickExport void
  ScaleResampleFilter(ResampleFilter *,const double,const double,const double,
    const double);

extern MagickExport MagickPixelPacket
  ResamplePixelColor(ResampleFilter *,const double,const double);

#if defined(__cplusplus) || defined(c_plusplus)
}
#endif

#endif
