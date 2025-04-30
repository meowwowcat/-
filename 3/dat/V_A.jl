
using CSV
using Plots
using DataFrames

# ファイルとラベルの対応表を用意
file_labels = Dict(
    "40a.dat" => "40",
    "80a.dat" => "80",
    "120a.dat" => "120",
    "140a.dat" => "140"
)

# 最初のファイルでプロット初期化
first_file = first(keys(file_labels))
data = CSV.read(first_file, DataFrame)
x = data[:, 1]
y = data[:, 2]
plt = plot(x, y,
      label=file_labels[first_file],
      marker=:circle,
      xlabel="V_CE(V)", 
      ylabel="I_C(mA)", 
      xlims = (-60,10)
      )

# 残りのファイルを追加
for (file, label) in Iterators.drop(file_labels, 1)
    data = CSV.read(file, DataFrame)
    x = data[:, 1]
    y = data[:, 2]
    plot!(plt, x, y, label=label,marker=:circle)
end

f(x) = (6.6-7.8)/(1.0-10.0)* (x-1.0) +6.6
plot!(f,label=:none)
g(x) = (14.4-12.2)/(10-1) * (x-1) + 12.2
plot!(g,label=:none)

h(x) = (25 - 19.0)/ (10-1) * (x-1) + 19
plot!(h,label=:none)
I(x) = (26.4 - 22.2) / (10 -1) * (x- 1) + 22.2
plot!(I,label=:none)

# グラフ表示
display(plt)

savefig("kou2.png")