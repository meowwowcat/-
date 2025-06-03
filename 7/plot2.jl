using Plots
using CSV
using DataFrames

file = "data/frank2.csv"

df = CSV.read(file, DataFrame,)

x = df[:,1]
y = df[:,2]

plt = plot(x, y, 
           xlabel = "Acceleranting Voltage [V]",
           ylabel ="Collected Current [μA]",
           label =:none,
           marker=:+,
           mc=:red,
          )

savefig(plt, "figure/fig2.png")
