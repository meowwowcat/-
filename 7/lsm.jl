using Plots 
using CSV
using DataFrames

file = "data/frank2.csv"

df = CSV.read(file,DataFrame,header=["x","y"])

x = df[:,1]
y = df[:,2]

X = zeros(59,11)

X[:,1] = 1
