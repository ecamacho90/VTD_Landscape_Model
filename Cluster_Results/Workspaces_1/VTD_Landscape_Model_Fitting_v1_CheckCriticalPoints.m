
function priorOK=VTD_Landscape_Model_Fitting_v1_CheckCriticalPoints(critpointsx,critpointsy,CaseLandscape,params)


%We can check the quadrants here too if wanted

if isempty(critpointsx)
    priorOK=0;

else
    critpointsrewritten = vpa([critpointsx,critpointsy]);
    vector = find(sum(abs(imag(critpointsrewritten)),2)==0);
    nrealcriticpoints = length(vector);
    priorOK=0;

    if CaseLandscape==1
        if nrealcriticpoints == 7
            [Scritpointsx,Ix]=sort(double(critpointsx(vector)));
            [Scritpointsy,Iy]=sort(double(critpointsy(vector(Ix(1:4)))));
            f =@(x,y) x.^4+y.^4-1.5*x^2*y^2+params(1)*x.^2+params(2)*x.*y+params(3)*y.^2+params(4)*x+params(5)*y;
            if f(Scritpointsx(Iy(2)),Scritpointsy(2))<f(Scritpointsx(Iy(3)),Scritpointsy(3))
                priorOK=1;
            end
%             scatter(critpointsrewritten(vector,1),critpointsrewritten(vector,2),'filled','MarkerEdgeColor','k','MarkerFaceColor','k')
%             hold on
        end

    elseif CaseLandscape==2
        if nrealcriticpoints == 5
            priorOK=1;
            condition1 = find((critpointsrewritten(vector,1)<-1));
            if ~isempty(condition1)
                condition2 = find((critpointsrewritten(condition1,2)>1));
                if ~isempty(condition2)
                    priorOK=1;

               end
            end
        end 

    elseif CaseLandscape==3
        if nrealcriticpoints == 3
            condition1=find(critpointsrewritten(vector,1)<=0);
               if isempty(condition1)
                   priorOK=1;
               end
        end

    elseif CaseLandscape==4
        if nrealcriticpoints == 3
            condition1 = find(critpointsrewritten(vector,1).*critpointsrewritten(vector,2)>=0);
            if length(condition1)>=2
                condition2 = length(find(critpointsrewritten(vector(condition1),1)>0));
                condition3 = length(find(critpointsrewritten(vector(condition1),1)<0));
                if (condition2>=1)&&(condition3>=1)
                priorOK=1;
                end
            end
        end


    end
end
