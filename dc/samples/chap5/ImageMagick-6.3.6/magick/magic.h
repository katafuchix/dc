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

  MagickCore magic methods.
*/
#ifndef _MAGICKCORE_MAGIC_H
#define _MAGICKCORE_MAGIC_H

#if defined(__cplusplus) || defined(c_plusplus)
extern "C" {
#endif

typedef struct _MagicInfo
{
  char
    *path,
    *name,
    *target;

  unsigned char
    *magic;

  size_t
    length;

  MagickOffsetType
    offset;

  MagickBooleanType
    stealth;

  struct _MagicInfo
    *previous,
    *next;  /* deprecated, use GetMagicInfoList() */

  unsigned long
    signature;
} MagicInfo;

extern MagickExport char
  **GetMagicList(const char *,unsigned long *,ExceptionInfo *);

extern MagickExport const char
  *GetMagicName(const MagicInfo *);

extern MagickExport MagickBooleanType
  ListMagicInfo(FILE *,ExceptionInfo *);

extern MagickExport const MagicInfo
  *GetMagicInfo(const unsigned char *,const size_t,ExceptionInfo *),
  **GetMagicInfoList(const char *,unsigned long *,ExceptionInfo *);

extern MagickExport void
  DestroyMagicList(void);

#if defined(__cplusplus) || defined(c_plusplus)
}
#endif

#endif
