using CSV
using DataFrames
using Plots
using Printf

df = CSV.read("data/data3.csv",DataFrame)

n = [0,1,2,3,4,5,6,7]
y_1 = df[:,2]
y_2 = df[:,3]

Y = (y_1 .+ y_2) ./ 2

N = length(n)
g = 9.8 #=加速度=#
F = 0.2 .* g .* n

delta = N * sum(F .^2) - sum(F)^2
a = (N * sum(F .* Y) - sum(F) * sum(Y)) / delta
b = (sum(F .^2) * sum(Y) - sum(F .* Y) * sum(F)) / delta

d = 832
l = 400
A = 16
B = 5.008
C = 35.2

E = (d * l^3) / (2 * a * A * B^3 * C)
E = E * 10^6 #=mm^2 -> m^2=#


sigma_a = 1 * sqrt(N / delta)

delta_E = sqrt( (1/d)^2 + (3 * 1 / l)^2 + (sigma_a / a)^2+ (0.05/A)^2 + (3 *0.05/B)^2 + (0.05 / C)^2)
delta_E = delta_E * 10^6


open("data/txt3.txt","w") do io
   println(io,"a =$a")
   println(io,"b =$b")
   println(io,"E =$E")
   println(io,"delta_E =$delta_E")
end



plt = plot(F,Y,
     label="Mesured Line",
     marker=:circle,
     xlabel="Weight[N]",
     ylabel="Scale reading[mm]"
     )
plot!(F,a .* F .+b,label="Fit Line",lw=2)

savefig(plt,"figure/plt3.pdf")
