# グラフの表示,最小二乗法の計算とそれを用いた直線の表示をするコードです.
# julia の使い方はGoogle等で各自で調べてください.
# 不具合,コードが間違っているとうがあったら教えてください.


using CSV
using Plots
using DataFrames
using LinearAlgebra
using Printf


#データの読み込み開始


print("ファイル名を入力してください.(~.csv):") #ファイル名入力

file_name = String( readline()) 

println(file_name) #ファイル名のチェック

df = CSV.read(file_name,DataFrame,delim=" ",ignorerepeated=true) #csvのDataFrame化,普通のcsvファイル(excel等)はカンマで区切られているのでdelim=","に変更する.

display(df) #読み込んだデータが間違ってないか確認

# printf("データが間違っていたらnを入力:") #読み込んだデータが間違っていたら終了

#以下でdf[:,1],df[:, 4]の数字部分は自分が使うcsvファイルをみて変える.

x_num = df[:, 1] #csvファイルの1行目を使っている.
y_l2 = df[:,4] #csvファイルの4行目を使っている.
x_length =  #xの大きさ
y_length =  #yの大きさ


# x_num, y_l2には0~14までの配列がある. ex)x_num[0]=1,x_num[1]=2,...

# データの読み込み終わり.

ave_x = sum(x_num)/ #x_numのすべての和
ave_y = sum(y_l2)/  #y_l2のすべての和

