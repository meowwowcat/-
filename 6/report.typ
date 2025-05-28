#set text(font:"Noto Serif CJK JP")


#set heading(numbering:"1.")
#set page(numbering:"-1-")
#set math.equation(numbering:"(1)",supplement: [Eq.])


#import "@preview/physica:0.9.5": *
#import "@preview/codelst:2.0.2": sourcefile
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *


#show: codly-init.with()
#show figure.where(kind: table): set figure(supplement: "Table")
#show figure.where(kind: image): set figure(supplement: "Fig. ")


#import "@preview/pillar:0.3.2"

#set table(inset: (x: 0.8em, y: 0.6em), stroke: none)
#set table.hline(stroke: 0.6pt)
#set table.vline(stroke: 0.6pt)

#let mytable(header, cells, cols: none) = {
    if cols == none {
        table(
            columns: header.len(),
            table.hline(),
            table.header(..header.flatten()),
            table.hline(),
            ..cells,
            table.hline(),
        )
    }
    else {
        table(
            ..pillar.cols(cols),
            columns: header.len(),
            table.hline(),
            table.header(..header.flatten()),
            table.hline(),
            ..cells,
            table.hline(),
        )
    }
}




#align(center)[#text(size:18pt)[ヤング率]]
#align(right)[24cb062h 菅原明]
#align(right)[共同実験者:原口優希]

= 目的
光のてこを用いて金属棒の荷重によるたわみを測定し,ヤング率を求める.

= 原理
@fig-1 のように幅$A$厚さ$B$の試料棒を間隔$l$の支持の上に置く.
中央に荷重$F$をくわえたとき,たわみが生じ$h$だけ下がる.
荷重をかけない補助棒を試料棒と平行におき,その上に鏡を置く.

#figure(
  image("figure/tawa.png",width:70%),
  caption:[試料棒のたわみの様子]
)<fig-1>
== ヤング率
金属などの固体は力を加えると変形し,力を取り除くともとに戻るという弾性変形がおきる.加えた力があまり大きくないとき,フックの法則が成り立つ.いま,
== 光のてこ
試料棒がたわんだとき,@fig-2 のようになる.
このとき鏡と望遠鏡の距離$d$は十分大きいものとして見ることができ,
これより,鏡の傾き$alpha$は,補助棒と試料棒の支点環の距離を$C$とすると,
$
alpha ~ tan(alpha) = h/c
$<eq-1>
だけ回転する.鏡から$d$はなれた望遠鏡の隣にスケールをおく.おもりをおいていないときの読みを$y_0$,おもりを載せたときのスケールの読みを$y$とする.このとき
鏡で反射させたスケールを読むと,鏡が回転したことで,
$
Delta y = y - y_0 =  2 d alpha
$<eq-2>
変化する.@eq-1,@eq-2 からたわみ$h$は
$
h = c/ (2 d) Delta y
$<eq1>
となる.
\
#figure(
  image("figure/teko.jpg",width:70%),
  caption:[光てこの関係図]
)<fig-2>

一方,たわみの大きさ$h$は@eq2 で与えることができる@教科書.
$
h = (F l^3)/(4 E A B^3)
$<eq2>
@eq1,@eq2 からよみ$y$は
$
y = (d l^3)/(2 E A B^3 C) F + y_0
$
となり,力$F$の一次関数となる.この傾き$a$を求めることで,ヤング率
$
E = (d l^3)/(2 K A B^3 C)
$
を求める.

= 実験方法
== 実験装置
- たわみ弾性率測定装置@fg1
- 読み取り望遠鏡
- ものさし 
- メジャー

#figure(
  image("figure/fig-2.png",width:70%),
  caption:[装置の概略図@教科書]
)<fg1>
== 測定
以下の手順を試料棒A,B,Cで行う
- @fg1 のように,試料棒と補助棒を支持のうえにおき,中央に鏡と重りを置く.
- @fg2 のように,望遠鏡を設置し,ものさしを垂直にさす.望遠鏡のピントを合わせる.この際ピントが会いづらいとき,望遠鏡の位置をずらしてみるのが効果的.
- おもりを乗せる前のものさしの値を記録する.目盛りは0.1mmの精度で読み取る.つぎに,分銅を一つずつ載せていき,都度ものさしの値を同様に記録する.分銅を少なくし測定のチェックをする.
分銅はゆっくり置くと,記録しやすい.
- 鏡からものさしまでの距離$d$,支持間の距離$l$を測る.試料棒の幅$A$厚さ$B$をノギスで5点図り平均を出す.試料棒と補助棒の間の距離は鏡の脚の間隔を測定する.

#figure(
  image("figure/sou.png",width:70%),
  caption:[実験装置の配置図@教科書]
)<fg2>
== 計算
今回,傾きを求める際の最小二乗法の計算をするのに,以下のJuliaのプログラムを用いた.
#sourcefile(read("lms_v2.jl"),file:"lms_v2.jl")
=== 説明
分銅w増加していくときの測定値を$y_1$減少していくときを$y_2$とした.
- 1~4行目 モジュールを宣言
- 7行目データの読み込み
- 17行目 $y_1,y_2$の平均値を用いる$ Y[i] = (y_1[i] + y_2[i])/2 $
- 26行目 力$F$の定義 $ F[i] = 0.2 dot n[i] dot g $
- 29行目 $Delta$の定義 $ Delta = N sum_i F^2[i] - (sum_i F[i])^2 $
- 32,33行目 最小二乗法で傾きと切片を求める
$ a = (N sum_i (F[i] dot Y[i]) - sum_i F[i] dot sum_i Y[i]) / Delta $<kou1>
$ b = (sum_i F^2[i] dot sum_i Y[i] - sum_i (F[i] dot Y[i] )dot sum_i F[i]) / Delta $
- 43行目ヤング率の計算 $ E = (d l^3)/(2 a A B^3 C) $<kou2>
- 47行目 標準誤差$sigma_a$ $ sigma_a = 1 dot sqrt(N/Delta) $
- 50行目 誤差の計算
$ (delta E)/E = sqrt( ((delta d)/d)^2 + (3 (delta l)/l)^2 + ((delta a)/a)^2 + ((delta A)/A)^2 +(3 (delta B)/B)^2 + ((delta C)/C)^2)
$
ただし今回は$delta d = delta l =1["mm"],delta A =delta B = delta C = 0.05["mm"]$とする.
- 測定値の図のプロット
- 77行目 フッティング直線のプロット(上書き)
- 80行目 図の保存

= 結果
== 試料棒A
=== 測定値

#figure(caption:figure.caption(
    position: top,
    [試料棒Aの測定値]),
    mytable(
        ([分銅の個数], [増加時の測定値 [mm]], [減少時の測定値 [mm]]),
        (csv("data/da1.csv").flatten()),
    ),
)
#figure(
  image("figure/plt1.png",width:70%),
  caption:[試料棒Bの測定値にフィッティングをしたもの]
)
試料棒の幅$A = 16.00["mm"]$,試料棒の厚み$B = 5.01["mm"]$,試料棒と補助棒の間隔$C=35.20["mm"]$,鏡からものさし$d = 832.00["mm"]$,支持間$l=400["mm"]$

ヤング率(絶対値)は
$
E &= 1.64 dot 10^11 ["N/m"^2]\
E plus.minus Delta E &= 1.64 dot 10^11 plus.minus 7.62 dot 10^9 ["N/m"^2]
$ 
となる.
== 試料棒B
=== 測定値
#figure(caption:figure.caption(
    position: top,
    [試料棒Bの測定値]),
    mytable(
        ([分銅の個数], [増加時の測定値 [mm]], [減少時の測定値 [mm]]),
        (csv("data/da2.csv").flatten()),
    ),
)
#figure(
  image("figure/plt2.png",width:70%),
  caption:[試料棒Bの測定値にフィッティングをしたもの]
)
試料棒の幅$A = 16.00["mm"]$,試料棒の厚み$B = 5.01["mm"]$,試料棒と補助棒の間隔$C=35.20["mm"]$,鏡からものさし$d = 832.00["mm"]$,支持間$l=400["mm"]$

ヤング率(絶対値)は
$
E &= 8.23 dot 10^10 ["N/m"^2]\
E plus.minus Delta E &= 8.23 dot 10^10 plus.minus 2.93 dot 10^9 ["N/m"^2]
$ 
となる.
== 試料棒C
=== 測定値
#figure(caption:figure.caption(
    position: top,
    [試料棒Cの測定値]),
    mytable(
        ([分銅の個数], [増加時の測定値 [mm]], [減少時の測定値 [mm]]),
        (csv("data/da3.csv").flatten()),
    ),
)
#figure(
  image("figure/plt3.png",width:70%),
  caption:[試料棒Bの測定値にフィッティングをしたもの]
)
試料棒の幅$A = 16.00["mm"]$,試料棒の厚み$B = 5.01["mm"]$,試料棒と補助棒の間隔$C=35.20["mm"]$,鏡からものさし$d = 832.00["mm"]$,支持間$l=400["mm"]$


ヤング率(絶対値)は
$
E &= 1.07 dot 10^11 ["N/m"^2]\
E plus.minus Delta E &= 1.07 dot 10^11 plus.minus 4.10 dot 10^9 ["N/m"^2]
$ 
となる.
#pagebreak()
= 考察
#figure(caption:figure.caption(
    position: top,
    [材料の弾性係数@yan]),
table(
  columns: 2,
  table.hline(),
  table.header([材　料], [縦弾性係数（ヤング係数） N/mm^2]),
  table.hline(),
  [鋳鉄], [74,000 ～ 117,000],
  [構造用鋼], [192,000 ～ 200,000],
  [軟鋼], [201,000 ～ 206,000],
  [硬鋼], [206,000],
  [鋳鋼], [172,000 ～ 212,000],
  [特殊鋼], [195,000 ～ 206,000],
  [銅鋳物], [82,000 ～ 88,000],
  [銅合金（一般）], [103,000 ～ 119,000],
  [黄銅], [69,000 ～ 98,000],
  [青銅鋳物], [79,000 ～ 82,000],
  [リン青銅], [93,000 ～ 103,000],
  [洋銀針金], [108,000],
  [モネルメタル], [172,000 ～ 180,000],
  table.hline(),
)
)
教科書@教科書 に載っている値とを比較すると,試料棒はそれぞれ
- A:白金
- B 金
- C:銅
であると予想できる.しかし,Cに関しては誤差が少しばかり大きすぎる.いまほかの文献で調べると,今回銅のヤング率の誤差に収まっている.このことから,参照する資料内で用いられる銅の純度も今回の測定に影響をしていると考えられる.
今回,教科書@教科書 における銅の値に比べて,測定値が小さかった.@kou1 @kou2 から,$E$が大きくなるには$a$が小さくならなければならない.したがって,ものさしを測るさいの測定の精度が上がるほど,$E$の値は大きくなり,求めたいヤング率の値に近づく.
#bibliography("bib/bib.bib",title:"参考文献")
