# Ubuntu 24.04 ベースイメージ
FROM ubuntu:24.04

# 環境変数（非対話的インストール）
ENV DEBIAN_FRONTEND=noninteractive
ENV JULIA_VERSION=1.11.5
ENV TYPST_VERSION=v0.13.1

# 必要なツールとフォントをインストール
RUN apt-get update && apt-get install -y \
    wget curl git unzip xz-utils \
    ca-certificates build-essential \
    libglib2.0-0 libxrender1 libfontconfig1 \
    fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

# Julia のインストール
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.11/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar -xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    mv julia-${JULIA_VERSION} /opt/julia && \
    ln -s /opt/julia/bin/julia /usr/local/bin/julia && \
    rm julia-${JULIA_VERSION}-linux-x86_64.tar.gz

# Typst のインストール（静的バイナリ）
RUN wget https://github.com/typst/typst/releases/download/${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz && \
    tar -xf typst-x86_64-unknown-linux-musl.tar.xz && \
    mv typst /usr/local/bin/typst && \
    chmod

