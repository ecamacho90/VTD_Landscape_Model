function [fatesT,ColorsT]=computefates_signs(XT)
    %Assign fates depending on the sign of its components (++, +-, -+,--) 
    %+Epiblast around initial condition
    global ModelParam;
    NumCells=size(XT,3);
    NumDays = size(XT,2);
    fatesT = zeros(NumDays, NumCells,1);
    ColorsT = zeros(NumDays, NumCells,3);
    for j=1:NumDays
        for i=1:NumCells
            X=squeeze(XT(:,j,i));
            if norm(X-ModelParam.y0)<3 
                fates=1;%Epiblast
                Colors = [0 0 1];
            else

               if X(1)>0
                  if X(2)>0
                      fates=4;%Mesoderm
                      Colors = [0 1 1];
                  else
                      fates=3;%Posterior Neural
                      Colors = [1 0 1];
                  end
               else
                   if X(2)>0 %Anterior Neural
                      fates=2;
                      Colors = [0 1 0];
                  else
                      fates=5; %NMP
                      Colors = [0 0 0];
                  end 
               end
            end
            ColorsT(j,i,:) = Colors;
            fatesT(j,i,:) = fates;
        end
        
    end
end