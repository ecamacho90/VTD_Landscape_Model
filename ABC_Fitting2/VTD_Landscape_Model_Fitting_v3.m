function [dydt,ChirTime]=VTD_Landscape_Model_Fitting_v3(t,y,p, dt, ChirTime)

%Epi as glued attractor

%%Sixth version of the landscape model for Vertebrate Trunk Development.
%Chir integration with time. 

%% Parameters

%p=(WNT, FGF,a0,b0,c0,u0,v0,a1,b1,c1,u1,v1,a2,b2,c2,u2,v2,a3,b3,c3,u3,v3,lambda,mu,e1,e2, alpha, gamma, psi, epsilon, d0, d1, d2, d3);          


%Integration of ChirTime
ChirFactor = ((ChirTime/p(23))^3)/(p(24)+(ChirTime/p(23))^3); %Parameters lambda and mu (2 parameters)
ChirTime = max(ChirTime+(2*p(1)-1)*dt,0); %Update Chir Time
p(1)=min(ChirFactor+ p(1),1);


%transform morphogens into model parameters
mapped = zeros(6,1);

%params x^2 xy y^2 x y
mapped(1:5) = p(3:7) + p(1)*p(8:12)+ChirFactor*(p(13:17) + p(2)*p(18:22)); %20 parameters
mapped(6) =  p(31) + p(1)*p(32)+ChirFactor*p(33)+p(2)*p(34);   

% mapped(1:5) = [-9, 4.5, -4, -20, 7] + p(1)*[1, -11.5, 2, 12, 3]+... %20 parameters
%     ChirFactor*([0, 4, -2.5, -28, -22] + p(2)*[4, -9, 8, 12, 4]);

chi = tanh(p(29)*(y(1,:)-p(27)-p(30)));


dydt=p(25)*0.5*(1+chi).*[
% x coordinate                      
- 4*y(1,:).^3    +    3*y(1,:).*y(2,:).^2    -    2*mapped(1)*y(1,:)   -  mapped(2)*y(2,:)   -   mapped(4,:);

% y coordinate
- 4*y(2,:).^3    +    3*y(2,:).*y(1,:).^2    -    2*mapped(3)*y(2,:)   -  mapped(2)*y(1,:)   -   mapped(5,:)] -...
...
p(26)*0.5*(1-chi).*[((y(1,:)-p(27)).^2 + mapped(6)).*(y(1,:)); (y(2,:)-p(28)).^3];
%p(26)*0.5*(1-chi).*[(y(1,:)-p(27)).*(y(1,:)-p(27) - abs(mapped(6))).*(y(1,:)+3); (y(2,:)-p(28)).^3];

end











