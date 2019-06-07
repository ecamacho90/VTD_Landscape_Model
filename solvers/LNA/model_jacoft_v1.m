function J=model_jacoft_v1(detsolstruct,t,param)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                          v6 VTD landscape model                         %
%                                                                         %
%  This programme gives the value of the jacobian of the model at time t. %
%                                                                         %
%  detsolstruct is the structure obtained from the deterministic solution %
%  The output is J, which is Jacobian(y(t),t,param).                      %                                                
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

modeleqstr='VTD_landscape_model_nosignal_v1';

%Fist, we compute y(t):

    yt=deval(detsolstruct(1),t);

    
%We need to evaluate the jacobian:
    modeleqjac=strcat(modeleqstr,'_jac');
    
%Evaluate the jacobian matrix in that point:
    
    J=feval(modeleqjac,t,yt,param);
    

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Elena 06/06/19        
        

   