%Demonstrates that Matlab int8() math that does not work like a microprocessor
% 8 bit SIGNED integer register add "operation" that would be performed with
% microproccer register overflow feature enabled
%
%Some digital signal processing operations simulated in Matlab could
% use this type of feaure for 'more exact' simulations of what goes on in the adder in a
% microprocessor or on a FPGA chip or other such types of devices
%
%Note that carefull declaration  of int8 type variables before and after
% calling dynamic library functions is critical to prevent matlab from
% converting your int8 to double precision. You cannot even copy int8
% variables without an int8() type cast

clear

t1 = int8(1)
t2 = int8(2^7-1)

disp(' ')
disp('@@')
disp('CASE 1:  ADD 2 int8 numbers USING --Normal Matlab int8) math-- (which does NOT use REGISTER microprocessor math)')
int8_MatlabValues = [t1,t2]
disp('EXAMPLE CASE 1: Add ABOVE 2 int8 numbers INCORRECTLY using --Matlab int8() math-- (Note: REGISTER microprocessor math is DESIRED')

disp('About to Test Execution USING Matlab int8 ADDITION operation ie:  INCORRECT_MATLABint8MathRESULT = 1 + 127')
disp('The following is not the desired RESULT when adding ABOVE two int8 values. NOTE: register math with overflow IS needed')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 1 MATH INCORRECT WAY t1 +t2 = ?                  %%%')
INCORRECT_MATLABint8MathRESULT = t1 + t2               %%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('INCORRECT 8bit result BECAUSE result remained at MAX value of int8 = 127')

%Demonstrate libsysum function that performs int8 register
%overflow like a microprocessor performs signed int8 register overflow

%unloadlibrary('libdysum');
if libisloaded( 'libdysum' )
    unloadlibrary('libdysum');
end;

loadlibrary('libdysum');

%libfunctionsview('libdysum')
 


n1 = int8(1);
n2 = int8(2^7-1);


disp(' ')
disp('CASE2:  ADD 2 int8 numbers USING --dySumChar8 function-- that implements microprocessor math CORRECTLY')
int8_RegisterValues = [n1,n2] %This is ONLY for conveying RegisterValue idea TO user in the command line display\

output = int8(33);
out1 = int8(44);

disp('EXAMPLE CASE 2:  Add ABOVE 2 int8 numbers CORRECTLY using --8 bit SIGNED integer Register math-- by calling "dySumChar8"  function')
disp('About to Test Execution USING Matlab int8() ADDING:  CORRECT_MexSumInt8mathRESULT = 1 + 127')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 2 MATH CORRECT RESULT using libdysum library %%%')

%CORRECT_MexSumint8mathRESULT = 
[out1] = calllib('libdysum','dySumChar8',n1,n2);   %%,output);
CORRECT_MexSumint8mathRESULT = int8(out1) %Must use int8() type declation here
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('CORRECT BECAUSE:  the output rolled over to value: -128 ') 




unloadlibrary('libdysum');