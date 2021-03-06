/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%                  M   M   AAA   TTTTT  RRRR   IIIII  X   X                   %
%                  MM MM  A   A    T    R   R    I     X X                    %
%                  M M M  AAAAA    T    RRRR     I      X                     %
%                  M   M  A   A    T    R R      I     X X                    %
%                  M   M  A   A    T    R  R   IIIII  X   X                   %
%                                                                             %
%                                                                             %
%                         ImageMagick Matrix Methods                          %
%                                                                             %
%                            Software Design                                  %
%                              John Cristy                                    %
%                              August 2007                                    %
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
#include "magick/matrix.h"
#include "magick/memory_.h"
#include "magick/utility.h"

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   A c q u i r e M a g i c k M a t r i x                                     %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  AcquireMagickMatrix() allocates and returns a matrix in the form of an
%  array of pointers to an array of doubles, with all values pre-set to zero.
%
%  This is used to generate the two dimentional matrix, and vectors required
%  for the GaussJordanElimination() method below, solving some system of
%  simultanious equations.

%  The format of the AcquireMagickMatrix method is:
%
%      double **AcquireMagickMatrix(const unsigned long nptrs,
%           const unsigned long size)
%
%  A description of each parameter follows:
%
%    o nptrs: The number pointers for the array of pointers
%             (first dimension)
%
%    o size: The size of the array of doubles each pointer points to.
%            (second dimension)
%
*/
MagickExport double **AcquireMagickMatrix(const unsigned long nptrs,
     const unsigned long size)
{
  double
   **matrix;

  register unsigned long
    i,
    j;

  matrix=(double **) AcquireQuantumMemory(nptrs,sizeof(*matrix));
  if (matrix == (double **) NULL)
    return((double **)NULL);

  for (i=0; i < nptrs; i++)
  {
    matrix[i]=(double *) AcquireQuantumMemory(size,sizeof(*matrix[i]));
    if (matrix[i] == (double *) NULL)
    {
      for (j=0; j < i; j++)
        matrix[j]=(double *) RelinquishMagickMemory(matrix[j]);
      matrix=(double **) RelinquishMagickMemory(matrix);
      return((double **) NULL);
    }
    /*(void) ResetMagickMemory(matrix[i],0,size*sizeof(*matrix[i])); */
    for (j=0; j < size; j++)
      matrix[i][j] = 0.0;
  }
  return(matrix);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   G a u s s J o r d a n E l i m i n a t i o n                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  GaussJordanElimination() returns a matrix in reduced row echelon form,
%  while simultaneously reducing and thus solving the augumented results
%  matrix.
%
%  See also  http://en.wikipedia.org/wiki/Gauss-Jordan_elimination
%
%  The format of the GaussJordanElimination method is:
%
%      MagickBooleanType GaussJordanElimination(double **matrix,
%        double **vectors, const unsigned long rank, const unsigned long nvecs)
%
%  A description of each parameter follows:
%
%    o matrix: The matrix to be reduced, as an 'array of row pointers'.
%
%    o vectors: The additional matrix argumenting the matrix for row reduction.
%             Producing an 'array of column vectors'.
%
%    o rank:  The size of the matrix (both rows and columns).
%             Also represents the number terms that need to be solved.
%
%    o nvecs: Number of vectors columns, argumenting the above matrix.
%             Usally 1, but can be more for more complex equation solving.
%
%  Note that the 'matrix' is given as a 'array of row pointers' of rank size.
%  That is values can be assigned as   matrix[row][column]   where 'row' is
%  typically the equation, and 'column' is the term of the equation.
%  That is the matrix is in the form of a 'row first array'.
%
%  However 'vectors' is a 'array of column pointers' which can have any number
%  of columns, with each column array the same 'rank' size as 'matrix'.
%
%  This allows for simpler handling of the results, especially is only one
%  column 'vector' is all that is required to produce the desired solution.
%
%  For example, the 'vectors' can consist of a pointer to a simple array of
%  doubles.  when only one set of simultanious equations is to be solved from
%  the given set of coefficient weighted terms.
%
%     double **matrix = AcquireMagickMatrix(8UL,8UL);
%     double coefficents[8];
%     ...
%     GaussJordanElimination(matrix, &coefficents, 8UL, 1UL);
%
%  However by specifing more 'columns' (as an 'array of vector columns',
%  you can use this function to solve a set of 'separable' equations.
%
%  For example a distortion function where    u = U(x,y)   v = V(x,y)
%  And the functions U() and V() have separate coefficents, but are being
%  generated from a common x,y->u,v  data set.
%
%  Another example is generation of a color gradient from a set of colors
%  at specific coordients, such as a list    x,y -> r,g,b,a
%  (Reference to be added - Anthony)
%
%  You can also use the 'vectors' to generate an inverse of the given 'matrix'
%  though as a 'column first array' rather than a 'row first array'. For
%  details see    http://en.wikipedia.org/wiki/Gauss-Jordan_elimination
%
*/
MagickExport MagickBooleanType GaussJordanElimination(double **matrix,
  double **vectors, const unsigned long rank, const unsigned long nvecs)
{
#define GaussJordanSwap(x,y) \
{ \
  if ((x) != (y)) \
    { \
      (x)+=(y); \
      (y)=(x)-(y); \
      (x)=(x)-(y); \
    } \
}

  double
    max,
    scale;

  long
    column,
    *columns,
    *pivots,
    row,
    *rows;

  register long
    i,
    j,
    k;

  columns=(long *) AcquireQuantumMemory(rank,sizeof(*columns));
  rows=(long *) AcquireQuantumMemory(rank,sizeof(*rows));
  pivots=(long *) AcquireQuantumMemory(rank,sizeof(*pivots));
  if ((rows == (long *) NULL) || (columns == (long *) NULL) ||
      (pivots == (long *) NULL))
    {
      if (pivots != (long *) NULL)
        pivots=(long *) RelinquishMagickMemory(pivots);
      if (columns != (long *) NULL)
        columns=(long *) RelinquishMagickMemory(columns);
      if (rows != (long *) NULL)
        rows=(long *) RelinquishMagickMemory(rows);
      return(MagickFalse);
    }
  (void) ResetMagickMemory(columns,0,rank*sizeof(*columns));
  (void) ResetMagickMemory(rows,0,rank*sizeof(*rows));
  (void) ResetMagickMemory(pivots,0,rank*sizeof(*pivots));
  column=0;
  row=0;
  for (i=0; i < (long) rank; i++)
  {
    max=0.0;
    for (j=0; j < (long) rank; j++)
      if (pivots[j] != 1)
        {
          for (k=0; k < (long) rank; k++)
            if (pivots[k] != 0)
              {
                if (pivots[k] > 1)
                  return(MagickFalse);
              }
            else
              if (fabs(matrix[j][k]) >= max)
                {
                  max=fabs(matrix[j][k]);
                  row=j;
                  column=k;
                }
        }
    pivots[column]++;
    if (row != column)
      {
        for (k=0; k < (long) rank; k++)
          GaussJordanSwap(matrix[row][k],matrix[column][k]);
        for (k=0; k < (long) nvecs; k++)
          GaussJordanSwap(vectors[k][row],vectors[k][column]);
      }
    rows[i]=row;
    columns[i]=column;
    if (matrix[column][column] == 0.0)
      return(MagickFalse);  /* sigularity */
    scale=1.0/matrix[column][column];
    matrix[column][column]=1.0;
    for (j=0; j < (long) rank; j++)
      matrix[column][j]*=scale;
    for (j=0; j < (long) nvecs; j++)
      vectors[j][column]*=scale;
    for (j=0; j < (long) rank; j++)
      if (j != column)
        {
          scale=matrix[j][column];
          matrix[j][column]=0.0;
          for (k=0; k < (long) rank; k++)
            matrix[j][k]-=scale*matrix[column][k];
          for (k=0; k < (long) nvecs; k++)
            vectors[k][j]-=scale*vectors[k][column];
        }
  }
  for (j=(long) rank-1; j >= 0; j--)
    if (columns[j] != rows[j])
      for (i=0; i < (long) rank; i++)
        GaussJordanSwap(matrix[i][rows[j]],matrix[i][columns[j]]);
  pivots=(long *) RelinquishMagickMemory(pivots);
  rows=(long *) RelinquishMagickMemory(rows);
  columns=(long *) RelinquishMagickMemory(columns);
  return(MagickTrue);
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   L e a s t S q u a r e s A d d T e r m s                                   %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  LeastSquaresAddTerms() adds one set of terms and associate results to the
%  given matrix and vectors for solving using least-squares function fitting.
%
%  The format of the AcquireMagickMatrix method is:
%
%      void LeastSquaresAddTerms(double **matrix,double **vectors,
%             const double *terms, const double *results,
%             const unsigned long rank, const unsigned long nvecs);
%
%  A description of each parameter follows:
%
%    o matrix: The square matrix to add given terms/results to.
%
%    o vectors: The result vectors to add terms/results to.
%
%    o terms: The pre-calculated terms (without the unknown coefficent
%             weights) that forms the equation being added.
%
%    o results: The result(s) that should be generated from the given terms
%               weighted by the yet-to-be-solved coefficents.
%
%    o rank: The rank or size of the dimentions of the square matrix.
%            Also the length of vectors, and number of terms being added.
%
%    o nvecs: Number of result vectors, and number or results being added.
%             Also represents the number of separable systems of equations
%             that is being solved.
%
%  Example of use...
%
%     // 2 dimentional Affine Equations (which are separable)
%     //   c0*x + c2*y + c4*1 => u
%     //   c1*x + c3*y + c5*1 => v
%
%     double **matrix = AcquireMagickMatrix(3UL,3UL);
%     double **vectors = AcquireMagickMatrix(2UL,3UL);
%     double terms[3], results[2];
%     ...
%     //for each given x,y -> u,v
%        terms[0] = x;
%        terms[1] = y;
%        terms[2] = 1;
%        results[0] = u;
%        results[1] = v;
%        LeastSquaresAddTerms(matrix,vectors,terms,results,3UL,2UL);
%     ...
%     if ( GaussJordanElimination(matrix,vectors,3UL,2UL) ) {
%       c0 = vectors[0][0];
%       c2 = vectors[0][1];
%       c4 = vectors[0][2];
%       c1 = vectors[1][0];
%       c3 = vectors[1][1];
%       c5 = vectors[1][2];
%     }
%     else
%       printf("Matrix unsolvable\n);
%     RelinquishMagickMatrix(matrix,3UL);
%     RelinquishMagickMatrix(vectors,2UL);
%
*/
MagickExport void LeastSquaresAddTerms(double **matrix,double **vectors,
     const double *terms, const double *results, const unsigned long rank,
     const unsigned long nvecs)
{
  register unsigned long
    i,
    j;

  for(j=0; j<rank; j++) {
    for(i=0; i<rank; i++)
      matrix[i][j] += terms[i] * terms[j];
    for(i=0; i<nvecs; i++)
      vectors[i][j] += results[i] * terms[j];
  }

  return;
}

/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%                                                                             %
%                                                                             %
%   R e l i n q u i s h M a g i c k M a t r i x                               %
%                                                                             %
%                                                                             %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  RelinquishMagickMatrix() frees the previously acquired matrix (array of
%  pointers to arrays of doubles).
%
%  The format of the RelinquishMagickMatrix method is:
%
%      double **RelinquishMagickMatrix(double **matrix,
%         const unsigned long nptrs)
%
%  A description of each parameter follows:
%
%    o matrix: the matrix to relinquish
%
%    o nptrs: The first dimention of the acquired matrix (number of pointers)
%
*/
MagickExport double **RelinquishMagickMatrix(double **matrix,
     const unsigned long nptrs)
{
  register unsigned long
    i;

  if (matrix == (double **) NULL )
    return(matrix);

  for (i=0; i < nptrs; i++)
     matrix[i]=(double *) RelinquishMagickMemory(matrix[i]);
  matrix=(double **) RelinquishMagickMemory(matrix);

  return(matrix);
}

