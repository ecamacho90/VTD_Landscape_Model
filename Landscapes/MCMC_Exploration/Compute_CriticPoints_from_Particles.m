load('LandscapesFound_Case3.mat')

CritPointsMatrix = zeros(3,2,Nparticles);
goodparticles = [];
syms x y

for i = 1:Nparticles
    
    disp(num2str(i))
    [critpointsx,critpointsy] = VTD_Landscape_Model_v1_CriticalPoints(NewData(i,:),x,y);
    vector = find(sum(abs(imag(vpa([critpointsx,critpointsy]))),2)==0);
    CritPointsMatrix(:,:,i) = [vpa(critpointsx(vector)),vpa(critpointsy(vector))];
    if length(find(CritPointsMatrix(:,1,i)>=0))==3  
        goodparticles = [goodparticles,i];
            disp(num2str(i))
        CritPointsMatrix(:,:,i)
    end
end

disp('Done')

save('Critic_Points_Particles_Case3')

%%

goodparticles = find(reshape(squeeze(CritPointsMatrix(:,1,:)),1,3000)>=0);

for i=goodparticles
    hold on
    scatter(squeeze(CritPointsMatrix(:,1,i)),squeeze(CritPointsMatrix(:,2,i)));
    pause()
    
end
