/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                 RRRR   EEEEE  SSSSS  IIIII  ZZZZZ  EEEEE                    %
%                 R   R  E      SS       I       ZZ  E                        %
%                 RRRR   EEE     SSS     I     ZZZ   EEE                      %
%                 R R    E         SS    I    ZZ     E                        %
%                 R  R   EEEEE  SSSSS  IIIII  ZZZZZ  EEEEE                    %
%                                                                             %
%                                                                             %
%                     ImageMagick Image Resize Methods                        %
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
#include "magick/artifact.h"
#include "magick/blob.h"
#include "magick/cache-view.h"
#include "magick/color.h"
#include "magick/color-private.h"
#include "magick/draw.h"
#include "magick/exception.h"
#include "magick/exception-private.h"
#include "magick/gem.h"
#include "magick/image.h"
#include "magick/image-private.h"
#include "magick/list.h"
#include "magick/memory_.h"
#include "magick/pixel-private.h"
#include "magick/property.h"
#include "magick/monitor.h"
#include "magick/quantum.h"
#include "magick/option.h"
#include "magick/resample.h"
#include "magick/resize.h"
#include "magick/resize-private.h"
#include "magick/string_.h"
#include "magick/utility.h"
#include "magick/version.h"

/*
  Typedef declarations.
*/
struct _ResizeFilter
{
  MagickRealType
    (*filter)(const MagickRealType),
    (*window)(const MagickRealType),
    support,
    wscale,
    blur;

  unsigned long
    signature;
};

/*
  Forward declaractions.
*/
static MagickRealType
  I0(MagickRealType x),
  BesselOrderOne(MagickRealType);

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   A c q u i r e R e s i z e F i l t e r                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  AcquireResizeFilter() allocates the ResizeFilter structure.  Choose from
%  these filters:
%
%  FIR (Finite impulse Response) Filters
%      Box         Triangle   Quadratic
%      Cubic       Hermite    Catrom
%      Mitchell
%
%  IIR (Infinite impulse Response) Filters
%      Gaussian     Sinc        Bessel
%
%  Windowed Sinc/Bessel Method
%      Blackman     Hanning     Hamming
%      Kaiser       Lancos (Sinc)
%
%  FIR filters are used as is, and are limited by that filters support window
%  (unless over-ridden).  'Gaussian' while classed as an IIR filter, is also
%  simply clipped by its support size (1.5).
%
%  Requesting a windowed filter will return either a windowed Sinc, for a one
%  dimentional orthogonal filtering method, such as ResizeImage(), or a
%  windowed Bessel for image operations requiring a two dimentional
%  cylindrical filtering method, such a DistortImage().  Which function is
%  is used set by the "cylindrical" boolean argument.
%
%  Directly requesting 'Sinc' or 'Bessel' will force the use of that filter
%  function, with a default 'Blackman' windowing method.  This is not however
%  recommended as it removes the correct filter selection for different
%  filtering image operations.  Selecting a window filtering method is better.
%
%  Lanczos is purely special case of a Sinc windowed Sinc, but defulting to
%  a 3 lobe support, rather that the default 4 lobe support.
%
%  Special options can be used to override specific, or all the filter
%  settings.   However doing so is not advisible unless you have expert
%  knowledge of the use of resampling filtered techniques. Extreme caution is
%  advised.
%
%    "filter:filter"    Select this function as the filter.
%        If a "filter:window" operation is not provided, then no windowing
%        will be performed on the selected filter, (support clipped)
%
%        This can be used to force the use of a windowing method as filter,
%        request a 'Sinc' filter in a radially filtered operation, or the
%        'Bessel' filter for a othogonal filtered operation.
%
%    "filter:window"   Select this windowing function for the filter.
%        While any filter could be used as a windowing function,
%        using that filters first lobe over the whole support window,
%        using a non-windowing method is not advisible.
%
%    "filter:lobes"    Number of lobes to use for the Sinc/Bessel filter.
%        This is a simper method of setting filter support size that will
%        correctly handle the Sinc/Bessel switch for an operators filtering
%        requirements.
%
%    "filter:support"  Set the support size for filtering to the size given
%        This is not recomented for Sinc/Bessel windowed filters, but is
%        used for simple filters like FIR filters, and the Gaussian Filter.
%        This will override any 'filter:lobes' option.
%
%    "filter:blur"     Scale the filter and support window by this amount.
%        A value >1 will generally result in a more burred image with
%        more ringing effects, while a value <1 will sharpen the
%        resulting image with more aliasing and Morie effects.
%
%  Set a true un-windowed Sinc filter with 10 lobes (very slow)
%     -set option:filter:filter  Sinc
%     -set option:filter:lobes   8
%
%  For example force an 8 lobe Lanczos (Sinc or Bessel) filter...
%     -filter Lanczos
%     -set option:filter:lobes   8
%
%  The format of the AcquireResizeFilter method is:
%
%      ResizeFilter *AcquireResizeFilter(const Image *image,
%        const FilterTypes filter_type, const MagickBooleanType radial,
%        ExceptionInfo *exception)
%
%    o image: the image.
%
%    o filter: the filter type, defining a preset filter, window and support.
%
%    o blur: blur the filter by this amount, use 1.0 if unknown.
%
%    o radial: 1D orthogonal filter (Sinc) or 2D radial filter (Bessel)
%
%    o exception: Return any errors or warnings in this structure.
%
*/

static MagickRealType Bessel(const MagickRealType x)
{
  /* See Pratt "Digital Image Processing" p.97 for Bessel functions

     This function actually a scaled Jinc(x) function.
        http://mathworld.wolfram.com/JincFunction.html
     And on page 11 of...
        http://www.ph.ed.ac.uk/%7ewjh/teaching/mo/slides/lens/lens.pdf
  */
  if (x == 0.0)
    return((MagickRealType) (MagickPI/4.0));
  return(BesselOrderOne(MagickPI*x)/(2.0*x));
}

static MagickRealType Blackman(const MagickRealType x)
{
  return(0.42+0.5*cos(MagickPI*(double) x)+0.08*cos(2.0*MagickPI*(double) x));
}

static MagickRealType Box(const MagickRealType x)
{
  if (x < -0.5)
    return(0.0);
  if (x < 0.5)
    return(1.0);
  return(0.0);
}

static MagickRealType Catrom(const MagickRealType x)
{
  if (x < -2.0)
    return(0.0);
  if (x < -1.0)
    return(0.5*(4.0+x*(8.0+x*(5.0+x))));
  if (x < 0.0)
    return(0.5*(2.0+x*x*(-5.0-3.0*x)));
  if (x < 1.0)
    return(0.5*(2.0+x*x*(-5.0+3.0*x)));
  if (x < 2.0)
    return(0.5*(4.0+x*(-8.0+x*(5.0-x))));
  return(0.0);
}

static MagickRealType Cubic(const MagickRealType x)
{
  if (x < -2.0)
    return(0.0);
  if (x < -1.0)
    return((2.0+x)*(2.0+x)*(2.0+x)/6.0);
  if (x < 0.0)
    return((4.0+x*x*(-6.0-3.0*x))/6.0);
  if (x < 1.0)
    return((4.0+x*x*(-6.0+3.0*x))/6.0);
  if (x < 2.0)
    return((2.0-x)*(2.0-x)*(2.0-x)/6.0);
  return(0.0);
}

static MagickRealType Gaussian(const MagickRealType x)
{
  return(exp((double) (-2.0*x*x))*sqrt(2.0/MagickPI));
}

static MagickRealType Hanning(const MagickRealType x)
{
  return(0.5+0.5*cos(MagickPI*(double) x));
}

static MagickRealType Hamming(const MagickRealType x)
{
  return(0.54+0.46*cos(MagickPI*(double) x));
}

static MagickRealType Hermite(const MagickRealType x)
{
  if (x < -1.0)
    return(0.0);
  if (x < 0.0)
    return((2.0*(-x)-3.0)*(-x)*(-x)+1.0);
  if (x < 1.0)
    return((2.0*x-3.0)*x*x+1.0);
  return(0.0);
}

static MagickRealType Kaiser(const MagickRealType x)
{
#define A  6.5
#define I0A  (1.0/I0(A))

  return(I0A*I0(A*sqrt((double) (1.0-x*x))));
}

static MagickRealType Sinc(const MagickRealType x)
{
  if (x == 0.0)
    return(1.0);
  return(sin(MagickPI*(double) x)/(MagickPI*(double) x));
}

#if 0
/* the lanzcos is just sinc windowed sinc */
static MagickRealType Lanczos(const MagickRealType x)
{
  if (x < -3.0)  /* 3 lobes */
    return(0.0);
  if (x < 0.0)
    return(Sinc(-x)*Sinc(-x/3.0));
  if (x < 3.0)
    return(Sinc(x)*Sinc(x/3.0));
  return(0.0);
}
#endif

static MagickRealType Mitchell(const MagickRealType x)
{
#define B   (1.0/3.0)
#define C   (1.0/3.0)
#define P0  ((  6.0- 2.0*B       )/6.0)
#define P2  ((-18.0+12.0*B+ 6.0*C)/6.0)
#define P3  (( 12.0- 9.0*B- 6.0*C)/6.0)
#define Q0  ((       8.0*B+24.0*C)/6.0)
#define Q1  ((     -12.0*B-48.0*C)/6.0)
#define Q2  ((       6.0*B+30.0*C)/6.0)
#define Q3  ((     - 1.0*B- 6.0*C)/6.0)

  if (x < -2.0)
    return(0.0);
  if (x < -1.0)
    return(Q0-x*(Q1-x*(Q2-x*Q3)));
  if (x < 0.0)
    return(P0+x*x*(P2-x*P3));
  if (x < 1.0)
    return(P0+x*x*(P2+x*P3));
  if (x < 2.0)
    return(Q0+x*(Q1+x*(Q2+x*Q3)));
  return(0.0);
}

static MagickRealType Quadratic(const MagickRealType x)
{
  if (x < -1.5)
    return(0.0);
  if (x < -0.5)
    return(0.5*(x+1.5)*(x+1.5));
  if (x < 0.5)
    return(0.75-x*x);
  if (x < 1.5)
    return(0.5*(x-1.5)*(x-1.5));
  return(0.0);
}

static MagickRealType Triangle(const MagickRealType x)
{
  if (x < -1.0)
    return(0.0);
  if (x < 0.0)
    return(1.0+x);
  if (x < 1.0)
    return(1.0-x);
  return(0.0);
}

MagickExport ResizeFilter *AcquireResizeFilter(const Image *image,
  const FilterTypes filter, const MagickRealType blur,
  const MagickBooleanType cylindrical, ExceptionInfo *exception)
{
  FilterTypes
    filter_type,
    window_type;

  const char
    *artifact;

  long
    filter_artifact;

  register ResizeFilter
    *resize_filter;

  /*
    Structure to map FilterTypes to the actual filter/window function to use.
    The default support size for that filter (typ 2.0).
    And scaling needed to use that function as a windowing function (typ 1.0).
  */
  static struct {
    MagickRealType
      (*function)(const MagickRealType),
      support,  /* default support size for this filter */
      wscale;   /* the size of the first lobe, for windowing scale */
  } const filters[KaiserFilter+1] =
  {
    { Box,       0.0f,  0.5f }, /* undefined */
    { Box,       0.0f,  0.5f }, /* point, sample, nearest neighbour */
    { Box,       0.5f,  0.5f }, /* nearest (magify), or averaging (minify) */
    { Triangle,  1.0f,  1.0f }, /* tent, or bilinear interpolation */
    { Hermite,   1.0f,  1.0f }, /* Hermite interpolation filter */
    { Hanning,   1.0f,  1.0f }, /* \                             */
    { Hamming,   1.0f,  1.0f }, /*  >-  Sinc Windowing functions */
    { Blackman,  1.0f,  1.0f }, /* /                             */
    { Gaussian,  1.5f,  1.5f },
    { Quadratic, 1.5f,  1.5f },
    { Cubic,     2.0f,  2.0f },
    { Catrom,    2.0f,  2.0f },
    { Mitchell,  2.0f,  2.0f },
    { Sinc,      3.0f,  1.0f }, /* lanczos -- Sinc windowed Sinc, 3 lobes */
    { Bessel,    3.2383f, 1.2197f }, /* 3 lobed bessel */
    { Sinc,      4.0f,  1.0f },      /* 4 lobed sinc (usally windowed) */
    { Kaiser,    1.0f,  1.0f }   /* Sinc windowing function */
  };
  /* The known zero crossings of the Bessel() or Jinc(x*PI) function
     Found by using
        http://cose.math.bas.bg/webMathematica/webComputing/BesselZeros.jsp
     for Jv function with v=1,  then dividing by PI (tabled below)
  */
  static MagickRealType bessel_zeros[16] = {
      1.21966989126651f,
      2.23313059438153f,
      3.23831548416624f,
      4.24106286379607f,
      5.24276437687019f,
      6.24392168986449f,
      7.24475986871996f,
      8.24539491395205f,
      9.24589268494948f,
      10.2462933487549f,
      11.2466227948779f,
      12.2468984611381f,
      13.2471325221811f,
      14.2473337358069f,
      15.2475085630373f,
      16.247661874701f,
  };
  /*
    Mapping of FilterTypes  into the actual filter function and windowing
    function to use.   A 'Box' windowing function means the filter is purely
    clipped to the support window.  A 'Sinc' filter function could be upgraded
    to a 'Bessel' filter if a "cylindrical" filter is requested, unless the
    "Sinc" filter was specifically requested.
  */
  static struct {
    FilterTypes
      filter,
      window;
  } const mapping[KaiserFilter+1] =
  {
    { BoxFilter,       BoxFilter },  /* undefined */
    { PointFilter,     BoxFilter },  /* special, 0 support impulse filter */
    { BoxFilter,       BoxFilter },
    { TriangleFilter,  BoxFilter },
    { HermiteFilter,   BoxFilter },
    { SincFilter,      HanningFilter },
    { SincFilter,      HammingFilter },
    { SincFilter,      BlackmanFilter },
    { GaussianFilter,  BoxFilter },
    { QuadraticFilter, BoxFilter },
    { CubicFilter,     BoxFilter },
    { CatromFilter,    BoxFilter },
    { MitchellFilter,  BoxFilter },
    { LanczosFilter,   SincFilter },  /* special, 3 lobed Sinc windowed Sinc */
    { BesselFilter,    BlackmanFilter }, /* 3 lobed bessel -specific request */
    { SincFilter,      BlackmanFilter }, /* 4 lobed sinc - specific request */
    { SincFilter,      KaiserFilter }
  };

  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(PointFilter <= filter && filter <= KaiserFilter);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);

  resize_filter=(ResizeFilter *) AcquireMagickMemory(sizeof(*resize_filter));
  if (resize_filter == (ResizeFilter *) NULL)
    ThrowFatalException(ResourceLimitFatalError,"MemoryAllocationFailed");

  /* defaults for the requested filter */
  filter_type = mapping[filter].filter;
  window_type = mapping[filter].window;

  if ( cylindrical == MagickTrue && filter != SincFilter ) {
    /* promote 1D Sinc Filter to a 2D Bessel filter */
    if ( filter_type == SincFilter )
      filter_type = BesselFilter;
    /* Prompote Lanczos (Sinc-Sinc) to Lanczos (Bessel-Bessel) */
    else if ( filter_type == LanczosFilter ) {
      filter_type = BesselFilter;
      window_type = BesselFilter;
    }
    /* FUTURE: blur other filters by 1.22 for cylindrical usage??? */
  }

  /* Override Filter Selection */
  artifact=GetImageArtifact(image,"filter:filter");
  if (artifact != (const char *) NULL) {
    /* raw filter request - no window function */
    filter_artifact=ParseMagickOption(MagickFilterOptions,
         MagickFalse,artifact);
    if ( PointFilter <= filter_artifact && filter_artifact <= KaiserFilter ) {
      filter_type = filter_artifact;
      window_type = BoxFilter;
    }
    /* Lanczos is nor a real filter but a self windowing Sinc/Bessel */
    if ( filter_artifact == LanczosFilter ) {
      filter_type = (cylindrical==MagickTrue) ? BesselFilter : LanczosFilter;
      window_type = (cylindrical==MagickTrue) ? BesselFilter : SincFilter;
    }
    /* Filter overwide with a specific window function? */
    artifact=GetImageArtifact(image,"filter:window");
    if (artifact != (const char *) NULL) {
      filter_artifact=ParseMagickOption(MagickFilterOptions,
            MagickFalse,artifact);
      if ( PointFilter <= filter_artifact && filter_artifact <= KaiserFilter ) {
        if ( filter_artifact != LanczosFilter )
          window_type = filter_artifact;
        else
          window_type = (cylindrical==MagickTrue) ? BesselFilter : SincFilter;
      }
    }
  }
  else {
    /* window specified, but no filter function?  Assume Sinc/Bessel */
    artifact=GetImageArtifact(image,"filter:window");
    if (artifact != (const char *) NULL) {
      filter_artifact=ParseMagickOption(MagickFilterOptions,MagickFalse,
        artifact);
      if ( PointFilter <= filter_artifact && filter_artifact <= KaiserFilter ) {
        filter_type = (cylindrical==MagickTrue) ? BesselFilter : SincFilter;
        if ( filter_artifact != LanczosFilter )
          window_type = filter_artifact;
        else
          window_type = filter_type;
      }
    }
  }

  resize_filter->filter  = filters[filter_type].function;
  resize_filter->support = filters[filter_type].support;
  resize_filter->window  = filters[window_type].function;
  resize_filter->wscale  = filters[window_type].wscale;
  resize_filter->blur    = blur;
  resize_filter->signature=MagickSignature;

  artifact=GetImageArtifact(image,"filter:lobes");
  if (artifact != (const char *) NULL) {
    long lobes = atof(artifact);
    if ( lobes < 1  ) lobes = 1;
    resize_filter->support = (MagickRealType) lobes;
    if ( filter_type == BesselFilter ) {
      if ( lobes > 16 ) lobes = 16;
      resize_filter->support = bessel_zeros[lobes-1];
    }
  }
  artifact=GetImageArtifact(image,"filter:support");
  if (artifact != (const char *) NULL)
    resize_filter->support = fabs(atof(artifact));
  artifact=GetImageArtifact(image,"filter:blur");
  if (artifact != (const char *) NULL)
    resize_filter->blur = atof(artifact);

  return(resize_filter);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   A d a p t i v e R e s i z e I m a g e                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  AdaptiveResizeImage() adaptively resize image with pixel resampling.
%
%  The format of the AdaptiveResizeImage method is:
%
%      Image *AdaptiveResizeImage(const Image *image,
%        const unsigned long columns,const unsigned long rows,
%        ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o columns: The number of columns in the resized image.
%
%    o rows: The number of rows in the resized image.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport Image *AdaptiveResizeImage(const Image *image,
  const unsigned long columns,const unsigned long rows,ExceptionInfo *exception)
{
#define AdaptiveResizeImageTag  "Resize/Image"

  Image
    *resize_image;

  long
    y;

  MagickPixelPacket
    pixel;

  PointInfo
    offset;

  register IndexPacket
    *resize_indexes;

  register long
    x;

  register PixelPacket
    *q;

  ResampleFilter
    *resample_filter;

  ViewInfo
    *resize_view;

  /*
    Resize image.
  */
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);
  if ((columns == 0) || (rows == 0))
    return((Image *) NULL);
  if ((columns == image->columns) && (rows == image->rows))
    return(CloneImage(image,0,0,MagickTrue,exception));
  resize_image=CloneImage(image,columns,rows,MagickTrue,exception);
  if (resize_image == (Image *) NULL)
    return((Image *) NULL);
  if (SetImageStorageClass(resize_image,DirectClass) == MagickFalse)
    {
      InheritException(exception,&resize_image->exception);
      resize_image=DestroyImage(resize_image);
      return((Image *) NULL);
    }
  GetMagickPixelPacket(image,&pixel);
  resample_filter=AcquireResampleFilter(image,exception);
  if (image->interpolate == UndefinedInterpolatePixel)
    (void) SetResampleFilterInterpolateMethod(resample_filter,
      MeshInterpolatePixel);
  resize_view=OpenCacheView(resize_image);
  for (y=0; y < (long) resize_image->rows; y++)
  {
    q=SetCacheView(resize_view,0,y,resize_image->columns,1);
    if (q == (PixelPacket *) NULL)
      break;
    resize_indexes=GetIndexes(resize_image);
    offset.y=((MagickRealType) y*image->rows/resize_image->rows);
    for (x=0; x < (long) resize_image->columns; x++)
    {
      offset.x=((MagickRealType) x*image->columns/resize_image->columns);
      pixel=ResamplePixelColor(resample_filter,offset.x-0.5,offset.y-0.5);
      SetPixelPacket(resize_image,&pixel,q,resize_indexes+x);
      q++;
    }
    if (SyncCacheView(resize_view) == MagickFalse)
      break;
  }
  resample_filter=DestroyResampleFilter(resample_filter);
  resize_view=CloseCacheView(resize_view);
  return(resize_image);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   B e s s e l O r d e r O n e                                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  BesselOrderOne() computes the Bessel function of x of the first kind of
%  order 0:
%
%    Reduce x to |x| since j1(x)= -j1(-x), and for x in (0,8]
%
%       j1(x) = x*j1(x);
%
%    For x in (8,inf)
%
%       j1(x) = sqrt(2/(pi*x))*(p1(x)*cos(x1)-q1(x)*sin(x1))
%
%    where x1 = x-3*pi/4. Compute sin(x1) and cos(x1) as follow:
%
%       cos(x1) =  cos(x)cos(3pi/4)+sin(x)sin(3pi/4)
%               =  1/sqrt(2) * (sin(x) - cos(x))
%       sin(x1) =  sin(x)cos(3pi/4)-cos(x)sin(3pi/4)
%               = -1/sqrt(2) * (sin(x) + cos(x))
%
%  The format of the BesselOrderOne method is:
%
%      MagickRealType BesselOrderOne(MagickRealType x)
%
%  A description of each parameter follows:
%
%    o x: MagickRealType value.
%
*/

#undef I0
static MagickRealType I0(MagickRealType x)
{
  MagickRealType
    sum,
    t,
    y;

  register long
    i;

  /*
    Zeroth order Bessel function of the first kind.
  */
  sum=1.0;
  y=x*x/4.0;
  t=y;
  for (i=2; t > MagickEpsilon; i++)
  {
    sum+=t;
    t*=y/((MagickRealType) i*i);
  }
  return(sum);
}

#undef J1
static MagickRealType J1(MagickRealType x)
{
  MagickRealType
    p,
    q;

  register long
    i;

  static const double
    Pone[] =
    {
       0.581199354001606143928050809e+21,
      -0.6672106568924916298020941484e+20,
       0.2316433580634002297931815435e+19,
      -0.3588817569910106050743641413e+17,
       0.2908795263834775409737601689e+15,
      -0.1322983480332126453125473247e+13,
       0.3413234182301700539091292655e+10,
      -0.4695753530642995859767162166e+7,
       0.270112271089232341485679099e+4
    },
    Qone[] =
    {
      0.11623987080032122878585294e+22,
      0.1185770712190320999837113348e+20,
      0.6092061398917521746105196863e+17,
      0.2081661221307607351240184229e+15,
      0.5243710262167649715406728642e+12,
      0.1013863514358673989967045588e+10,
      0.1501793594998585505921097578e+7,
      0.1606931573481487801970916749e+4,
      0.1e+1
    };

  p=Pone[8];
  q=Qone[8];
  for (i=7; i >= 0; i--)
  {
    p=p*x*x+Pone[i];
    q=q*x*x+Qone[i];
  }
  return(p/q);
}

#undef P1
static MagickRealType P1(MagickRealType x)
{
  MagickRealType
    p,
    q;

  register long
    i;

  static const double
    Pone[] =
    {
      0.352246649133679798341724373e+5,
      0.62758845247161281269005675e+5,
      0.313539631109159574238669888e+5,
      0.49854832060594338434500455e+4,
      0.2111529182853962382105718e+3,
      0.12571716929145341558495e+1
    },
    Qone[] =
    {
      0.352246649133679798068390431e+5,
      0.626943469593560511888833731e+5,
      0.312404063819041039923015703e+5,
      0.4930396490181088979386097e+4,
      0.2030775189134759322293574e+3,
      0.1e+1
    };

  p=Pone[5];
  q=Qone[5];
  for (i=4; i >= 0; i--)
  {
    p=p*(8.0/x)*(8.0/x)+Pone[i];
    q=q*(8.0/x)*(8.0/x)+Qone[i];
  }
  return(p/q);
}

#undef Q1
static MagickRealType Q1(MagickRealType x)
{
  MagickRealType
    p,
    q;

  register long
    i;

  static const double
    Pone[] =
    {
      0.3511751914303552822533318e+3,
      0.7210391804904475039280863e+3,
      0.4259873011654442389886993e+3,
      0.831898957673850827325226e+2,
      0.45681716295512267064405e+1,
      0.3532840052740123642735e-1
    },
    Qone[] =
    {
      0.74917374171809127714519505e+4,
      0.154141773392650970499848051e+5,
      0.91522317015169922705904727e+4,
      0.18111867005523513506724158e+4,
      0.1038187585462133728776636e+3,
      0.1e+1
    };

  p=Pone[5];
  q=Qone[5];
  for (i=4; i >= 0; i--)
  {
    p=p*(8.0/x)*(8.0/x)+Pone[i];
    q=q*(8.0/x)*(8.0/x)+Qone[i];
  }
  return(p/q);
}

static MagickRealType BesselOrderOne(MagickRealType x)
{
  MagickRealType
    p,
    q;

  if (x == 0.0)
    return(0.0);
  p=x;
  if (x < 0.0)
    x=(-x);
  if (x < 8.0)
    return(p*J1(x));
  q=sqrt((double) (2.0/(MagickPI*x)))*(P1(x)*(1.0/sqrt(2.0)*(sin((double) x)-
    cos((double) x)))-8.0/x*Q1(x)*(-1.0/sqrt(2.0)*(sin((double) x)+
    cos((double) x))));
  if (p < 0.0)
    q=(-q);
  return(q);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   D e s t r o y R e s i z e F i l t e r                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  DestroyResizeFilter() destroy the resize filter.
%
%  The format of the AcquireResizeFilter method is:
%
%      ResizeFilter *DestroyResizeFilter(ResizeFilter *resize_filter)
%
%  A description of each parameter follows:
%
%    o resize_filter: the resize filter.
%
*/
MagickExport ResizeFilter *DestroyResizeFilter(ResizeFilter *resize_filter)
{
  assert(resize_filter != (ResizeFilter *) NULL);
  assert(resize_filter->signature == MagickSignature);
  resize_filter->signature=(~MagickSignature);
  resize_filter=(ResizeFilter *) RelinquishMagickMemory(resize_filter);
  return(resize_filter);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   G e t R e s i z e F i l t e r S u p p o r t                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetResizeFilterSupport() return the current support window size for this
%  filter.  Note that this may have been enlarged by filter:blur factor.
%
%  The format of the GetResizeFilterSupport method is:
%
%      MagickRealType GetResizeFilterSupport(const ResizeFilter *resize_filter)
%
%  A description of each parameter follows:
%
%    o filter: Image filter to use.
%
*/
MagickExport MagickRealType GetResizeFilterSupport(
  const ResizeFilter *resize_filter)
{
  assert(resize_filter != (ResizeFilter *) NULL);
  assert(resize_filter->signature == MagickSignature);
  return(resize_filter->support*resize_filter->blur);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   G e t R e s i z e F i l t e r W e i g h t                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GetResizeFilterWeight evaluates the specified resize filter at the point x
%  which usally lies between zero and the filters current 'support' and
%  returns the weight of the filter function at that point.
%
%  The format of the GetResizeFilterWeight method is:
%
%      MagickRealType GetResizeFilterWeight(const ResizeFilter *resize_filter,
%        const MagickRealType x)
%
%  A description of each parameter follows:
%
%    o filter: the filter type.
%
%    o x: the point.
%
*/
MagickExport MagickRealType GetResizeFilterWeight(
  const ResizeFilter *resize_filter,const MagickRealType x)
{
  MagickRealType
    x_blur,
    wscale,
    support;

  assert(resize_filter != (ResizeFilter *) NULL);
  assert(resize_filter->signature == MagickSignature);

  if ( resize_filter->support < MagickEpsilon )
    return(0); /* Point Filter */

  x_blur  = x/resize_filter->blur;
  wscale  = resize_filter->wscale;
  support = resize_filter->support;
  wscale  = resize_filter->window(x_blur*wscale/support);
  return(wscale*resize_filter->filter(x_blur));
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M a g n i f y I m a g e                                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MagnifyImage() is a convenience method that scales an image proportionally
%  to twice its size.
%
%  The format of the MagnifyImage method is:
%
%      Image *MagnifyImage(const Image *image,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport Image *MagnifyImage(const Image *image,ExceptionInfo *exception)
{
  Image
    *magnify_image;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);
  magnify_image=ResizeImage(image,2*image->columns,2*image->rows,CubicFilter,
    1.0,exception);
  return(magnify_image);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   M i n i f y I m a g e                                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  MinifyImage() is a convenience method that scales an image proportionally
%  to half its size.
%
%  The format of the MinifyImage method is:
%
%      Image *MinifyImage(const Image *image,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport Image *MinifyImage(const Image *image,ExceptionInfo *exception)
{
  Image
    *minify_image;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);
  minify_image=ResizeImage(image,image->columns/2,image->rows/2,CubicFilter,
    1.0,exception);
  return(minify_image);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   R e s a m p l e I m a g e                                                 %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ResampleImage() resize image in terms of its pixel size, so that when
%  displayed at the given resolution it will be the same size in terms of
%  real world units as the original image at the original resolution.
%
%  The format of the ResampleImage method is:
%
%      Image *ResampleImage(Image *image,const double x_resolution,
%        const double y_resolution,const FilterTypes filter,const double blur,
%        ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image: The image to be resized to fit the given resolution.
%
%    o x_resolution: The new image x resolution.
%
%    o y_resolution: The new image y resolution.
%
%    o filter: Image filter to use.
%
%    o blur: The blur factor where > 1 is blurry, < 1 is sharp.
%
*/
MagickExport Image *ResampleImage(const Image *image,const double x_resolution,
  const double y_resolution,const FilterTypes filter,const double blur,
  ExceptionInfo *exception)
{
#define ResampleImageTag  "Resample/Image"

  Image
    *resample_image;

  unsigned long
    height,
    width;

  /*
    Initialize sampled image attributes.
  */
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);
  width=(unsigned long) (x_resolution*image->columns/
    (image->x_resolution == 0.0 ? 72.0 : image->x_resolution)+0.5);
  height=(unsigned long) (y_resolution*image->rows/
    (image->y_resolution == 0.0 ? 72.0 : image->y_resolution)+0.5);
  resample_image=ResizeImage(image,width,height,filter,blur,exception);
  if (resample_image != (Image *) NULL)
    {
      resample_image->x_resolution=x_resolution;
      resample_image->y_resolution=y_resolution;
    }
  return(resample_image);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   R e s i z e I m a g e                                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ResizeImage() scales an image to the desired dimensions, using
%  the given filter (see AcquireFilterInfo() ).
%
%  If an undefined filter is given the filter defaults to Mitchell for a
%  colormapped image, a image with a matte channel, or if the image is
%  enlarged.  Otherwise the filter defaults to a Lanczos.
%
%  ResizeImage() was inspired by Paul Heckbert's "zoom" program.
%
%  The format of the ResizeImage method is:
%
%      Image *ResizeImage(Image *image,const unsigned long columns,
%        const unsigned long rows,const FilterTypes filter,const double blur,
%        ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o columns: The number of columns in the scaled image.
%
%    o rows: The number of rows in the scaled image.
%
%    o filter: Image filter to use.
%
%    o blur: The blur factor where > 1 is blurry, < 1 is sharp.
%            Typically set this to 1.0.
%
%    o exception: Return any errors or warnings in this structure.
%
*/

typedef struct _ContributionInfo
{
  MagickRealType
    weight;

  long
    pixel;
} ContributionInfo;

static inline double MagickMax(const double x,const double y)
{
  if (x > y)
    return(x);
  return(y);
}

static inline double MagickMin(const double x,const double y)
{
  if (x < y)
    return(x);
  return(y);
}

static MagickBooleanType HorizontalFilter(const ResizeFilter *resize_filter,
  const Image *image,Image *resize_image,const MagickRealType x_factor,
  const MagickSizeType span,MagickOffsetType *quantum,  ExceptionInfo *exception)
{
#define ResizeImageTag  "Resize/Image"

  ContributionInfo
    *contribution;

  long
    j,
    n,
    start,
    stop,
    x;

  MagickBooleanType
    status;

  MagickPixelPacket
    pixel,
    zero;

  MagickRealType
    alpha,
    center,
    density,
    gamma,
    scale,
    support;

  register const IndexPacket
    *indexes;

  register const PixelPacket
    *pixels;

  register IndexPacket
    *resize_indexes;

  register long
    i,
    y;

  register PixelPacket
    *resize_pixels;

  /*
    Apply filter to resize horizontally from image to resize_image.
  */
  scale=MagickMax(1.0/x_factor,1.0);
  support=scale*GetResizeFilterSupport(resize_filter);
  resize_image->storage_class=image->storage_class;
  if (support > 0.5)
    {
      if (SetImageStorageClass(resize_image,DirectClass) == MagickFalse)
        {
          InheritException(exception,&resize_image->exception);
          return(MagickFalse);
        }
    }
  else
    {
      /*
        Support too small even for nearest neighbour
        Reduce to point sampling.
      */
      support=(MagickRealType) 0.5;
      scale=1.0;
    }
  contribution=(ContributionInfo *) AcquireQuantumMemory((size_t) (2.0*support+
    3.0),sizeof(*contribution));
  if (contribution == (ContributionInfo *) NULL)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),
        ResourceLimitError,"MemoryAllocationFailed","`%s'",image->filename);
      return(MagickFalse);
    }
  scale=1.0/scale;
  (void) ResetMagickMemory(&zero,0,sizeof(zero));
  for (x=0; x < (long) resize_image->columns; x++)
  {
    center=(MagickRealType) (x+0.5)/x_factor;
    start=(long) (MagickMax(center-support-MagickEpsilon,0.0)+0.5);
    stop=(long) (MagickMin(center+support,(double) image->columns)+0.5);
    density=0.0;
    for (n=0; n < (stop-start); n++)
    {
      contribution[n].pixel=start+n;
      contribution[n].weight=GetResizeFilterWeight(resize_filter,scale*
        ((MagickRealType) (start+n)-center+0.5));
      density+=contribution[n].weight;
    }
    if ((density != 0.0) && (density != 1.0))
      {
        /*
          Normalize.
        */
        density=1.0/density;
        for (i=0; i < n; i++)
          contribution[i].weight*=density;
      }
    pixels=AcquireImagePixels(image,contribution[0].pixel,0,(unsigned long)
      (contribution[n-1].pixel-contribution[0].pixel+1),image->rows,exception);
    resize_pixels=SetImagePixels(resize_image,x,0,1,resize_image->rows);
    if ((pixels == (const PixelPacket *) NULL) ||
        (resize_pixels == (PixelPacket *) NULL))
      break;
    indexes=AcquireIndexes(image);
    resize_indexes=GetIndexes(resize_image);
    #pragma omp parallel for private(alpha, gamma, i, j, pixel)
    for (y=0; y < (long) resize_image->rows; y++)
    {
      pixel=zero;
      if (image->matte == MagickFalse)
        {
          for (i=0; i < n; i++)
          {
            j=y*(contribution[n-1].pixel-contribution[0].pixel+1)+
              (contribution[i].pixel-contribution[0].pixel);
            alpha=contribution[i].weight;
            pixel.red+=alpha*(pixels+j)->red;
            pixel.green+=alpha*(pixels+j)->green;
            pixel.blue+=alpha*(pixels+j)->blue;
            pixel.opacity+=alpha*(pixels+j)->opacity;
          }
          resize_pixels[y].red=RoundToQuantum(pixel.red);
          resize_pixels[y].green=RoundToQuantum(pixel.green);
          resize_pixels[y].blue=RoundToQuantum(pixel.blue);
          resize_pixels[y].opacity=RoundToQuantum(pixel.opacity);
        }
      else
        {
          gamma=0.0;
          for (i=0; i < n; i++)
          {
            j=y*(contribution[n-1].pixel-contribution[0].pixel+1)+
              (contribution[i].pixel-contribution[0].pixel);
            alpha=contribution[i].weight*QuantumScale*((MagickRealType)
              QuantumRange-(pixels+j)->opacity);
            pixel.red+=alpha*(pixels+j)->red;
            pixel.green+=alpha*(pixels+j)->green;
            pixel.blue+=alpha*(pixels+j)->blue;
            pixel.opacity+=contribution[i].weight*(pixels+j)->opacity;
            gamma+=alpha;
          }
          gamma=1.0/(fabs((double) gamma) <= MagickEpsilon ? 1.0 : gamma);
          resize_pixels[y].red=RoundToQuantum(gamma*pixel.red);
          resize_pixels[y].green=RoundToQuantum(gamma*pixel.green);
          resize_pixels[y].blue=RoundToQuantum(gamma*pixel.blue);
          resize_pixels[y].opacity=RoundToQuantum(pixel.opacity);
        }
      if ((image->colorspace == CMYKColorspace) &&
          (resize_image->colorspace == CMYKColorspace))
        {
          if (image->matte == MagickFalse)
            {
              for (i=0; i < n; i++)
              {
                j=y*(contribution[n-1].pixel-contribution[0].pixel+1)+
                  (contribution[i].pixel-contribution[0].pixel);
                alpha=contribution[i].weight;
                pixel.index+=alpha*indexes[j];
              }
              resize_indexes[y]=(IndexPacket) RoundToQuantum(pixel.index);
            }
          else
            {
              gamma=0.0;
              for (i=0; i < n; i++)
              {
                j=y*(contribution[n-1].pixel-contribution[0].pixel+1)+
                  (contribution[i].pixel-contribution[0].pixel);
                alpha=contribution[i].weight*QuantumScale*((MagickRealType)
                  QuantumRange-(pixels+j)->opacity);
                pixel.index+=alpha*indexes[j];
                gamma+=alpha;
              }
              gamma=1.0/(fabs((double) gamma) <= MagickEpsilon ? 1.0 : gamma);
              resize_indexes[y]=(IndexPacket) RoundToQuantum(gamma*pixel.index);
            }
        }
      if ((resize_image->storage_class == PseudoClass) &&
          (image->storage_class == PseudoClass))
        {
          i=(long) (MagickMin(MagickMax(center,(double) start),(double) stop-
            1.0)+0.5);
          j=y*(contribution[n-1].pixel-contribution[0].pixel+1)+
            (contribution[i-start].pixel-contribution[0].pixel);
          resize_indexes[y]=indexes[j];
        }
    }
    if (SyncImagePixels(resize_image) == MagickFalse)
      break;
    if ((image->progress_monitor != (MagickProgressMonitor) NULL) &&
        (QuantumTick(*quantum,span) != MagickFalse))
      {
        status=image->progress_monitor(ResizeImageTag,(MagickOffsetType)
          *quantum,span,image->client_data);
        if (status == MagickFalse)
          break;
      }
    (*quantum)++;
  }
  contribution=(ContributionInfo *) RelinquishMagickMemory(contribution);
  return(x == (long) resize_image->columns ? MagickTrue : MagickFalse);
}

static MagickBooleanType VerticalFilter(const ResizeFilter *resize_filter,
  const Image *image,Image *resize_image,const MagickRealType y_factor,
  const MagickSizeType span,MagickOffsetType *quantum,
  ExceptionInfo *exception)
{
  ContributionInfo
    *contribution;

  long
    j,
    n,
    start,
    stop,
    y;

  MagickBooleanType
    status;

  MagickPixelPacket
    pixel,
    zero;

  MagickRealType
    alpha,
    center,
    density,
    gamma,
    scale,
    support;

  register const IndexPacket
    *indexes;

  register const PixelPacket
    *pixels;

  register IndexPacket
    *resize_indexes;

  register long
    i,
    x;

  register PixelPacket
    *resize_pixels;

  /*
    Apply filter to resize vertically from image to resize_image.
  */
  scale=MagickMax(1.0/y_factor,1.0);
  support=scale*GetResizeFilterSupport(resize_filter);
  resize_image->storage_class=image->storage_class;
  if (support > 0.5)
    {
      if (SetImageStorageClass(resize_image,DirectClass) == MagickFalse)
        {
          InheritException(exception,&resize_image->exception);
          return(MagickFalse);
        }
    }
  else
    {
      /*
        Support too small even for nearest neighbour
        Reduce to point sampling.
      */
      support=(MagickRealType) 0.5;
      scale=1.0;
    }
  contribution=(ContributionInfo *) AcquireQuantumMemory((size_t) (2.0*support+
    3.0),sizeof(*contribution));
  if (contribution == (ContributionInfo *) NULL)
    {
      (void) ThrowMagickException(exception,GetMagickModule(),
        ResourceLimitError,"MemoryAllocationFailed","`%s'",image->filename);
      return(MagickFalse);
    }
  scale=1.0/scale;
  (void) ResetMagickMemory(&zero,0,sizeof(zero));
  for (y=0; y < (long) resize_image->rows; y++)
  {
    center=(MagickRealType) (y+0.5)/y_factor;
    start=(long) (MagickMax(center-support-MagickEpsilon,0.0)+0.5);
    stop=(long) (MagickMin(center+support,(double) image->rows)+0.5);
    density=0.0;
    for (n=0; n < (stop-start); n++)
    {
      contribution[n].pixel=start+n;
      contribution[n].weight=GetResizeFilterWeight(resize_filter,scale*
        ((MagickRealType) (start+n)-center+0.5));
      density+=contribution[n].weight;
    }
    if ((density != 0.0) && (density != 1.0))
      {
        /*
          Normalize.
        */
        density=1.0/density;
        for (i=0; i < n; i++)
          contribution[i].weight*=density;
      }
    pixels=AcquireImagePixels(image,0,contribution[0].pixel,image->columns,
      (unsigned long) (contribution[n-1].pixel-contribution[0].pixel+1),
      exception);
    resize_pixels=SetImagePixels(resize_image,0,y,resize_image->columns,1);
    if ((pixels == (const PixelPacket *) NULL) ||
        (resize_pixels == (PixelPacket *) NULL))
      break;
    indexes=AcquireIndexes(image);
    resize_indexes=GetIndexes(resize_image);
    #pragma omp parallel for private(alpha, gamma, i, j, pixel)
    for (x=0; x < (long) resize_image->columns; x++)
    {
      gamma=0.0;
      pixel=zero;
      if (image->matte == MagickFalse)
        {
          for (i=0; i < n; i++)
          {
            j=(long) ((contribution[i].pixel-contribution[0].pixel)*
              image->columns+x);
            alpha=contribution[i].weight;
            pixel.red+=alpha*(pixels+j)->red;
            pixel.green+=alpha*(pixels+j)->green;
            pixel.blue+=alpha*(pixels+j)->blue;
            pixel.opacity+=alpha*(pixels+j)->opacity;
          }
          resize_pixels[x].red=RoundToQuantum(pixel.red);
          resize_pixels[x].green=RoundToQuantum(pixel.green);
          resize_pixels[x].blue=RoundToQuantum(pixel.blue);
          resize_pixels[x].opacity=RoundToQuantum(pixel.opacity);
        }
      else
        {
          for (i=0; i < n; i++)
          {
            j=(long) ((contribution[i].pixel-contribution[0].pixel)*
              image->columns+x);
            alpha=contribution[i].weight*QuantumScale*((MagickRealType)
              QuantumRange-(pixels+j)->opacity);
            pixel.red+=alpha*(pixels+j)->red;
            pixel.green+=alpha*(pixels+j)->green;
            pixel.blue+=alpha*(pixels+j)->blue;
            pixel.opacity+=contribution[i].weight*(pixels+j)->opacity;
            gamma+=alpha;
          }
          gamma=1.0/(fabs((double) gamma) <= MagickEpsilon ? 1.0 : gamma);
          resize_pixels[x].red=RoundToQuantum(gamma*pixel.red);
          resize_pixels[x].green=RoundToQuantum(gamma*pixel.green);
          resize_pixels[x].blue=RoundToQuantum(gamma*pixel.blue);
          resize_pixels[x].opacity=RoundToQuantum(pixel.opacity);
        }
      if ((image->colorspace == CMYKColorspace) &&
          (resize_image->colorspace == CMYKColorspace))
        {
          gamma=0.0;
          if (image->matte == MagickFalse)
            {
              for (i=0; i < n; i++)
              {
                j=(long) ((contribution[i].pixel-contribution[0].pixel)*
                  image->columns+x);
                alpha=contribution[i].weight;
                pixel.index+=alpha*indexes[j];
              }
              resize_indexes[x]=(IndexPacket) RoundToQuantum(pixel.index);
            }
          else
            {
              for (i=0; i < n; i++)
              {
                j=(long) ((contribution[i].pixel-contribution[0].pixel)*
                  image->columns+x);
                alpha=contribution[i].weight*QuantumScale*((MagickRealType)
                  QuantumRange-(pixels+j)->opacity);
                pixel.index+=alpha*indexes[j];
                gamma+=alpha;
              }
              gamma=1.0/(fabs((double) gamma) <= MagickEpsilon ? 1.0 : gamma);
              resize_indexes[x]=(IndexPacket) RoundToQuantum(gamma*pixel.index);
            }
        }
      if ((resize_image->storage_class == PseudoClass) &&
          (image->storage_class == PseudoClass))
        {
          i=(long) (MagickMin(MagickMax(center,(double) start),(double) stop-
            1.0)+0.5);
          j=(long) ((contribution[i-start].pixel-contribution[0].pixel)*
            image->columns+x);
          resize_indexes[x]=indexes[j];
        }
    }
    if (SyncImagePixels(resize_image) == MagickFalse)
      break;
    if ((image->progress_monitor != (MagickProgressMonitor) NULL) &&
        (QuantumTick(*quantum,span) != MagickFalse))
      {
        status=image->progress_monitor(ResizeImageTag,(MagickOffsetType)
          *quantum,span,image->client_data);
        if (status == MagickFalse)
          break;
      }
    (*quantum)++;
  }
  contribution=(ContributionInfo *) RelinquishMagickMemory(contribution);
  return(y == (long) resize_image->rows ? MagickTrue : MagickFalse);
}

MagickExport Image *ResizeImage(const Image *image,const unsigned long columns,
  const unsigned long rows,const FilterTypes filter,const double blur,
  ExceptionInfo *exception)
{
  FilterTypes
    filter_type;

  Image
    *filter_image,
    *resize_image;

  MagickRealType
    x_factor,
    y_factor;

  MagickSizeType
    span;

  MagickStatusType
    status;

  ResizeFilter
    *resize_filter;

  MagickOffsetType
    quantum;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);
  /*
    Initialize resize image attributes.
  */
  if ((columns == 0) || (rows == 0))
    ThrowImageException(ImageError,"NegativeOrZeroImageSize");
  if ((columns == image->columns) && (rows == image->rows) &&
      (filter == UndefinedFilter) && (blur == 1.0))
    return(CloneImage(image,0,0,MagickTrue,exception));
  resize_image=CloneImage(image,columns,rows,MagickTrue,exception);
  if (resize_image == (Image *) NULL)
    return((Image *) NULL);
  /*
    Scaling, Acquire filter, and contribution info
  */
  x_factor=(MagickRealType) resize_image->columns/(MagickRealType)
    image->columns;
  y_factor=(MagickRealType) resize_image->rows/(MagickRealType) image->rows;
  filter_type=LanczosFilter;
  if (filter != UndefinedFilter)
    filter_type=filter;
  else
    if ((x_factor == 1.0) && (y_factor == 1.0))
      filter_type=PointFilter;
    else
      if ((image->storage_class == PseudoClass) ||
          (image->matte != MagickFalse) || ((x_factor*y_factor) > 1.0))
        filter_type=MitchellFilter;
  resize_filter=AcquireResizeFilter(image,filter_type,blur,MagickFalse,
    exception);
  /*
    Resize image.
  */
  quantum=0;
  if ((columns*((MagickSizeType) image->rows+rows)) >
      (rows*((MagickSizeType) image->columns+columns)))
    {
      filter_image=CloneImage(image,columns,image->rows,MagickTrue,exception);
      if (filter_image == (Image *) NULL)
        {
          resize_image=DestroyImage(resize_image);
          resize_filter=DestroyResizeFilter(resize_filter);
          return((Image *) NULL);
        }
      span=(MagickSizeType) (filter_image->columns+resize_image->rows);
      status=HorizontalFilter(resize_filter,image,filter_image,x_factor,span,
        &quantum,exception);
      status|=VerticalFilter(resize_filter,filter_image,resize_image,y_factor,
        span,&quantum,exception);
    }
  else
    {
      filter_image=CloneImage(image,image->columns,rows,MagickTrue,exception);
      if (filter_image == (Image *) NULL)
        {
          resize_image=DestroyImage(resize_image);
          resize_filter=DestroyResizeFilter(resize_filter);
          return((Image *) NULL);
        }
      span=(MagickSizeType) (resize_image->columns+filter_image->rows);
      status=VerticalFilter(resize_filter,image,filter_image,y_factor,span,
        &quantum,exception);
      status|=HorizontalFilter(resize_filter,filter_image,resize_image,x_factor,
        span,&quantum,exception);
    }
  /*
    Free allocated memory.
  */
  filter_image=DestroyImage(filter_image);
  resize_filter=DestroyResizeFilter(resize_filter);
  if (status == MagickFalse)
    {
      resize_image=DestroyImage(resize_image);
      ThrowImageException(ResourceLimitError,"MemoryAllocationFailed");
    }
  return(resize_image);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   S a m p l e I m a g e                                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  SampleImage() scales an image to the desired dimensions with pixel
%  sampling.  Unlike other scaling methods, this method does not introduce
%  any additional color into the scaled image.
%
%  The format of the SampleImage method is:
%
%      Image *SampleImage(const Image *image,const unsigned long columns,
%        const unsigned long rows,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o columns: The number of columns in the sampled image.
%
%    o rows: The number of rows in the sampled image.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport Image *SampleImage(const Image *image,const unsigned long columns,
  const unsigned long rows,ExceptionInfo *exception)
{
#define SampleImageTag  "Sample/Image"

  Image
    *sample_image;

  long
    j,
    *x_offset,
    y,
    *y_offset;

  MagickBooleanType
    status;

  register const IndexPacket
    *indexes;

  register const PixelPacket
    *pixels;

  register IndexPacket
    *sample_indexes;

  register long
    x;

  register PixelPacket
    *sample_pixels;

  /*
    Initialize sampled image attributes.
  */
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);
  if ((columns == 0) || (rows == 0))
    ThrowImageException(ImageError,"NegativeOrZeroImageSize");
  if ((columns == image->columns) && (rows == image->rows))
    return(CloneImage(image,0,0,MagickTrue,exception));
  sample_image=CloneImage(image,columns,rows,MagickTrue,exception);
  if (sample_image == (Image *) NULL)
    return((Image *) NULL);
  /*
    Allocate scan line buffer and column offset buffers.
  */
  x_offset=(long *) AcquireQuantumMemory((size_t) sample_image->columns,
    sizeof(*x_offset));
  y_offset=(long *) AcquireQuantumMemory((size_t) sample_image->rows,
    sizeof(*y_offset));
  if ((x_offset == (long *) NULL) || (y_offset == (long *) NULL))
    {
      sample_image=DestroyImage(sample_image);
      ThrowImageException(ResourceLimitError,"MemoryAllocationFailed");
    }
  /*
    Initialize pixel offsets.
  */
  for (x=0; x < (long) sample_image->columns; x++)
    x_offset[x]=(long) (((MagickRealType) x+0.5)*image->columns/
      sample_image->columns);
  for (y=0; y < (long) sample_image->rows; y++)
    y_offset[y]=(long) (((MagickRealType) y+0.5)*image->rows/
      sample_image->rows);
  /*
    Sample each row.
  */
  j=(-1);
  pixels=AcquireImagePixels(image,0,0,image->columns,1,exception);
  indexes=AcquireIndexes(image);
  for (y=0; y < (long) sample_image->rows; y++)
  {
    sample_pixels=SetImagePixels(sample_image,0,y,sample_image->columns,1);
    if (sample_pixels == (PixelPacket *) NULL)
      break;
    sample_indexes=GetIndexes(sample_image);
    if (j != y_offset[y])
      {
        /*
          Read a scan line.
        */
        j=y_offset[y];
        pixels=AcquireImagePixels(image,0,j,image->columns,1,exception);
        if (pixels == (const PixelPacket *) NULL)
          break;
        indexes=AcquireIndexes(image);
      }
    /*
      Sample each column.
    */
    for (x=0; x < (long) sample_image->columns; x++)
      sample_pixels[x]=pixels[x_offset[x]];
    if ((image->storage_class == PseudoClass) ||
        (image->colorspace == CMYKColorspace))
      for (x=0; x < (long) sample_image->columns; x++)
        sample_indexes[x]=indexes[x_offset[x]];
    if (SyncImagePixels(sample_image) == MagickFalse)
      break;
    if ((image->progress_monitor != (MagickProgressMonitor) NULL) &&
        (QuantumTick(y,image->rows) != MagickFalse))
      {
        status=image->progress_monitor(SampleImageTag,y,image->rows,
          image->client_data);
        if (status == MagickFalse)
          break;
      }
  }
  y_offset=(long *) RelinquishMagickMemory(y_offset);
  x_offset=(long *) RelinquishMagickMemory(x_offset);
  return(sample_image);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   S c a l e I m a g e                                                       %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ScaleImage() changes the size of an image to the given dimensions.
%
%  The format of the ScaleImage method is:
%
%      Image *ScaleImage(const Image *image,const unsigned long columns,
%        const unsigned long rows,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o columns: The number of columns in the scaled image.
%
%    o rows: The number of rows in the scaled image.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport Image *ScaleImage(const Image *image,const unsigned long columns,
  const unsigned long rows,ExceptionInfo *exception)
{
#define ScaleImageTag  "Scale/Image"

  Image
    *scale_image;

  long
    number_rows,
    y;

  MagickBooleanType
    next_column,
    next_row,
    status;

  MagickPixelPacket
    pixel,
    *scale_scanline,
    *scanline,
    *x_vector,
    *y_vector,
    zero;

  PointInfo
    scale,
    span;

  register const IndexPacket
    *indexes;

  register const PixelPacket
    *p;

  register IndexPacket
    *scale_indexes;

  register long
    i,
    x;

  register MagickPixelPacket
    *s,
    *t;

  register PixelPacket
    *q;

  /*
    Initialize scaled image attributes.
  */
  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);
  if ((columns == 0) || (rows == 0))
    return((Image *) NULL);
  if ((columns == image->columns) && (rows == image->rows))
    return(CloneImage(image,0,0,MagickTrue,exception));
  scale_image=CloneImage(image,columns,rows,MagickTrue,exception);
  if (scale_image == (Image *) NULL)
    return((Image *) NULL);
  if (SetImageStorageClass(scale_image,DirectClass) == MagickFalse)
    {
      InheritException(exception,&scale_image->exception);
      scale_image=DestroyImage(scale_image);
      return((Image *) NULL);
    }
  /*
    Allocate memory.
  */
  x_vector=(MagickPixelPacket *) AcquireQuantumMemory((size_t) image->columns,
    sizeof(*x_vector));
  scanline=x_vector;
  if (image->rows != scale_image->rows)
    scanline=(MagickPixelPacket *) AcquireQuantumMemory((size_t) image->columns,
      sizeof(*scanline));
  scale_scanline=(MagickPixelPacket *) AcquireQuantumMemory((size_t)
    scale_image->columns,sizeof(*scale_scanline));
  y_vector=(MagickPixelPacket *) AcquireQuantumMemory((size_t) image->columns,
    sizeof(*y_vector));
  if ((scanline == (MagickPixelPacket *) NULL) ||
      (scale_scanline == (MagickPixelPacket *) NULL) ||
      (x_vector == (MagickPixelPacket *) NULL) ||
      (y_vector == (MagickPixelPacket *) NULL))
    {
      scale_image=DestroyImage(scale_image);
      ThrowImageException(ResourceLimitError,"MemoryAllocationFailed");
    }
  /*
    Scale image.
  */
  number_rows=0;
  next_row=MagickTrue;
  span.y=1.0;
  scale.y=(double) scale_image->rows/(double) image->rows;
  (void) ResetMagickMemory(y_vector,0,(size_t) image->columns*
    sizeof(*y_vector));
  GetMagickPixelPacket(image,&pixel);
  (void) ResetMagickMemory(&zero,0,sizeof(zero));
  i=0;
  for (y=0; y < (long) scale_image->rows; y++)
  {
    q=SetImagePixels(scale_image,0,y,scale_image->columns,1);
    if (q == (PixelPacket *) NULL)
      break;
    scale_indexes=GetIndexes(scale_image);
    if (scale_image->rows == image->rows)
      {
        /*
          Read a new scanline.
        */
        p=AcquireImagePixels(image,0,i++,image->columns,1,exception);
        if (p == (const PixelPacket *) NULL)
          break;
        indexes=AcquireIndexes(image);
        for (x=0; x < (long) image->columns; x++)
        {
          x_vector[x].red=(MagickRealType) p->red;
          x_vector[x].green=(MagickRealType) p->green;
          x_vector[x].blue=(MagickRealType) p->blue;
          if (image->matte != MagickFalse)
            x_vector[x].opacity=(MagickRealType) p->opacity;
          if (indexes != (IndexPacket *) NULL)
            x_vector[x].index=(MagickRealType) indexes[x];
          p++;
        }
      }
    else
      {
        /*
          Scale Y direction.
        */
        while (scale.y < span.y)
        {
          if ((next_row != MagickFalse) && (number_rows < (long) image->rows))
            {
              /*
                Read a new scanline.
              */
              p=AcquireImagePixels(image,0,i++,image->columns,1,exception);
              if (p == (const PixelPacket *) NULL)
                break;
              indexes=AcquireIndexes(image);
              for (x=0; x < (long) image->columns; x++)
              {
                x_vector[x].red=(MagickRealType) p->red;
                x_vector[x].green=(MagickRealType) p->green;
                x_vector[x].blue=(MagickRealType) p->blue;
                if (image->matte != MagickFalse)
                  x_vector[x].opacity=(MagickRealType) p->opacity;
                if (indexes != (IndexPacket *) NULL)
                  x_vector[x].index=(MagickRealType) indexes[x];
                p++;
              }
              number_rows++;
            }
          for (x=0; x < (long) image->columns; x++)
          {
            y_vector[x].red+=scale.y*x_vector[x].red;
            y_vector[x].green+=scale.y*x_vector[x].green;
            y_vector[x].blue+=scale.y*x_vector[x].blue;
            if (scale_image->matte != MagickFalse)
              y_vector[x].opacity+=scale.y*x_vector[x].opacity;
            if (scale_indexes != (IndexPacket *) NULL)
              y_vector[x].index+=scale.y*x_vector[x].index;
          }
          span.y-=scale.y;
          scale.y=(double) scale_image->rows/(double) image->rows;
          next_row=MagickTrue;
        }
        if ((next_row != MagickFalse) && (number_rows < (long) image->rows))
          {
            /*
              Read a new scanline.
            */
            p=AcquireImagePixels(image,0,i++,image->columns,1,exception);
            if (p == (const PixelPacket *) NULL)
              break;
            indexes=AcquireIndexes(image);
            for (x=0; x < (long) image->columns; x++)
            {
              x_vector[x].red=(MagickRealType) p->red;
              x_vector[x].green=(MagickRealType) p->green;
              x_vector[x].blue=(MagickRealType) p->blue;
              if (image->matte != MagickFalse)
                x_vector[x].opacity=(MagickRealType) p->opacity;
              if (indexes != (IndexPacket *) NULL)
                x_vector[x].index=(MagickRealType) indexes[x];
              p++;
            }
            number_rows++;
            next_row=MagickFalse;
          }
        s=scanline;
        for (x=0; x < (long) image->columns; x++)
        {
          pixel.red=y_vector[x].red+span.y*x_vector[x].red;
          pixel.green=y_vector[x].green+span.y*x_vector[x].green;
          pixel.blue=y_vector[x].blue+span.y*x_vector[x].blue;
          if (image->matte != MagickFalse)
            pixel.opacity=y_vector[x].opacity+span.y*x_vector[x].opacity;
          if (scale_indexes != (IndexPacket *) NULL)
            pixel.index=y_vector[x].index+span.y*x_vector[x].index;
          s->red=pixel.red;
          s->green=pixel.green;
          s->blue=pixel.blue;
          if (scale_image->matte != MagickFalse)
            s->opacity=pixel.opacity;
          if (scale_indexes != (IndexPacket *) NULL)
            s->index=pixel.index;
          s++;
          y_vector[x]=zero;
        }
        scale.y-=span.y;
        if (scale.y <= 0)
          {
            scale.y=(double) scale_image->rows/(double) image->rows;
            next_row=MagickTrue;
          }
        span.y=1.0;
      }
    if (scale_image->columns == image->columns)
      {
        /*
          Transfer scanline to scaled image.
        */
        s=scanline;
        for (x=0; x < (long) scale_image->columns; x++)
        {
          q->red=RoundToQuantum(s->red);
          q->green=RoundToQuantum(s->green);
          q->blue=RoundToQuantum(s->blue);
          if (scale_image->matte != MagickFalse)
            q->opacity=RoundToQuantum(s->opacity);
          if (scale_indexes != (IndexPacket *) NULL)
            scale_indexes[x]=(IndexPacket) RoundToQuantum(s->index);
          q++;
          s++;
        }
      }
    else
      {
        /*
          Scale X direction.
        */
        pixel=zero;
        next_column=MagickFalse;
        span.x=1.0;
        s=scanline;
        t=scale_scanline;
        for (x=0; x < (long) image->columns; x++)
        {
          scale.x=(double) scale_image->columns/(double) image->columns;
          while (scale.x >= span.x)
          {
            if (next_column != MagickFalse)
              {
                pixel=zero;
                t++;
              }
            pixel.red+=span.x*s->red;
            pixel.green+=span.x*s->green;
            pixel.blue+=span.x*s->blue;
            if (image->matte != MagickFalse)
              pixel.opacity+=span.x*s->opacity;
            if (scale_indexes != (IndexPacket *) NULL)
              pixel.index+=span.x*s->index;
            t->red=pixel.red;
            t->green=pixel.green;
            t->blue=pixel.blue;
            if (scale_image->matte != MagickFalse)
              t->opacity=pixel.opacity;
            if (scale_indexes != (IndexPacket *) NULL)
              t->index=pixel.index;
            scale.x-=span.x;
            span.x=1.0;
            next_column=MagickTrue;
          }
        if (scale.x > 0)
          {
            if (next_column != MagickFalse)
              {
                pixel=zero;
                next_column=MagickFalse;
                t++;
              }
            pixel.red+=scale.x*s->red;
            pixel.green+=scale.x*s->green;
            pixel.blue+=scale.x*s->blue;
            if (scale_image->matte != MagickFalse)
              pixel.opacity+=scale.x*s->opacity;
            if (scale_indexes != (IndexPacket *) NULL)
              pixel.index+=scale.x*s->index;
            span.x-=scale.x;
          }
        s++;
      }
      if (span.x > 0)
        {
          s--;
          pixel.red+=span.x*s->red;
          pixel.green+=span.x*s->green;
          pixel.blue+=span.x*s->blue;
          if (scale_image->matte != MagickFalse)
            pixel.opacity+=span.x*s->opacity;
          if (scale_indexes != (IndexPacket *) NULL)
            pixel.index+=span.x*s->index;
        }
      if ((next_column == MagickFalse) &&
          ((long) (t-scale_scanline) < (long) scale_image->columns))
        {
          t->red=pixel.red;
          t->green=pixel.green;
          t->blue=pixel.blue;
          if (scale_image->matte != MagickFalse)
            t->opacity=pixel.opacity;
          if (scale_indexes != (IndexPacket *) NULL)
            t->index=pixel.index;
        }
      /*
        Transfer scanline to scaled image.
      */
      t=scale_scanline;
      for (x=0; x < (long) scale_image->columns; x++)
      {
        q->red=RoundToQuantum(t->red);
        q->green=RoundToQuantum(t->green);
        q->blue=RoundToQuantum(t->blue);
        if (scale_image->matte != MagickFalse)
          q->opacity=RoundToQuantum(t->opacity);
        if (scale_indexes != (IndexPacket *) NULL)
          scale_indexes[x]=(IndexPacket) RoundToQuantum(t->index);
        t++;
        q++;
      }
    }
    if (SyncImagePixels(scale_image) == MagickFalse)
      break;
    if ((image->progress_monitor != (MagickProgressMonitor) NULL) &&
        (QuantumTick(y,image->rows) != MagickFalse))
      {
        status=image->progress_monitor(ScaleImageTag,y,image->rows,
          image->client_data);
        if (status == MagickFalse)
          break;
      }
  }
  /*
    Free allocated memory.
  */
  y_vector=(MagickPixelPacket *) RelinquishMagickMemory(y_vector);
  scale_scanline=(MagickPixelPacket *) RelinquishMagickMemory(scale_scanline);
  if (scale_image->rows != image->rows)
    scanline=(MagickPixelPacket *) RelinquishMagickMemory(scanline);
  x_vector=(MagickPixelPacket *) RelinquishMagickMemory(x_vector);
  return(scale_image);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
+   S e t R e s i z e F i l t e r S u p p o r t                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  SetResizeFilterSupport() specifies which IR filter to use to window
%
%  The format of the SetResizeFilterSupport method is:
%
%      void SetResizeFilterSupport(ResizeFilter *resize_filter,
%        const MagickRealType support)
%
%  A description of each parameter follows:
%
%    o resize_filter: the resize filter.
%
%    o support: the filter spport radius.
%
*/
MagickExport void SetResizeFilterSupport(ResizeFilter *resize_filter,
  const MagickRealType support)
{
  assert(resize_filter != (ResizeFilter *) NULL);
  assert(resize_filter->signature == MagickSignature);
  resize_filter->support=support;
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   T h u m b n a i l I m a g e                                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ThumbnailImage() changes the size of an image to the given dimensions and
%  removes any associated profiles.  The goal is to produce small low cost
%  thumbnail images suited for display on the Web.
%
%  The format of the ThumbnailImage method is:
%
%      Image *ThumbnailImage(const Image *image,const unsigned long columns,
%        const unsigned long rows,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o image: The image.
%
%    o columns: The number of columns in the scaled image.
%
%    o rows: The number of rows in the scaled image.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport Image *ThumbnailImage(const Image *image,
  const unsigned long columns,const unsigned long rows,ExceptionInfo *exception)
{
  char
    value[MaxTextExtent];

  const char
    *attribute;

  Image
    *sample_image,
    *thumbnail_image;

  MagickRealType
    x_factor,
    y_factor;

  struct stat
    attributes;

  unsigned long
    version;

  assert(image != (Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);
  x_factor=(MagickRealType) columns/(MagickRealType) image->columns;
  y_factor=(MagickRealType) rows/(MagickRealType) image->rows;
  if ((x_factor*y_factor) > 0.1)
    {
      thumbnail_image=ZoomImage(image,columns,rows,exception);
      if (thumbnail_image != (Image *) NULL)
        (void) StripImage(thumbnail_image);
      return(thumbnail_image);
    }
  sample_image=SampleImage(image,5*columns,5*rows,exception);
  if (sample_image == (Image *) NULL)
    return((Image *) NULL);
  thumbnail_image=ZoomImage(sample_image,columns,rows,exception);
  sample_image=DestroyImage(sample_image);
  if (thumbnail_image == (Image *) NULL)
    return(thumbnail_image);
  if (thumbnail_image->matte == MagickFalse)
    (void) SetImageOpacity(thumbnail_image,OpaqueOpacity);
  thumbnail_image->depth=8;
  thumbnail_image->interlace=NoInterlace;
  (void) StripImage(thumbnail_image);
  (void) CopyMagickString(value,image->magick_filename,MaxTextExtent);
  if (strstr(image->magick_filename,"///") == (char *) NULL)
    (void) FormatMagickString(value,MaxTextExtent,"file:///%s",
      image->magick_filename);
  (void) SetImageProperty(thumbnail_image,"Thumb::URI",value);
  (void) CopyMagickString(value,image->magick_filename,MaxTextExtent);
  if (stat(image->filename,&attributes) == 0)
    {
      (void) FormatMagickString(value,MaxTextExtent,"%ld",attributes.st_mtime);
      (void) SetImageProperty(thumbnail_image,"Thumb::MTime",value);
    }
  (void) FormatMagickString(value,MaxTextExtent,"%ld",attributes.st_mtime);
  (void) FormatMagickSize(GetBlobSize(image),value);
  (void) SetImageProperty(thumbnail_image,"Thumb::Size",value);
  (void) FormatMagickString(value,MaxTextExtent,"image/%s",image->magick);
  LocaleLower(value);
  (void) SetImageProperty(thumbnail_image,"Thumb::Mimetype",value);
  attribute=GetImageProperty(image,"comment");
  if ((attribute != (const char *) NULL) &&
      (value != (char *) NULL))
    (void) SetImageProperty(thumbnail_image,"description",value);
  (void) SetImageProperty(thumbnail_image,"software",
    GetMagickVersion(&version));
  (void) FormatMagickString(value,MaxTextExtent,"%lu",image->magick_columns);
  (void) SetImageProperty(thumbnail_image,"Thumb::Image::Width",value);
  (void) FormatMagickString(value,MaxTextExtent,"%lu",image->magick_rows);
  (void) SetImageProperty(thumbnail_image,"Thumb::Image::height",value);
  (void) FormatMagickString(value,MaxTextExtent,"%lu",
    GetImageListLength(image));
  (void) SetImageProperty(thumbnail_image,"Thumb::Document::Pages",value);
  return(thumbnail_image);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   Z o o m I m a g e                                                         %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ZoomImage() creates a new image that is a scaled size of an existing one.
%  It allocates the memory necessary for the new Image structure and returns a
%  pointer to the new image.  The Point filter gives fast pixel replication,
%  Triangle is equivalent to bi-linear interpolation, and Mitchel giver slower,
%  very high-quality results.  See Graphic Gems III for details on this
%  algorithm.
%
%  The filter member of the Image structure specifies which image filter to
%  use. Blur specifies the blur factor where > 1 is blurry, < 1 is sharp.
%
%  The format of the ZoomImage method is:
%
%      Image *ZoomImage(const Image *image,const unsigned long columns,
%        const unsigned long rows,ExceptionInfo *exception)
%
%  A description of each parameter follows:
%
%    o zoom_image: Method ZoomImage returns a pointer to the image after
%      scaling.  A null image is returned if there is a memory shortage.
%
%    o image: The image.
%
%    o columns: An integer that specifies the number of columns in the zoom
%      image.
%
%    o rows: An integer that specifies the number of rows in the scaled
%      image.
%
%    o exception: Return any errors or warnings in this structure.
%
*/
MagickExport Image *ZoomImage(const Image *image,const unsigned long columns,
  const unsigned long rows,ExceptionInfo *exception)
{
  Image
    *zoom_image;

  assert(image != (const Image *) NULL);
  assert(image->signature == MagickSignature);
  if (image->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",image->filename);
  assert(exception != (ExceptionInfo *) NULL);
  assert(exception->signature == MagickSignature);
  zoom_image=ResizeImage(image,columns,rows,image->filter,image->blur,
    exception);
  return(zoom_image);
}
