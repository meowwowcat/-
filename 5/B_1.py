import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

filename = "noise.csv"

df = pd.read_csv(filename,skipfooter=11,usecols=[0,1],names=['time','voltage'])
data = df['voltage'].values
#data

data_num  = len(data)            #データの個数
data_min  = min(data)            #データの最小値
data_max  = max(data)            #データの最大値
data_ave  = np.average(data)     #平均値の計算
data_sig  = np.std(data)         #標準偏差の計算
data_usig = np.std(data, ddof=1) #不偏標準偏差の計算は引数のddof=1を指定する。

#def: function 

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



N = 100
sp_x, sp_ave_list, sp_sig_list, sp_sig = splitting_data(data, N) #作った関数を呼び出す

#N個ごとに分割した時間変動を誤差込みで描画
plt.errorbar(sp_x, sp_ave_list, yerr=sp_sig_list, fmt='ko') #誤差棒をplotするときはplt.errobar関数を使う
plt.xlabel('Time series data', fontsize=14) #X軸のラベル
plt.ylabel('Voltage / V', fontsize=14)        #Y軸のラベル
plt.grid(ls='--')

plt.savefig('fig6.png')

#___________________________________________________________________________________#

def cal_leastsq(xdata, ydata, sigma):
    """
    与えられたデータに対して最小二乗法を用いて直線のフィットを行い、その結果と誤差を計算する関数
    
    Parameters:
        xdata : numpy.ndarray
            x軸のデータ
        ydata : numpy.ndarray
            y軸のデータ
        sigma : numpy.ndarray
            yの誤差のデータ
        
    Returns:
        a : float
            フィットされた直線の傾き
        b : float
            フィットされた直線の切片
        a_err : float
            フィットされた直線の傾きの誤差
        b_err : float
            フィットされた直線の切片の誤差
        chisq_min : float
            最小のカイ二乗値
    """
    x = sp_x
    y = sp_ave_list
    s = sp_sig_list

    delta = ( (sum((x**2)/(s**2))) * (sum(1./(s**2))) ) - ( (sum(x/(s**2)))**2 )
    a     = ( ( (sum((x*y)/(s**2))) * (sum(1/(s**2))) ) - ( (sum(x/(s**2))) * (sum(y/(s**2))) ) )/delta
    a_err = np.sqrt(sum(1/(s**2))/delta)
    b     = ( sum(x**2/(s**2))*sum(y/(s**2)) - (sum(x*y/(s**2)))*(sum(x/(s**2))) )/delta
    b_err = np.sqrt((sum(x**2/s**2))/delta)
    
    # χ^2_min (最小のカイ二乗値) を計算
    fit_values = a * x + b               #フィットから予測された値
    residuals = (y - fit_values) / sigma #ydataと直線の残差/sigma
    chisq_min = np.sum(residuals**2)     #χ2min

    return a, b, a_err, b_err, chisq_min

xdata = sp_x
ydata = sp_ave_list
sigma = sp_sig_list


a, b, a_err, b_err, chisq_min = cal_leastsq(xdata=xdata, ydata=ydata, sigma=sigma) #作った関数を呼び出す。
print(f'a={a} +- {a_err}')
print(f'b={b} +- {b_err}')
print(f'chi2_min = {chisq_min}')
#換算χ2を計算、パラメータの数が2なので自由度はN - 2
print(f'reduced chi-squared = {chisq_min/(len(ydata)-2)}')

#plot
y_fit_data = a * xdata + b
plt.errorbar(xdata, ydata, yerr=sigma, fmt='ko', label='data')
plt.plot(xdata, y_fit_data, 'r-', label='fit results')
plt.xlabel(r'$\rm xdata$', fontsize=14)
plt.ylabel(r'$\rm ydata$', fontsize=14)
plt.legend(fontsize=14)
plt.grid(ls='--')

plt.savefig('fig.png')