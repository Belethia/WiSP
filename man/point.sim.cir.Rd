\name{point.sim.cir}
\alias{point.sim.cir}
\title{Change-In-Ration Method : Simulation}
\description{
        This function simulates sample objects of class 'sample.cir' and estimates abundance and  related parameters for each simulated sample object.  
}
\usage{
        point.sim.cir(pop.spec, survey.spec, design.spec, B = 99, plot = FALSE, numerical=TRUE, seed=NULL, ...)
}
\arguments{
\item{pop.spec}{population specification; either an object of class 'population' or 'pars.population'}
\item{survey.spec}{survey specification; an object of class 'pars.survey.cir'}
\item{design.spec}{design specification; an object of class 'design.cir'}
\item{B}{number of simulations required}
\item{plot}{if TRUE, a histogram of the group abundance  point estimates obtained from each sample object is produced}
\item{numerical}{If TRUE, estimation is by numerical maximisation of the log likelihood function}
\item{seed}{Number passed to set.seed() to initialise random number generator}
\item{...}{extra plot arguments}
}
\details{
        This function produces samples by simulating surveys from the observation model (using survey.spec) and if pop.spec is of class 'pars.population' from the state model (using pop.spec to generate new populations on each simulation).  

		There are difficulties with this incarnation of the change-in-ratio estimator.  At present, consider the use of \code{\link{two.samp.cir}} and  \code{\link{three.samp.cir}} as alternatives in the two- and three- sample situations.
}
\value{
An object of class point.sim.ce with the following elements:
  \item{est}{A results matrix, each row of which contains the following values:}
    \item{Nhat.grp}{MLE of group abundance}
    \item{Nhat.ind}{MLE of individual abundance (= Nhat.grp * Es)}
    \item{Es}{Estimate of mean group size (simple mean of observed group sizes)}
  
  \item{true}{The true (simulated) values of group abundance, animal abundance and mean group size}
  \item{numerical}{Equal to the argument 'numerical' passed to the function}
  \item{random.pop}{TRUE if population is randomised}
  \item{random.design}{TRUE if design is randomised}
  \item{parents}{Details of WiSP objects passed to function}
  \item{created}{Creation date and time}
  \item{seed}{Equal to the argument 'seed' passed to the function}  
}
\seealso{ 
        \code{\link{setpars.population}},   \code{\link{setpars.survey.rm}}
     	\code{\link{point.est.cir}}, 		\code{\link{set.seed}}
}
\examples{
rm.reg<-generate.region(x.length=100, y.width=50)

rm.dens <- generate.density(rm.reg)
rm.poppars<-setpars.population(density.pop = rm.dens, number.groups = 100, size.method = "poisson",
                               size.min = 1, size.max = 5, size.mean = 1, exposure.method = "beta",
                               exposure.min = 2, exposure.max = 10, exposure.mean = 3, exposure.shape = 0.5,
                               type.values=c("Male","Female"), type.prob=c(0.48,0.52))
rm.pop<-generate.population(rm.poppars)

rm.des<-generate.design.rm(rm.reg, n.occ = 5, effort=c(1,2,3,2,1))
rm.survpars<-setpars.survey.rm(pop=rm.pop, des=rm.des, pmin=0.03, pmax=0.95, improvement=0.05)
rm.samp<-generate.sample.rm(rm.survpars)

#Simulate (randomise population only)
#This make take a couple of minutes.  Press ESC to stop simulations.
cir.sim<-point.sim.cir(pop.spec=rm.poppars, survey.spec=rm.survpars, design.spec=rm.des, B=99,
                       seed=NULL, plot=FALSE)
summary(cir.sim)
plot(cir.sim)
plot(cir.sim, type="hist")
plot(cir.sim, type="box")
}
\keyword{}

