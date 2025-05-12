# グラフの表示,最小二乗法の計算とそれを用いた直線の表示をするコードです.
# julia の使い方はGoogle等で各自で調べてください.
# 不具合,コードが間違っているとうがあったら教えてください.


using CSV
using Plots
using DataFrames
using LinearAlgebra
using Printf


#データの読み込み開始


  # print("ファイル名を入力してください.(~.csv):") #ファイル名入力

  #file_name = String( readline()) 

  #println(file_name) #ファイル名のチェック

  #df = CSV.read(file_name,DataFrame,delim=" ",ignorerepeated=true) #csvのDataFrame化,普通のcsvファイル(excel等)はカンマで区切られているのでdelim=","に変更する.

df = CSV.read("data1.csv", DataFrame, delim=" ", ignorerepeated=true)
df2 = CSV.read("data2.csv",DataFrame)

display(df) #読み込んだデータが間違ってないか確認
display(df2)
# printf("データが間違っていたらnを入力:") #読み込んだデータが間違っていたら終了

#以下でdf[:,1],df[:, 4]の数字部分は自分が使うcsvファイルをみて変える.

x = df[:, 1] #csvファイルの1行目を使っている.
a_r = df[:,2] #左側の半径
a_l = df[:,3] #右側の半径

N = length(x)  #xの大きさ
#y_leng = length(y) #yの大きさ

# errorのやつ
err = df2[:, 1] #誤差10回のやつ
N_err = length(err)


# x_numには0~14までの配列がある. ex)x_num[0]=1,x_num[1]=2,...

# データの読み込み終わり.

#_________________________________________________________

# 直径l_r
l_r = zeros(N)
l2 = zeros(N)

 for i in 1 : N
    l_r[i] = a_l[i] - a_r[i]
    l2[i] = l_r[i] * l_r[i]
 end

 

# データの最良値(ここでは平均を撮ってます.)

ave_x = sum(x) / N 
ave_y = sum(l2) / N 
ave_err = sum(err) / N_err
d_x = zeros(N) #配列xの大きさ(要素の個数)
d_y = zeros(N) #配列yの大きさ(要素の個数)
d_err = zeros(N_err)

# 偏差

for i =  1 : N
    d_y[i] = l2[i] - ave_y
end

for i = 1: N_err
    d_err[i] = err[i] - ave_err
end

sum_dy2 = sum(d_y .^2)
sum_d_err = sum(d_err .^2)
# 標準偏差

σ_y = sqrt(1 * sum_dy2 /(N -1))
σ_err = sqrt(1 * sum_d_err / (N_err -1))

# 標準誤差
σ_ty = σ_y / sqrt(N)
σ_t_err = σ_err / sqrt(N_err)

# ニュートンリングでの誤差
σ_ay = zeros(N) 

for i = 1 : N
    σ_ay[i] = 2 * sqrt(2) * σ_t_err * l_r[i]
end


#___ 誤差σ_a 後で直す

#σ_a = 

#=____________最小二乗法  y=A*x + B のA,Bを求める._____________=#

xy = zeros(N) #xy[i] の定義
σ2_ay =zeros(N) # σ^2の定義

for i = 1 : N
    xy[i] = x[i] * l_r[i]
    σ2_ay[i] = σ_ay[i] * σ_ay[i]
end

#=いろいろな和 =#
sum_xy_σ2 = sum(xy ./ σ2_ay)
sum_1_σ2 = sum(1 ./ σ2_ay)
sum_x_σ2 = sum(x ./ σ2_ay)
sum_y_σ2 = sum(l2 ./ σ2_ay)
sum_x2_σ2 = sum(x .^2 ./ σ2_ay)
sum_xy = sum(x .* l_r)
sum_x = sum(x)
sum_y = sum(l_r)
sum_x2 = sum(x .^2)


function A()
    A = ( (sum_xy_σ2 * sum_1_σ2) - (sum_x2_σ2 * sum_y_σ2) ) / ( (sum_x2_σ2 * sum_1_σ2) - (sum_x_σ2 * sum_x_σ2) )
    return A
end

function B()
    B = ( (sum_x2_σ2 * sum_y_σ2) - (sum_x_σ2 * sum_xy_σ2)) / ( (sum_x2_σ2 * sum_1_σ2) - (sum_x_σ2 * sum_x_σ2))
    return B
end

@show A()

#=
function C()
    C = (N * sum_xy - sum_x * sum_y) / (N * sum_x2 - sum_x^2)
    return C
end

function D()
    D = (sum_y * sum_x2 - sum_x * sum_xy) / (N * sum_x2 - sum_x^2)
    return D
end
=#



plot(x, l2, seriestype = :scatter, label = "Data")
P = plot!(x, A() * x .+ B(), label = "Fit Line")
savefig(P, "te.png")

#わけわからん