vce = Float64[]
ic = Float64[]

open("40a.dat","r") do file
    for line in eachline(file)
        vals = split(strip(line))
        push!(vce, parse(Float64, vals[1]))
        push!(ic, parse(Float64, vals[2]))
    end
end

x = hcat(ones(length(vce)), vce)
β= x \ ic

intercept = β[1]
slope = β[2]

early_voltage = - intercept / slope

println("early_voltage V_A = ", early_voltage, "V")

using Plots
scatter(vce, ic, label ="Mesured_Data", xlabel="V_CE(V)",ylabel="I_C(mA)")
plot!(vce, x * β, label="Fitted Line")
vline!([early_voltage], label="V_A", linestyle=:dash)

