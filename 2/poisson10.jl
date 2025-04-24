import Pkg

Pkg.add("Distributions")
Pkg.add("Plots")

using Distributions
using Plots

poisson_dist = Poisson(10)

k = 0:25

pmf = pdf.(poisson_dist, k)

bar(k,pmf,
    xlabel = "k (Number of events)",
    ylabel = "Probability",
    legend = false,
    color =:skyblue,
    linecolor =:black
   )

savefig("plot.png")
