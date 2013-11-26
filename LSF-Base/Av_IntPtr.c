#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "Av_IntPtr.h"  /* XS_*_intPtr() */
#ifdef __cplusplus
}
#endif

/* modified from Av_CharPtrPtr by Paul Franceus. Much thanks
 * To the original author of Av_CharPtrPtr.c
 */

/* Used by the INPUT typemap for int*.
 * Will convert a Perl AV* (containing ints) to a C int*.
 */
int*
XS_unpack_intPtr( rv )
     SV *rv;
{
  AV *av;
  SV **ssv;
  int *ia;
  int avlen;
  int x;
  
  if( SvROK( rv ) && (SvTYPE(SvRV(rv)) == SVt_PVAV) )
    av = (AV*)SvRV(rv);
  else {
    if( SvOK(rv) ){
      warn("XS_unpack_intPtr: rv was not an AV ref");
    }
    return( (int *)NULL );
  }
  
  /* is it empty? */
  avlen = av_len(av);
  if( avlen < 0 ){
    /*warn("XS_unpack_intPtr: array was empty");*/
    return( (int *)NULL );
  }
  
  /* av_len+2 == number of strings, array[0] will contain the length of
   * the array.
   */
  ia = (int *)safemalloc( sizeof(int) * (avlen + 2) );
  if( ia == NULL ){
    warn("XS_unpack_intPtr: unable to malloc int *");
    return( (int *)NULL );
  }
  ia[0] = avlen + 1;
  for( x = 0; x <= avlen; ++x ){
    ssv = av_fetch( av, x, 0 );
    if( ssv != NULL ){
      if( SvIOK( *ssv ) ){
	  ia[x+1] = SvIV( *ssv );
      }
      else
	warn("XS_unpack_intPtr: array elem %d was not an integer.", x );
    }
    else
      ia[x+1] = 0;
  }
  return( ia );
}

/* Used by the OUTPUT typemap for int*.
 * Will convert a C int* to a Perl AV*.
 * We assume that the length is the first element in the array.
 * I know this is a kludge, but it had to be stored somewhere.
 */
void
XS_pack_intPtr( st, ia )
SV *st;
int *ia;
{
	AV *av = newAV();
	SV *sv;
	int c, size;
         
        size = ia[0];
	for( c = 1; c <= size; ++c ){
		sv = newSViv( ia[c] );
		av_push( av, sv );
	}
	sv = newSVrv( st, NULL );	/* upgrade stack SV to an RV */
	SvREFCNT_dec( sv );	/* discard */
	SvRV( st ) = (SV*)av;	/* make stack RV point at our AV */
}


/* cleanup the temporary char** from XS_unpack_charPtrPtr */
void
XS_release_intPtr(ia)
int *ia;
{
	safefree( ia );
}

