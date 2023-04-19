%Demonstrates that Matlab int16() math that does not work like a microprocessor
% 16 bit SIGNED integer register add "operation" that would be performed with
% microproccer register overflow feature enabled
%
%Some digital signal processing operations simulated in Matlab could
% use this type of feaure for 'more exact' simulations of what goes on in the adder in a
% microprocessor or on a FPGA chip or other such types of devices
%
%Note that carefull declaration  of int16 type variables before and after
% calling dynamic library functions is critical to prevent matlab from
% converting your int16 to double precision. You cannot even copy int16
% variables without an int16() type cast

clear
USE_MEX = logical(1);  % Edit this to use dylib instead of mex file

t1 = int16(1)
t2 = int16(2^15-1)

disp(' ')
disp('@@')
disp('CASE 1:  ADD 2 int16 numbers USING --Normal Matlab int16) math-- (which does NOT use REGISTER microprocessor math)')
int16_MatlabValues = [t1,t2]
disp('EXAMPLE CASE 1: Add ABOVE 2 int16 numbers INCORRECTLY using --Matlab int16() math-- (Note: REGISTER microprocessor math is DESIRED')

disp('About to Test Execution USING Matlab int16 ADDITION operation ie:  INCORRECT_MATLABint16MathRESULT = 1 + 32767')
disp('The following is not the desired RESULT when adding ABOVE two int16 values. NOTE: register math with overflow IS needed')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 1 MATH INCORRECT WAY t1 +t2 = ?                  %%%')
INCORRECT_MATLABint16MathRESULT = t1 + t2               %%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('INCORRECT 16bit result BECAUSE result remained at MAX value of int16 = 32767')

%Demonstrate libsysum function that performs int16 register
%overflow like a microprocessor performs signed int16 register overflow

if ~USE_MEX
    
    if libisloaded( 'libdysum' )
    unloadlibrary('libdysum');
    end;
    loadlibrary('libdysum');

    %libfunctionsview('libdysum')
end;

n1 = int16(1);
n2 = int16(2^15-1);

disp(' ')
disp('CASE2:  ADD 2 int16 numbers USING --dySumInt16 function-- that implements microprocessor math CORRECTLY')
int16_RegisterValues = [n1,n2] %This is ONLY for conveying RegisterValue idea TO user in the command line display\

output = int16(33);
out1 = int16(44);

disp('EXAMPLE CASE 2:  Add ABOVE 2 int16 numbers CORRECTLY using --16 bit SIGNED integer Register math-- by calling "dySumInt16"  function')
disp('About to Test Execution USING Matlab int16() ADDING:  CORRECT_MexSumInt32mathRESULT = 1 + 32767')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 2 MATH CORRECT RESULT using libdysum library %%%')

%CORRECT_MexSumInt16mathRESULT = 
%%[out1] = calllib('libdysum','dySumInt16',n1,n2,output);
%%CORRECT_MexSumInt16mathRESULT = int16(out1) %Must use int16() type declation here
if USE_MEX
   CORRECT_SumInt16mathRESULT = mexSumInt16(n1,n2)

else
   [out1] = calllib('libdysum','dySumInt16',n1,n2,output);
   CORRECT_Sumint16mathRESULT = int16(out1) %Must use int16() type declation here
end;
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('CORRECT BECAUSE:  the output rolled over to value: -32768 ') 




if ~ USE_MEX
   unloadlibrary('libdysum');
end;