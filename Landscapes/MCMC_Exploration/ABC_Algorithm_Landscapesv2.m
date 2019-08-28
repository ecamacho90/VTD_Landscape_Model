function ABC_Algorithm_Landscapesv2(CaseLandscape)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                         ABC SMC ALGORITHM
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               CONSTANTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%cd('/cluster/elenacamacho')

%Maximum number of steps:
MaxStep = 1.e6;

%Set the random number generator:
%--------------------------------
rng(13)

%Number of particles:
%--------------------
Nparticles=1000;

%Parameters:
%-----------

%Number of parameters:
npar = 37;

%     1 2 3 4 5 
%  p=[a,b,c,u,v];

syms x y

%Parameters to fit:
%------------------
parfitnumbers = [1,2,4,5];%1:5;

%Number of parameters to fit:
nparfit = length(parfitnumbers);

%Initial parameters:
if CaseLandscape ==1
initpar = [-9,4.5,-4,-20,7];
elseif CaseLandscape==2
initpar = [-8,-7,-2,-8,10];    
elseif CaseLandscape==3
initpar = [-8,-3,-4.5,-36,-12];    
elseif CaseLandscape==4
initpar = [-4,-12,3.5,-24,-8];    
end
initpar(3)=-3;

%Model name:
model = 'VTD_Landscape_Model_v1';


%Landscapes to fit:
landscapestofit = [1];

%Number of landscapes to fit:
nlandscapes = length(landscapestofit);



%DON'T NEED TO CHANGE:
%---------------------

%Priors function handle:
priorshandle = str2func(strcat(model,'_Priors'));

%Density function constraints handle:
constraintshandle = str2func(strcat(model,'_Constraints'));

%Relations between parameters contraints handle:
relationsconstraintshandle1 = str2func(strcat(model,'_Relations_Constraints1'));

%Check critical points:
criticalpointshandle = str2func(strcat(model,'_CriticalPoints'));

%Check critical points:
checkcriticalpointshandle = str2func(strcat(model,'_CheckCriticalPointsv2'));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               SAMPLER T=0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    
    tic

    
    %Update threshold number:
    %------------------------
    N = 0;
    i = 0;
    
    
    %New cell in the particles matrix:
    %---------------------------------
    NewData = zeros(1000,5);

    %Find the particles:
    %-------------------
    while (N<Nparticles)&&(i<MaxStep)

        if rem(i,100)==0
            disp('---------------------------------------------------')
            disp('---------------------------------------------------')
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
            
        valuepriors = zeros(1,nparfit);

        paramaux = initpar;

        parami = 0;

        priorOK = 1;

        while (parami<nparfit)&&(priorOK)  

            parami = parami+1;

            paramifit = parfitnumbers(parami); 

            provparvalue = feval(priorshandle,paramifit,CaseLandscape); 

            priorOK = feval(constraintshandle,provparvalue,paramifit,CaseLandscape); 

            paramaux(paramifit) = provparvalue; 

        end
         

        
        %Check that the parameters fulfill all the constraints:
        %------------------------------------------------------
        
        if priorOK
            
            priorOK = feval(relationsconstraintshandle1,paramaux,CaseLandscape);
            
        end

        %Compute critical points
        [critpointsx,critpointsy] = feval(criticalpointshandle,paramaux,x,y);
  
        %Check that the lanscape has the desired number of critical points
        priorOK = feval(checkcriticalpointshandle,critpointsx,critpointsy,CaseLandscape,paramaux);
        


            %ACCEPT THE PARTICLE OR NOT DEPENDING ON THE DISTANCE:
            %-----------------------------------------------------
            if priorOK

                %Count that a new particle has been found:
                N = N+1;
                
                %Save the data in the matrix:    
                %NewData = [NewData; paramaux];
                NewData(N,:) = paramaux;
                
                    
                
            end
               
    end

   eltime=toc;

    
    
  
save(['LandscapesFound_Case',num2str(CaseLandscape)])

    
    











%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%20/01/16               Elena Camacho Aguilar

