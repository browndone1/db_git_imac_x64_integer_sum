//
//  libdysum.h
//  dysum
//
//  Created by db on 11/22/22.
//
//  An iMac intel x64 dynamic dylib that contains functions that return the sum
//   of 2 integer values of various types.
//
//  No support for m1 iMacs yet. (I don't have one)
//
//  dySum32
//    Allows matlab to add 2 integer32 values using
//     microprocessor interger32 math that uses register overflow.
//     (ie when max/min integer values are exceeded)
//
//    This is useful when simulating integer operations in a matlab model
//     because matlab will clamp vales at min/max value after an overflow
//     operation occurs.
//
//    Clamping occurs when  min/max values are exceeded. If you want the actual
//     microprocessor value after overflow, you can use this function.
//
//   dySumUint32
//     Similar for 32 bit unsigned integers
//
//   dySumInt16
//     Similar for signed 16 bit integers
//
//   dySumUint16
//     Similar for unsigned 16 bit integers
//
//   dySumInt64
//     Similar for signed 64 bit integers
//
//   dySumUint64
//        similar for unsigned 64 bit integers


#ifndef libdysum_h
#define libdysum_h



int dySum32(int inumber1, int inumber2); //, int *ioutput);

unsigned int dySumUint32(unsigned int inumber1,unsigned int inumber2, unsigned int *ioutput);

short dySumInt16(short inumber1,short inumber2, short *ioutput);

unsigned short dySumUint16(unsigned short inumber1,unsigned short inumber2, unsigned short *ioutput);

long dySumInt64(long inumber1,long inumber2, long *ioutput);

unsigned long dySumUint64(unsigned long inumber1, unsigned long inumber2, unsigned long *ioutput);




#endif /* libdysum_h */
