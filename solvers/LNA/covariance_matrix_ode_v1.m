function dCovMatdt=covariance_matrix_ode_v1(CovMat,detsolstruct,t,param,dimension)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                          v1 VTD landscape model                         %
%                                                                         %
%  This programme contains the ODE of the LNA which solution determines   %
%  the covariance matrix.                                                 %
%                                                                         %
%  CovMat is the covariance matrix at t.                                  %
%  detsolstruct is the structure of y(t).                                 %
%  t is the time point.                                                   %
%  param are the parameters.                                              %
%  dimension is the number of rows of the covariance matrix.              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Compute the jacobian at t, J(y(t),t):
J=model_jacoft_v1(detsolstruct,t,param);

%Reshape the vector into a matrix:
CovMat=reshape(CovMat,dimension,dimension);

%Perform the operations:
dCovMatdt=J*CovMat+CovMat*J'+2*param(end)*eye(dimension);

%Reshape it back into a vector:
dCovMatdt=reshape(dCovMatdt,dimension^2,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Elena 06/06/19
