function [fates,Colors] = computefates_GaussMix(Xsol)

    [~, times, samples] = size(Xsol);
    Data = reshape(Xsol, [2,times*samples])';

    NumDims = 2;
    NumClust = 6;
    Initial.mu = [-10 5; -3 3; 3 -3; 3 3; -3 -3; 0 0];
   
    Initial.Sigma = zeros(NumDims,NumDims,NumClust);
    for i = 1:NumClust
        Initial.Sigma(:,:,i) = 0.25*eye(NumDims,NumDims);
    end
    Initial.ComponentProportion = (1./NumClust)*ones(1,NumClust);


    gmfit = fitgmdist(Data, NumClust,'CovarianceType','full',...
        'SharedCovariance',false, 'Options',statset('MaxIter', 300), 'Start', Initial);

    %% Visualise result
    clusterX = cluster(gmfit, Data);

    %%Plot Histograms for each cluster, all proteins and show proportions
   % DA_PlotCombined1DHist(Data, 1:2, 1:NumClust, 0, clusterX, {'x','y'}, 100, 0, [], 'All', '', '', [1,3,9,7,5], gmfit);

    %%Plot 2D contour curves
    DA_PlotCombined2DHist(Data, 1, 1:2, 1:NumClust, 0,  clusterX, {'x','y'}, 100, 0, [], 'All', [], '', [1,3,7,9,5,11]);

    %% Assign fates
    fates = zeros(samples,times);
    for i=1:times
        fates(:,i) = cluster(gmfit, squeeze(Xsol(:,i,:))');
    end

    Colors = zeros(samples, times, 3); %This is dispensable for the MCMC 
    for i=1:times
        for j=1:samples
            switch fates(j,i)
                case 1
                    Colors(j,i,:)=[0 0 1];
                case 2
                    Colors(j,i,:)=[0 1 0];
                case 3
                    Colors(j,i,:)=[1 0 1];
                case 4
                    Colors(j,i,:)=[0 1 1];
                case 5
                    Colors(j,i,:)=[0 0 0];
                case 6
                    Colors(j,i,:)=[1 0 0];
            end
        end
    end
end