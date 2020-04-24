function pvalue=VTD_Landscape_Model_Fitting_v3_Priors(paramnumber)

if paramnumber==1
    %WNT
    
elseif paramnumber == 2
    %FGF

elseif paramnumber == 3
    %a0
        %pvalue = -random('Gamma',10,0.9);
        %pvalue = -random('Gamma',12,1.1);%% 50% with height saddles
         pvalue = -random('Gamma',21,0.6);%% 80% -> 40% with height saddles

elseif paramnumber == 4
    %b0
        %pvalue = random('Gamma',3.5,1.5);
        %pvalue = random('Gamma',3,1);
        pvalue = random('Gamma',3.5,0.8);
        
elseif paramnumber == 5
    %c0
        pvalue = -random('Gamma',2,2);
elseif paramnumber == 6
    %u0
        %pvalue = -random('Uniform',0,50);
        %pvalue = -random('Gamma',3.7,6);
        pvalue = -random('Gamma',5.4,4);
        
elseif paramnumber == 7
    %v0
        %pvalue = random('Uniform',0,50);%%12%
        %pvalue = random('Gamma',3.5,4.5);
        pvalue = random('Gamma',5.2,3);
        
elseif paramnumber == 8
    %a1
        pvalue = -random('Gamma',10,0.9);
elseif paramnumber == 9
    %b1
        %pvalue = -random('Gamma',8.1,1.1);
        pvalue = -random('Gamma',9.2,1);
elseif paramnumber == 10
    %c1
        pvalue = -random('Gamma',3,1.5);
elseif paramnumber == 11
    %u1
        pvalue = -random('Uniform',0,50);
elseif paramnumber == 12
    %v1
        pvalue = random('Uniform',0,50);
elseif paramnumber == 13
    %a2
        %pvalue = -random('Gamma',10,0.9);
        %pvalue = -random('Gamma',11.6,0.6); %From fitting Case 3
        pvalue = -random('Gamma',13,0.6);
        
elseif paramnumber == 14
    %b2
        %pvalue = -random('Gamma',3.5,1.5);
        %pvalue = -random('Gamma',4.8,0.7); %From fitting Case 3
         pvalue = -random('Gamma',5,0.6);
         
elseif paramnumber == 15
    %c2
        %pvalue = -random('Gamma',2,2);
        pvalue = -random('Gamma',2.4,1.2); %From fitting Case 3

elseif paramnumber == 16
    %u2
        %pvalue = -random('Uniform',0,50);
        %pvalue = -random('Uniform',40,80);
        %pvalue = random('Gamma',2,6)-50;
%         pvalue = random('Gamma',1.22,6.7); %From fitting Case 3
        pvalue = -random('Uniform',40,80);
        
elseif paramnumber == 17
    %v2
        %pvalue = random('Uniform',-30,30);
        %pvalue = random('Gamma',2.5,5)-20; %%70%
        %pvalue = random('Normal',0,15);
        %pvalue = random('Gamma',2.4,9.7)-30; %From fitting Case 3
        pvalue = random('Gamma',2.7,8.4)-30;
        
elseif paramnumber == 18
    %a3
        pvalue = -random('Gamma',8,0.5);
elseif paramnumber == 19
    %b3        
        %pvalue = -random('Gamma',36,0.35);
        pvalue = -random('Gamma',40,0.3);
        
elseif paramnumber == 20
    %c3
        %pvalue = random('Normal',0,3);
        pvalue = random('Normal',-1,2.8);
elseif paramnumber == 21
    %u3
        %pvalue = -random('Uniform',0,50);
        %pvalue = -random('Gamma',1.5,12.9);
        pvalue = -random('Gamma',2,9);
elseif paramnumber == 22
    %v3
        %pvalue = -random('Uniform',0,50);
        %pvalue = -random('Gamma',4,5)+15;
        %pvalue = -random('Gamma',1.55,11.9);
        pvalue = -random('Gamma',5,4)+15;
        
elseif paramnumber == 23
    %lambda
        pvalue = random('Uniform',0,72);

elseif paramnumber == 24
    %mu
        pvalue = random('Uniform',0,10);

elseif paramnumber == 25
    %e1
        pvalue = random('Gamma',3.125,0.008);

elseif paramnumber == 26
    %e2
        pvalue = random('Gamma',3.125,0.008);
        
elseif paramnumber == 27
    %alpha
        pvalue = random('Normal',-8,1);
        
elseif paramnumber == 28
    %gamma
        pvalue = random('Gamma',4.5,0.5);
        
elseif paramnumber == 29
    %psi
        pvalue = random('Gamma',2.5,1.5);
        
elseif paramnumber == 30
    %epsilon
        pvalue = random('Gamma',3,1);
        
elseif paramnumber == 31
    %d0
        pvalue = -random('Gamma',4,1);
        
elseif paramnumber == 32
    %d1
        pvalue = random('Normal',0,1);
        
elseif paramnumber == 33
    %d2
        pvalue = random('Normal',0,1);
        
elseif paramnumber == 34
    %d3
        pvalue = random('Normal',0,1);        
        
elseif paramnumber == 35
    %D
        pvalue = random('Uniform',0.05,1);       
    
end


    
    
  