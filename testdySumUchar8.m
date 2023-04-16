%Demonstrates that Matlab uint8() math that does not work like a microprocessor
% 8 bit UNSIGNED integer register add "operation" that would be performed with
% microproccer register overflow feature enabled
%
%Some digital signal processing operations simulated in Matlab could
% use this type of feaure for 'more exact' simulations of what goes on in the adder in a
% microprocessor or on a FPGA chip or other such types of devices
%
%Note that carefull declaration  of uint8 type variables before and after
% calling dynamic library functions is critical to prevent matlab from
% converting your uint8 to double precision. You cannot even copy uint8
% variables without an uint8() type cast

clear

t1 = uint8(1)
t2 = uint8(2^8-1)

disp(' ')
disp('@@')
disp('CASE 1:  ADD 2 uint8 numbers USING --Normal Matlab uint8) math-- (which does NOT use REGISTER microprocessor math)')
uint8_MatlabValues = [t1,t2]
disp('EXAMPLE CASE 1: Add ABOVE 2 uint8 numbers INCORRECTLY using --Matlab uint8() math-- (Note: REGISTER microprocessor math is DESIRED')

disp('About to Test Execution USING Matlab uint8 ADDITION operation ie:  INCORRECT_MATLABuint8MathRESULT = 1 + 255')
disp('The following is not the desired RESULT when adding ABOVE two uint8 values. NOTE: register math with overflow IS needed')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 1 MATH INCORRECT WAY t1 +t2 = ?                  %%%')
INCORRECT_MATLABuint8MathRESULT = t1 + t2               %%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('INCORRECT 8bit result BECAUSE result remained at MAX value of uint8 = 255')

%Demonstrate libsysum function that performs uint8 register
%overflow like a microprocessor performs signed uint8 register overflow

%unloadlibrary('libdysum');
if libisloaded( 'libdysum' )
    unloadlibrary('libdysum');
end;

loadlibrary('libdysum');

%libfunctionsview('libdysum')
 


n1 = uint8(1);
n2 = uint8(2^8-1);


disp(' ')
disp('CASE2:  ADD 2 uint8 numbers USING --dySumUchar8 function-- that implements microprocessor math CORRECTLY')
uint8_RegisterValues = [n1,n2] %This is ONLY for conveying RegisterValue idea TO user in the command line display\

output = uint8(33);
out1 = uint8(44);

disp('EXAMPLE CASE 2:  Add ABOVE 2 uint8 numbers CORRECTLY using --8 bit SIGNED unsigned integer Register math-- by calling "dySumUchar8"  function')
disp('About to Test Execution USING Matlab uint8() ADDING:  CORRECT_MexSumuint8mathRESULT = 1 + 255')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 2 MATH CORRECT RESULT using libdysum library %%%')

%CORRECT_MexSumuint8mathRESULT = 
[out1] = calllib('libdysum','dySumUchar8',n1,n2);   %%,output);
CORRECT_MexSumuint8mathRESULT = uint8(out1) %Must use uint8() type declation here
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('CORRECT BECAUSE:  the output rolled over to value: 0 ') 




unloadlibrary('libdysum');