function kernelvalue = VTD_Landscape_Model_Fitting_v1_EvalKernels(newparticle,particleprevstep,CovMat)

kernelvalue = mvnpdf(newparticle,particleprevstep,CovMat);