function kernelvalue = VTD_Landscape_Model_Fitting_v3_EvalKernels(newparticle,particleprevstep,CovMat)

kernelvalue = mvnpdf(newparticle,particleprevstep,CovMat);