function SetModelParam_Chir25FGF25


% for use with MasterFile or SimulationEulerMaruyama_VTD_12hourMes_v5

global ModelParam;

fprintf(1, '%s called to define params\n',mfilename);

%%Media changes

ModelParam.tMediaChanges = [ModelParam.t0;ModelParam.tF]; % Times at which there was a media change (time in hours), and the final time
ModelParam.nMediaChanges = length(ModelParam.tMediaChanges)-1;

%                            WNT  FGF  
ModelParam.pMediaChanges = [  1    1 ];
                                               
ModelParam.Mmediachanges = [0; cumsum((ModelParam.tMediaChanges(2:end) - ModelParam.tMediaChanges(1:end-1))/ModelParam.dt)];                          

end