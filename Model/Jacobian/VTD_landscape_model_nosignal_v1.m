function dydt=VTD_landscape_model_nosignal_v1(t,y,p)



%% This is the equation for a single cell without signals.
%  It is used for the linear noise approximation to cumpute the initial condition of the
%  system.

%% Parameters
% WNT ;   1   (WNT signal)    
% FGF ;   2   (FGF signal)          
% a11 ;   3   (Linear map)     
% a12 ;   4   (Linear map)
% a21 ;   5   (Linear map)
% a22 ;   6   (Linear map)
% a31 ;   7   (Linear map)
% a32 ;   8   (Linear map)
% b1  ;   9   (Linear map)
% b2  ;   10  (Linear map)
% b3  ;   11  (Linear map)
% Tau ;   12  (Time constant)

% p= [WNT,FGF,a11,a12,a21,a22,a31,a32,b1,b2,b3];

dydt=p(12)*[
% x coordinate                      
- 4*y(1).^3    +    3*y(1).*y(2).^2    +    2*y(1)    -    y(2)*p(11)    -    p(9);

% y coordinate
- 4*y(2).^3    +    3*y(2).*y(1).^2                   -    y(1)*p(11)    -    p(10)];

