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

  MagickCore types.
*/
#ifndef _MAGICKCORE_MAGICK_TYPE_H
#define _MAGICKCORE_MAGICK_TYPE_H

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

#include "magick/magick-config.h"

#if !defined(QuantumDepth)
#define QuantumDepth  16
#endif

#if defined(__WINDOWS__) && !defined(__MINGW32__)
#  define MagickLLConstant(c)  (MagickOffsetType) (c ## i64)
#  define MagickULLConstant(c)  (MagickSizeType) (c ## ui64)
#else
#  define MagickLLConstant(c)  (MagickOffsetType) (c ## LL)
#  define MagickULLConstant(c)  (MagickSizeType) (c ## ULL)
#endif

#if (QuantumDepth == 8)
#define MagickEpsilon  1.0e-6
#define MagickHuge     1.0e6
#define MaxColormapSize  256UL
#define MaxMap  255UL
#define QuantumRange  255UL

typedef float MagickRealType;
#if defined(UseHDRI)
typedef float Quantum;
#define QuantumFormat  "%g"
#else
typedef unsigned char Quantum;
#define QuantumFormat  "%u"
#endif
typedef unsigned long QuantumAny;
#elif (QuantumDepth == 16)
#define MagickEpsilon  1.0e-10
#define MagickHuge     1.0e12
#define MaxColormapSize  65536UL
#define MaxMap  65535UL
#define QuantumRange  65535UL

typedef double MagickRealType;
#if defined(UseHDRI)
typedef float Quantum;
#define QuantumFormat  "%g"
#else
typedef unsigned short Quantum;
#define QuantumFormat  "%u"
#endif
typedef unsigned long QuantumAny;
#elif (QuantumDepth == 32)
#define MagickEpsilon  1.0e-10
#define MagickHuge     1.0e12
#define MaxColormapSize  65536UL
#define MaxMap  65535UL
#define QuantumRange  4294967295UL

#if defined(HAVE_LONG_DOUBLE)
typedef long double MagickRealType;
#else
typedef double MagickRealType;
#endif
#if defined(UseHDRI)
typedef float Quantum;
#define QuantumFormat  "%g"
#else
typedef unsigned int Quantum;
#define QuantumFormat  "%u"
#endif
typedef unsigned long QuantumAny;
#elif (QuantumDepth == 64) && defined(HAVE_LONG_DOUBLE)
#define MagickEpsilon  1.0e-10
#define MagickHuge     1.0e12
#define MaxColormapSize  65536UL
#define MaxMap  65535UL
#define QuantumRange  MagickULLConstant(18446744073709551615)

typedef long double MagickRealType;
#if defined(UseHDRI)
typedef double Quantum;
#define QuantumFormat  "%g"
#else
typedef unsigned long long Quantum;
#define QuantumFormat  "%llu"
#endif
typedef unsigned long long QuantumAny;
#else
#if !defined(_CH_)
# error "Specified value of QuantumDepth is not supported"
#endif
#endif
#define MaxRGB  QuantumRange  /* deprecated */

/*
  Typedef declarations.
*/
typedef unsigned int MagickStatusType;
#if !defined(__WINDOWS__)
#if (SIZEOF_LONG_LONG == 8)
typedef long long MagickOffsetType;
typedef unsigned long long MagickSizeType;
#define MagickSizeFormat  "%10llu"
#else
typedef long MagickOffsetType;
typedef unsigned long MagickSizeType;
#define MagickSizeFormat  "%10lu"
#endif
#else
typedef __int64 MagickOffsetType;
typedef unsigned __int64 MagickSizeType;
#define MagickSizeFormat  "%10llu"
#endif

#if defined(macintosh)
#define ExceptionInfo  MagickExceptionInfo
#endif

typedef enum
{
  UndefinedChannel,
  RedChannel = 0x0001,
  GrayChannel = 0x0001,
  CyanChannel = 0x0001,
  GreenChannel = 0x0002,
  MagentaChannel = 0x0002,
  BlueChannel = 0x0004,
  YellowChannel = 0x0004,
  AlphaChannel = 0x0008,
  OpacityChannel = 0x0008,
  MatteChannel = 0x0008,  /* deprecated */
  BlackChannel = 0x0020,
  IndexChannel = 0x0020,
  AllChannels = 0xff,
  DefaultChannels = (AllChannels &~ OpacityChannel)
} ChannelType;

typedef enum
{
  UndefinedClass,
  DirectClass,
  PseudoClass
} ClassType;

typedef enum
{
  MagickFalse = 0,
  MagickTrue = 1
} MagickBooleanType;

typedef struct _BlobInfo BlobInfo;

typedef struct _ExceptionInfo ExceptionInfo;

typedef struct _Image Image;

typedef struct _ImageInfo ImageInfo;

#if defined(__cplusplus) || defined(c_plusplus)
}
#endif

#endif
