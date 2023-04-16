//
//  libdysum.h
//  dysum
//
//  Created by db on 11/22/22.
//
//  Example of a dylib that returns integer values.
//
//  dySum32
//    Allows matlab to add 2 integer32 values using
//    microprocessor integer32 math that uses register overflow.
//    (ie when max/min integer values are exceeded)
//
//    This is useful when simulating integer operations in a matlab simulation
//    because matlab will clamp vales at min/max value after an overflow operation occurs.
//    This occurs when  min/max values are exceeded. If you want the actual microprocessor
//    value you can use this function.
//
//   dySumUint32
//     Similar for 32 bit unsigned
//
//   dySumInt16
//     Similar for signed 16 bit
//
//   dySumUint16
//     Similar for unsigned 16 bit
//
//   dySumInt64
//     Similar for signed 64 bit
//
//   dySumUint64
//        similar for unsigned 64 bit


#ifndef libdysum_h
#define libdysum_h

signed char dySumChar8(signed char inumber1,signed char inumber2); //, signed char *ioutput);

unsigned char dySumUchar8(unsigned char inumber1,unsigned char inumber2); //, unsigned char *ioutput);

int dySum32(int inumber1, int inumber2); //simple, breaking with mex file calling argument standard

//EXPORTED_FUNCTION int dySum32(int inumber1, int inumber2);

//following functions sort-of follow the mex file calling argument standard

unsigned int dySumUint32(unsigned int inumber1,unsigned int inumber2, unsigned int *ioutput);

short dySumInt16(short inumber1,short inumber2, short *ioutput);

unsigned short dySumUint16(unsigned short inumber1,unsigned short inumber2, unsigned short *ioutput);

long dySumInt64(long inumber1,long inumber2, long *ioutput);

unsigned long dySumUint64(unsigned long inumber1, unsigned long inumber2, unsigned long *ioutput);




#endif /* libdysum_h */
