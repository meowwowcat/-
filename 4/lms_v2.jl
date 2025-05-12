# 最小二乗法の計算とそれを用いた直線の表示をするコードです.
# コードa けずに

using CSV
using Plots
using DataFrames
using Printf

λ = 5.89*10^(-4)

# データの読み込み

df1 = CSV.read("data/data1.csv", DataFrame, delim=" ", ignorerepeated=true)
df2 = CSV.read("data/data2.csv",DataFrame)

x = df1[:, 1] #number1~15
a_r = df1[:, 2] #r_r
a_l = df1[:,3] #r_l
err = df2[:,1] # 誤差データ（10個）

N =length(x)
N_err = length(err)

#l2

l = a_l - a_r
y = l .* l

# 標準偏差σ_a
ave_err = sum(err) / N_err
d_err = err .- ave_err
σ_a = sqrt(sum(d_err .^2) / (N_err -1))

#標準誤差σ_i
σ_i = 2 .* sqrt(2) .*σ_a .* l

σ2_i = σ_i .^2


# 最小二乗法
sum_1_σ2 = sum(1 ./ σ2_i) 
sum_x_σ2 = sum(x ./ σ2_i)
sum_y_σ2 = sum(y ./ σ2_i)
sum_x2_σ2 = sum( (x .^2) ./ σ2_i)
sum_y2_σ2 = sum( (y .^2) ./ σ2_i)
sum_xy_σ2 = sum((x .* y) ./ σ2_i)

# A,Bの計算

denominator = sum_x2_σ2 * sum_1_σ2 - sum_x_σ2^2

A = (sum_xy_σ2 * sum_1_σ2 - sum_x_σ2 * sum_y_σ2) / denominator
B = (sum_x2_σ2 * sum_y_σ2 - sum_x_σ2 * sum_xy_σ2) / denominator

R = A /(4 * λ)

println("A = $A")
println("B = $B")
println("R = $R")

open("data/data3.txt","w") do io
    println(io, "A = $A")
    println(io, "B = $B")
    println(io, "R = $R")
end


#グラフのプロット

plt = plot(
    x,y,
    label = "",
    xlabel="Number",
    ylabel="\$l^2\$",
    marker=:circle
    
)
plot!(x, A .* x .+ B, label="Weighted Fit Line", lw=2)

savefig( "figures/fig.pdf")