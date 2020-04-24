function priorvalue=VTD_Landscape_Model_Fitting_v3_EvalPriors(compparamvalue,paramnumber)

if paramnumber==1
    %WNT
    
elseif paramnumber == 2
    %FGF

elseif paramnumber == 3
    %a0
        priorvalue = pdf('Gamma',-compparamvalue,21,0.6);
        
elseif paramnumber == 4
    %b0
        priorvalue = pdf('Gamma',compparamvalue,3.5,0.8);
        
elseif paramnumber == 5
    %c0
        priorvalue =  pdf('Gamma',-compparamvalue,2,2);
elseif paramnumber == 6
    %u0
        priorvalue = pdf('Gamma',-compparamvalue,5.4,4);
elseif paramnumber == 7
    %v0
        priorvalue = pdf('Gamma',compparamvalue,5.2,3);
elseif paramnumber == 8
    %a1
        priorvalue = pdf('Gamma',-compparamvalue,10,0.9);
elseif paramnumber == 9
    %b1
        priorvalue = pdf('Gamma',-compparamvalue,9.2,1);
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
        priorvalue = pdf('Gamma',-compparamvalue,13,0.6); %From fitting Case 3

elseif paramnumber == 14
    %b2
        priorvalue = pdf('Gamma',-compparamvalue,5,0.6); %From fitting Case 3

elseif paramnumber == 15
    %c2
        priorvalue = pdf('Gamma',-compparamvalue,2.4,1.2); %From fitting Case 3

elseif paramnumber == 16
    %u2
        priorvalue = pdf('Uniform',-compparamvalue,40,80); %From fitting Case 3
  
elseif paramnumber == 17
    %v2
        priorvalue = pdf('Gamma',compparamvalue+30,2.7,8.4); %From fitting Case 3
    
elseif paramnumber == 18
    %a3
        priorvalue = pdf('Gamma',-compparamvalue,8,0.5);
elseif paramnumber == 19
    %b3        
        priorvalue = pdf('Gamma',-compparamvalue,40,0.3);

elseif paramnumber == 20
    %c3
        priorvalue = pdf('Normal',-compparamvalue,-1,2.8);
elseif paramnumber == 21
    %u3
        priorvalue = pdf('Gamma',-compparamvalue,2,9);
elseif paramnumber == 22
    %v3
        priorvalue = pdf('Gamma',-compparamvalue+15,5,4);
elseif paramnumber == 23
    %lambda
        priorvalue = pdf('Uniform',compparamvalue,0,72); %pvalue?

elseif paramnumber == 24
    %mu
        priorvalue = pdf('Uniform',compparamvalue,0,10);

elseif paramnumber == 25
    %e1
        priorvalue = pdf('Gamma',compparamvalue,3.125,0.008);

elseif paramnumber == 26
    %e2
        priorvalue = pdf('Gamma',compparamvalue,3.125,0.008);
        
elseif paramnumber == 27
    %alpha
        priorvalue = pdf('Normal',compparamvalue,-8,1);
        
elseif paramnumber == 28
    %gamma
        priorvalue = pdf('Gamma',compparamvalue,4.5,0.5);
        
elseif paramnumber == 29
    %psi
        priorvalue = pdf('Gamma',compparamvalue,2.5,1.5);
        
elseif paramnumber == 30
    %epsilon
        priorvalue = pdf('Gamma',compparamvalue,3,1);
        
elseif paramnumber == 31
    %d0
        priorvalue = pdf('Gamma',-compparamvalue,4,1);
        
elseif paramnumber == 32
    %d1
        priorvalue = pdf('Normal',compparamvalue,0,1);
        
elseif paramnumber == 33
    %d2
        priorvalue = pdf('Normal',compparamvalue,0,1);
        
elseif paramnumber == 34
    %d3
        priorvalue = pdf('Normal',compparamvalue,0,1);        
        
elseif paramnumber == 35
    %D
        priorvalue = pdf('Uniform',compparamvalue,0.05,1);
    
end

