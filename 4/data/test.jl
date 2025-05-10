using Statistics
using Plots
using CSV
using DataFrames

df = CSV.read("data1.csv",DataFrame; delim=' ',ignorerepeated=true)

x = df[:,1]
y = df[:,4]

b=cov(x,y) / std(x)^2
a=mean(y)-b*mean(x)
println(b)
println(a)


