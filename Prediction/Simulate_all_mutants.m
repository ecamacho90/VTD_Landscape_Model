
load('/cluster/elenameritxelldata/19_09_12_7Mut_SENSITIVITYNEWPRIORS_ABCMv5v1_10000part_500sim_27par_Eps4_Eps3p08_Eps2p47_Eps2p08_Eps1p78_Eps1p58_Eps1p46.mat',...
    'ParticlesMatrixaux');
%load('/Users/meritxellsaez/Documents/Cluster_Results/19_09_12_7Mut_SENSITIVITYNEWPRIORS_ABCMv5v1_10000part_500sim_27par_Eps4_Eps3p08_Eps2p47_Eps2p08_Eps1p78_Eps1p58_Eps1p46.mat',...
%    'ParticlesMatrixaux');

% load('DataAll180814.mat','ClusteredDataWithThd');
% DataToFit=ClusteredDataWithThd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               CONSTANTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Set the stream of random number generators:
%-------------------------------------------


numPart = 100;%size(ParticlesMatrixaux,1);

%Time step:
dt = 0.01;

%Time for solution approximation:
t0 = 0;
t1 = 3*24;
tspan=t0:dt:t1;

%Number of subintervals:
M = (t1-t0)/dt;

%Times
times = floor(t1/(10*dt)+1);%t1/12+1;


%Number of simulations:
nsimulations = 500;

%     1   2   3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22
%  p=[WNT,FGF,a0,b0,c0,u0,v0,a1,b1,c1,u1,v1,a2,b2,c2,u2,v2,a3,b3,c3,u3,v3,
%
%     23     24 25 26 27
%     lambda,mu,e1,e2,D ];


%Initial condition:
y0 = [-8 3]';

%Model name:
model = 'VTD_Landscape_Model_Pred_v1';


%Number of mutants:
%mutantstofit=1:14;
mutantstofit=[1,3,5,6,7,9,11];
nmutants = length(mutantstofit);


%Samples 
samples = nsimulations*nmutants;

Allsimulations = zeros(numPart,2+5+3,times,samples);

%Parameters that give an error in gm:
errorparams = [];
    
%Load data for clustering:

%    load('/cluster/elenameritxelldata/DataProp180814_ClusteredDataWithThd.mat','DataToFit')

%Clustering parameters
    NumDims = 2;
    NumClust = 6;
    Initial.mu = [-10 5; -3 3; 3 -3; 3 3; -3 -3; 0 0];
    Initial.Sigma = zeros(NumDims,NumDims,NumClust);

    for i = 1:NumClust
        Initial.Sigma(:,:,i) = 0.25*eye(NumDims,NumDims);
    end
    Initial.ComponentProportion = (1./NumClust)*ones(1,NumClust);
    


%Distance function handle:
distancehandle = str2func(strcat(model,'_AbsDistance_Gauss_Fates_GenSim'));
      
    %New cell in the particles matrix:
    %---------------------------------
    NewData = zeros(numPart, 27);
    NewFates = zeros(nmutants,times,NumClust,numPart); %NewFates(i,j,k,m) is the proportion of cells in cluster k at time j in Experiment i when using particle m.

    PartToUse = randperm(size(ParticlesMatrixaux,1), numPart);
    
    Particles = ParticlesMatrixaux(PartToUse,1:27);
    
    %simulate the particles:
    %-------------------
 parfor i=1:numPart
            paramaux = Particles(i,:);
            paramsimulations = paramaux;
            
            InitialCondition = repmat(y0,1,nsimulations)+randn(2,nsimulations)*sqrt(paramaux(end)); %This will be substituted by the solution coming from the LNA
            NoiseX = randn(M,nsimulations)*sqrt(2*paramaux(end)*dt); 
            NoiseY = randn(M,nsimulations)*sqrt(2*paramaux(end)*dt); 
            
            
            
            paramsimulations(8:22) = paramaux(8:22)-paramaux(3:17);%From a,b,c to ws
            
            [simulations,fatesmatrix,errorcatched,paramcatched] = feval(distancehandle,t0,dt,t1,times,samples,InitialCondition,nsimulations,paramsimulations,NoiseX,NoiseY,mutantstofit,nmutants,NumClust,Initial);
                   
%             weights = 1./11*ones(11,1);
%             totaldistance = sum(distances'*weights);%%

                 if (errorcatched==0)
                %Save the data in the matrix:    
                    NewData(i,:) = paramaux;%, distances', totaldistance];
                    NewFates(:,:,:,i) = fatesmatrix;
                    Allsimulations(i,:,:,:)=simulations;
                 else
                     errorparams = [errorparams;paramcatched];
                 end
                    
    
 end
Mut1 = Allsimulations(:,:,:,1:500);
Mut2 = Allsimulations(:,:,:,501:1000);
Mut3 = Allsimulations(:,:,:,1001:1500);
Mut4 = Allsimulations(:,:,:,1501:2000);
Mut5 = Allsimulations(:,:,:,2001:2501);
Mut6 = Allsimulations(:,:,:,2501:3000);
Mut7 = Allsimulations(:,:,:,3001:3500);


%save('Simulations_7_1.mat','NewFates','NewData','errorparams','Mut1','Mut2','Mut3','Mut4','Mut5','Mut6','Mut7','-v7.3')
save('/cluster/meritxellsaez/Simulations_7_1000.mat','NewFates','NewData','errorparams','Mut1','Mut2','Mut3','Mut4','Mut5','Mut6','Mut7','-v7.3')
