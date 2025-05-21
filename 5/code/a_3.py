# 必要なライブラリのインポート
import pandas as pd                # データ操作用（pandasライブラリ）
import matplotlib.pyplot as plt    # グラフ描画用（matplotlibライブラリ）

# 読み込むCSVファイル名を指定
filename = "noise.csv"

# CSVファイルを読み込み
# ・末尾11行は不要な情報としてスキップ（skipfooter=11）
# ・0列目と1列目のみ使用（usecols=[0,1]）
# ・列名を'times'と'voltage'に設定
df = pd.read_csv(filename, skipfooter=11, usecols=[0, 1], names=['times', 'voltage'], engine='python')

# 電圧データのみをNumPy配列として取り出す
data = df['voltage'].values

# ヒストグラムの作成（10個のビンに分けて頻度をカウント）
n, bins, _ = plt.hist(data, bins=10)

# 軸ラベルの設定
plt.xlabel('Voltage[V]', fontsize=14)   # x軸は「電圧（ボルト）」
plt.ylabel('Counts', fontsize=14)      # y軸は「出現回数（度数）」

# グラフを画像ファイルとして保存（事前に"figure"フォルダを作成しておくこと）
plt.savefig("figure/fig2.png")
