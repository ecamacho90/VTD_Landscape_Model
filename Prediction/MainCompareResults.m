%load('DataAll180814_PartialFit.mat')
load('DataAll180814_PartialFit_remDead.mat')
DataToFit = ClusteredDataWithThd;


load('/Users/meritxellsaez/Documents/Cluster_Results/Predictions_7_01to20.mat');
FatesSummary = mean(NewFates,4);

Params = {'a1','b1','u1','v1','a2','b2','u2','v2','a3','b3','u3','v3','a4','b4','u4','v4','lambda','mu','xi1','xi2'};

ExpConditions = {'Chir22p5','Chir23p5','Chir25FGF23p5','Chir25FGF24p5'};

   
Days = [2,2.5,3,3.5,4,4.5,5];
Fates = {'Epi','Ant Neur', 'Post Neur', 'Meso', 'NMP','Trans'};
               
%%
for i=1:4
    EC=ExpConditions{i};

    proportionsSim = squeeze(FatesSummary(i,:,:));
    proportionsReal = squeeze(DataToFit(mutantstofit(i),:,:));
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

FatesSummary = zeros(48,7,6);
load('/Users/meritxellsaez/Documents/Cluster_Results/Predictions_7_01to20.mat');
FatesSummary(1:9,:,:)=mean(NewFates(5:13,:,:,:),4);
load('/Users/meritxellsaez/Documents/Cluster_Results/Predictions_7_21to40.mat');
FatesSummary(10:29,:,:)=mean(NewFates,4);
load('/Users/meritxellsaez/Documents/Cluster_Results/Predictions_7_41to59.mat');
FatesSummary(30:48,:,:)=mean(NewFates,4);

Conditions = {'12h pulses','24h pulses','12h pulses after Day 3.5','12h pulses after Day 4',...
    '12h pulses after Day 3', '6h pulses after Day 2.5', '6h pulses after Day 2.75',  '6h pulses after Day 3',...
    '3h pulses 12h -> 27h', '3h pulses 18h -> 33h','3h pulses 24h -> 39h',...
    '3h pulses 30h -> 45h','3h pulses 36h -> 51h','0.1 CHIR Day 3', '0.3 CHIR Day 3', '0.5 CHIR Day 3', '0.7 CHIR Day 3',...
    '0.1 CHIR Day 3.5', '0.3 CHIR Day 3.5', '0.5 CHIR Day 3.5', '0.7 CHIR Day 3.5',...
    '0.1 CHIR Day 2', '0.2 CHIR Day 2', '0.3 CHIR Day 2', '0.5 CHIR Day 2', '0.7 CHIR Day 2', '0.9 CHIR Day 2',...
    'CHIR Day 3, 3h', 'CHIR Day 3, 6h', 'CHIR Day 3, 9h', 'CHIR Day 2.75, 3h', 'CHIR Day 2.75, 6h', 'CHIR Day 2.75, 9h',...
    'CHIR 0.5 Day 3, 6h', 'CHIR 0.5 Day 3, 12h', 'CHIR 0.5 Day 3, 24h',...
    'CHIR Day 2, 3h', 'CHIR Day 2, 6h', 'CHIR Day 2, 9h','3h pulses 12h -> 21h', '3h pulses 18h -> 27h', 'CHIR 2-5, FGF 0.1 Day 3',...
    'CHIR 2-5, FGF 0.3 Day 3','CHIR 2-5, FGF 0.5 Day 3','CHIR 2-5, FGF 0.7 Day 3','CHIR from Day 2.5', 'CHIR from Day 3', '3h pulse 12h-15h'};

SaveName = {'12hPulses','24hPulses','12hPulses3p5','12hPulses4',...
    '12hPulses3', '6hPulses2p5', '6hPulses2p75', '6hPulses3',...
    '3hPulses12h27h', '3hPulses18h33h','3hPulses24h39h',...
    '3hPulses30h45h','3hPulses36h51h','0p1CHIRDay3', '0p3CHIRDay3', '0p5CHIRDay3', '0p7CHIRDay3',...
    '0p1CHIRDay3p5', '0p3CHIRDay3p5', '0p5CHIRDay3p5', '0p7CHIRDay3p5',...
    '0p1CHIRDay2', '0p2CHIRDay2', '0p3CHIRDay2', '0p5CHIRDay2', '0p7CHIRDay2', '0p9CHIRDay2',...
    'CHIRDay3_3h', 'CHIRDay3_6h', 'CHIRDay3_9h', 'CHIRDay2p75_3h', 'CHIRDay2p75_6h', 'CHIRDay2p75_9h',...
    'CHIR0p5Day3_6h', 'CHIR0p5Day3_12h', 'CHIR0p5Day3_24h',...
    'CHIRDay2_3h', 'CHIRDay2_6h', 'CHIRDay2_9h','3hPulses12h21h', '3hPulses18h27h', 'CHIR25FGF0p1Day3',...
    'CHIR25FGF0p3Day3','CHIR25FGF0p5Day3','CHIR25FGF0p7Day3','CHIRDay2p5', 'CHIRDay3', '3hPulse12h15h'};


for i=1:48
figure;
proportionsSim = squeeze(FatesSummary(i,:,:));
colorMatWithValsG(proportionsSim);
set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);
set(gca, 'FontSize',14);
sgtitle(Conditions{i},'FontSize',18);
saveas(gcf,['Predictions_', SaveName{i},'.png']);
end

%%
FatesSummary = zeros(10,7,6);





