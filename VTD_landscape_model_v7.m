function [dydt,ChirTime]=VTD_landscape_model_v7(t,y,p,dt, ChirTime)


%%Sixth version of the landscape model for Vertebrate Trunk Development.
%Chir integration with time. Time "constant" bounded paraboloid.

%% Parameters
%p=(WNT, FGF);          

%Integration of ChirTime
ChirFactor=0;
if p(1)==0 && ChirTime>0 %If Chir off put ChirTime negative and reduce
    ChirTime = -ChirTime+dt;
    ChirFactor = (-ChirTime/24)^3/(1+(-ChirTime/24)^3);
    p(1)= ChirFactor;
elseif p(1)==0 && ChirTime<0 %If Chir off and ChirTime negative reduce
    ChirTime = ChirTime+dt;
    ChirFactor = (-ChirTime/24)^3/(1+(-ChirTime/24)^3);
    p(1)= ChirFactor;
    if ChirTime>-0.01
        ChirTime=0;
    end
elseif p(1)==1 %If Chir on increase ChirTime
    ChirFactor = (ChirTime/24)^3/(1+(ChirTime/24)^3); %Parameters lambda and mu (2 parameters)
    ChirTime = ChirTime+dt; %Update Chir Time
end


%transform morphogens into model parameters
mapped = zeros(10,1);

%params x^2 xy y^2 x y
mapped(1:4) = [-9, 4.5,  -20, 7] + p(1)*[1, -11.5, 12, 3]+... %20 parameters
    ChirFactor*([0, 4,  -26, -22] + p(2)*[2, -9,  1, -23]);

% mapped(1:5) = [-9, 4.5, -4, -20, 7] + p(1)*[1, -11.5, 2, 12, 3]+... %20 parameters
%     ChirFactor*([0, 4, -2.5, -28, -22] + p(2)*[4, -9, 8, 12, 4]);

%time factor a(x+b^2)+c(y+d^2)+e bounded above by f
mapped(5:10) = [0.08   8    0.08    -3    -0.7        0.03]*(1-p(1))+...
               [0   0    0   0    0.1        0.03]*(p(1));   %2 parameters          
fact1 = mapped(5)*(y(1)+mapped(6)).^2+mapped(7)*(y(2)+mapped(8)).^2+mapped(9);

if fact1<1.e-8
    fact = 1.e-8;
elseif fact1>mapped(10)
    fact = mapped(10);
else
    fact = fact1;
end
 

dydt=fact*[
% x coordinate                      
- 4*y(1).^3    +    3*y(1).*y(2).^2  -    2*mapped(1)*y(1)   -  mapped(2)*y(2)   -   mapped(3);

% y coordinate
- 4*y(2).^3    +    3*y(2).*y(1).^2  +           6*y(2)      -  mapped(2)*y(1)   -   mapped(4)];

end





