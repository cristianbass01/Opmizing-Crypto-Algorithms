#include "fe25519.h"

#if 0
#define WINDOWSIZE 1 /* Should be 1,2, or 4 */
#define WINDOWMASK ((1<<WINDOWSIZE)-1)
#endif

// USE of radix-26 representation
#define CONV8TO26(j) (((j)*8) / 26)
#define MASK26 0x3FFFFFF
#define MASK21 0x1FFFFF

static const unsigned int shifter[32] = {
  0, 8, 16, 24, 6, 14, 22, 4, 12, 20, 2, 10, 18, // 13 bytes
  0, 8, 16, 24, 6, 14, 22, 4, 12, 20, 2, 10, 18, // 26 bytes
  0, 8, 16, 24, 6, 14 // 32 bytes
} ;

const fe25519 fe25519_zero = {{0}};
const fe25519 fe25519_one  = {{1}};
const fe25519 fe25519_two  = {{2}};

/* sqrt(-1) in radix-26 */
const fe25519 fe25519_sqrtm1 = {{0x20ea0b0, 0x386c9d2, 0x2478c4e, 0x1ab4bf, 0x32f4318, 0x37ef5e9, 0xd00993, 0x37c2cad, 0x804fc1, 0xae0c9}};

/* -sqrt(-1) in radix-26 */
const fe25519 fe25519_msqrtm1 = {{0x1f15f3d, 0x79362d, 0x1b873b1, 0x3e54b40, 0xd0bce7, 0x810a16, 0x32ff66c, 0x83d352, 0x37fb03e, 0x151f36}};

/* -1 in radix-26 */
const fe25519 fe25519_m1 = {{0x3ffffec, 0x3ffffff, 0x3ffffff, 0x3ffffff, 0x3ffffff, 0x3ffffff, 0x3ffffff, 0x3ffffff, 0x3ffffff, 0x1fffff}};

// Changed to radix-26
static unsigned long long equal(unsigned long long a,unsigned long long b) /* 64-bit inputs */
{
  unsigned long long x = a ^ b; /* 0: yes; 1..65535: no */
  x -= 1; /* 4294967295: yes; 0..65534: no */
  x >>= 63; /* 1: yes; 0: no */
  return x;
}

// Changed to radix-26
static unsigned long long ge(unsigned long long a, unsigned long long b) /* 64-bit inputs */
{
  unsigned long long x = a;
  x -= (unsigned long long) b; /* 0..65535: yes; 4294901761..4294967295: no */
  x >>= 63; /* 0: yes; 1: no */
  x ^= 1; /* 1: yes; 0: no */
  return x;
}

// Changed to radix-26
static unsigned long long times19(unsigned long long a)
{
  return (a << 4) + (a << 1) + a;
}

// Changed to radix-26
static unsigned long long times608(unsigned long long a)
{
  return (a << 9) + (a << 6) + (a << 5);
}

// Changed to radix-26
static void reduce_add_sub(fe25519 *r)
{
  unsigned long long t;
  int i;

  t = r->v[9] >> 21;
  r->v[9] &= MASK21;
  t = times19(t);
  r->v[0] += t;
  for(i=0;i<9;i++)
  {
    t = r->v[i] >> 26;
    r->v[i+1] += t;
    r->v[i] &= MASK26;
  }
}

// Changed to radix-26
static void reduce_mul(unsigned long long *v)
{
  unsigned long long t;
  int i, rep;

  for(rep=0;rep<2;rep++)
  {
    t = (v[9] >> 21);
    v[9] &= MASK21;
    t = times19(t);
    v[0] += t;
    for(i=0;i<9;i++)
    {
      t = v[i] >> 26;
      v[i+1] += t;
      v[i] &= MASK26;
    }
  }
}

// Changed to radix-26
/* reduction modulo 2^255-19 */
void fe25519_freeze(fe25519 *r) 
{
  int i;
  uint32_t m = equal(r->v[9], MASK21);
  for(i=8;i>0;i--)
    m &= equal(r->v[i], MASK26);
  m &= ge(r->v[0], 0x3FFFFED); // complement 2 of 19: from 237 to 0x3FFFFED

  m = -m;

  r->v[9] -= m&MASK21;
  for(i=8;i>0;i--)
    r->v[i] -= m&MASK26;
  r->v[0] -= m&0x3FFFFED;
}

// Changed to radix-26
void fe25519_unpack(fe25519 *r, const unsigned char x[32])
{
  int i, u;
  u = 0;
  for(i=0;i<10;i++) r->v[i] = 0;
  for(i=0;i<32;i++){
    // shifting the bits to the left, applying the mask and propagating the remaining bits to the next integer
    r->v[CONV8TO26(i)] |= ((x[i] << shifter[i]) & MASK26) | u;

    // updating u
    u = x[i] >> (26 - shifter[i]);
  } 
  r->v[9] &= MASK21; 
}

// Changed to radix-26
/* Assumes input x being reduced below 2^255 */
void fe25519_pack(unsigned char r[32], const fe25519 *x)
{
  int i;
  fe25519 y = *x;
  fe25519_freeze(&y);
  // conversion from 10 26-bit integers to 32 bytes (y to r)
  for (i=0;i<32;i++) r[i] = (y.v[CONV8TO26(i)] | (y.v[CONV8TO26(i+1)] << 26)) >> shifter[i] & 0xFF;

}

int fe25519_iszero(const fe25519 *x)
{
  return fe25519_iseq(x, &fe25519_zero);
}

int fe25519_isone(const fe25519 *x)
{
  return fe25519_iseq(x, &fe25519_one);
}

// return true if x has LSB set
int fe25519_isnegative(const fe25519 *x)
{
  fe25519 t = *x;
  
  fe25519_freeze(&t);

  return t.v[0] & 1;
}

// Changed to radix-26
int fe25519_iseq(const fe25519 *x, const fe25519 *y)
{
  fe25519 t1,t2;
  int i,r=0;

  t1 = *x;
  t2 = *y;
  fe25519_freeze(&t1);
  fe25519_freeze(&t2);
  for(i=0;i<10;i++)
    r |= (1-equal(t1.v[i],t2.v[i]));
  return 1-r;
}

void fe25519_cmov(fe25519 *r, const fe25519 *x, unsigned char b)
{
  if(b) *r = *x;
}

void fe25519_neg(fe25519 *r, const fe25519 *x)
{
  fe25519 t = fe25519_zero;
  fe25519_sub(r, &t, x);
}

// Changed to radix-26
void fe25519_add(fe25519 *r, const fe25519 *x, const fe25519 *y)
{
  int i;
  for(i=0;i<10;i++) r->v[i] = x->v[i] + y->v[i];
  reduce_add_sub(r);
}

// Changed to radix-26
void fe25519_double(fe25519 *r, const fe25519 *x)
{
  int i;
  for(i=0;i<10;i++) r->v[i] = 2*x->v[i];
  reduce_add_sub(r);
}

// Change to radix-26
void fe25519_sub(fe25519 *r, const fe25519 *x, const fe25519 *y)
{
  // I think here they are adding 2*(2^255-19) to x so that when subtracted it will be positive
  // I also think it should be enough to add just 2^255 - 19, since y should still be in the range 0 to 2^255 - 19
  int i;
  uint32_t t[10];

  t[0] = x->v[0] + 0x7ffffda;
  t[9] = x->v[9] + 0x3ffffe; 
  for(i=1;i<9;i++) t[i] = x->v[i] + 0x7fffffe;

  for(i=0;i<10;i++) r->v[i] = t[i] - y->v[i];

  reduce_add_sub(r);
}

// Change to radix-26
void fe25519_mul(fe25519 *r, const fe25519 *x, const fe25519 *y)
{
  
  int i,j;
  unsigned long long t[19];
  for(i=0;i<19;i++) t[i] = 0;
  for(i=0;i<10;i++)
    for(j=0;j<10;j++)
      // 26-bit * 26-bit = 52-bit
      // max 10 additions -> 52 + up(log2(10)) = 56-bit
      t[i+j] += x->v[i] * y->v[j]; 
  
  // the problem is relative to the last 9 elements
  // because they will need to be multiply by 608
  // 56-bit t * 608 = 56 + up(log2(608)) = 56 + 10 = 66-bit TOO BIG
  // So I'll reduce them before adding them to the result
  reduce_mul(t+9); 

  for(i=10;i<19;i++)
    r->v[i-10] = t[i-10] + times608(t[i]);
  r->v[9] = t[9]; /* result now in r[0]...r[31] */
  
  reduce_mul(r->v);
}

void fe25519_square(fe25519 *r, const fe25519 *x)
{
  fe25519_mul(r, x, x);
}

#if 0
void fe25519_invert(fe25519 *r, const fe25519 *x)
{
	fe25519 z2;
	fe25519 z9;
	fe25519 z11;
	fe25519 z2_5_0;
	fe25519 z2_10_0;
	fe25519 z2_20_0;
	fe25519 z2_50_0;
	fe25519 z2_100_0;
	fe25519 t0;
	fe25519 t1;
	int i;
	
	/* 2 */ fe25519_square(&z2,x);
	/* 4 */ fe25519_square(&t1,&z2);
	/* 8 */ fe25519_square(&t0,&t1);
	/* 9 */ fe25519_mul(&z9,&t0,x);
	/* 11 */ fe25519_mul(&z11,&z9,&z2);
	/* 22 */ fe25519_square(&t0,&z11);
	/* 2^5 - 2^0 = 31 */ fe25519_mul(&z2_5_0,&t0,&z9);

	/* 2^6 - 2^1 */ fe25519_square(&t0,&z2_5_0);
	/* 2^7 - 2^2 */ fe25519_square(&t1,&t0);
	/* 2^8 - 2^3 */ fe25519_square(&t0,&t1);
	/* 2^9 - 2^4 */ fe25519_square(&t1,&t0);
	/* 2^10 - 2^5 */ fe25519_square(&t0,&t1);
	/* 2^10 - 2^0 */ fe25519_mul(&z2_10_0,&t0,&z2_5_0);

	/* 2^11 - 2^1 */ fe25519_square(&t0,&z2_10_0);
	/* 2^12 - 2^2 */ fe25519_square(&t1,&t0);
	/* 2^20 - 2^10 */ for (i = 2;i < 10;i += 2) { fe25519_square(&t0,&t1); fe25519_square(&t1,&t0); }
	/* 2^20 - 2^0 */ fe25519_mul(&z2_20_0,&t1,&z2_10_0);

	/* 2^21 - 2^1 */ fe25519_square(&t0,&z2_20_0);
	/* 2^22 - 2^2 */ fe25519_square(&t1,&t0);
	/* 2^40 - 2^20 */ for (i = 2;i < 20;i += 2) { fe25519_square(&t0,&t1); fe25519_square(&t1,&t0); }
	/* 2^40 - 2^0 */ fe25519_mul(&t0,&t1,&z2_20_0);

	/* 2^41 - 2^1 */ fe25519_square(&t1,&t0);
	/* 2^42 - 2^2 */ fe25519_square(&t0,&t1);
	/* 2^50 - 2^10 */ for (i = 2;i < 10;i += 2) { fe25519_square(&t1,&t0); fe25519_square(&t0,&t1); }
	/* 2^50 - 2^0 */ fe25519_mul(&z2_50_0,&t0,&z2_10_0);

	/* 2^51 - 2^1 */ fe25519_square(&t0,&z2_50_0);
	/* 2^52 - 2^2 */ fe25519_square(&t1,&t0);
	/* 2^100 - 2^50 */ for (i = 2;i < 50;i += 2) { fe25519_square(&t0,&t1); fe25519_square(&t1,&t0); }
	/* 2^100 - 2^0 */ fe25519_mul(&z2_100_0,&t1,&z2_50_0);

	/* 2^101 - 2^1 */ fe25519_square(&t1,&z2_100_0);
	/* 2^102 - 2^2 */ fe25519_square(&t0,&t1);
	/* 2^200 - 2^100 */ for (i = 2;i < 100;i += 2) { fe25519_square(&t1,&t0); fe25519_square(&t0,&t1); }
	/* 2^200 - 2^0 */ fe25519_mul(&t1,&t0,&z2_100_0);

	/* 2^201 - 2^1 */ fe25519_square(&t0,&t1);
	/* 2^202 - 2^2 */ fe25519_square(&t1,&t0);
	/* 2^250 - 2^50 */ for (i = 2;i < 50;i += 2) { fe25519_square(&t0,&t1); fe25519_square(&t1,&t0); }
	/* 2^250 - 2^0 */ fe25519_mul(&t0,&t1,&z2_50_0);

	/* 2^251 - 2^1 */ fe25519_square(&t1,&t0);
	/* 2^252 - 2^2 */ fe25519_square(&t0,&t1);
	/* 2^253 - 2^3 */ fe25519_square(&t1,&t0);
	/* 2^254 - 2^4 */ fe25519_square(&t0,&t1);
	/* 2^255 - 2^5 */ fe25519_square(&t1,&t0);
	/* 2^255 - 21 */ fe25519_mul(r,&t1,&z11);
}
#endif

void fe25519_pow2523(fe25519 *r, const fe25519 *x)
{
	fe25519 z2;
	fe25519 z9;
	fe25519 z11;
	fe25519 z2_5_0;
	fe25519 z2_10_0;
	fe25519 z2_20_0;
	fe25519 z2_50_0;
	fe25519 z2_100_0;
	fe25519 t;
	int i;
		
	/* 2 */ fe25519_square(&z2,x);
	/* 4 */ fe25519_square(&t,&z2);
	/* 8 */ fe25519_square(&t,&t);
	/* 9 */ fe25519_mul(&z9,&t,x);
	/* 11 */ fe25519_mul(&z11,&z9,&z2);
	/* 22 */ fe25519_square(&t,&z11);
	/* 2^5 - 2^0 = 31 */ fe25519_mul(&z2_5_0,&t,&z9);

	/* 2^6 - 2^1 */ fe25519_square(&t,&z2_5_0);
	/* 2^10 - 2^5 */ for (i = 1;i < 5;i++) { fe25519_square(&t,&t); }
	/* 2^10 - 2^0 */ fe25519_mul(&z2_10_0,&t,&z2_5_0);

	/* 2^11 - 2^1 */ fe25519_square(&t,&z2_10_0);
	/* 2^20 - 2^10 */ for (i = 1;i < 10;i++) { fe25519_square(&t,&t); }
	/* 2^20 - 2^0 */ fe25519_mul(&z2_20_0,&t,&z2_10_0);

	/* 2^21 - 2^1 */ fe25519_square(&t,&z2_20_0);
	/* 2^40 - 2^20 */ for (i = 1;i < 20;i++) { fe25519_square(&t,&t); }
	/* 2^40 - 2^0 */ fe25519_mul(&t,&t,&z2_20_0);

	/* 2^41 - 2^1 */ fe25519_square(&t,&t);
	/* 2^50 - 2^10 */ for (i = 1;i < 10;i++) { fe25519_square(&t,&t); }
	/* 2^50 - 2^0 */ fe25519_mul(&z2_50_0,&t,&z2_10_0);

	/* 2^51 - 2^1 */ fe25519_square(&t,&z2_50_0);
	/* 2^100 - 2^50 */ for (i = 1;i < 50;i++) { fe25519_square(&t,&t); }
	/* 2^100 - 2^0 */ fe25519_mul(&z2_100_0,&t,&z2_50_0);

	/* 2^101 - 2^1 */ fe25519_square(&t,&z2_100_0);
	/* 2^200 - 2^100 */ for (i = 1;i < 100;i++) { fe25519_square(&t,&t); }
	/* 2^200 - 2^0 */ fe25519_mul(&t,&t,&z2_100_0);

	/* 2^201 - 2^1 */ fe25519_square(&t,&t);
	/* 2^250 - 2^50 */ for (i = 1;i < 50;i++) { fe25519_square(&t,&t); }
	/* 2^250 - 2^0 */ fe25519_mul(&t,&t,&z2_50_0);

	/* 2^251 - 2^1 */ fe25519_square(&t,&t);
	/* 2^252 - 2^2 */ fe25519_square(&t,&t);
	/* 2^252 - 3 */ fe25519_mul(r,&t,x);
}

void fe25519_invsqrt(fe25519 *r, const fe25519 *x)
{
  fe25519 den2, den3, den4, den6, chk, t, t2;
  int b;

  fe25519_square(&den2, x);
  fe25519_mul(&den3, &den2, x);

  fe25519_square(&den4, &den2);
  fe25519_mul(&den6, &den2, &den4);
  fe25519_mul(&t, &den6, x); // r is now x^7

  fe25519_pow2523(&t, &t);
  fe25519_mul(&t, &t, &den3);

  fe25519_square(&chk, &t);
  fe25519_mul(&chk, &chk, x);

  fe25519_mul(&t2, &t, &fe25519_sqrtm1);
  b = 1 - fe25519_isone(&chk);

  fe25519_cmov(&t, &t2, b);

  *r = t;
}
