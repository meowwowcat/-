using CSV,DataFrames,Plots

file = "data/data1.csv"

df = CSV.read(file, DataFrame,header=["time","temp"])

x = df[:,1]
y = df[:,2]

plt = plot(x,y,
           xlabel = "t  (min)",
           ylabel = "θ (℃)",
           marker=:+,
           mc=:red           
         )

savefig(plt,"fig.png")


