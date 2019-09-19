function [dydt,ChirTime]=VTD_Landscape_Model_Fitting_v1(t,y,p, dt, ChirTime)


%%Sixth version of the landscape model for Vertebrate Trunk Development.
%Chir integration with time. Time "constant" bounded paraboloid.

%% Parameters
% The a0 and so on are the ones recalculated already
%p=(WNT, FGF,a0,b0,c0,u0,v0,a1,b1,c1,u1,v1,a2,b2,c2,u2,v2,a3,b3,c3,u3,v3,lambda,mu,e1,e2);          

% Sixth version of the landscape model for Vertebrate Trunk Development.
% Chir integration with time. Time "constant" bounded paraboloid.

%Integration of ChirTime
ChirFactor=0;
if p(1)==0 && ChirTime>0 %If Chir off put ChirTime negative and reduce
    ChirTime = -ChirTime+dt;
    ChirFactor = (-ChirTime/p(23))^3/(p(24)+(-ChirTime/p(23))^3);
    p(1)= ChirFactor;
elseif p(1)==0 && ChirTime<0 %If Chir off and ChirTime negative reduce
    ChirTime = ChirTime+dt;
    ChirFactor = (-ChirTime/p(23))^3/(p(24)+(-ChirTime/p(23))^3);
    p(1)= ChirFactor;
    if ChirTime>-0.01
        ChirTime=0;
    end
elseif p(1)==1 %If Chir on increase ChirTime
    ChirFactor = (-ChirTime/p(23))^3/(p(24)+(-ChirTime/p(23))^3); %Parameters lambda and mu (2 parameters)
    ChirTime = ChirTime+dt; %Update Chir Time
end


%transform morphogens into model parameters
mapped = zeros(11,1);

%params x^2 xy y^2 x y
mapped(1:5) = p(3:7) + p(1)*p(8:12)+... %20 parameters
    ChirFactor*(p(13:17) + p(2)*p(18:22));

% mapped(1:5) = [-9, 4.5, -4, -20, 7] + p(1)*[1, -11.5, 2, 12, 3]+... %20 parameters
%     ChirFactor*([0, 4, -2.5, -28, -22] + p(2)*[4, -9, 8, 12, 4]);

%time factor a(x+b^2)+c(y+d^2)+e bounded above by f
mapped(6:11) = [0.08   8    0.08    -3    -0.7        p(25)]*(1-p(1))+...
               [0   0    0   0    0.1        p(26)]*(p(1));   %2 parameters          
fact1 = mapped(5)*(y(1)+mapped(6)).^2+mapped(7)*(y(2)+mapped(8)).^2+mapped(9);

if fact1<1.e-8
    fact = 1.e-8;
elseif fact1>mapped(11)
    fact = mapped(11);
else
    fact = fact1;
end
 

dydt=fact*[
% x coordinate                      
- 4*y(1,:).^3    +    3*y(1,:).*y(2,:).^2    -    2*mapped(1)*y(1,:)   -  mapped(2)*y(2,:)   -   mapped(4,:);

% y coordinate
- 4*y(2,:).^3    +    3*y(2,:).*y(1,:).^2    -    2*mapped(3)*y(2,:)   -  mapped(2)*y(1,:)   -   mapped(5,:)];

end











