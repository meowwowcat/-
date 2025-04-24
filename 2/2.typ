#set text(font:"Noto Serif CJK JP")
#import "@preview/codelst:2.0.2": sourcecode
#import "@preview/codelst:2.0.2": sourcefile

#align(center)[#text(size:18pt)[基礎物理学実験 第二回レポート]]
#align(right)[24cb062h 菅原明]

= 課題1のグラフ
#image("1.jpg")
直線は$y = 0.986+0.218$.
誤差付きでは$y=(0.986 plus.minus 0.01) + (0.218 plus.minus 0.01)$
= 問題3.37
加速度$a("m/s"^)2$の計算をすると
$
a = (v_2 -  v_1)/t = (0.85 - 0.21)/8.0 = 0.08 ("m/s"^2)
$


いま,$delta a$を計算すると,
$
delta a &= sqrt(((a delta v_1)/(v_2-v_1))^2+((a delta v_2)/(v_2 - v_1))^2 + ((delta t)/t)^2)\
&= 0.08 times sqrt(0.001236) = 8.89 times 10^(-3)
$
であるので,$a$は
$
a = 0.08 plus.minus 0.01 ("m/s"^2)
$
となり,加速度の測定値は理論値と合わない.
= ポアソン分布とガウス分布
ポアソン分布,ガウス分布ともにJuliaを用いてグラフを表示させた.
== ポアソン分布

#figure(
  image("plot.png", width: 80%),
  caption:[平均値10のポアソン分布]
)
#figure(
  sourcefile(read("poisson10.jl"),file:"poisson10.jl"),
  caption:[ポアソン分布のコード]
)

== ガウス分布

#figure(
  image("gaussian_plot.png",width: 80%),
  caption:[平均10,分散10のガウス分布]
)

#figure(
  sourcefile(read("gaussian.jl"),file:"gaussian.jl"),
  caption:[ガウス分布のコード]
)
