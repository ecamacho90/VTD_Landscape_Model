versionmodel = '3';
versionsubmodel = '1';


for i = 1:9
    fileID = fopen(['Parallel_function_VTD_AbsDist_Modelv',versionmodel,'_v',versionsubmodel,'_00',num2str(i),'.m'],'w');
    fprintf(fileID, '%s\n', '% Parallel_call_function_5000');
    fprintf(fileID, '%s\n', '% This script calls ABC_Algorithm in a parallel way so that the particles');
    fprintf(fileID, '%s\n', '% are computed in parallel subsets.');
    fprintf(fileID, '%s\n', '% For loop ');
    fprintf(fileID, '%s\n', ['function',' ','Parallel_function_VTD_AbsDist_Modelv',versionmodel,'_v',versionsubmodel,'_00',num2str(i),'()']);

    fprintf(fileID, '%s\n', '%Here we fit a data set that has been simulated with a parameter vector that we choose.');
    fprintf(fileID, '\t%s\n','functionname = mfilename();');
    fprintf(fileID, '%s\n', '% Details for batch');
    fprintf(fileID, '\t%s\n', ['struc = Call_Parallel_function_VTD_AbsDist_Modelv',versionmodel,'_v',versionsubmodel,'(1,str2double(functionname((end-2):end)));']);
    fprintf(fileID, '\t%s\n', '% clear all');
    fprintf(fileID, '\t%s\n', ['% struc = Call_Parallel_function_VTD_AbsDist_Modelv',versionmodel,'_v',versionsubmodel,'(1,1);']);
    fprintf(fileID, '%s\n', '% Number of parallel computations:');
    fprintf(fileID, '\t%s\n', 'jobmax = struc.jobmax;');
    fprintf(fileID, '\t%s\n', 'jobsvector = struc.jobsvector;');
    fprintf(fileID, '\t%s\n', 'EpTvector = struc.EpTvector;');
    fprintf(fileID, '\t%s\n', 'names = struc.names;');
    fprintf(fileID, '\t%s\n', 'loopept=struc.loopept;');
    fprintf(fileID, '%s\n', '% Number of particles:');
    fprintf(fileID, '\t%s\n', 'Nmax = struc.Nmax;');
    fprintf(fileID, '\t%s\n', 'namedata = struc.namedata;');
    fprintf(fileID, '\t%s\n', 'model = struc.model;');
    fprintf(fileID, '\t%s\n', 'ABCversion = struc.ABCversion;');
    fprintf(fileID, '\t%s\n', 'weightsdistances = struc.weightsdistances;');
    fprintf(fileID, '\t%s\n', 'pathtodata = struc.pathtodata;');
    fprintf(fileID, '\t%s\n', 'mutantstofit = struc.mutantstofit;');
    fprintf(fileID, '\t%s\n', 'parfitnumbers = struc.parfitnumbers;');
    fprintf(fileID, '\t%s\n', 'EpT = EpTvector(1:loopept);');
    fprintf(fileID, '\t%s\n', 'namenewdata = [namedata,names{loopept}];');
    fprintf(fileID, '\t%s\n', 'NoClassifiedOption = struc.NoClassifiedOption;');
    fprintf(fileID, '%s\n', '%Random number generator stream:');
    fprintf(fileID, '\t%s\n', 'nthresholdsEpT = length(EpT);');
    fprintf(fileID, '\t%s\n', 'streamnum = 2*nthresholdsEpT-1;');
    fprintf(fileID, '\t%s\n', 'nparfit = length(parfitnumbers);');
    fprintf(fileID, '\t%s\n', 'T = length(EpT)-1;');
    fprintf(fileID, '\t%s\n', 'Tmax = length(EpT);');
    fprintf(fileID, '\t%s\n', 'Numberofparticleseachjob = Nmax/jobmax;');
    fprintf(fileID, '\t%s\n', "covarianceOLCMhandle = str2func(strcat(model,'_CovarianceMatricesOLCM'));");
    fprintf(fileID, '%s\n', '% Check if we have previous data');
    fprintf(fileID, '\t%s\n', 'if T==0');
    fprintf(fileID, '\t\t%s\n', 'PreviousData=[];');
    fprintf(fileID, '\t\t%s\n', 'CovarianceMatricesParticles = [];');
    fprintf(fileID, '\t%s\n', 'else');
    fprintf(fileID, '\t\t%s\n', "load([pathtodata,'/',namedata],'ParticlesMatrix')");
    fprintf(fileID, '\t\t%s\n', 'PreviousData = ParticlesMatrix{1,T};');
    fprintf(fileID, '\t\t%s\n', 'CovarianceMatricesParticles = feval(covarianceOLCMhandle,PreviousData,parfitnumbers,nparfit,Nmax,EpT(T+1));');
    fprintf(fileID, '\t%s\n', 'end');
    fprintf(fileID, '%s\n', '% Create job in cluster:');
    fprintf(fileID, '\t%s\n', "p = parcluster('local');");
    fprintf(fileID, '\t%s\n', 'Jobs = createJob(p);');
    fprintf(fileID, '\t%s\n', 'for jobnum = jobsvector');
    fprintf(fileID, '\t\t%s\n', '%     ABC_SMC_Algorithm_OLCM_VTD_landscape_v3_Gauss_AbsDistance(mutantstofit,parfitnumbers,EpT,T,Tmax,Nmax,Numberofparticleseachjob,PreviousData,namenewdata,CovarianceMatricesParticles,NoClassifiedOption,weightsdistances,streamnum,jobnum)');
    fprintf(fileID, '\t\t%s\n', 'createTask(Jobs,str2func(ABCversion),0,{mutantstofit,parfitnumbers,EpT,T,Tmax,Nmax,Numberofparticleseachjob,PreviousData,namenewdata,CovarianceMatricesParticles,NoClassifiedOption,weightsdistances,streamnum,jobnum});');
    fprintf(fileID, '\t\t%s\n', "disp(['Job ',num2str(jobnum),' created']);");
    fprintf(fileID, '\t%s\n', 'end');
    fprintf(fileID, '\t%s\n', "disp('Submiting job.......................')");
    fprintf(fileID, '\t%s\n', 'submit(Jobs);');
    fprintf(fileID, '\t%s\n', "disp('Submitted!')");
    fprintf(fileID, '\t%s\n', "disp('Waiting for it to finish............')");
    fprintf(fileID, '\t%s\n', 'wait(Jobs);');
    fprintf(fileID, '\t%s\n', 'delete(Jobs)');
    fprintf(fileID, '\t%s\n', 'clear Jobs');
    fprintf(fileID, '\t%s\n', "disp('Finished!')");
    fprintf(fileID, '\t%s\n', 'exit');
       
    fclose(fileID);
    
    
    
end

%%
for i = 10:40
    fileID = fopen(['Parallel_function_VTD_AbsDist_Modelv',versionmodel,'_v',versionsubmodel,'_0',num2str(i),'.m'],'w');
     fprintf(fileID, '%s\n', '% Parallel_call_function_5000');
    fprintf(fileID, '%s\n', '% This script calls ABC_Algorithm in a parallel way so that the particles');
    fprintf(fileID, '%s\n', '% are computed in parallel subsets.');
    fprintf(fileID, '%s\n', '% For loop ');
    fprintf(fileID, '%s\n', ['function',' ','Parallel_function_VTD_AbsDist_Modelv',versionmodel,'_v',versionsubmodel,'_0',num2str(i),'()']);

    fprintf(fileID, '%s\n', '%Here we fit a data set that has been simulated with a parameter vector that we choose.');
    fprintf(fileID, '\t%s\n','functionname = mfilename();');
    fprintf(fileID, '%s\n', '% Details for batch');
    fprintf(fileID, '\t%s\n', ['struc = Call_Parallel_function_VTD_AbsDist_Modelv',versionmodel,'_v',versionsubmodel,'(1,str2double(functionname((end-2):end)));']);
    fprintf(fileID, '\t%s\n', '% clear all');
    fprintf(fileID, '\t%s\n', ['% struc = Call_Parallel_function_VTD_AbsDist_Modelv',versionmodel,'_v',versionsubmodel,'(1,1);']);
    fprintf(fileID, '%s\n', '% Number of parallel computations:');
    fprintf(fileID, '\t%s\n', 'jobmax = struc.jobmax;');
    fprintf(fileID, '\t%s\n', 'jobsvector = struc.jobsvector;');
    fprintf(fileID, '\t%s\n', 'EpTvector = struc.EpTvector;');
    fprintf(fileID, '\t%s\n', 'names = struc.names;');
    fprintf(fileID, '\t%s\n', 'loopept=struc.loopept;');
    fprintf(fileID, '%s\n', '% Number of particles:');
    fprintf(fileID, '\t%s\n', 'Nmax = struc.Nmax;');
    fprintf(fileID, '\t%s\n', 'namedata = struc.namedata;');
    fprintf(fileID, '\t%s\n', 'model = struc.model;');
    fprintf(fileID, '\t%s\n', 'ABCversion = struc.ABCversion;');
    fprintf(fileID, '\t%s\n', 'weightsdistances = struc.weightsdistances;');
    fprintf(fileID, '\t%s\n', 'pathtodata = struc.pathtodata;');
    fprintf(fileID, '\t%s\n', 'mutantstofit = struc.mutantstofit;');
    fprintf(fileID, '\t%s\n', 'parfitnumbers = struc.parfitnumbers;');
    fprintf(fileID, '\t%s\n', 'EpT = EpTvector(1:loopept);');
    fprintf(fileID, '\t%s\n', 'namenewdata = [namedata,names{loopept}];');
    fprintf(fileID, '\t%s\n', 'NoClassifiedOption = struc.NoClassifiedOption;');
    fprintf(fileID, '%s\n', '%Random number generator stream:');
    fprintf(fileID, '\t%s\n', 'nthresholdsEpT = length(EpT);');
    fprintf(fileID, '\t%s\n', 'streamnum = 2*nthresholdsEpT-1;');
    fprintf(fileID, '\t%s\n', 'nparfit = length(parfitnumbers);');
    fprintf(fileID, '\t%s\n', 'T = length(EpT)-1;');
    fprintf(fileID, '\t%s\n', 'Tmax = length(EpT);');
    fprintf(fileID, '\t%s\n', 'Numberofparticleseachjob = Nmax/jobmax;');
    fprintf(fileID, '\t%s\n', "covarianceOLCMhandle = str2func(strcat(model,'_CovarianceMatricesOLCM'));");
    fprintf(fileID, '%s\n', '% Check if we have previous data');
    fprintf(fileID, '\t%s\n', 'if T==0');
    fprintf(fileID, '\t\t%s\n', 'PreviousData=[];');
    fprintf(fileID, '\t\t%s\n', 'CovarianceMatricesParticles = [];');
    fprintf(fileID, '\t%s\n', 'else');
    fprintf(fileID, '\t\t%s\n', "load([pathtodata,'/',namedata],'ParticlesMatrix')");
    fprintf(fileID, '\t\t%s\n', 'PreviousData = ParticlesMatrix{1,T};');
    fprintf(fileID, '\t\t%s\n', 'CovarianceMatricesParticles = feval(covarianceOLCMhandle,PreviousData,parfitnumbers,nparfit,Nmax,EpT(T+1));');
    fprintf(fileID, '\t%s\n', 'end');
    fprintf(fileID, '%s\n', '% Create job in cluster:');
    fprintf(fileID, '\t%s\n', "p = parcluster('local');");
    fprintf(fileID, '\t%s\n', 'Jobs = createJob(p);');
    fprintf(fileID, '\t%s\n', 'for jobnum = jobsvector');
    fprintf(fileID, '\t\t%s\n', '%     ABC_SMC_Algorithm_OLCM_VTD_landscape_v3_Gauss_AbsDistance(mutantstofit,parfitnumbers,EpT,T,Tmax,Nmax,Numberofparticleseachjob,PreviousData,namenewdata,CovarianceMatricesParticles,NoClassifiedOption,weightsdistances,streamnum,jobnum)');
    fprintf(fileID, '\t\t%s\n', 'createTask(Jobs,str2func(ABCversion),0,{mutantstofit,parfitnumbers,EpT,T,Tmax,Nmax,Numberofparticleseachjob,PreviousData,namenewdata,CovarianceMatricesParticles,NoClassifiedOption,weightsdistances,streamnum,jobnum});');
    fprintf(fileID, '\t\t%s\n', "disp(['Job ',num2str(jobnum),' created']);");
    fprintf(fileID, '\t%s\n', 'end');
    fprintf(fileID, '\t%s\n', "disp('Submiting job.......................')");
    fprintf(fileID, '\t%s\n', 'submit(Jobs);');
    fprintf(fileID, '\t%s\n', "disp('Submitted!')");
    fprintf(fileID, '\t%s\n', "disp('Waiting for it to finish............')");
    fprintf(fileID, '\t%s\n', 'wait(Jobs);');
    fprintf(fileID, '\t%s\n', 'delete(Jobs)');
    fprintf(fileID, '\t%s\n', 'clear Jobs');
    fprintf(fileID, '\t%s\n', "disp('Finished!')");
    fprintf(fileID, '\t%s\n', 'exit');

    fclose(fileID);
    
    
    
end


