import pandas as pd
import matplotlib.pyplot as plt
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



#それぞれの値を表示する。
print(f"Number of data = {data_num}")               #データの個数
print(f"Maximum value = {data_max}")                #データの最大値
print(f"Minimum value = {data_min}")                #データの最小値
print(f"Average value of data = {data_ave}")        #平均値
print(f"Standard Deviation = {data_sig}")           #標準偏差
print(f"Unbiased Standard Deviation = {data_usig}") #不偏標準偏差


x_data = np.arange(1, data_num+1, 1)

plt.plot(x_data, data, color='k')
plt.xlabel('Time series data[sec]', fontsize=14)
plt.ylabel('voltage [V]', fontsize=14)
plt.legend(['Voltage values'], fontsize=14)
plt.grid()

plt.savefig('figure/fig1.png')
