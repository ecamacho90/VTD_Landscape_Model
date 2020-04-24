% Parallel_call_function_5000
% This script calls ABC_Algorithm in a parallel way so that the particles
% are computed in parallel subsets.
% For loop 
function Parallel_function_VTD_AbsDist_Modelv3_v1_008()
%Here we fit a data set that has been simulated with a parameter vector that we choose.
	functionname = mfilename();
% Details for batch
	struc = Call_Parallel_function_VTD_AbsDist_Modelv3_v1(1,str2double(functionname((end-2):end)));
	% clear all
	% struc = Call_Parallel_function_VTD_AbsDist_Modelv3_v1(1,1);
% Number of parallel computations:
	jobmax = struc.jobmax;
	jobsvector = struc.jobsvector;
	EpTvector = struc.EpTvector;
	names = struc.names;
	loopept=struc.loopept;
% Number of particles:
	Nmax = struc.Nmax;
	namedata = struc.namedata;
	model = struc.model;
	ABCversion = struc.ABCversion;
	weightsdistances = struc.weightsdistances;
	pathtodata = struc.pathtodata;
	mutantstofit = struc.mutantstofit;
	parfitnumbers = struc.parfitnumbers;
	EpT = EpTvector(1:loopept);
	namenewdata = [namedata,names{loopept}];
	NoClassifiedOption = struc.NoClassifiedOption;
%Random number generator stream:
	nthresholdsEpT = length(EpT);
	streamnum = 2*nthresholdsEpT-1;
	nparfit = length(parfitnumbers);
	T = length(EpT)-1;
	Tmax = length(EpT);
	Numberofparticleseachjob = Nmax/jobmax;
	covarianceOLCMhandle = str2func(strcat(model,'_CovarianceMatricesOLCM'));
% Check if we have previous data
	if T==0
		PreviousData=[];
		CovarianceMatricesParticles = [];
	else
		load([pathtodata,'/',namedata],'ParticlesMatrix')
		PreviousData = ParticlesMatrix{1,T};
		CovarianceMatricesParticles = feval(covarianceOLCMhandle,PreviousData,parfitnumbers,nparfit,Nmax,EpT(T+1));
	end
% Create job in cluster:
	p = parcluster('local');
	Jobs = createJob(p);
	for jobnum = jobsvector
		%     ABC_SMC_Algorithm_OLCM_VTD_landscape_v3_Gauss_AbsDistance(mutantstofit,parfitnumbers,EpT,T,Tmax,Nmax,Numberofparticleseachjob,PreviousData,namenewdata,CovarianceMatricesParticles,NoClassifiedOption,weightsdistances,streamnum,jobnum)
		createTask(Jobs,str2func(ABCversion),0,{mutantstofit,parfitnumbers,EpT,T,Tmax,Nmax,Numberofparticleseachjob,PreviousData,namenewdata,CovarianceMatricesParticles,NoClassifiedOption,weightsdistances,streamnum,jobnum});
		disp(['Job ',num2str(jobnum),' created']);
	end
	disp('Submiting job.......................')
	submit(Jobs);
	disp('Submitted!')
	disp('Waiting for it to finish............')
	wait(Jobs);
	delete(Jobs)
	clear Jobs
	disp('Finished!')
	exit
