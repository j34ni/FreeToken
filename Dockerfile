FROM ghcr.io/j34ni/boslie:x86_64

RUN /opt/conda/envs/boslie/bin/pip install --no-cache-dir \
        torch==2.11.0 \
        --extra-index-url https://download.pytorch.org/whl/cu130

RUN /opt/conda/envs/boslie/bin/pip install --no-cache-dir \
        "freetoken[accel]"

RUN find /opt/conda/envs/boslie/lib/python3.12/site-packages -name direct_url.json -delete \
    && /opt/conda/bin/conda clean -afy

EXPOSE 1919

ENTRYPOINT ["ft"]
CMD ["serve", "--host", "0.0.0.0", "--port", "1919", "--moe-backend", "offload"]
