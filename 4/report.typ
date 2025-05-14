#set text(font:"Noto Serif CJK JP")


#set heading(numbering:"1.")
#set page(numbering:"-1-")
#set math.equation(numbering:"(1)",supplement: [Eq.])


#import "@preview/physica:0.9.5": *
#import "@preview/codelst:2.0.2": sourcefile


#show figure.where(kind: table): set figure(supplement: "Table")
#show figure.where(kind: image): set figure(supplement: "Fig. ")

#let is-page(n) = counter(page).get().first() == n

#align(center)[#text(size:18pt)[ニュートンリング]]
#align(right)[24cb062h 菅原明]
#align(right)[共同実験者:24cb077k 原口優希]

= 目的
レンズの凸面と平面ガラスとの間にできた空気の薄層の内外面で反射した光の鑑賞出できたニュートンリングと呼ばれる一群の同心円状の環を用いて凸レンズの曲率半径を求める.
@教科書

= 原理
@fig-1 のように,平面ガラスの上に平凸レンズの凸面を下向きにしてのせ,それらの間に,薄い空気層をつくる.
そこに波長$lambda$の平行光線を平面ガラスに上から入射させると,平凸レンズの下面で反射した光と平面ガラスの上面で反射した光が干渉する.今,平凸レンズと平面ガラスとの間には空気の非常に薄い層があるので,入射光と反射光は平行とみなすことができる.
このとき,光路差$Delta$は空気の層の厚さ$d$の2倍である.
$
Delta = 2 d
$
#figure(
  image("figures/fig_1.png",width: 50%),
  caption:[平面ガラスと平凸レンズの薄い隙間での光の干渉@教科書(p44)]

)<fig-1> 
平凸レンズの凸面の曲率半径を$R$,平凸レンズと平面ガラスとの接触点から光の入射点までの距離を$r$と置くと,
$
r^2 = (2 R - d) d ~ 2 R d
$
となるから,光路差$Delta$は
$
Delta = r^2/ R
$
となる.平面ガラスの上面で反射した光は,空気(疎な媒質)からガラス(みつな媒質)に向かう反射であるから,位相が反転し,光路差$lambda/2$の変化を受ける.
これから2つの反射光が強め合う条件は,$m$を整数として,
$
r^2/R + lambda/2 = m lambda
$
と表せる.ここから$r^2$は
$
r^2 = (2 m - 1)/2 lambda R ,(m = 1,2,3,...)
$<eq-1>
となる.一方,2つの反射光が弱め合う条件は,
$
r^2/R + lambda/2 = (2 m +1) lambda /2
$
なので,$r^2$は
$
r^2 = m lambda R ,(m = 0,1,2,3,...)
$<eq-2>

@eq-1 , @eq-2 に対して,$r$の等しい点,はすべて同等であるから,平凸レンズと平面ガラスの接触点を中心とした環状の干渉縞が現れる.
今,中心位置を正確に特定するのは困難であるから,環の半径ではなく直径を測定する.
@fig-2 のように$m$番目のの環の直径を$l_m$と$m+n$番目の直径$l_(m+n)$を測定し,それらの差を取ると,
$
l^2_(m+n) - l^2_m = 4 n lambda R
$<eq-3>
となる.
@eq-3 より,名環の番号$m$とその直径$l_m$の関係は次のようになる.
$
l^2_m = 4 lambda R m C , (C = "定数")
$
番号$m$と直径の2乗$l^2_m$とが線形関係にあるので,その傾きから曲率半径$R$が求まる.
\
環の直径を15個計測し,最小二乗法を用いて線形の傾きをだし,凸レンズの曲率半径を求める.

#figure(
  image("figures/fig_2.png",width:50%),
  caption:[ニュートンリング@教科書]  
)<fig-2>

= 実験方法
実験装置は@fig-3 のようにおいた.

#figure(
  image("figures/fig_4.jpg",width: 50%),
  caption:[実験装置の配置]
)<fig-3>

- ナトリウムランプをつけ,明るい光が出ているところの高さに,集光レンズ,ハーフミラーをあわせる.
ハーフミラーの角度を調整し,光をレンズ容器に垂直に入るように調整する.
- マイクロメーターを10mmの位置になるように調整する.顕微鏡を覗き,環が15個以上あることを確認する.次に十字線の中心がニュートンリングのほぼ中心に合うように調整(横線が移動方向と平行になるように調整)し,ピントを合わせる.

- 顕微鏡を覗きながら,15番目のかんの暗環に十字線の縦線が接するようにおく.このときのマイクロメーターの値を記録する.

- 一つの暗環の値を記録したら,中心方向にずらし,環番号が小さくなるように,一方向にのみ,動かす.中心を通過したとき,今度は環番号が大きくなるように動かしていく.

- 最後に,位置の読み取り誤差を求めるために,$m=3$の環の一方の位置を10回測定する.

= 結果
環番号$m$と環の直径の二乗$l^2_m$の関係は@fig_5 となる.

#figure(
  image("figures/fig-1.png",width: 80%),
  caption:[環番号と$l^2_m$の関係]
)<fig_5>

となった.ここで最小二乗法を用いて$A = 4 lambda R$ $B = C $を求めると,
$
A = 4 lambda R &=  3.96 plus.minus 0.00\
B = C &=1.00
$
となるので,曲率半径$R$は$lambda$を定めると決まる.今ナトリウムランプの波長は
$ 
 lambda = 5.89 times 10^(-4) ["mm"]
$
を用いる@lambda .
$
  R = 1.68 times 10^3 plus.minus 1.56 ["mm"]
$
が得られた.

#figure(
  image("figures/fig.png",width:80%),
 caption:[測定値と最小二乗法を用いたfit line]
)<fig-6>

= 考察
曲率半径の値の誤差は曲率半径の0.09%の誤差が含まれてた.
環番号と$sigma_i$の値は@table-1 に表す.


#figure(
  caption:figure.caption(
    position: top,
    [環番号と直径の2乗の誤差]),
table(
  
  columns: 15,
  stroke: (x: none),
 table.header(
 [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15]
 ),
[#text(size:8pt)[0.0280]],
[#text(size:8pt)[0.0395]],
[#text(size:8pt)[0.0465]],
[#text(size:8pt)[0.0530]],
[#text(size:8pt)[0.0595]],
[#text(size:8pt)[0.0650]],
[#text(size:8pt)[0.0695]],
[#text(size:8pt)[0.0752]],
[#text(size:8pt)[0.0789]],
[#text(size:8pt)[0.0833]],
[#text(size:8pt)[0.0866]],
[#text(size:8pt)[0.0900]],
[#text(size:8pt)[0.0937]],
[#text(size:8pt)[0.0970]],
[#text(size:8pt)[0.100]],
)
)<table-1>
$sigma_i$は$l^2_m$に比例するので,環番号が大きくなるにつれて誤差が大きくなる.そのため,$delta A$も大きくなる.以上のことから,$delta R$の要因は,$sigma_i$のとり方から発生するものである.

@table-2 において$sigma' - sigma$を見ると数値が大きくなっている.
正しく測定されていれば$sigma,sigma'$は同程度となることから,測定が間違っている,あるいは$sigma,sigma'$の計算が間違っていることになり,誤差推定の妥当性がかなり低いものとなっている.
#figure(
  caption:figure.caption(
    position: top,
    [$sigma,sigma'$の差の絶対値]),
table(
  
  columns: 15,
  stroke: (x: none),
 table.header(
 [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15]
 ),
[#text(size:8pt)[0.32]],
[#text(size:8pt)[0.28]],
[#text(size:8pt)[0.066]],
[#text(size:8pt)[0.19]],
[#text(size:8pt)[0.13]],
[#text(size:8pt)[0.27]],
[#text(size:8pt)[0.19]],
[#text(size:8pt)[0.79]],
[#text(size:8pt)[0.28]],
[#text(size:8pt)[0.57]],
[#text(size:8pt)[0.11]],
[#text(size:8pt)[0.54]],
[#text(size:8pt)[0.47]],
[#text(size:8pt)[0.61]],
[#text(size:8pt)[1.2]],
)
)<table-2>
= 使用したプログラム
juliaのコードです.
#sourcefile(read("lms_v2.jl"),file:"lms_v2.jl")
#figure(
  sourcefile(read("data/data1.csv"),file:"data/data1.csv"),
  caption:[測定した値]
)
#figure(
  sourcefile(read("data/data2.csv"),file:"data/data2.csv"),
  caption:[測定した10回の誤差]
)
#bibliography("bib/bib.bib",title:"参考文献")
