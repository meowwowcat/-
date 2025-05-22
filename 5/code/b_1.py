# 必要なライブラリの読み込み
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# データファイル名の指定
filename = "noise.csv"

# CSVファイルからデータを読み込む（末尾11行をスキップ、0列目と1列目のみ使用）
# カラム名を 'time', 'voltage' に指定
df = pd.read_csv(filename, skipfooter=11, usecols=[0,1], names=['time','voltage'], engine='python')

# 電圧データを NumPy 配列として取り出す
data = df['voltage'].values

# 基本統計量の計算
data_num  = len(data)            # データの個数
data_min  = min(data)            # 最小値
data_max  = max(data)            # 最大値
data_ave  = np.average(data)     # 平均値
data_sig  = np.std(data)         # 標準偏差
data_usig = np.std(data, ddof=1) # 不偏標準偏差（ddof=1 を指定）

# ------------------------------------------------------------------------------------
# 関数: データをN個ずつに分割し、各分割の平均値と誤差を求める
def splitting_data(data, N):
    N = int(N)                          # 分割数を整数化
    data_num = len(data)               # データの総数
    remainder = data_num % N           # 余りを計算
    cut_num   = data_num - remainder   # 端数を切り捨てて使うデータ数を決定
    data_cut  = data[:cut_num]         # 端数を取り除いたデータ
    sp_num    = cut_num // N           # 分割できる回数
    data_sp   = data_cut.reshape(sp_num, N) # N個ずつ行にして2次元配列化

    # 各分割の平均値と標本平均の標準誤差を計算
    sp_ave_list = np.average(data_sp, axis=-1)                      # 各グループの平均値
    sp_sig_list = np.std(data_sp, ddof=1, axis=-1) / np.sqrt(N)    # 各グループの誤差

    # 全体の標準偏差（各平均値のばらつき）を計算
    sp_sig = np.std(sp_ave_list, ddof=1)

    # グラフのx軸用：各平均値の中心位置
    sp_x = np.arange(0, cut_num, N) + (N / 2.)

    return sp_x, sp_ave_list, sp_sig_list, sp_sig

# 分割数を指定し、データの分割・平均・誤差を取得
N = 100
sp_x, sp_ave_list, sp_sig_list, sp_sig = splitting_data(data, N)

# 分割平均とその誤差をエラーバー付きでプロット
plt.errorbar(sp_x, sp_ave_list, yerr=sp_sig_list, fmt='ko') # 'ko' = 黒丸
plt.xlabel('Time series data', fontsize=14)
plt.ylabel('Voltage / V', fontsize=14)
plt.grid(ls='--')
plt.savefig('figure/fig6.png')  # 図の保存

# ------------------------------------------------------------------------------------
# 関数: 最小二乗法で直線フィッティングを行い、パラメータと誤差を求める
def cal_leastsq(xdata, ydata, sigma):
    """
    最小二乗法による直線フィッティングとパラメータ誤差の計算

    Parameters:
        xdata : x軸データ（NumPy配列）
        ydata : y軸データ（平均値）
        sigma : yの誤差（標準誤差）

    Returns:
        a : 傾き
        b : 切片
        a_err : 傾きの誤差
        b_err : 切片の誤差
        chisq_min : 最小カイ二乗値
    """
    x = xdata
    y = ydata
    s = sigma

    # フィッティング係数を計算するためのΔ（分母）
    delta = (np.sum(x**2 / s**2) * np.sum(1 / s**2)) - (np.sum(x / s**2))**2

    # 傾きと切片、およびその誤差を計算
    a = (np.sum(x * y / s**2) * np.sum(1 / s**2) - np.sum(x / s**2) * np.sum(y / s**2)) / delta
    a_err = np.sqrt(np.sum(1 / s**2) / delta)
    b = (np.sum(x**2 / s**2) * np.sum(y / s**2) - np.sum(x * y / s**2) * np.sum(x / s**2)) / delta
    b_err = np.sqrt(np.sum(x**2 / s**2) / delta)

    # フィットの理論値と残差による最小カイ2乗の計算
    fit_values = a * x + b
    residuals = (y - fit_values) / s
    chisq_min = np.sum(residuals**2)

    return a, b, a_err, b_err, chisq_min

# 最小二乗法によるフィッティングを実行
xdata = sp_x
ydata = sp_ave_list
sigma = sp_sig_list

a, b, a_err, b_err, chisq_min = cal_leastsq(xdata, ydata, sigma)

# 結果を出力
print(f'a = {a:.5f} ± {a_err:.5f}')
print(f'b = {b:.5f} ± {b_err:.5f}')
print(f'chi^2 = {chisq_min:.3f}')
print(f'reduced chi^2 = {chisq_min/(len(ydata)-2):.3f}')

# フィット結果の描画
y_fit_data = a * xdata + b
plt.errorbar(xdata, ydata, yerr=sigma, fmt='ko', label='data') # 測定値
plt.plot(xdata, y_fit_data, 'r-', label='fit results')         # フィット線
plt.xlabel(r'$\rm xdata$', fontsize=14)
plt.ylabel(r'$\rm ydata$', fontsize=14)
plt.legend(fontsize=14)
plt.grid(ls='--')

# 最終的な図の保存
plt.savefig('figure/fig.png')
