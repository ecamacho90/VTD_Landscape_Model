versionmodel = '5';
versionsubmodel = '1';
datefunc = '30_09_19';
%%
for i = 1:9
    fileID = fopen(['ABCv',versionmodel,'v',versionsubmodel,'_00',num2str(i),'.txt'],'w');
    fprintf(fileID,'# specify the shell to run the job \n');
    fprintf(fileID,'#PBS -S /bin/bash \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# name the job \n');
    fprintf(fileID,['#PBS -N ABC','_v',versionmodel,'_v',versionsubmodel,'_',datefunc,'_00',num2str(i),' \n']);
    fprintf(fileID,'\n');
    fprintf(fileID,'# use the submission environment \n');
    fprintf(fileID,'#PBS -V \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# redirect job?s standard output \n');
    fprintf(fileID,['#PBS -o /cluster/elenameritxelldata/ABCstdoutv',versionmodel,'v',versionsubmodel,'_00',num2str(i),'.txt \n']);
    fprintf(fileID,'\n');
    fprintf(fileID,'# redirect job?s standard error \n');
    fprintf(fileID,['#PBS -e /cluster/elenameritxelldata/ABCstderrv',versionmodel,'v',versionsubmodel,'_00',num2str(i),'.txt \n']);
    fprintf(fileID,'\n');
    fprintf(fileID,'# maximum amount of real time that a job can be in the running state \n');
    fprintf(fileID,'#PBS -l walltime=100:00:00 \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# number of CPU cores requested on a single node. Because matlab can only have at most 8 jobs in parallel, request 6 cores \n');
    fprintf(fileID,'#PBS -l ncpus=6 \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# maximum amount of physical memory that the job can use \n');
    fprintf(fileID,'#PBS -l mem=10gb \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# email at the beginning and end of the job \n');
    fprintf(fileID,'#PBS -m be \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# email address to receive the notifications \n');
    fprintf(fileID,'#PBS -M ecamacho.90@gmail.com \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# submit matlab job \n');
    fprintf(fileID,['matlab -nodisplay -r Parallel_function_VTD_AbsDist_Modelv',versionmodel,'_v',versionsubmodel,'_00',num2str(i),'>/cluster/elenameritxelldata/ABClogv',versionmodel,'v',versionsubmodel,'_00',num2str(i),'.txt']);
    
    fclose(fileID);
    
    
    
end

%%

for i = 10:40
    fileID = fopen(['ABCv',versionmodel,'v',versionsubmodel,'_0',num2str(i),'.txt'],'w');
    fprintf(fileID,'# specify the shell to run the job \n');
    fprintf(fileID,'#PBS -S /bin/bash \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# name the job \n');
    fprintf(fileID,['#PBS -N ABC','_v',versionmodel,'_v',versionsubmodel,'_',datefunc,'_00',num2str(i),' \n']);
    fprintf(fileID,'\n');
    fprintf(fileID,'# use the submission environment \n');
    fprintf(fileID,'#PBS -V \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# redirect job?s standard output \n');
    fprintf(fileID,['#PBS -o /cluster/elenameritxelldata/ABCstdoutv',versionmodel,'v',versionsubmodel,'_0',num2str(i),'.txt \n']);
    fprintf(fileID,'\n');
    fprintf(fileID,'# redirect job?s standard error \n');
    fprintf(fileID,['#PBS -e /cluster/elenameritxelldata/ABCstderrv',versionmodel,'v',versionsubmodel,'_0',num2str(i),'.txt \n']);
    fprintf(fileID,'\n');
    fprintf(fileID,'# maximum amount of real time that a job can be in the running state \n');
    fprintf(fileID,'#PBS -l walltime=100:00:00 \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# number of CPU cores requested on a single node. Because matlab can only have at most 8 jobs in parallel, request 6 cores \n');
    fprintf(fileID,'#PBS -l ncpus=6 \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# maximum amount of physical memory that the job can use \n');
    fprintf(fileID,'#PBS -l mem=10gb \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# email at the beginning and end of the job \n');
    fprintf(fileID,'#PBS -m be \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# email address to receive the notifications \n');
    fprintf(fileID,'#PBS -M ecamacho.90@gmail.com \n');
    fprintf(fileID,'\n');
    fprintf(fileID,'# submit matlab job \n');
    fprintf(fileID,['matlab -nodisplay -r Parallel_function_VTD_AbsDist_Modelv',versionmodel,'_v',versionsubmodel,'_0',num2str(i),'>/cluster/elenameritxelldata/ABClogv',versionmodel,'v',versionsubmodel,'_0',num2str(i),'.txt']);
    
    fclose(fileID);
    
end
