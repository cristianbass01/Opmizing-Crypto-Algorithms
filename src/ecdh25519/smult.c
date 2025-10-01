#include "group.h"
#include "smult.h"

// Constant time equality check as given in the slides
static unsigned char int_eq(int a, int b)
{
  unsigned long long t = a ^ b;
  t = (-t) >> 63;
  return 1-t;
}

// Constant time cmov as given in the slides
static void ec_point_cmov(group_ge *r, const group_ge *t, unsigned char b)
{
  unsigned char *u = (unsigned char *)r;
  unsigned char *v = (unsigned char *)t;
  unsigned int i;
  b = -b;
  for(i=0; i < sizeof(group_ge); i++)
    u[i] = (b & v[i]) ^ (~b & u[i]);
}

// Constant time table lookup as given in the slides adjusted with size 16 instead of 256
static void ec_point_lookup(group_ge *t, const group_ge *table, int pos)
{
  int i;
  unsigned char b;
  *t = table[0];
  for(i=0;i<16;i++)
  {
    b = int_eq(i, pos); 
    ec_point_cmov(t, &table[i], b); 
  }
}

// Elliptic curve scalar multiplication
int crypto_scalarmult(unsigned char *ss, const unsigned char *sk, const unsigned char *pk)
{
  group_ge p, k, l;
  group_ge T[16]; 
  unsigned char t[32];
  int i,j;

  for(i=0;i<32;i++) {
    t[i] = sk[i];
  }

  t[0] &= 248;
  t[31] &= 127;
  t[31] |= 64;

  if(group_ge_unpack(&p, pk)) return -1;

  // T will contains O, P, 2P, 3P, ..., 15P
  T[0] = group_ge_neutral;
  T[1] = p;
  for(int y=2; y<16; y++) {
    group_ge_add(&T[y], &T[y-1], &T[1]);
  }

  // Fixed-window implementation with window size 4
  
  // first computation can be skipped as we already have it
  ec_point_lookup(&l, T, ((int) ((t[31] >> 4) & 0xF)));
  k = l;

  // finish processing the last byte (first 4-bits)
  for(j=0;j<4;j++) group_ge_double(&k, &k);
  ec_point_lookup(&l, T, ((int) (t[31] & 0xF)));
  group_ge_add(&k, &k, &l);
  
  for(i=30;i>=0;i--) // start from the second last byte
  {
    // Second 4-bit window
    for(j=0;j<4;j++) group_ge_double(&k, &k);
    ec_point_lookup(&l, T, ((int) ((t[i] >> 4) & 0xF)));
    group_ge_add(&k, &k, &l);

    // First 4-bit window
    for(j=0;j<4;j++) group_ge_double(&k, &k);
    ec_point_lookup(&l, T, ((int) (t[i] & 0xF)));
    group_ge_add(&k, &k, &l);
  }

  group_ge_pack(ss, &k);
  return 0;
}

int crypto_scalarmult_base(unsigned char *pk, const unsigned char *sk)
{
  unsigned char t[GROUP_GE_PACKEDBYTES];
  group_ge_pack(t, &group_ge_base);
  return crypto_scalarmult(pk, sk, t);
}


