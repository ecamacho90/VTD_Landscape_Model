function [distances,fatesmatrix] = VTD_Landscape_Model_Fitting_v1_AbsDistance_Gauss_Fates(t0,dt,t1,times,samples,InitialCondition,nsimulations,paramsimulations,NoiseX,NoiseY,mutantstofit,nmutants,datamutants,NumClust,Initial)


simulations = zeros(2,times,samples);
fatesmatrix = zeros(nmutants,times,NumClust);


for mutantnumber = 1:nmutants

    simulations(:,:,1+nsimulations*(mutantnumber-1):nsimulations*mutantnumber) = VTD_Landscape_Model_Fitting_v1_AbsDistance_Gauss_Fates_EachMut(t0,dt,t1,InitialCondition,nsimulations,paramsimulations,NoiseX,NoiseY,mutantstofit(mutantnumber));
    
%     figure
%     for time = 1:times
%         
%         subplot(3,3,time)
%         scatter(simulations(1,time,1+nsimulations*(mutantnumber-1):nsimulations*mutantnumber),simulations(2,time,1+nsimulations*(mutantnumber-1):nsimulations*mutantnumber),'filled')
% %         xlim([min(min(simulations(1,:,1+nsimulations*(mutantnumber-1):nsimulations*mutantnumber))),max(max(simulations(1,:,1+nsimulations*(mutantnumber-1):nsimulations*mutantnumber)))])
% %         ylim([min(min(simulations(2,:,1+nsimulations*(mutantnumber-1):nsimulations*mutantnumber))),max(max(simulations(2,:,1+nsimulations*(mutantnumber-1):nsimulations*mutantnumber)))])
%         
%     end

end
    
%% ClusterData

    Data = reshape(simulations, [2,times*samples])';
    size(Data)
    figure
    scatter(Data(:,1),Data(:,2),'filled')
    
    gmfit = fitgmdist(Data, NumClust,'CovarianceType','full',...
        'SharedCovariance',false, 'Options',statset('MaxIter', 300), 'Start', Initial);

%% Assign fates
    fatesaux = zeros(samples,times);
  
    for i=1:times
        fatesaux(:,i) = cluster(gmfit, squeeze(simulations(:,i,:))');
    end

    for mutantnumber = 1:nmutants
        
        for clusternumber = 1 :NumClust
        
            fatesmatrix(mutantnumber, :, clusternumber) = sum(fatesaux(1+nsimulations*(mutantnumber-1):nsimulations*mutantnumber,:)==clusternumber,1)/nsimulations;
        end
        
    end
    
%% Compute distance
    
    distances = sum(squeeze(sum(abs(datamutants - fatesmatrix),2)),2);