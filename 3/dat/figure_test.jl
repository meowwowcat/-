
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
      )

# 残りのファイルを追加
for (file, label) in Iterators.drop(file_labels, 1)
    data = CSV.read(file, DataFrame)
    x = data[:, 1]
    y = data[:, 2]
    plot!(plt, x, y, label=label,marker=:circle)
end

# グラフ表示
display(plt)


savefig(plt,"figure_test.pdf")
savefig("figure_test.png")
