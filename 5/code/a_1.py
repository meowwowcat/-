# 必要なライブラリのインポート
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# 読み込むCSVファイル名を指定
filename = "noise.csv"

# CSVファイルを読み込む（末尾11行をスキップし、1列目と2列目のみを使用）
# カラム名は 'times', 'voltage' に設定
df = pd.read_csv(filename, skipfooter=11, usecols=[0,1], names=['times','voltage'], engine='python')

# 電圧データをNumPy配列として取得
data = df['voltage'].values 

# 基本的な統計量の計算
data_num = len(data)                     # データの個数
data_min = min(data)                     # 最小値
data_max = max(data)                     # 最大値
data_ave = np.average(data)              # 平均値
data_sig = np.std(data)                  # 標準偏差（母集団）
data_usig = np.std(data, ddof=1)         # 不偏標準偏差（標本用、ddof=1）

# 時系列データのx軸（1から始める連番）
x_data = np.arange(1, data_num + 1, 1)

# 電圧データのプロット（黒線でプロ
