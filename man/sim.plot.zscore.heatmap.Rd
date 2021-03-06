\name{sim.plot.zscore.heatmap}

\alias{sim.plot.zscore.heatmap}

\title{Association heatmap from z-scores}

\description{
	Produces an association heatmap that shows the association (standardized influence) of 
 each independent feature (expression measurement) with each dependent feature 
 (copy number measurement). A P-value bar on the left indicates test signficance. 
 A color bar on top indicates genes with mean z-scores across the signficant copy 
 number probes above a set threshold. A summary of the copy number data helps to identify 
 what copy number alterations are present in a region of association with expression. 
 Positive association can mean copy number gain and increased expression, or deletion and 
 decreased expression. The heatmaps can also be used in an exploratory analysis, 
 looking for very local effects of copy number changes (usually small amplifications) on 
 gene expression, that do not lead to a significant test result.
}

\usage{
sim.plot.zscore.heatmap(input.regions = "all chrs", 
 		input.region.indep = NULL, 
		method = c("full", "smooth", "window", "overlap"),
		adjust = ~1, 
		significance = 0.2, 
		z.threshold = 3, 
		colRamp = colorRampPalette(c("red", "black", "green")), 
		add.colRamp = colorRampPalette(c("blue", "black", "yellow"))(7),
		show.names.indep = FALSE, 
		show.names.dep = FALSE,
		adjust.method = "BY", 
		scale, 
		add.scale,
		add.plot = c("smooth", "none", "heatmap"), 
		smooth.lambda = 2,		
		pdf = TRUE,		
		run.name = "analysis_results",...)
}

\arguments{
	\item{input.regions}{\code{vector} indicating the dependent regions to be analyzed. Can be defined in four ways:
  	      \code{1) predefined input region: } insert a predefined input region, choices are: 
  	      \dQuote{all chrs}, 
  	      \dQuote{all chrs auto}, 
  	      \dQuote{all arms}, 
  	      \dQuote{all arms auto} 
  	      In the predefined regions \dQuote{all arms} and \dQuote{all arms auto} the arms 13p, 14p, 15p, 21p and 22p 
  	      are left out, because in most studies there are no or few probes in these regions. 
  	      To include them, just make your own vector of arms. 
  	      \code{2) whole chromosome(s): } insert a single chromosome or a list of chromosomes as a 
  	      \code{vector:} 
  	      \code{c(1, 2, 3)}. 
  	      \code{3) chromosome arms: } insert a single chromosome arm  or a list of chromosome arms like 
  	      \code{c("1q", "2p", "2q")}.
  	      \code{4) subregions of a chromosome: } insert a chromosome number followed by the start and end position like 
  	      \code{"chr1:1-1000000"} 
  	      These regions can also be combined, e.g. \code{c("chr1:1-1000000","2q", 3)}.
  	      See \code{\link{integrated.analysis}} for more information.}  
	
  	\item{input.region.indep}{indicating the independent region which will be analysed in combination of the dependent 
                              region. Only one input region can given using the same format as the dependent input region.}
  	
  	\item{method}{this must be the either full, window, overlap or smooth but the data should generated by the 
         same method in \code{integrated.analysis}.}
  	  
  	\item{adjust}{This variable must be a vector with the same length as \code{samples} or FALSE. The 
  				  vector will be transformed to a factor and the levels of this will be coloured according to 
                  their subtype. When \code{subtype=FALSE}, all the samples will be coloured black.}
  
  	\item{significance}{The threshold for selecting significant P-values.}

  	\item{z.threshold}{Threshold to display a green or red bar in the color bar on top of 
                       the heatmap for independent features with mean z-scores above \code{z.threshold} (high positive 
                       association) or below \code{-z.threshold} (high negative association).}

	\item{colRamp}{Palette of colors to be used in the heatmap.}
	
	\item{add.colRamp}{Palette of colors to be used in the added plot.}
		

 	\item{show.names.indep}{\code{logical} if set to TRUE, displays the names (\code{indep.id} and \code{in
                            dep.symb} entered in the \code{\link{assemble.data}}) of the independent features with mean z-scores above or 
                            below the \code{z.threshold} in the heatmap.}

  	\item{show.names.dep}{\code{logical} if set to TRUE, displays the names (\code{dep.id} and \code{dep.sy
                          mb} entered in the \code{\link{assemble.data}}) of the \code{significant} dependent features in the heatmap.}

	\item{adjust.method}{Method used to adjust the P-values for multiple testing, see \link[stats:p.adjust]{p.adjust}.
         Default is "BY" recommended when copy number is used as dependent data. 
         See \link{SIM} for more information about adjusting P-values.}
   
  	\item{scale}{Vector specifying the color scale in the heatmap.
    If scale="auto", the maximum and minimum value of all z-scores will be calculated 
    and set as the limits for all analyzed regions. Another option is to define a custom scale, 
    e.g. scale = c(-5,5).}

 	\item{add.scale}{Vector specifying the color scale in the left plot near the heatmap.
    If scale="auto", the maximum and minimum value of all the values will be calculated 
    and set as the limits for all analyzed regions. Another option is to define a custom scale, 
    e.g. scale = c(-5,5).}
    
  	\item{add.plot}{Summary plot of copy number data in left panel. Either \code{"smooth"},\code{"heatmap"}, or \code{"none"}. The \code{"smooth"} plot smoothes the copy number log ratios 
                    per sample, see \link[quantsmooth]{quantsmooth} for more details. The \code{"heatmap"} method produces 
                    an aCGH heatmap where green indicates gain, and red loss. The scale of the aCGH heatmap 
                    is automatically set to the min and max of the aCGH measurements of the analyzed regions. 
                    Default is plot.method = \code{"none"}, no additional plot will be drawn.}

  	\item{smooth.lambda}{Numeric value, specifying the quantile smoothing parameter for 
                         \code{plot.method="smooth"}. See \link[quantsmooth]{quantsmooth} and \code{references} for more information.}
  
   	\item{pdf}{\code{logical}; indicate whether to generate a pdf of the plots in the current working directory or not.}
   	
   	\item{run.name}{This must be the same a given to \code{integrated.analysis}}

	\item{...}{not used in this version}
}

\details{
	The \code{sim.plot.zscore.heatmap} function can only run after the \link{integrated.analysis} 
is run with \code{zscores = TRUE}.

The results are returned as a single-page pdf containing an association heatmap of the regions 
listed in \code{input.regions}. For high-density arrays large files will be produced, both 
demanding more memory available from your computer to produce them as well as being heavier to 
open on screen. To avoid this, analyze chromosome arms as units instead of chromosomes, both 
here and in \code{input.regions = "all arms"}. 
  
The heatmap contains the z-scores generated by the function \link{integrated.analysis} with 
\code{zscores=TRUE}. The dependent features are plotted from bottom to top, the independent 
features from left to right. Positive associations are shown in green, negative associations in red 
(color scale on the right). At the left side of the heatmap a color bar represents the 
multiple testing corrected P-values of the probes in the dependent data (copy number), also  
with a color legend. Dependening on which \code{plot.method} is used, a summary of copy number 
changes is shown on the left. At the top of the heatmap is a color bar corresponding to 
the mean z-scores of the independent features (expression data) that are above or below 
the \code{z.threshold}. If \code{show.names.indep} is set to TRUE, labels will be drawn for 
the probes with mean z-scores greater than \code{z.threshold} or lower than \code{-z.threshold} 
at the bottom of the heatmap. If \code{show.names.dep} is set to TRUE, labels will be drawn for 
the significant dependent probes lower than \code{significance} to the right of the heatmap.


}
\value{
	No values are returned. The results are stored in a subdirectory of \code{run.name} as pdf.
}

\references{
Eilers PH, de Menezes RX. 2005 Apr 1, 
Quantile smoothing of array CGH data. 
\emph{Bioinformatics}, \bold{21}(7):1146-53.
 
Wang P, Kim Y, Pollack J, Narasimhan B, Tibshirani R. 2005, 
A method for calling gains and losses in array CGH data. 
\emph{Biostatistics}, \bold{6} :45-58.
}

\author{Marten Boetzer, Melle Sieswerda, Renee X. de Menezes  \email{R.X.Menezes@lumc.nl}}

\seealso{
\link{SIM}, 
\link{tabulate.pvals}, 
\link{tabulate.top.dep.features}, 
\link{tabulate.top.indep.features},
\link{sim.plot.overlapping.indep.dep.features}
}


\examples{
#first run example(assemble.data)
#and example(integrated.analysis)

#plot the zscores in a heatmap
sim.plot.zscore.heatmap(input.regions = "8q",  adjust.method = "BY", 
                        run.name = "chr8q", pdf = FALSE)

sim.plot.zscore.heatmap(input.regions = "8q", 
                        method="full", 
                        significance = 0.05,
                        z.threshold = 1, 
                        colRamp = colorRampPalette(c("red", "black", 
                           "green"))(15), 
                        show.names.indep=TRUE, 
                        show.names.dep=TRUE, 
                        adjust.method = "holm",  
                        add.plot = "heatmap", 
                        smooth.lambda = 2,        
                        pdf = FALSE,            
                        run.name = "chr8q")
                        
sim.plot.zscore.heatmap(input.regions = "8q", 
                        method="full", 
                        significance = 0.05,                        
                        z.threshold = 1,                        
                        show.names.indep = TRUE, 
                        show.names.dep = TRUE,                       
                        add.plot = "none", 
                        smooth.lambda = 2,
                        scale = c(-2, 2),                       
                        pdf = FALSE, 
                        run.name = "chr8q")
}
\keyword{hplot}

