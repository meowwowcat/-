using CSV
using DataFrames
using Plots

gr()

df = CSV.read("data1.csv",DataFrame; delim=' ', ignorerepeated=true)

x = df[:,1]
y = df[:,4]

plt = plot(x,y,
       label=:none,
       xlabel="Number",
       ylabel="\$l^2\$"
      )


savefig("fig.png")
savefig("fig.pdf")
