using CSV
using DataFrames
using Plots

df = CSV.read("data/data1.csv",DataFrame)

n = df[:,1]
x_1 = df[:,2]

plt = plot(n,x_1,marker=:circle)

savefig(plt,"test.png")