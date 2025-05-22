import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import norm #scipyからガウス関数を読み込む

import numpy as np

filename = "noise.csv"

df = pd.read_csv(filename,skipfooter=11, usecols=[0,1], names=['times','voltage'])

data = df['voltage'].values 

data_num = len(data)
data_min = min(data)
data_max = max(data)
data_ave = np.average(data)
data_sig = np.std(data)
data_usig = np.std(data, ddof=1)

n, bins, _ = plt.hist(data, bins=10, histtype='step', density=True, label='measured value', color='k')

#ガウス関数の描画
x_g = np.linspace(data_min, data_max, 100) #dataの最小値から最大値までを100点用意
y_g = norm.pdf(x_g, data_ave, data_usig)   #norm.pdf(x軸データ, 平均値, 不偏標準偏差)
plt.plot(x_g, y_g, color='r')              #colorで色を指定可能
plt.grid(ls='--')
plt.xlabel('Voltage/V', fontsize=14)
plt.ylabel('Relative frequency', fontsize=14)

plt.savefig('figure/fig4.png') 