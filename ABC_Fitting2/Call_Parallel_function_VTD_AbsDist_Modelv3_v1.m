function struc = Call_Parallel_function_VTD_AbsDist_Modelv3_v1(Mut,nbatch)

% cd('/cluster/elenacamacho')
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEW PRIORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Mut==1

    EpTvector = [4];

    names = cell(1,1);
    names{1} = {''};

    loopept=1;

    namedata = {'20_04_22_7Mut_SENSITIVITYNEWPRIORS_ABCMv3v1_10000part_500sim_33par_Eps4_'};
    
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
    parfitnumbers = [3,4,6,7,8,9,11,12,13,14,16,17,18,19,21,22,23,24,25,26,27,28,29,30,31,32,34,35];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Model:
    model = 'VTD_Landscape_Model_Fitting_v3'; % !!! Change in ABC_SMC_Algorithm... too !!!

    % ABC version:
    ABCversion = 'ABC_SMC_Algorithm_OLCM_VTD_landscape_v3_Gauss_AbsDistance';

    % Vector of jobs for the batch:
    jobsvector = ((nbatch-1)*njobsperbatch + 1): njobsperbatch*nbatch;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    struc = struct('pathtodata',pathtodata,'EpTvector',EpTvector,'names',names,'loopept',loopept,'Nmax',Nmax,'namedata',namedata,'mutantstofit',mutantstofit,'parfitnumbers',parfitnumbers,'model',model,'ABCversion',ABCversion,'jobsvector',jobsvector,'jobmax',jobmax,'weightsdistances',weightsdistances,'NoClassifiedOption',NoClassifiedOption);
        
end