import pandas as pd
import matplotlib.pyplot as plt

filename = "noise.csv"

df = pd.read_csv(filename,skipfooter=11, usecols=[0,1], names=['times','voltage'])

data = df['voltage'].values 

n, bins, _ = plt.hist(data, bins=10)
plt.xlabel('Voltage/V', fontsize=14)
plt.ylabel('Counts', fontsize=14)

plt.savefig("figure/fig2.png")