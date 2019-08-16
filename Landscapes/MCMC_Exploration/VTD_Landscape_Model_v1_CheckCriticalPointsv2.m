function priorOK =VTD_Landscape_Model_v1_CheckCriticalPointsv2(critpointsx,critpointsy,CaseLandscape,params)

%We can check the quadrants here too if wanted

priorOK=0;
vector = find(sum(abs(imag(vpa([critpointsx,critpointsy]))),2)==0);
nrealcriticpoints = length(vector);

if CaseLandscape==1
    if nrealcriticpoints == 7
        [Scritpointsx,Ix]=sort(double(critpointsx(vector)));
        [Scritpointsy,Iy]=sort(double(critpointsy(vector(Ix(1:4)))));
        f =@(x,y) x.^4+y.^4-1.5*x^2*y^2+params(1)*x.^2+params(2)*x.*y+params(3)*y.^2+params(4)*x+params(5)*y;
        if f(Scritpointsx(Iy(2)),Scritpointsy(2))<f(Scritpointsx(Iy(3)),Scritpointsy(3))
            priorOK=1;
        end
    end

elseif CaseLandscape==2
    if nrealcriticpoints == 5
        priorOK=1;
        for i=1:nrealcriticpoints
            idxpoint = vector(i);
           if double(critpointsx(idxpoint))<-1 && double(critpointsy(idxpoint))>1
               priorOK=0;
           end
        end
    end   
    
elseif CaseLandscape==3
    if nrealcriticpoints == 3
        priorOK=1;
        for i=1:nrealcriticpoints
            idxpoint = vector(i);
           if double(critpointsx(idxpoint))<=0
               priorOK=0;
           end
        end
    end
  
elseif CaseLandscape==4

    if nrealcriticpoints == 3
        %priorOK=1;
        aux=[0,0];
        for i=1:nrealcriticpoints
            idxpoint = vector(i);
            if  double(critpointsx(idxpoint))<=0 && double(critpointsy(idxpoint))<=0
               aux(1)=1;
           elseif double(critpointsx(idxpoint))>=0 && double(critpointsy(idxpoint))>=0
               aux(2)=1;
           end
           if sum(aux)==2
               priorOK=1;
           end
        end
    end

    
end
