
using Plots

x = [24.4,28.4]
y = [-0.1,0.1]

plot(x,y,
    xlabel = "Temperature (℃)",
    ylabel = "Cooling per minute (℃)",
    marker=:+,
    mc=:red,
    xlims = (23,29),
    ylims = (-0.2,0.2),
    label =:none
   )

# line
 a = (y[2] - y[1])/(x[2] - x[1])
 b = y[1] - a * x[1]

 x_line = LinRange(x[1]-0.1, x[2]+0.1,100)
 y_line = a .* x_line .+ b

 plot!(x_line,y_line,label =:none)

function f(x)
    f = a .* x + b
return f
end

using CSV,DataFrames

file1 = "data/data1.csv"

df = CSV.read(file1, DataFrame, header=["time","temp"])

time = df[:,1]
temp = df[:,2]




