FROM ghcr.io/astral-sh/uv:bookworm-slim

ENV UV_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
ENV UV_PYTHON_INSTALL_MIRROR=file:///tmp/uv-python

# 先复制到 /tmp/uv-python
COPY cpython-3.13.7+20250902-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz \
     /tmp/uv-python/cpython-3.13.7+20250902-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz

# 再建 20250902 目录并移动
RUN mkdir -p /tmp/uv-python/20250902 && \
    mv /tmp/uv-python/cpython-3.13.7+20250902-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz \
       /tmp/uv-python/20250902/

ADD . /app
WORKDIR /app
RUN uv sync 
CMD ["uv", "run", "start_proxy.py"]