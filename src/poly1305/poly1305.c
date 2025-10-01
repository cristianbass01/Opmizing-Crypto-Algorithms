/*
20080912
D. J. Bernstein
Public domain.
*/

#include "poly1305.h"

#define CONV8TO26(j) (((j) << 3) / 26) // j * 8 / 26
#define MASK26 0x3FFFFFF

static const unsigned int shifter[17] = {
  0, 8, 16, 24, 6, 14, 22, 4, 12, 20, 2, 10, 18, 
  0, 8, 16, 24
} ;

static void add(unsigned long long h[5],const unsigned long long c[5])
{
  unsigned int j;
  unsigned long long u;
  u = 0;
  // update the mask to 26 bits and the number of bits to shift
  for (j = 0;j < 5;++j) { u += h[j] + c[j]; h[j] = u & MASK26; u >>= 26; }
  // save the last remaining bits to the last integer
  h[4] += u << 26;
}

static void squeeze(unsigned long long h[5])
{
  unsigned int j;
  unsigned long long u;
  u = 0;
  // update the mask to 26 bits and the number of bits to shift
  for (j = 0;j < 5;++j) { u += h[j]; h[j] = u & MASK26; u >>= 26; }
  // the last remainer will be multiplied by 5 and added to the first integer
  // this step ensure the ring property of 2^130 - 5
  u *= 5;
  for (j = 0;j < 5;++j) { u += h[j]; h[j] = u & MASK26; u >>= 26; }
}

// Add 5 to the first integer of h and add 1 to each of the bits from 26 to 52 
// of the last integer of h to check if the integer is bigger than 2^130 - 5
static const unsigned long long minusp[5] = {
  5, 0, 0, 0, 0xFFFFFFC000000
} ;

static void freeze(unsigned long long h[5])
{
  unsigned long long horig[5];
  unsigned int j;
  unsigned long long negative;
  for (j = 0;j < 5;++j) horig[j] = h[j];
  add(h,minusp);
  // check if the integer has some carry over the 130 bits
  negative = -(h[4] >> 51);
  for (j = 0;j < 5;++j) h[j] ^= negative & (horig[j] ^ h[j]);
}

static void mulmod(unsigned long long h[5],const unsigned long long r[5])
{
  unsigned long long hr[5];
  unsigned int i;
  unsigned int j;
  unsigned long long u;

  for (i = 0;i < 5;++i) {
    u = 0;
    for (j = 0;j <= i;++j) u += h[j] * r[i - j];
    // set the scaling factor to 5 to ensure the ring property of 2^130 - 5 -> 2^130 mod 2^130 - 5 = 5
    // in the case of radix-8 it was 2^136 mod 2^130 - 5 = 320
    for (j = i + 1;j < 5;++j) u += 5 * h[j] * r[i + 5 - j];
    hr[i] = u;
  }
  for (i = 0;i < 5;++i) h[i] = hr[i];
  squeeze(h);
}

int crypto_onetimeauth_poly1305(unsigned char *out,const unsigned char *in,unsigned long long inlen, const unsigned char *k)
{
  unsigned int j;
  unsigned long long u;
  unsigned long long r[5];
  unsigned long long h[5];
  unsigned long long c[5];
  
  for (j = 0;j < 5;++j) r[j] = 0;

  r[0] = k[0]
    | k[1] << 8
    | k[2] << 16
    | (k[3] & 3) << 24; // I'll take only the first 2 bits of k[3] to reach 26 bits

  r[1] = (k[3] & 15) >> 2 // Save the rest of k[3] to r[1] (6 bits)
    | (k[4] & 252) << 6 // 6 + 8 = 14 bits
    | k[5] << 14 // 14 + 8 = 22 bits
    | (k[6] & 15) << 22; // 22 + 4 = 26 bits (need to save only 4 bits of k[6])

  r[2] = k[6] >> 4 // Save the rest of k[6] to r[2] (4 bits)
    | (k[7] & 15) << 4 // 4 + 8 = 12 bits
    | (k[8] & 252) << 12 // 12 + 8 = 20 bits
    | (k[9] & 63) << 20; // 20 + 6 = 26 bits

  r[3] = k[9] >> 6 // Save the rest of k[9] to r[3] (2 bits)
    | k[10] << 2 // 2 + 8 = 10 bits
    | (k[11] & 15) << 10 // 10 + 8 = 18 bits
    | (k[12] & 252) << 18; // 18 + 8 = 26 bits
  
  r[4] = k[13]
    | k[14] << 8
    | (k[15] & 15) << 16;

  for (j = 0;j < 5;++j) h[j] = 0;

  // u will contain the remaining bits from the last byte of the input
  u = 0;
  while (inlen > 0) {
    for (j = 0;j < 5;++j) c[j] = 0;

    // conversion from 16 bytes to 5 26-bit integers (in to c)
    for (j = 0;(j < 16) && (j < inlen);++j){
      // shifting the bits to the left, applying the mask and propagating the remaining bits to the next integer
      c[CONV8TO26(j)] |= ((in[j] << shifter[j]) & MASK26)
                | u;
      
      // updating u
      u = in[j] >> (26 - shifter[j]);
    }
    // adding the last byte of the input (1) with the remainer
    c[CONV8TO26(j)] |= 1 << shifter[j]
              | u;

    in += j; inlen -= j;
    
    add(h,c);
    mulmod(h,r);
  }

  freeze(h);

  u = 0;
  for (j = 0;j < 5;++j) c[j] = 0;
  // conversion from 16 bytes to 5 26-bit integers (k to c)
  for (j = 0;j < 16;++j){
    c[CONV8TO26(j)] |= ((k[j + 16] << shifter[j]) & MASK26)
              | u;
    u = k[j + 16] >> (26 - shifter[j]);
  }
  add(h,c);

  // conversion from 5 26-bit integers to 16 bytes (h to out)
  for (j = 0;j < 16;++j) out[j] = (h[CONV8TO26(j)] | (h[CONV8TO26(j+1)] << 26)) >> shifter[j] & 0xFF;
  return 0;
}
