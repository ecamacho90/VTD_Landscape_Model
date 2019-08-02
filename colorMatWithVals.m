function colorMatWithVals(mat)
%Prints matrix with values and corresponding landscape coloured background
 
    % code found at
    % http://stackoverflow.com/questions/3942892/how-do-i-visualize-a-matrix-with-colors-and-values-displayed
    sizeX = size(mat,2);
    sizeY = size(mat,1);

    Colors = [0 0 1; 0 1 0; 1 0 1; 0 1 1; 0 0 0];
    auxmat = repmat([1,2,3,4,5],sizeY,1);
    imagesc(auxmat,'AlphaData', mat, 'AlphaDataMapping', 'scaled');
    colormap(Colors);
    
    textStrings = num2str(mat(:),'%0.2f');  %# Create strings from the matrix values
    for i=1:size(textStrings,1)
        if strcmp(textStrings(i,:),'0.00')
            textStrings(i,:)='    ';
        end
    end
   
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    [x,y] = meshgrid(1:sizeX, 1:sizeY);   %# Create x and y coordinates for the strings
    hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
                    'HorizontalAlignment','center', 'FontSize', 15);
   
    textColors = false(numel(mat),3); %%Choose text color. All black
    for i=1:sizeY
        if mat(i,1)>50 %if blue strong white text
            textColors(i,:) = [true, true, true];
        end
        if mat(i,5)>50 %if black strong white text
            textColors(i+28,:) = [true, true, true];
        end
    end
    set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors
 
%     set(gca,'XTick',1:sizeX,...                         %# Change the axes tick marks
%             'YTick',1:sizeY,...
%             'TickLength',[0 0]);
%         set(gca,'xticklabel',[]);
%         set(gca,'yticklabel',[]);
end