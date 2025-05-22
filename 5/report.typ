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


#align(center)[#text(size:18pt)[ニュートンリング]]
#align(right)[24cb062h 菅原明]

= 目的 
測定をした値には必ず誤差が生じる.
今回は電気回路等で発生する雑音を含んだ電圧データをダウンロード@noise し,それを計算機を用いて解析をし,偶然誤差の性質や誤差伝播法則など誤差を含んだデータの扱い方を習得する.@教科書
データ解析のツールとして今回はPython,Juliaを用いる.

= 原理
== 母集団の平均と標準偏差
母集団の平均値$M$に対し,測定した$i$番目のデータを$d_i$,データの個数を$N$とすると,標準偏差$sigma$は母集団の平均値$M$を用いて,
$
sigma = sqrt((sum^(N)_(i=1) (d_i - M)^2)/N)
$<eq1-1>
で与えられる.しかし,事前に測定値の平均値がわかっておらず,測定データの平均$m$で$M$を代用するとき,平均値と芳醇偏差は
$
m = (sum^(N)_(i=1) d_i)/N
$
$
sigma_s = sqrt((sum^(N)_(i=1) (d_i - m)^2)/(N -1))
$<eq1-2>
で求めることができる.この標準偏差を不変標準偏差といい,分母が$N-1$となっているのは平均値$m$をデータ$d_i$からきめており,$(d_i - m)$の自由度は1減っているからである.
@eq1-1,@eq1-2 の値はデータの数が少なくなると,値が大きくことなくことに注意する.

= 実験方法
今回,自らでデータの測定は行わず配布されたデータ@noise を使用して計算機を用いて解析する.
Pythonを使用する場合は,Google Colaboratory(以下Colab)あるいは,ローカルで仮想環境を作り(参照:https://qiita.com/fiftystorm36/items/b2fd47cf32c7694adc2e),
JupyterあるいはPython3をもちいて解析をする.以前pythonを触ってみた際にJupyterをしようしたので,今回もこれを使用していく.

== 仮想環境の利用@venv
OS: 24.04.2 LTS \
Python 3.9.18\ 
\
今回仮想環境をつくるにあたり,venvというツールをもちいる.プロジェクトディレクトリに移動いて,noiseという今回使用する新しい環境を作る.

#codly(number-format: none)
```
$ cd [project dir]
$ python3 -m noise
```
また,
#codly(number-format: none)
```
$ sourse noise/bin/activate
```
とすることで,仮想環境に入った状態になる.
バージョンの確認は
```
(noise) $ python -V
```
である.パッケージのインストールは,
```
(noise) $ pip install パッケージ名
```

でインストールすることができる.
\
仮想環境を終わらせるには
```
(nose) $ deactivate
```
とすれば良いです.

= Pythonを利用したデータ解析
== 課題A-1,2

#sourcefile(read("code/a_1.py"),file:"code/a_1.py")

=== 説明
このコードはcsvファイルから電圧データを読み込み,実験データの基本的な量(平均値,標準偏差,不偏標準偏差)を計算し,時間経過に沿った電圧の変化をグラフに表示させるコードです.
- pandas,matplotlib,numpyというモジュールをインポートし,pandas,matplotlib,numpyをそれぞれpd,plt,npと略す.
- pandasを用いて,csvを読み込み,不要な行をなくす.
- Numpyを用いて,実験データの基本的な量を計算.
- matplotlibで時間軸に対する電圧変化をプロットし,画像として保存
== 課題A-3
#sourcefile(read("code/a_3.py"),file:"code/a_3.py")
このコードでは電圧データの分布を確認するためにヒストグラムを作成した.電圧の値の分布を10個のピンに分類した.
- plt.histを使って,ヒストグラムを描写する.

== 課題A-4
#sourcefile(read("code/a_4.py"),file:"code/a_4.py")
このコードは,測定された電圧データの分布をヒストグラムとして可視化し,得られたデータにたいし,正規分布をフィッティングしている.

== 課題A-5
#sourcefile(read("code/a_5.py"),file:"code/a_5.py")
このコードは電圧データを一定の点数ごと(5,10,20,50,100,200)に分割し,それぞれのブロックごとに平均値を求める.ここで,平均値の標準偏差を求め,分割数を変化させたときの不偏標準偏差の変化を調べる.
== 課題B-1
#sourcefile(read("code/b_1.py"),file:"code/b_1.py")

= 結果

#figure(
  image("figure/fig1.png"),
  caption:[課題A-1:電圧と時間の関係]
)<fig-1>
@fig-1 から電圧の値は時間に対して,大きな誤差はなく比較的平均値に収まっている.




#bibliography("bib/bib.bib",title:"参考文献")
