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

def splitting_data(data, N):
    data = data
    N = int(N)

    data_num = len(data)                    #データの個数の確認
    
    remainder = data_num % N                    #余りを計算
    cut_num   = int(data_num-remainder)
    data_cut  = data[:cut_num]              #データ個数の調整
    sp_num    = int(cut_num/N)             #分割数
    data_sp   = data_cut.reshape(sp_num, N) #N個ごとに分割

    sp_ave_list = np.average(data_sp, axis=-1)             #分割数ごとの平均値を計算
    sp_sig_list = np.std(data_sp, ddof=1, axis=-1)/np.sqrt(N) #分割数ごとの標本平均の標準偏差を計算

    sp_sig = np.std(sp_ave_list, ddof=1)

    #plot用のx軸も用意しておく。
    sp_x = np.arange(0, cut_num, N)+(N/2.)
    
    return sp_x, sp_ave_list, sp_sig_list, sp_sig


sig_list = []
n_list = [5, 10, 20, 50, 100, 200]

for n in n_list:
    sp_x, sp_ave_list, sp_sig_list, sp_sig = splitting_data(data, n) #作った関数を呼び出す
    sig_list.append(sp_sig)

plt.plot(n_list, sig_list, "ko-")
plt.xlabel('Number of segments', fontsize=14)
plt.ylabel('Unbiased standard deviation', fontsize=14)
plt.grid(ls='--')
plt.savefig('figure/fig5.png') 
