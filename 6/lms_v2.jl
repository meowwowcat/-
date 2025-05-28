using CSV
using DataFrames
using Plots
using Printf

# CSVファイルを読み込み、データフレームとして取得
df = CSV.read("data/data3.csv", DataFrame)

# 荷重を表す配列（0〜7まで）
n = [0, 1, 2, 3, 4, 5, 6, 7]

# データの2列目と3列目を取得（複数回の計測値と仮定）
y_1 = df[:, 2]
y_2 = df[:, 3]

# 計測値の平均をとってYとする
Y = (y_1 .+ y_2) ./ 2

# データ点の数
N = length(n)

# 重力加速度 [m/s^2]
g = 9.8

# 質量[n] から力F [N] を計算
F = 0.2 .* g .* n  # 0.2kg単位の荷重をかけていると仮定

# 最小二乗法のための共通項 delta を計算
delta = N * sum(F .^ 2) - sum(F)^2

# 傾きaと切片bを最小二乗法で求める
a = (N * sum(F .* Y) - sum(F) * sum(Y)) / delta
b = (sum(F .^ 2) * sum(Y) - sum(F .* Y) * sum(F)) / delta

# 以下はヤング率Eの計算に必要な定数（装置の仕様）
d = 832   # 望遠鏡と鏡の距離 [mm]
l = 400   # 支持間距離 [mm]
A = 16    # 幅 [mm]
B = 5.008 # 厚さ [mm]
C = 35.2  # [mm]

# ヤング率 E を計算（式はたわみの公式に基づく）
E = (d * l^3) / (2 * a * A * B^3 * C)
E = E * 10^6  # mm^2 -> m^2 に変換（ヤング率の単位調整）

# aの標準誤差の近似値
sigma_a = 1 * sqrt(N / delta)

# ヤング率の誤差の合成（誤差伝播式）
delta_E = E * sqrt(
    (1/d)^2 + 
    (3 * 1 / l)^2 + 
    (sigma_a / a)^2 + 
    (0.05 / A)^2 + 
    (3 * 0.05 / B)^2 + 
    (0.05 / C)^2
)
delta_E = delta_E * 10^6  # 単位変換

# 結果をテキストファイルに出力
open("data/txt3.txt", "w") do io
    println(io, "a =$a")
    println(io, "b =$b")
    println(io, "E =$E")
    println(io, "delta_E =$delta_E")
end

# 実測値とフィッティング直線をプロット
plt = plot(F, Y,
    label="Mesured Line",
    marker=:circle,
    xlabel="Weight[N]",
    ylabel="Scale reading[mm]"
)

# フィッティング直線を上に重ねる
plot!(F, a .* F .+ b, label="Fit Line", lw=2)

# プロットをPDFとして保存
savefig(plt, "figure/plt3.pdf")
