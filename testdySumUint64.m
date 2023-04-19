%Demonstrates that Matlab uint64() math that does not work like a microprocessor
% 64 bit integer register add "operation" that would be performed with
% microproccer register overflow feature enabled
%
%Some digital signal processing operations simulated in Matlab could
% use this type of feaure for 'more exact' simulations of what goes on in the adder in a
% microprocessor or on a FPGA chip or other such types of devices
%
%Note that carefull declaration  of uint64 type variables before and after
% calling dynamic library functions is critical to prevent matlab from
% converting your uint64 to double precision. You cannot even copy uint64
% variables without an uint64() type cast

clear
USE_MEX = logical(1);  % Edit this to use dylib instead of mex file

t1 = uint64(1);
t2 = uint64(2^64-1);

disp(' ')
disp('@@')
disp('CASE 1:  ADD 2 uint64 numbers USING --Normal Matlab uint64() math-- (not using REGISTER microprocessor math)')
uint64_MatlabValues = [t1,t2]
disp('EXAMPLE CASE 1: Add ABOVE 2 uint64 numbers INCORRECTLY using --Matlab uint64() math-- (Note: REGISTER microprocessor math is DESIRED')

disp('About to Test Execution USING Matlab uint64 ADDITION operation ie:  INCORRECT_MATLABuint64MathRESULT = 1 + 18446744073709551615')
disp('The following is not the desired RESULT when adding ABOVE two uint64 values: Note: register math with overflow IS needed')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 1 MATH INCORRECT WAY t1 +t2 = ?                   %%%')
INCORRECT_MATLABuint64MathRESULT = t1 + t2               %%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('INCORRECT BECAUSE:  result remained at MAX value of uint64 = 18446744073709551615')

%Demonstrate dySumUint64 dynamic library function that performs integer64 register
%overflow like a microprocessor performs unsigned integer register overflow

if ~USE_MEX
    if libisloaded( 'libdysum' )
    unloadlibrary('libdysum');
    end;
    loadlibrary('libdysum');

    %libfunctionsview('libdysum')
end; 

n1 = uint64(1);
n2 = uint64(2^64-1);
disp(' ')
disp('CASE2:  ADD 2 uint64 numbers USING --dySumUint64 dynamic library function-- that implements microprocessor math CORRECTLY')
RegisterValues = [n1,n2]

output = uint64(33);
out1 = uint64(44);

%[out1,out2,n1,n2,output]
disp('EXAMPLE CASE 2:  Add ABOVE 2 uint64 numbers CORRECTLY using --64 bit integer Register math-- by calling "dySumUint64" dynamic library function')
disp('About to Test Execution USING Matlab uint64() built-in ADDING method:  CORRECT_dySumUint64mathRESULT = 1 + 18,446,744,073,709,551,615')
disp('*******   This is really a big number!!! 18 million trillions *******')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 2 MATH CORRECT RESULT using dySumUint64 function: n1 + n2 = ?%%%')
%%[out1] = calllib('libdysum','dySumUint64',n1,n2,output);
%%CORRECT_SumUint64mathRESULT = uint64(out1) %Must use uint64() type declation here

if USE_MEX
    
   CORRECT_MexSumUint64mathRESULT = mexSumUint64(n1,n2)   
   
else   
    
  [out1] = calllib('libdysum','dySumUint64',n1,n2,output);
  CORRECT_SumUint64mathRESULT = uint64(out1)  %Must use uint64() type declation here
end;
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('CORRECT BECAUSE:  Note that output rolled over to 0 ') 




if ~ USE_MEX  
unloadlibrary('libdysum');
end;
