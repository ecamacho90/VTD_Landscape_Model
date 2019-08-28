function [dydt,ChirTime]=VTD_landscape_model_v7(t,y,p, dt, ChirTime)


%%Sixth version of the landscape model for Vertebrate Trunk Development.
%Chir integration with time. Time "constant" bounded paraboloid.

%% Parameters
%p=(WNT, FGF);          

%Integration of ChirTime
if p(1)==0 && ChirTime~=0 %If Chir off put ChirTime=0
    ChirTime = 0;
end
ChirFactor = (ChirTime/24)^3/(1+(ChirTime/24)^3); %Parameters lambda and mu (2 parameters)
if p(1)==1
    ChirTime = ChirTime+dt; %Update Chir Time
end

%transform morphogens into model parameters
mapped = zeros(11,1);

%params x^2 xy y^2 x y
mapped(1:5) = [1,-3,-3,-20,10] + p(1)*[1,4.5,-2.5,16,0]+... %20 parameters
    ChirFactor*([-5,-1,5.5,-4,-4] + p(2)*[1.5,1,0,4,4]);

%time factor a(x+b^2)+c(y+d^2)+e bounded above by f
mapped(6:11) = [0.08   8    0.08    -3    -0.7        0.02]*(1-p(1))+...
               [0   0    0   0    0.1        0.04]*(p(1));   %2 parameters          
fact1 = mapped(6)*(y(1)+mapped(7)).^2+mapped(8)*(y(2)+mapped(9)).^2+mapped(10);

if fact1<1.e-8
    fact = 1.e-8;
elseif fact1>mapped(11)
    fact = mapped(11);
else
    fact = fact1;
end
 

dydt=fact*[
% x coordinate                      
- 4*y(1).^3 + 3*y(1).*y(2).^2 + 8*y(1) - 3*mapped(1)*y(1).^2 - mapped(3)*y(2) - mapped(4);

% y coordinate
- 4*y(2).^3 + 3*y(2).*y(1).^2 + 8*y(2) - 3*mapped(2)*y(2).^2 - mapped(3)*y(1) - mapped(5)]; 

end





