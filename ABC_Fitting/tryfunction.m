function res = tryfunction()

res=0;
x = ones(1,10);

for i=1:10
    y=ones(1,i);
    try
        res=[x;y];
    catch
        return;
    end
end

disp('Termina')