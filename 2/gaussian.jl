using Distributions
using Plots

μ= 10
σ²= 10
σ= sqrt(σ²)
normal_dist = Normal(μ,σ)

x = μ-3σ: 0.1 : μ + 3σ
y = pdf.(normal_dist, x)

plot(x,y,
     xlabel = "x",
     ylabel = "Density",
     legend = false,
     linewidth = 2,
     color =:orange,
     fill=(0, :orange, 0.3))

savefig("gaussian_plot.png")
