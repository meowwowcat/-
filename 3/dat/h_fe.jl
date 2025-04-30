using CSV
using DataFrames
using Plots

df = CSV.read("hfe_v2.dat",DataFrame;delim=' ', ignorerepeated=true)

x_1 = df[:, 1]
y = df[:, 2]


plot(x_1,y,label=:none,marker=:circle,
     xlabel="I_B (A)",
     ylabel="I_C (A)")



savefig("h_fe.png")
