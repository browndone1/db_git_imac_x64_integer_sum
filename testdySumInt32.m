%Demonstrates that Matlab int32() math that does not work like a microprocessor
% 32 bit integer register add "operation" that would be performed with
% microproccer register overflow feature enabled
%
%Some digital signal processing operations simulated in Matlab could
% use this type of feaure for 'more exact' simulations of what goes on in the adder in a
% microprocessor or on a FPGA chip or other such types of devices
%
%Note that carefull declaration  of int32 type variables before and after
% calling dynamic library functions is critical to prevent matlab from
% converting your int32 to double precision. You cannot even copy int32
% variables with out an int32() type cast


t2 = int32(2^31-1);
t1 = int32(1);
disp(' ')
disp('@@')
disp('CASE 1:  ADD 2 int32 numbers USING --Normal Matlab int32() math-- (not using REGISTER microprocessor math)')
int32_MatlabValues = [t1,t2]
disp('EXAMPLE CASE 1: Add ABOVE 2 int32 numbers INCORRECTLY using --Matlab int32() math-- (Note: REGISTER microprocessor math is DESIRED')

disp('About to Test Execution USING Matlab int32 ADDITION operation ie:  INCORRECT_MATLABint32MathRESULT = 1 + 2147483647')
disp('The following is not the desired RESULT when adding ABOVE two int32 values: Note: register math with overflow IS needed')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 1 MATH INCORRECT WAY t1 +t2 = ?                   %%%')
INCORRECT_MATLABint32MathRESULT = t1 + t2               %%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('INCORRECT BECAUSE:  result remained at MAX value of int32')

%Demonstrate dySum32 dynamic library function that performs integer32 register
%overflow like a microprocessor performs unsigned integer register overflow

if libisloaded( 'libdysum' )
    unloadlibrary('libdysum');
end;
loadlibrary('libdysum');

%libfunctionsview('libdysum')
 

n1 = int32(1);
n2 = int32(2^31-1);
disp(' ')
disp('CASE2:  ADD 2 int32 numbers USING --dySum32 dynamic library function-- that implements microprocessor math CORRECTLY')
RegisterValues = [n1,n2]

out1 = int32(44);

%[out1,out2] = calllib('libdysum','dySum32',n1,n2,output);

%[out1,out2,n1,n2,output]
disp('EXAMPLE CASE 2:  Add ABOVE 2 int32 numbers CORRECTLY using --32 bit integer Register math-- by calling "dySum32" dynamic library function')
disp('About to Test Execution USING Matlab int32() built-in ADDING method:  CORRECT_dySum32mathRESULT = 1 + 2147483647')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 2 MATH CORRECT RESULT using dySum32 function: n1 + n2 = ?%%%')
[out1] = calllib('libdysum','dySum32',n1,n2); %%,output);
CORRECT_SumInt32mathRESULT = int32(out1)  %Must use int32() type declation here
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('CORRECT BECAUSE:  the output rolled over to MAX negative value: -2147483648 ') 




unloadlibrary('libdysum');