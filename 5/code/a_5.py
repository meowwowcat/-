# 必要なライブラリをインポート
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# 入力ファイル名
filename = "noise.csv"

# データの読み込み
# ・末尾11行は無視
# ・0列と1列のみを読み込む（時刻と電圧）
# ・列名を'times'と'voltage'に指定
df = pd.read_csv(filename, skipfooter=11, usecols=[0,1], names=['times','voltage'], engine='python')

# 電圧データのみ取り出す
data = df['voltage'].values

# 基本統計量を計算
data_num = len(data)                   # データ数
data_min = min(data)                   # 最小値
data_max = max(data)                   # 最大値
data_ave = np.average(data)           # 平均値
data_sig = np.std(data)               # 標準偏差（母標準偏差）
data_usig = np.std(data, ddof=1)      # 不偏標準偏差（標本の標準偏差）

# --- データを分割し、それぞれの標本平均の標準偏差を求める関数 --- #
def splitting_data(data, N):
    data = data
    N = int(N)

    data_num = len(data)                  # 全体のデータ数を取得
    remainder = data_num % N              # Nで割った余りを計算
    cut_num   = int(data_num - remainder) # Nで割り切れる長さに調整
    data_cut  = data[:cut_num]            # 調整後のデータを抽出

    sp_num    = int(cut_num / N)          # 分割後のブロック数
    data_sp   = data_cut.reshape(sp_num, N)  # N個ごとのブロックに分割

    sp_ave_list = np.average(data_sp, axis=-1)                 # 各ブロックの平均を求める
    sp_sig_list = np.std(data_sp, ddof=1, axis=-1) / np.sqrt(N) # 各ブロックの標本平均の標準偏差

    sp_sig = np.std(sp_ave_list, ddof=1)  # 全ブロックの平均値に対する標準偏差（評価用）

    sp_x = np.arange(0, cut_num, N) + (N / 2.)  # 各ブロックの中心点をx軸として返す

    return sp_x, sp_ave_list, sp_sig_list, sp_sig

# N（1ブロックあたりのデータ数）ごとに標準偏差を計算
sig_list = []                                # 結果を格納するリスト
n_list = [5, 10, 20, 50, 100, 200]           # 検討する分割数のリスト

for n in n_list:
    sp_x, sp_ave_list, sp_sig_list, sp_sig = splitting_data(data, n)
    sig_list.append(sp_sig)                 # 分割平均の標準偏差をリストに追加

# 結果のプロット
plt.plot(n_list, sig_list, "ko-")           # 黒丸+線グラフ
plt.xlabel('Number of segments', fontsize=14)
plt.ylabel('Unbiased standard deviation', fontsize=14)
plt.grid(ls='--')
plt.savefig('figure/fig5.png')              # グラフを画像として保存
