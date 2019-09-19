function priorvalue=VTD_Landscape_Model_Fitting_v1_EvalPriors(compparamvalue,paramnumber)

if paramnumber==1
    %WNT
    
elseif paramnumber == 2
    %FGF

elseif paramnumber == 3
    %a0
        priorvalue = pdf('Gamma',-compparamvalue,12,1.1);
        
elseif paramnumber == 4
    %b0
        priorvalue = pdf('Gamma',compparamvalue,3,1);
        
elseif paramnumber == 5
    %c0
        priorvalue = pdf('Gamma',-compparamvalue,2,2);
elseif paramnumber == 6
    %u0
        priorvalue = pdf('Gamma',-compparamvalue,3.7,6);
elseif paramnumber == 7
    %v0
        priorvalue = pdf('Gamma',compparamvalue,3.5,4.5);
elseif paramnumber == 8
    %a1
        priorvalue = pdf('Gamma',-compparamvalue,10,0.9);
elseif paramnumber == 9
    %b1
        priorvalue = pdf('Gamma',-compparamvalue,8.1,1.1);
elseif paramnumber == 10
    %c1
        priorvalue = pdf('Gamma',-compparamvalue,3,1.5);
elseif paramnumber == 11
    %u1
        priorvalue = pdf('Uniform',-compparamvalue,0,50);
elseif paramnumber == 12
    %v1
        priorvalue = pdf('Uniform',compparamvalue,0,50);
elseif paramnumber == 13
    %a2
        priorvalue = pdf('Gamma',-compparamvalue,11.6,0.6); %From fitting Case 3

elseif paramnumber == 14
    %b2
        priorvalue = pdf('Gamma',-compparamvalue,4.8,0.7); %From fitting Case 3

elseif paramnumber == 15
    %c2
        priorvalue = pdf('Gamma',-compparamvalue,2.4,1.2); %From fitting Case 3

elseif paramnumber == 16
    %u2
        priorvalue = pdf('Gamma',compparamvalue,1.22,6.7); %From fitting Case 3
  
elseif paramnumber == 17
    %v2
        priorvalue = pdf('Gamma',compparamvalue,2.4,9.7)-30; %From fitting Case 3
    
elseif paramnumber == 18
    %a3
        priorvalue = pdf('Gamma',-compparamvalue,8,0.5);
elseif paramnumber == 19
    %b3        
        priorvalue = pdf('Gamma',-compparamvalue,36,0.35);

elseif paramnumber == 20
    %c3
        priorvalue = pdf('Normal',compparamvalue,-1,2.8);
elseif paramnumber == 21
    %u3
        priorvalue = pdf('Gamma',-compparamvalue,1.5,12.9);
elseif paramnumber == 22
    %v3
        priorvalue = pdf('Gamma',-compparamvalue,1.55,11.9);
elseif paramnumber == 23
    %lambda
        pvalue = pdf('Uniform',compparamvalue,0,72); 

elseif paramnumber == 24
    %mu
        pvalue = pdf('Uniform',compparamvalue,0,10);

elseif paramnumber == 25
    %e1
        pvalue = pdf('Gamma',compparamvalue,3.125,0.008);

elseif paramnumber == 26
    %e2
        pvalue = pdf('Gamma',compparamvalue,3.125,0.008);
        
elseif paramnumber == 27
    %D
        pvalue = pdf('Uniform',compparamvalue,0.05,1);         
    
end

