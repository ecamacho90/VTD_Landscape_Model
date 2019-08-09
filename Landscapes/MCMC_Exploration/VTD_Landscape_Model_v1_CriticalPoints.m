function [critpointsx,critpointsy]=VTD_Landscape_Model_v1_CriticalPoints(paramaux,x,y)

eqns = [4*x^3 - 3*x*y^2 + paramaux(1)*2*x + paramaux(2)*y + paramaux(4)==0 , ...
        4*y^3 - 3*x^2*y + paramaux(2)*x + 2*paramaux(3)*y + paramaux(5)];
    
vars = [x,y];

[critpointsx,critpointsy] = solve(eqns,vars);
