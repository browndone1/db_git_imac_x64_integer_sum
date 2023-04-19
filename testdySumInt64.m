%Demonstrates that Matlab int64() math that does not work like a microprocessor
% 64 bit integer register add "operation" that would be performed with
% microproccer register overflow feature enabled
%
%Some digital signal processing operations simulated in Matlab could
% use this type of feaure for 'more exact' simulations of what goes on in the adder in a
% microprocessor or on a FPGA chip or other such types of devices
%
%Note that carefull declaration  of int54 type variables before and after
%calling dynamic library functions is critical to prevent matlab from
%converting your int64 to double precision. You cannot even copy int64
%variables without an int64() type cast
clear
USE_MEX = logical(1);  % Edit this to use dylib instead of mex file

t1 = int64(1);
t2 = int64(2^63-1);

disp(' ')
disp('@@')
disp('CASE 1:  ADD 2 int64 numbers USING --Normal Matlab int64() math-- (not using REGISTER microprocessor math)')
int64_MatlabValues = [t1,t2]
disp('EXAMPLE CASE 1: Add ABOVE 2 int64 numbers INCORRECTLY using --Matlab int64() math-- (Note: REGISTER microprocessor math is DESIRED')

disp('About to Test Execution USING Matlab int64 ADDITION operation ie:  INCORRECT_MATLABint64MathRESULT = 1 + 9223372036854775807')
disp('The following is not the desired RESULT when adding ABOVE two int64 values: Note: register math with overflow IS needed')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 1 MATH INCORRECT WAY t1 +t2 = ?                   %%%')
INCORRECT_MATLABint64MathRESULT = t1 + t2               %%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('INCORRECT BECAUSE:  result remained at MAX value of int64 = 9223372036854775807')

%Demonstrate dySumInt64 dynamic library function that performs integer64 register
%overflow like a microprocessor performs unsigned integer register overflow

USE_MEX = logical(1);  % Edit this to use dylib instead of mex file

n1 = int64(1);
n2 = int64(2^63-1);
disp(' ')
disp('CASE2:  ADD 2 int64 numbers USING --dySumInt64 dynamic library function-- that implements microprocessor math CORRECTLY')
RegisterValues = [n1,n2]

output = int64(33);
out1 = int64(44);

%[out1,out2,n1,n2,output]
disp('EXAMPLE CASE 2:  Add ABOVE 2 int64 numbers CORRECTLY using --64 bit integer Register math-- by calling "dySumInt64" dynamic library function')
disp('About to Test Execution USING Matlab int64() built-in ADDING method:  CORRECT_dySum64mathRESULT = 1 + 9223372036854775807')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 2 MATH CORRECT RESULT using dySumInt64 function: n1 + n2 = ?%%%')
if USE_MEX
   CORRECT_SumInt64mathRESULT = mexSumInt64(n1,n2)

else
   [out1] = calllib('libdysum','dySumInt64',n1,n2,output);
   CORRECT_Sumint64mathRESULT = int64(out1) %Must use int64() type declation here
end;
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('CORRECT BECAUSE:  Note that output rolled over to MAX negative value: -9223372036854775807 ') 



if ~ USE_MEX
   unloadlibrary('libdysum');
end;