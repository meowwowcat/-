using CSV
using DataFrames
using Plots

df = CSV.read("1.dat",DataFrame; delim=' ', ignorerepeated=true)

x_1 = df[:, 1]
x_2 = df[:, 3]
y = df[:, 2]


plot(x_1,y,label="Mesured",marker=:circle,
     xlabel="V_BE(V)",
     ylabel="I_B (μA)")
plot!(x_2,y,label="Correction",marker=:circle)


savefig("exp1_fig.png")
