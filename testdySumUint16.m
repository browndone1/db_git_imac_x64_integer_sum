%Demonstrates that Matlab uint16() math that does not work like a microprocessor
% 16 bit SIGNED integer register add "operation" that would be performed with
% microproccer register overflow feature enabled
%
%Some digital signal processing operations simulated in Matlab could
% use this type of feaure for 'more exact' simulations of what goes on in the adder in a
% microprocessor or on a FPGA chip or other such types of devices
%
%Note that carefull declaration  of uint16 type variables before and after
% calling dynamic library functions is critical to prevent matlab from
% converting your uint16 to double precision. You cannot even copy uint16
% variables without an uint16() type cast

clear
USE_MEX = logical(1);  % Edit this to use dylib instead of mex file

t1 = uint16(1)
t2 = uint16(2^16-1)

disp(' ')
disp('@@')
disp('CASE 1:  ADD 2 uint16 numbers USING --Normal Matlab uint16) math-- (which does NOT use REGISTER microprocessor math)')
uint16_MatlabValues = [t1,t2]
disp('EXAMPLE CASE 1: Add ABOVE 2 uint16 numbers INCORRECTLY using --Matlab uint16() math-- (Note: REGISTER microprocessor math is DESIRED')

disp('About to Test Execution USING Matlab uint16 ADDITION operation ie:  INCORRECT_MATLABuint16MathRESULT = 1 + 65535')
disp('The following is not the desired RESULT when adding ABOVE two uint16 values. NOTE: register math with overflow IS needed')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 1 MATH INCORRECT WAY t1 +t2 = ?                  %%%')
INCORRECT_MATLABuint16MathRESULT = t1 + t2               %%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('INCORRECT 16bit result BECAUSE result remained at MAX value of uint16 = 65535')

%Demonstrate libsysum function that performs uint16 register
%overflow like a microprocessor performs signed uint16 register overflow

if ~USE_MEX
    if libisloaded( 'libdysum' )
    unloadlibrary('libdysum');
    end;
    loadlibrary('libdysum');

    %libfunctionsview('libdysum')
end; 
 


n1 = uint16(1);
n2 = uint16(2^16-1);


disp(' ')
disp('CASE2:  ADD 2 uint16 numbers USING --dySumUint16 function-- that implements microprocessor math CORRECTLY')
uint16_RegisterValues = [n1,n2] %This is ONLY for conveying RegisterValue idea TO user in the command line display\

output = uint16(33);
out1 = uint16(44);

disp('EXAMPLE CASE 2:  Add ABOVE 2 uint16 numbers CORRECTLY using --16 bit SIGNED integer Register math-- by calling "dySumUint16"  function')
disp('About to Test Execution USING Matlab uint16() ADDING:  CORRECT_MexSumInt16mathRESULT = 1 + 65535')

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%% CASE 2 MATH CORRECT RESULT using libdysum library %%%')

%CORRECT_MexSumUint16mathRESULT = 
%%[out1] = calllib('libdysum','dySumUint16',n1,n2,output);
%%CORRECT_MexSumuint16mathRESULT = uint16(out1) %Must use uint16() type declation here

if USE_MEX
   CORRECT_MexSumUint16mathRESULT = mexSumUint16(n1,n2)   
else   
    
  [out1] = calllib('libdysum','dySumUint16',n1,n2,output);
  CORRECT_SumUint16mathRESULT = uint16(out1)  %Must use uint16() type declation here
end;
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

disp('CORRECT BECAUSE: the output rolled over to value: 0 ') 




if ~ USE_MEX  
unloadlibrary('libdysum');
end;