# 必要なライブラリの読み込み
import pandas as pd                     # 表形式のデータ処理用
import matplotlib.pyplot as plt         # グラフ描画用
from scipy.stats import norm            # 正規分布（ガウス関数）を扱うためのモジュール
import numpy as np                      # 数値計算用

# 読み込むCSVファイル名
filename = "noise.csv"

# CSVファイルからデータを読み込み
# ・末尾11行を除外（skipfooter=11）
# ・最初の2列（0列と1列）を使用
# ・列名を'times'と'voltage'に設定
df = pd.read_csv(filename, skipfooter=11, usecols=[0,1], names=['times','voltage'], engine='python')

# 電圧データをNumPy配列として抽出
data = df['voltage'].values

# データの基本統計量を算出
data_num = len(data)                   # データ数
data_min = min(data)                   # 最小値
data_max = max(data)                   # 最大値
data_ave = np.average(data)           # 平均値
data_sig = np.std(data)               # 標準偏差（母標準偏差）
data_usig = np.std(data, ddof=1)      # 不偏標準偏差（サンプルからの推定）

# ヒストグラムの描画（相対度数で表示、線のみのスタイル）
# density=True により縦軸は確率密度（合計1）に正規化される
n, bins, _ = plt.hist(data, bins=10, histtype='step', density=True,
                      label='measured value', color='k')

# ガウス関数（正規分布）を描画
x_g = np.linspace(data_min, data_max, 100)    # 最小値～最大値まで100点のx軸データを生成
y_g = norm.pdf(x_g, data_ave, data_usig)      # 平均値と不偏標準偏差に基づく正規分布の確率密度を計算
plt.plot(x_g, y_g, color='r')                 # 赤色の線でプロット

# グリッド線の設定
plt.grid(ls='--')                             # 破線のグリッドを表示

# 軸ラベルの設定
plt.xlabel('Voltage/V', fontsize=14)
plt.ylabel('Relative frequency', fontsize=14)

# 画像ファイルとして保存（事前にfigureフォルダが必要）
plt.savefig('figure/fig4.png')
