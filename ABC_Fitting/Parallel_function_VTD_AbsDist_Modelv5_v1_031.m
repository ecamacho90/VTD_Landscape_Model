% Parallel_call_function_10000
% This script calls ABC_Algorithm in a parallel way so that the particles
% are computed in parallel subsets.
%% For loop
function Parallel_function_VTD_AbsDist_Modelv5_v1_031()
%%
%Here we fit a data set that has been simulated with a parameter vector
%that we choose.
functionname = mfilename();

% Details for batch
struc = Call_Parallel_function_VTD_AbsDist_Modelv1_v1(1,str2double(functionname((end-2):end)));

%%  START RUNNING FROM HERE
% clear all
% struc = Call_Parallel_function_VTD_AbsDist_Modelv1_v1(1,1);
%%

% Number of parallel computations:
jobmax = struc.jobmax;

% Vector of jobs
jobsvector = struc.jobsvector;

EpTvector = struc.EpTvector;

names = struc.names;

%for loopept=4:5
loopept=struc.loopept;

% Number of particles:
Nmax = struc.Nmax;

namedata = struc.namedata;

%Model name:
model = struc.model;%'Vulval_Development_v11';
model = 'VTD_Landscape_Model_Fitting_v1';

% ABC version:
ABCversion = struc.ABCversion; %'ABC_SMC_Algorithm_OLCM_Template_v11_Fates_AbsDistance'

% Weights for the distances:
weightsdistances = struc.weightsdistances;

%Path to data 
pathtodata = struc.pathtodata;

% % Add path:
% addpath(pathtodata)

% Variables

%-----------------------
% To change:
%-----------------------

% Mutants to fit:
mutantstofit = struc.mutantstofit;

% Parameters to fit (exclude those fixed):
parfitnumbers = struc.parfitnumbers;

% New threshold: (CHANGE)
EpTsmall = EpTvector(loopept);

% Chain of thresholds, including the new: (CHANGE)
EpT = EpTvector(1:loopept);

% Name of the last data set: (CHANGE)
namedata = namedata;

% Name of the new data set:(CHANGE)
namenewdata = [namedata,names{loopept}];

NoClassifiedOption = struc.NoClassifiedOption;


%-----------------------
% Not to change:
%-----------------------

%Random number generator stream:
nthresholdsEpT = length(EpT);
streamnum = 2*nthresholdsEpT-1; 

%Number of parameters to fit:
nparfit = length(parfitnumbers);

% Number of thresholds computed so far:
T = length(EpT)-1;

% Number of the threshold that we will use: 
Tmax = length(EpT);

% Number of particles in each parallel computation:
Numberofparticleseachjob = Nmax/jobmax;

%Covariance matrices OLCM function handle:
covarianceOLCMhandle = str2func(strcat(model,'_CovarianceMatricesOLCM'));



% Check if we have previous data

if T==0
    PreviousData=[];
    CovarianceMatricesParticles = [];
    
else
    
    load([pathtodata,'/',namedata],'ParticlesMatrix')
    PreviousData = ParticlesMatrix{1,T};
    
    %Compute the covariance matrix corresponding to each of the particles
    %of the previous step to use a local multivariate normal perturbation
    %kernel
    %--------------------------------------------------------------------

    CovarianceMatricesParticles = feval(covarianceOLCMhandle,PreviousData,parfitnumbers,nparfit,Nmax,EpT(T+1));
    
    
end
%%
% Create job in cluster:

p = parcluster('local');
Jobs = createJob(p);

% Loop to call jobs
for jobnum = jobsvector
    
%     ABC_SMC_Algorithm_OLCM_VTD_landscape_v1_Gauss_AbsDistance(mutantstofit,parfitnumbers,EpT,T,Tmax,Nmax,Numberofparticleseachjob,PreviousData,namenewdata,CovarianceMatricesParticles,NoClassifiedOption,weightsdistances,streamnum,jobnum)
                                                             
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




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%20/01/16

%v1: First version of ABC algorithm for VTD model.


%Parallel_function_VTD_AbsDist_Modelv5_v1_01.m (c) by Elena Camacho Aguilar

%Parallel_function_VTD_AbsDist_Modelv5_v1_01.m is licensed under a 
%Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) Unported License.

%You should have received a copy of the license along with this
%work.  If not, see <https://creativecommons.org/licenses/by-nc-sa/4.0/>.

