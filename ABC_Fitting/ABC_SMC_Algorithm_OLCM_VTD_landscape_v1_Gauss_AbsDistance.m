function ABC_SMC_Algorithm_OLCM_VTD_landscape_v1_Gauss_AbsDistance(mutantstofit,parfitnumbers,EpT,T,Tmax,Nmax,Numberofparticleseachjob,PreviousData,namenewdata,CovarianceMatricesParticles,NoClassifiedOption,weightsdistances,streamnum,jobnum)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                         ABC SMC ALGORITHM
%                   Optimal Local Covariance Matrix 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               INPUT VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% * *mutantstofit*: Vector containing the number of the mutants that we are
% going to fit.
% * *parfitnumbers*: Vector containing the number of the parameters that we
% are going to fit.
% * *EpT*: Vector containing the thresholds that we are going to use for
% the algorithm. 
% * *T*: Number of steps that we have done in the thresholds. For computing the first
% threshold, T=0. For the second threshold, T=1.
% * *Tmax*: Number of maximum number of steps in thresholds. For computing
% one threshold, Tmax=1. For the second one, Tmax=2.
% * *Nmax*: Number of total particles that we are considering.
% * *jobnum*: Number of the parallel subset of particles that we are
% computing.
% * *Numberofparticleseachjob*: Number of particles that we will compute in
% this job.
% * *PreviousData*: Matrix containing the particles and distances from the
% previous iteration.
% * *namenewdata* : Name of the Workspace of the new data set.
% * *CovarianceMatricesParticles*: Local covariance matrix of the normal
% perturbation kernel for each particle.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               CONSTANTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%cd('/cluster/elenacamacho')

%Maximum number of steps:
MaxStep = 1.e6;

%Set the stream of random number generators:
%-------------------------------------------

reset(RandStream.getGlobalStream) %reset the random stream

substreamnum = jobnum; %number of substream

cmrg = RandStream.create('mrg32k3a','NumStreams',100,'StreamIndices',streamnum);
RandStream.setGlobalStream(cmrg)
cmrg.Substream = substreamnum;

% To solve critical points equations
syms x y

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
nsimulations = 500;%64;

%Number of parameters:
npar = 27;

%     1   2   3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22
%  p=[WNT,FGF,a0,b0,c0,u0,v0,a1,b1,c1,u1,v1,a2,b2,c2,u2,v2,a3,b3,c3,u3,v3,
%
%     23     24 25 26 27
%     lambda,mu,e1,e2,D ];


%Number of parameters to fit:
nparfit = length(parfitnumbers);

%Initial parameters:
initpar = [0,   1,   -9, 4.5, -3,  -20, 7 , -8, -7, -3, 8, 10 ,  -8, -3, -3,  -18, -12 ,  -6, -13, -3,  -17, -35, 24, 1, 0.03, 0.03, 0.2];

%Initial condition:
y0 = [-8 3]';

%Model name:
model = 'VTD_Landscape_Model_Fitting_v1';


%Number of mutants:
nmutants = length(mutantstofit);

%Samples 
samples = nsimulations*nmutants;
    
%Load data for clustering:
if NoClassifiedOption
    load('DataProp180814_ClusteredDataWithThd.mat','DataToFit')
    %Clustering parameters
    NumDims = 2;
    NumClust = 6;
    Initial.mu = [-10 5; -3 3; 3 -3; 3 3; -3 -3; 0 0];
    Initial.Sigma = zeros(NumDims,NumDims,NumClust);

    for i = 1:NumClust
        Initial.Sigma(:,:,i) = 0.25*eye(NumDims,NumDims);
    end
    Initial.ComponentProportion = (1./NumClust)*ones(1,NumClust);
    
else
    load('DataProp180814_ClusteredDataNoThd.mat','DataToFit')
end

% save(['paramFatesM5v1_',num2str(jobnum)])


%DON'T NEED TO CHANGE:
%---------------------

%Priors function handle:
priorshandle = str2func(strcat(model,'_Priors')); %Done

%Simulated data function handle:
modelhandle = str2func(strcat(model,'_simulation'));

%Distance function handle:
distancehandle = str2func(strcat(model,'_AbsDistance_Gauss_Fates'));

%Covariance matrices OLCM function handle:
covarianceOLCMhandle = str2func(strcat(model,'_CovarianceMatricesOLCM'));

%Perturbation Kernels handle:
kernelshandle = str2func(strcat(model,'_Kernels'));

%Density function prior handle:
evalpriorshandle = str2func(strcat(model,'_EvalPriors')); %Done

%Density function kernel handle:
evalkernelhandle = str2func(strcat(model,'_EvalKernels')); %Done

%Density function constraints handle:
constraintshandle = str2func(strcat(model,'_Constraints')); %Done

%Relations between parameters contraints handle:
relationsconstraintshandle1 = str2func(strcat(model,'_Relations_Constraints1'));

%Relations between parameters contraints handle:
relationsconstraintshandle2 = str2func(strcat(model,'_Relations_Constraints2'));

%Compute critical points handle:
computecriticalpointshandle = str2func(strcat(model,'_CriticalPoints'));

%Check critical points handle:
checkcriticalpointshandle = str2func(strcat(model,'_CheckCriticalPoints'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               SAMPLER T=0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  paramaux = initpar;
  parfitnumbersi = parfitnumbers;
  sublandscapefit = 1:4;
if T==0
    
    tic

    
    %Update threshold number:
    %------------------------
    
    T = T+1;
    N = 0;
    i = 0;
    
    %Set new threshold so that the threshold for each mutant is EpT(T):
    %------------------------------------------------------------------
    newEpT = EpT(T);
    
    %New cell in the particles matrix:
    %---------------------------------
    NewData = [];
    NewFates = zeros(nmutants,times,NumClust,Numberofparticleseachjob); %NewFates(i,j,k,m) is the proportion of cells in cluster k at time j in Experiment i when using particle m.
    CheckParamConstraintsResult = 0;
    CheckLandscapesResult = 0;

    %Find the particles:
    %-------------------
    while (N<Numberofparticleseachjob)&&(i<MaxStep)

        if rem(i,10)==0
            disp('---------------------------------------------------')
            disp('---------------------------------------------------')
            disp(strcat('            Threshold: ',num2str(EpT(T))));
            disp(strcat('            Job number: ',num2str(jobnum)));
            disp(strcat('            Step: ',num2str(i)));
            disp(strcat('            Accepted particles: ',num2str(N)));
            disp('---------------------------------------------------')
            disp('---------------------------------------------------')
        end


        %Update steps:
        %-------------

        i = i+1;

        %Sample parameter values:
        %------------------------
            
     %   valuepriors = zeros(1,nparfit); %Meri:Not used

%        paramaux = initpar;

        %parami = 0;
        parami = 1;%Meri
        
       % priorOK = 1;

        %while (parami<nparfit)%%&&(priorOK)%Meri  %Only if priorOK is not 0 and parami<npar the while loop will stop
        while (parami<numel(parfitnumbersi))
            %parami = parami+1;%Meri

            paramifit = parfitnumbersi(parami); %Parameter number

            provparvalue = feval(priorshandle,paramifit); %Sample a value

            priorOK = feval(constraintshandle,provparvalue,paramifit); %Check that is a valid value
            if rem(parami,4)==0 %Modify if fitting c
                priorOK = feval(relationsconstraintshandle1,paramaux);
                if priorOK==0
                   parami = parami-3; 
                end
            end
            if priorOK %Meri 
               parami = parami + 1; 
               paramaux(paramifit) = provparvalue; %Save the value
            else 
                i=i+1;
            end
            
        end
            
        %Check that the parameters fulfill all the constraints:
        %------------------------------------------------------
        
%         if priorOK
%             
%             priorOK = feval(relationsconstraintshandle1,paramaux);
%             
%         end

        %Check the sublandscapes have the correct number of critical pts:
        %----------------------------------------------------------------
        if priorOK 
            disp('Constraint fulfilled')
            CheckParamConstraintsResult = CheckParamConstraintsResult +1;
            
           % sublandscapen = 1;

            %while (sublandscapen<5)%&&(priorOK)
            for sublandscapen=sublandscapefit
                subparamaux = paramaux((3+(sublandscapen-1)*5):(2+(sublandscapen)*5));
%                 subparamaux

                %Compute critical points
                [critpointsx,critpointsy] = feval(computecriticalpointshandle,subparamaux,x,y);

                %Check that the lanscape has the desired number of critical points
                priorOK = feval(checkcriticalpointshandle,critpointsx,critpointsy,sublandscapen,subparamaux);
                if priorOK
                    parfitnumbersi = parfitnumbersi(parfitnumbersi<2+5*(sublandscapen-1)+1 | parfitnumbersi>2+5*(sublandscapen));
                    sublandscapefit = sublandscapefit(sublandscapefit~=sublandscapen);
                end
                %sublandscapen = sublandscapen+1;
            end
        end
        
       % if priorOK
        if numel(parfitnumbersi)==5    
            CheckLandscapesResult = CheckLandscapesResult+1;
            
            InitialCondition = repmat(y0,1,nsimulations)+randn(2,nsimulations)*sqrt(paramaux(end)); %This will be substituted by the solution coming from the LNA
            NoiseX = randn(M,nsimulations)*sqrt(2*paramaux(end)*dt); 
            NoiseY = randn(M,nsimulations)*sqrt(2*paramaux(end)*dt); 
            
%             figure('WindowStyle','docked');
%             hold on
%             scatter(InitialCondition(1,:),InitialCondition(2,:))
            
            %size([NoiseX;NoiseY])
            paramsimulations = paramaux;
            
            paramsimulations(8:22) = paramaux(8:22)-paramaux(3:17);%From a,b,c to ws
            
            [distances,fatesmatrix] = feval(distancehandle,t0,dt,t1,times,samples,InitialCondition,nsimulations,paramsimulations,NoiseX,NoiseY,mutantstofit,nmutants,DataToFit,NumClust,Initial);
                   
            totaldistance = sum(distances'.*weightsdistances);%%

            %ACCEPT THE PARTICLE OR NOT DEPENDING ON THE DISTANCE:
            %-----------------------------------------------------
            if totaldistance<=newEpT

                %Count that a new particle has been found:
                N = N+1;
                
                %Save the data in the matrix:    
                NewData = [NewData; paramaux, distances', totaldistance,1];
                NewFates(:,:,:,N) = fatesmatrix;
                    
                
            end           
            
            parfitnumbersi = parfitnumbers;
            sublandscapefit = 1:4;
        end
    end
    
    eltime=toc;
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               SAMPLER T>0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
if (T>0)&(T<Tmax)
 tic
    %Update threshold number:
    %------------------------
    
    T = T+1;
    N = 0;
    i = 0;
    
    %Set new threshold so that the threshold for each mutant is EpT(T):
    %------------------------------------------------------------------
    newEpT = EpT(T);
    
    %New cell in the particles matrix:
    %---------------------------------
    NewData = [];
     NewFates = zeros(nmutants,times,NumClust,Numberofparticleseachjob); %NewFates(i,j,k,m) is the proportion of cells in cluster k at time j in Experiment i when using particle m.
   
    
%     %Compute the covariance matrix corresponding to each of the particles
%     %of the previous step to use a local multivariate normal perturbation
%     %kernel
%     %--------------------------------------------------------------------
% 
%     CovarianceMatricesParticles = feval(covarianceOLCMhandle,PreviousData,parfitnumbers,nparfit,Nmax,EpT(T));
     
    %Weights of each particle:
    %-------------------------
    w0 = PreviousData(:,end);
    
    %Find the particles:
    %-------------------
    while (N<Numberofparticleseachjob)&&(i<MaxStep)

        if rem(i,10)==0
            disp('---------------------------------------------------')
            disp('---------------------------------------------------')
            disp(strcat('            Threshold: ',num2str(EpT(T))));
            disp(strcat('            Job number: ',num2str(jobnum)));
            disp(strcat('            Step: ',num2str(i)));
            disp(strcat('            Accepted particles: ',num2str(N)));
            disp('---------------------------------------------------')
            disp('---------------------------------------------------')
        end


        %Update steps:
        %-------------

        i = i+1;
        

        %SAMPLE THE NEXT PARTICLE:
        %-------------------------
 
        %Computing the next particle:
        %-----------------------------
%         size(w0)
%         Nmax
        particlenum = randsample(Nmax,1,true,w0);

        paramaux = PreviousData(particlenum,1:npar); %Sample a particle from the previous step and take the parameters that we are fitting

        newcomponentsparamaux = mvnrnd(paramaux(parfitnumbers),CovarianceMatricesParticles(:,:,particlenum)); % Use multivariate normal perturbation kernel to find new particle.


        %Check if the new components are valid:
        %-------------------------------------
        valuepriors = zeros(1,nparfit);

        parami = 0;  %Set the index of the parameter for which we will do for loop

        priorOK = 1;  %It will keep track that all the prior evaluated at every parameter is not 0

         while (parami<nparfit)&&(priorOK)  %Only if priorOK is not 0 and parami<npar the while loop will stop

            parami = parami+1;

            paramifit = parfitnumbers(parami);

            provparvalue = newcomponentsparamaux(parami); %Take the parami component of the new candidate vector that contains the new values of the parameters that we are fitting.
            
            priorOK = feval(evalpriorshandle,provparvalue,paramifit,minimumM); %We will have to change this so that it stops if we found one parameter which prior is 0

            if priorOK

            priorOK = feval(constraintshandle,provparvalue,paramifit,minimumM); %Check that is a valid value

            end

            paramaux(paramifit) = provparvalue;

            valuepriors(parami) = priorOK;

         end
         
              
        %Check that the parameters fulfill all the constraints:
        %------------------------------------------------------
        
        if priorOK
            
            priorOK = feval(relationsconstraintshandle1,paramaux);
            
        end
        
        %Check the sublandscapes have the correct number of critical pts:
        %----------------------------------------------------------------
        sublandscapen = 1;
        
        while (sublandscapen<5)&(priorOK)
            subparamaux = paramaux((3+(sublandscapen-1)*5):(2+(sublandscapen)*5));
            
            %Compute critical points
            [critpointsx,critpointsy] = feval(computecriticalpointshandle,subparamaux,x,y);
  
            %Check that the lanscape has the desired number of critical points
            priorOK = feval(checkcriticalpointshandle,critpointsx,critpointsy,sublandscapen,subparamaux);
            
            sublandscapen = sublandscapen+1;
        end
       
        if priorOK
            
            InitialCondition = repmat(y0,1,nsimulations)+randn(2,nsimulations)*sqrt(paramaux(end)); %This will be substituted by the solution coming from the LNA
            NoiseX = randn(M,nsimulations)*sqrt(2*paramaux(end)*dt); 
            NoiseY = randn(M,nsimulations)*sqrt(2*paramaux(end)*dt); 
            
            size([NoiseX;NoiseY])
            paramsimulations = paramaux;
            
            paramsimulations(8:22) = paramaux(8:22)-paramaux(3:17);%from a,b,c to ws
            
            [distances,fatesmatrix] = feval(distancehandle,t0,dt,t1,times,samples,InitialCondition,nsimulations,paramsimulations,NoiseX,NoiseY,mutantstofit,nmutants,DataToFit,NumClust,Initial);
                   
            totaldistance = sum(distances'.*weightsdistances);

         


            %ACCEPT THE PARTCILE OR NOT DEPENDING ON THE DISTANCE:
            %-----------------------------------------------------

            if totaldistance<=newEpT

                %Count that a new particle has been found:
                N = N+1;
  
                %Compute the weight of the particle:
                denominator = 0;

                for partic=1:Nmax

                        denominator = denominator+w0(partic)*feval(evalkernelhandle,newcomponentsparamaux,PreviousData(partic,parfitnumbers),CovarianceMatricesParticles(:,:,partic));

                end

                w1 = prod(valuepriors)/denominator; %We multiply the priors of each component of the parameter vector to compute the value of the prior of the parameter vector
                
                NewData = [NewData; paramaux, distances, totaldistance,w1];
                NewFates(:,:,:,N) = fatesmatrix;
                
            end
               
        end


    end
    eltime=toc;

end
 

save(['/home/meritxellsaez/elenadata/',namenewdata,'_',num2str(jobnum)],'newEpT','NewData','NewFates','CheckParamConstraintsResult','CheckLandscapesResult','streamnum','substreamnum','eltime','i')
reset(RandStream.getGlobalStream)


fileID = fopen('/home/meritxellsaez/elenadata/FilesThatRun.txt','a');
fprintf(fileID,num2str(jobnum));
fprintf(fileID,'\n');
fclose(fileID);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%20/01/16

%v1: First version of ABC algorithm for VTD model. Noise is fixed for each
%particle, so all simulations done with the same particle have the same
%noise realisations.


%ABC_SMC_Algorithm_OLCM_Template.m (c) by Elena Camacho Aguilar

%ABC_SMC_Algorithm_OLCM_Template.m is licensed under a 
%Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) Unported License.

%You should have received a copy of the license along with this
%work.  If not, see <https://creativecommons.org/licenses/by-nc-sa/4.0/>.
