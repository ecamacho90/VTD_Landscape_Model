%Uses previoulsy computed simulations together with the new generated
%points to compute the gaussian mixture used for clustering

pathInput = '/Users/meritxellsaez/Documents/Vertebrate_Trunk_Development/Cluster_Results';
%load('19_09_12_7Mut_SENSITIVITYNEWPRIORS_ABCMv5v1_10000part_500sim_27par_Eps4_Eps3p07_Eps2p47_Eps2p10_Eps1p83_Eps1p56_Eps1p43.mat',...
%    'ParticlesMatrixaux');

%pathInput='.';
load(fullfile(pathInput, 'Predictions_7_Simulations.mat'),'NewData', 'simDay2','simDay2p5','simDay3','simDay3p5',...
    'simDay4','simDay4p5','simDay5')


OldData = cat(3,simDay2,simDay2p5,simDay3,simDay3p5,simDay4,simDay4p5,simDay5);
clear simDay2 simDay2p5 simDay3 simDay3p5 simDay4 simDay4p5 simDay5;

Particles = NewData;
numPart = 100; %size(Particles,1);

Particles = Particles(1:numPart,:); %Run a smaller number of particles
OldData = OldData(1:numPart,:,:,:);
 

%Time step:
dt = 0.01;

%Time for solution approximation:
t0 = 0;
t1 = 3*24;
tspan=t0:dt:t1;

%Number of subintervals:
M = (t1-t0)/dt;

%Times
times = t1/12+1;


%Number of simulations:
nsimulations = 200;

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
%mutantstofit=1:11;

%mutantstofit=60;

%mutantstofit = setdiff(mutantstofit,[1,3,5,6,7,9,11]);
%mutantstofit=[1,3,5,6,7,9,11];

%nmutants = length(mutantstofit);


%Samples 
%samples = nsimulations*nmutants;


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
    


%%Distance function handle:
distancehandle = str2func(strcat(model,'_AbsDistance_Gauss_Fates_PreSim'));
      
    %% New cell in the particles matrix:
    %---------------------------------
    
    mutantstofit=[1 2 3 6 20 25 26 27 33 51];
    nmutants = length(mutantstofit);
    samples = nsimulations*nmutants;
    
    NewData = zeros(numPart, 27);
    NewFates = zeros(nmutants,times,NumClust,numPart); %NewFates(i,j,k,m) is the proportion of cells in cluster k at time j in Experiment i when using particle m.

    
    
    %%Find the particles:
    %-------------------
    
    
    
 parfor i=1:numPart
            paramaux = Particles(i,:);
            paramsimulations = paramaux;
            
            InitialCondition = repmat(y0,1,nsimulations)+randn(2,nsimulations)*sqrt(paramaux(end)); %This will be substituted by the solution coming from the LNA
            NoiseX = randn(M,nsimulations)*sqrt(2*paramaux(end)*dt); 
            NoiseY = randn(M,nsimulations)*sqrt(2*paramaux(end)*dt); 
            
            
            
            paramsimulations(8:22) = paramaux(8:22)-paramaux(3:17);%From a,b,c to ws
            
            [~,fatesmatrix,errorcatched,paramcatched] = feval(distancehandle,t0,dt,t1,times,samples,InitialCondition,nsimulations,paramsimulations,NoiseX,NoiseY,mutantstofit,nmutants,NumClust,Initial, squeeze(OldData(1,:,:,:)));
                   
%             weights = 1./11*ones(11,1);
%             totaldistance = sum(distances'*weights);%%

                 if (errorcatched==0)
                %Save the data in the matrix:    
                    NewData(i,:) = paramaux;%, distances', totaldistance];
                    NewFates(:,:,:,i) = fatesmatrix;
                    %Allsimulations(i,:,:,:)=simulations;
                 else
                     errorparams = [errorparams;paramcatched];
                 end
                    
    
 end
 
 FatesSummary = mean(NewFates,4);
 %%
%Conditions = {'CHIR 0.65', 'CHIR 0.65 2-3', 'CHIR 0.65 2-2.5','1 Pulse', '2 Pulses'};
Conditions = {'No Chir', 'CHIR 2-2.5', 'CHIR 2-3', 'CHIR 2-5', '2 Pulses', 'CHIR 2-3 0.1', 'CHIR 2-3 0.3',...
    'CHIR 2-3 0.5', 'CHIR 0.1', '1 Pulse'};
%CondSave = {'SimCHIR0p65_2to5', 'SimCHIR0p65_2to3', 'SimCHIR0p65_2to2p5','Sim1PulseCHIR', 'Sim2PulsesCHIR'};
CondSave = {'NoChir', 'CHIR2to2p5', 'CHIR2to3', 'CHIR2to5', '2PulsesCHIR', 'CHIR2to3CHIR0p1', 'CHIR2to3CHIR0p3',...
    'CHIR2to30p5', 'CHIR0p1', '1PulseCHIR'};

for i=1:numel(Conditions)
   figure;
   proportionsSim = squeeze(FatesSummary(i,:,:));
   colorMatWithValsG(proportionsSim);
   set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);
   set(gca, 'FontSize',14);
   sgtitle(Conditions{i},'FontSize',18);
   saveas(gcf, [CondSave{i},'.png'])
end

%save('/cluster/meritxellsaez/Predictions_7_21to40.mat','NewFates','errorparams', 'mutantstofit','-v7.3')
%save('Predictions_7_New.mat','NewFates','NewData','errorparams','mutantstofit')
