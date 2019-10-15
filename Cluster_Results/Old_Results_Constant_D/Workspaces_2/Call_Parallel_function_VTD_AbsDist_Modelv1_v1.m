function struc = Call_Parallel_function_VTD_AbsDist_Modelv1_v1(Mut,nbatch)

% cd('/cluster/elenacamacho')
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEW PRIORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Mut==1

    EpTvector = [4,3.09];

    names = cell(1,1);
    names{1} = {'','_Eps3p09'};

    loopept=2

    namedata = {'19_09_12_7Mut_SENSITIVITYNEWPRIORS_ABCMv5v1_10000part_500sim_27par_Eps4'};
    
    pathtodata = '/cluster/elenameritxelldata';
    
    % Mutants to fit:
    mutantstofit = [1,2,3,4,5,6,7];
    
    weightsdistances = ones(1,length(mutantstofit))/length(mutantstofit);
    
    NoClassifiedOption = 1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Number of particles:
    Nmax = 10000;

    % Number of jobs max:
    jobmax = 200;    %Each task will compute Nmax/jobmax particles

    % N jobs per batch:
    njobsperbatch = 5; %There needs to be jobmax/njobsperbatch Parallel_function_... functions

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Parameters to fit:
    parfitnumbers = [3,4,6,7,8,9,11,12,13,14,16,17,18,19,21,22,23,24,25,26,27];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Model:
    model = 'Vulval_Development_Modelv9_v1'; % !!! Change in ABC_SMC_Algorithm... too !!!

    % ABC version:
    ABCversion = 'ABC_SMC_Algorithm_OLCM_VTD_landscape_v1_Gauss_AbsDistance';

    % Vector of jobs for the batch:
    jobsvector = ((nbatch-1)*njobsperbatch + 1): njobsperbatch*nbatch;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    struc = struct('pathtodata',pathtodata,'EpTvector',EpTvector,'names',names,'loopept',loopept,'Nmax',Nmax,'namedata',namedata,'mutantstofit',mutantstofit,'parfitnumbers',parfitnumbers,'model',model,'ABCversion',ABCversion,'jobsvector',jobsvector,'jobmax',jobmax,'weightsdistances',weightsdistances,'NoClassifiedOption',NoClassifiedOption);
    
end