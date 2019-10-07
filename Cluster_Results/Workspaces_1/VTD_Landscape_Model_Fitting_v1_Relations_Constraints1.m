function priorOK=VTD_Landscape_Model_Fitting_v1_Relations_Constraints1(paramaux)

priorOK = 0;




%Initial parameters:
%if (paramaux(5)>2*paramaux(3))  &&  (paramaux(10)>2*paramaux(8))&&(paramaux(10)<paramaux(8))  &&  (paramaux(19)<(paramaux(18)-8))
if (paramaux(5)>2*paramaux(3))  &&  (paramaux(10)>paramaux(8))  &&  (paramaux(19)<2*(paramaux(18))) 
    priorOK=1;
end
