
%%  TO RUN AFTER FIRST THRESHOLD IS DONE
%----------------------------------------

clear all
struc = Call_Parallel_function_VTD_AbsDist_Modelv3(1,1);

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
model = 'VTD_Landscape_Model_Fitting_v3';

% ABC version:
ABCversion = struc.ABCversion; %'ABC_SMC_Algorithm_OLCM_Template_v11_Fates_AbsDistance'

% Weights for the distances:
weightsdistances = struc.weightsdistances;

%Path to data 
pathtodata = struc.pathtodata;

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
    ErrorParams = [];
    
else
    
    load([pathtodata,namedata],'ParticlesMatrix')
    PreviousData = ParticlesMatrix{1,T};
    PreviosErrorParams = ErrorParams{1,T};
    
    %Compute the covariance matrix corresponding to each of the particles
    %of the previous step to use a local multivariate normal perturbation
    %kernel
    %--------------------------------------------------------------------

    CovarianceMatricesParticles = feval(covarianceOLCMhandle,PreviousData,parfitnumbers,nparfit,Nmax,EpT(T+1));
    
    
end

%%
% Save the data:
% 
% load(namedata,'FatesMatrix')
ParticlesMatrixaux = [];
ErrorParamsaux = [];
FatesMatrixaux = [];
streamJobs = cell(1,jobmax);
substreamJobs = cell(1,jobmax);

for jobnum = 1:jobmax
    
    load([namenewdata,'_',num2str(jobnum)],'NewData','NewFates','streamnum','substreamnum','errorparams')
    
    ParticlesMatrixaux = [ParticlesMatrixaux;NewData];
    ErrorParamsaux = [ErrorParamsaux;errorparams];
    FatesMatrixaux = cat(4,FatesMatrixaux,NewFates);
    streamJobs{jobnum} = streamnum;
    substreamJobs{jobnum} = substreamnum;
    
    
end

%Normalise the weights:
ParticlesMatrixaux(:,end) = ParticlesMatrixaux(:,end)/sum(ParticlesMatrixaux(:,end));
%%
%Save it in the cell of results:
if T==0

    ParticlesMatrix{1,1} = ParticlesMatrixaux;
    FatesMatrix{1,1} = FatesMatrixaux;
    ErrorParams{1,1} = ErrorParamsaux;

elseif T>0

    ParticlesMatrix{1,T+1} = ParticlesMatrixaux;
    FatesMatrix{1,T+1} = FatesMatrixaux;
    ErrorParams{1,T+1} = ErrorParamsaux;
    
end

clear('ans')

save(namenewdata)

disp('Data Saved')
% exit



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%03/10/19

%v1: First version of ABC algorithm for VTD model.

% Added command to save errorparams

%Parallel_function_VTD_AbsDist_Modelv5_v1_01.m (c) by Elena Camacho Aguilar

%Parallel_function_VTD_AbsDist_Modelv5_v1_01.m is licensed under a 
%Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) Unported License.

%You should have received a copy of the license along with this
%work.  If not, see <https://creativecommons.org/licenses/by-nc-sa/4.0/>.

