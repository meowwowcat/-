# Julia code for Specific Heat Calculation (No Heat Correction)
# From Raw Experimental Log Data

# --- 1. 各測定の生データからのパラメータ抽出 ---
# 注: これらの値は、以前の対話で提供された非構造化ログデータから手動で抽出したものです。
#     より複雑なCSVファイルから直接読み込む場合は、CSV.jlなどのパッケージを使用します。

# 各測定の水の質量 (g)
mass_water_g = [184.0, 221.7, 260.3, 297.5]

# コイルの電圧 (V) - 生ログの「コイル, X.X(V)」の部分
coil_voltage_V = [3.5, 3.5, 3.5, 3.5]

# コイルの電流 (A) - 生ログの「コイル, X.X(A)」の部分
coil_current_A = [1.57, 1.58, 1.58, 1.59]

# 加熱開始時間 (分) - 生ログの "t1" の値
heating_start_time_min = [5.0, 5.0, 5.0, 5.0]

# 加熱終了時間 (分) - 生ログの "t2" の値
heating_end_time_min = [16.38, 18.22, 20.23, 22.56]

# 加熱開始時点の温度 (°C) - 生ログの "t1" 時間に対応する温度
# 測定3の開始温度は24.7Cでしたので注意
temp_at_start_C = [24.5, 24.5, 24.7, 24.5]

# 加熱終了時点の温度 (°C) - 生ログの "t2" 時間に対応する温度
temp_at_end_C = [28.4, 28.1, 28.5, 28.5]


# --- 2. Y値 (熱補正なし) の計算 ---

# 各測定のY値を格納する配列を初期化
Y_uncorrected = Float64[]

println("--- 各測定ごとのY値の計算 (熱補正なし) ---")
for i in 1:length(mass_water_g)
    # 加熱時間 (秒) = (終了時間 - 開始時間) * 60
    t_seconds = (heating_end_time_min[i] - heating_start_time_min[i]) * 60

    # 未補正の温度変化 (Δθ) = 終了温度 - 開始温度
    delta_theta_C = temp_at_end_C[i] - temp_at_start_C[i]

    # 供給電力量 (Q) = 電圧 * 電流 * 時間
    Q_joules = coil_voltage_V[i] * coil_current_A[i] * t_seconds

    # Y値の計算 Y = Q / Δθ
    Y_val = Q_joules / delta_theta_C

    push!(Y_uncorrected, Y_val)

    println("測定 ", i, ":")
    println("  水の質量 (M): ", mass_water_g[i], " g")
    println("  加熱時間 (t): ", round(t_seconds, digits=2), " s")
    println("  温度変化 (Δθ): ", round(delta_theta_C, digits=2), " °C")
    println("  供給熱量 (Q): ", round(Q_joules, digits=2), " J")
    println("  Y値 (Q/Δθ): ", round(Y_val, digits=3), " J/°C")
    println("------------------------------------")
end

println("全てのY値 (熱補正なし): ", round.(Y_uncorrected, digits=3))


# --- 3. 最小二乗法による比熱の計算 ---

# データ点の数
n = length(mass_water_g)

# 各種合計値の計算
sum_M = sum(mass_water_g)
sum_Y = sum(Y_uncorrected)
sum_M_squared = sum(mass_water_g.^2)
sum_M_Y = sum(mass_water_g .* Y_uncorrected)

# 傾き a の計算 (これが水の比熱 c_water に相当)
# 公式: a = (n * Σ(MY) - (ΣM)(ΣY)) / (n * Σ(M^2) - (ΣM)^2)
a = (n * sum_M_Y - sum_M * sum_Y) / (n * sum_M_squared - sum_M^2)

# 切片 b の計算 (これがカロリーメーターの熱容量 C_calorimeter に相当)
# 公式: b = (ΣY - a * ΣM) / n
b = (sum_Y - a * sum_M) / n

# --- 結果の表示 ---
println("\n--- 熱補正なしの比熱と熱容量の最終計算結果 ---")
println("回帰直線の方程式: Y = aM + b")
println("傾き (a) = 水の比熱 (c_water): ", round(a, digits=4), " J/(g·°C)")
println("切片 (b) = カロリーメーターの熱容量 (C_calorimeter): ", round(b, digits=3), " J/°C")