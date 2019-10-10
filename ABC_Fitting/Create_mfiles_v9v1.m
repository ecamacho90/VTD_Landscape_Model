versionmodel = '9';
versionsubmodel = '1';


for i = 2:9
    fileID = fopen(['Parallel_function_AbsDist_Modelv',versionmodel,'v',versionsubmodel,'_0',num2str(i),'.m'],'w');
    fprintf(fileID,'% Parallel_call_function_5000 \n');
    fprintf(fileID,'% This script calls ABC_Algorithm in a parallel way so that the particles\n');
    fprintf(fileID,'% are computed in parallel subsets. \n');
    fprintf(fileID,'% For loop \n');
    fprintf(fileID,['function',' ','Parallel_function_AbsDist_Modelv',versionmodel,'v',versionsubmodel,'_0',num2str(i),'() \n']);

    fclose(fileID);
    
    
    
end


for i = 10:20
    fileID = fopen(['Parallel_function_AbsDist_Modelv',versionmodel,'v',versionsubmodel,'_',num2str(i),'.m'],'w');
    fprintf(fileID,'% Parallel_call_function_5000 \n');
    fprintf(fileID,'% This script calls ABC_Algorithm in a parallel way so that the particles\n');
    fprintf(fileID,'% are computed in parallel subsets. \n');
    fprintf(fileID,'% For loop \n');
    fprintf(fileID,['function',' ','Parallel_function_AbsDist_Modelv',versionmodel,'v',versionsubmodel,'_',num2str(i),'() \n']);

    fclose(fileID);
    
    
    
end


