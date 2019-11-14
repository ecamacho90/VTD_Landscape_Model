load('DataAll180814.mat')
DataToFit = ClusteredDataWithThd;

%load('Predictions_7_WrongDistReal.mat');
load('Predictions_7_Pred1.mat');
FatesSummary = mean(NewFates,4);

Params = {'a1','b1','u1','v1','a2','b2','u2','v2','a3','b3','u3','v3','a4','b4','u4','v4','lambda','mu','xi1','xi2'};

ExpConditions = {'NoChir','Chir22p5','Chir23','Chir23p5','Chir24','Chir25','Chir25FGF23','Chir25FGF23p5','Chir25FGF24','Chir25FGF24p5','Chir25FGF25',...
    'Pulses12h', 'Pulses24h', 'Pulses12hDay3.5'};
Days = [2,2.5,3,3.5,4,4.5,5];
Fates = {'Epi','Ant Neur', 'Post Neur', 'Meso', 'NMP','Trans'};
               
%%
for i=1:11
    EC=ExpConditions{i};

    proportionsSim = squeeze(FatesSummary(i,:,:));
    proportionsReal = squeeze(DataToFit(i,:,:));
    difProp = abs(proportionsSim-proportionsReal);

    figure('Position', [110, 220, 1220, 570]);
    sgtitle([EC,' Proportions']);
    subplot(1,3,1)
    colorMatWithValsG(proportionsReal);
    set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);
    title('Original Data');
    subplot(1,3,2)
    colorMatWithValsG(proportionsSim);
    set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);
    title('Simulated Data');
    subplot(1,3,3)
    colorMatWithValsG(difProp);
    set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);
    title('Absolute distance');
    saveas(gca,['Compare_MeanProportionsPedictionAll_',EC,'.png']);
    
end

%%
for i=12:14
    EC=ExpConditions{i};

    proportionsSim = squeeze(FatesSummary(i,:,:));
    figure;
    sgtitle([EC,' Proportions']);
    colorMatWithValsG(proportionsSim);
    set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);

end

for i=12:14
    EC=ExpConditions{i};
    figure('Position', [110, 220, 1220, 570]);
    sgtitle([EC,' Distribution Proportions']);
    for j=2:7
        for k=1:6
            subplot(6,6,(j-2)*(6)+k);
            histogram(squeeze(NewFates(i,j,k,:)));
            ylabel(['Day ',num2str(Days(j))]);
            xlabel(Fates{k});
        end
    end
    %saveas(gca,['Dist_Proportions_Comp_',EC,'.png']);
end

%%
for i=1:11
    EC=ExpConditions{i};
    proportionsReal = squeeze(DataToFit(i,:,:));
    figure('Position', [110, 220, 1220, 570]);
    sgtitle([EC,' Distribution Proportions']);
    for j=2:7
        for k=1:6
            subplot(6,6,(j-2)*(6)+k);
            histogram(squeeze(NewFates(i,j,k,:)));
            Axes=gca;
            line([proportionsReal(j,k),proportionsReal(j,k)],Axes.YLim, 'Color','r','LineWidth',3)
            ylabel(['Day ',num2str(Days(j))]);
            xlabel(Fates{k});
        end
    end
    %saveas(gca,['Dist_Proportions_Comp_',EC,'.png']);
end

%%
for i=1:11
    EC=ExpConditions{i};
    proportionsReal = squeeze(DataToFit(i,:,:));
    figure('Position', [110, 220, 1220, 570]);
    sgtitle([EC,' Distribution Relative Distance']);
    for j=2:7
        for k=1:6
            subplot(6,6,(j-2)*(6)+k);
            histogram((squeeze(NewFates(i,j,k,:))-proportionsReal(j,k)));
            %Axes=gca;
            %line([proportionsReal(j,k),proportionsReal(j,k)],Axes.YLim, 'Color','r','LineWidth',3)
            ylabel(['Day ',num2str(Days(j))]);
            xlabel(Fates{k});
        end
    end
    %saveas(gca,['Rel_Dist_Proportions_Pred_',EC,'.png']);
end
%%


[M,I] = min(squeeze(ParticlesMatrixaux(:,35)));

for i=1:7
    EC=ExpConditions{i};

    proportionsSim = squeeze(FatesMatrixaux(i,:,:,I));
    proportionsReal = squeeze(DataToFit(i,:,:));
    difProp = abs(proportionsSim-proportionsReal);

    figure('Position', [110, 220, 1220, 570]);
    sgtitle([EC,' Proportions']);
    subplot(1,3,1)
    colorMatWithValsG(proportionsReal);
    set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);
    title('Original Data');
    subplot(1,3,2)
    colorMatWithValsG(proportionsSim);
    set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);
    title('Best Simulated Data');
    subplot(1,3,3)
    colorMatWithValsG(difProp);
    set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);
    title('Absolute distance');
    %saveas(gca,['Compare_BestProportions_',EC,'.png']);
    
end

%%

v1 = squeeze(FatesMatrixaux(5,7,3,:));

v2 = squeeze(FatesMatrixaux(6,7,3,:));

figure;
histogram2(v1,v2);
hold on;
histogram2('XBinEdges',[0.18,0.20], 'YBinEdges',[0.005,0.015],'BinCounts',1000);
%%
figure;
sgtitle(['Relative Distances']);
for i=28:34
    for j=i+1:34
    subplot(7,6,(i-28)*6+j-28)
    histogram2(squeeze(ParticlesMatrixaux(:,i)),squeeze(ParticlesMatrixaux(:,j)));
    xlabel(ExpConditions{i-27});
    ylabel(ExpConditions{j-27});
    view(0,90);
    
    end
end

%%
figure;
sgtitle(['Relative Distances']);
for i=1:27
    for j=i+1:27
    subplot(7,6,(i-1)*6+j-1)
    histogram2(squeeze(ParticlesMatrixaux(:,i)),squeeze(ParticlesMatrixaux(:,j)));
    xlabel(ExpConditions{i-27});
    ylabel(ExpConditions{j-27});
    view(0,90);
    
    end
end

Correlations=corr(ParticlesMatrixaux(:,parfitnumbers));
figure;
imagesc(abs(Correlations))


%%
figure;
for i=parfitnumbers
   subplot(4,7,i)
   histogram(squeeze(ParticlesMatrixaux(:,i)));
end

%%

M=ParticlesMatrixaux(:,parfitnumbers);
M=M(:,1:end-1);
aux = corr(M);
[V,I]=find(abs(aux)>0.5);
J=V<I;
V=V(J); I=I(J);
figure; 
for i=1:numel(I) 
    subplot(7,6,i); 
    histogram2(M(:,V(i)),M(:,I(i))); 
    xlabel(Params{V(i)});
    ylabel(Params{I(i)});
    view(0,90);
end
%%


[Score, Rot] = pca(M);
Score(:,1)
aux = corr(Rot);
[V,I]=find(abs(aux)>0.7);
J=V<I;
V=V(J); I=I(J);
figure; 
for i=1:numel(I) 
    subplot(7,6,i); 
    histogram2(M(:,V(i)),M(:,I(i))); 
    %xlabel(Params{V(i)});
    %ylabel(Params{I(i)});
    view(0,90);
end

%%

load('19_09_12_7Mut_SENSITIVITYNEWPRIORS_ABCMv5v1_10000part_500sim_27par_Eps4_Eps3p07_Eps2p47_Eps2p10_Eps1p83_Eps1p56_Eps1p43.mat',...
     'ParticlesMatrix','parfitnumbers');


for i=1
    aux = [ParticlesMatrix{i}; ParticlesMatrix{7}];
    group = [i*ones(10000,1);(7)*ones(10000,1)];
    figure('units','normalized','outerposition',[0 0 1 1])
    gplotmatrix(aux(:,parfitnumbers),[],group);
    saveas(gcf,['ComparisonRun',num2str(i),'_Run',num2str(7),'.png']);
%     close all;
end

%%

load('Predictions_7_Pulses1')

FatesSummary = mean(NewFates,4);
Conditions = {'12h pulses','24h pulses','12h pulses after 3.5','12h pulses after 4',...
    '12h pulses after 3', '6h pulses after 2.5', '6h pulses after 2.75',  '6h pulses after 3',...
    '3h pulses 12h -> 27h', '3h pulses 18h -> 33h','3h pulses 24h -> 39h',...
    '3h pulses 30h -> 45h','3h pulses 36h -> 51h'};

SaveName = {'12hPulses','24hPulses','12hPulses3p5','12hPulses4',...
    '12hPulses3', '6hPulses2p5', '6hPulses2p75', '6hPulses3',...
    '3hPulses12h27h', '3hPulses18h33h','3hPulses24h39h',...
    '3hPulses30h45h','3hPulses36h51h'};


for i=1:13
figure;
proportionsSim = squeeze(FatesSummary(i,:,:));
colorMatWithValsG(proportionsSim);
set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);
set(gca, 'FontSize',14);
sgtitle(Conditions{i},'FontSize',18);
saveas(gcf,[SaveName{i},'.png']);
end



    
