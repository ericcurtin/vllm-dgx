# Generated from history.txt
# This Dockerfile reconstructs the image from its history

ARG RELEASE
ARG LAUNCHPAD_BUILD_ARCH
LABEL org.opencontainers.image.ref.name=ubuntu
LABEL org.opencontainers.image.version=24.04
ADD file:d77dea5c49828eb0de89439d2b631bc8ea27cb9ef774412b56a060ba1673487b in /
CMD ["/bin/bash"]
ARG JETPACK_HOST_MOUNTS=
ARG ENABLE_MITMPROXY=0
ENV NVIDIA_REQUIRE_JETPACK_HOST_MOUNTS=
RUN if [ -n "${JETPACK_HOST_MOUNTS}" ]; then        echo "/usr/lib/aarch64-linux-gnu/tegra" > /etc/ld.so.conf.d/nvidia-tegra.conf     && echo "/usr/lib/aarch64-linux-gnu/tegra-egl" >> /etc/ld.so.conf.d/nvidia-tegra.conf;     fi
RUN /tmp/manage_cert.sh install
RUN if [ -d /usr/share/ca-certificates ]; then exit; fi  && export DEBIAN_FRONTEND=noninteractive  && apt-get update  && apt-get install -y --no-install-recommends ca-certificates  && rm -rf /var/lib/apt/lists/*
RUN /tmp/manage_cert.sh install
RUN export DEBIAN_FRONTEND=noninteractive  && apt-get update  && apt-get install -y --no-install-recommends         adduser         curl         libnl-route-3-200         libnl-3-200         libnl-3-dev         libnl-route-3-dev         patch         wget  && rm -rf /var/lib/apt/lists/*  && echo "hsts=0" > /root/.wgetrc
ARG GDRCOPY_VERSION=2.5.1
ARG HPCX_VERSION=2.24.1
ARG RDMACORE_VERSION=56.0
ARG MOFED_VERSION=5.4-rdmacore56.0
ARG OPENUCX_VERSION=1.19.0
ARG OPENMPI_VERSION=4.1.7
ARG EFA_VERSION=1.38.1
ARG AWS_OFI_NCCL_VERSION=1.14.0
ENV GDRCOPY_VERSION=2.5.1 HPCX_VERSION=2.24.1 MOFED_VERSION=5.4-rdmacore56.0 OPENUCX_VERSION=1.19.0 OPENMPI_VERSION=4.1.7 RDMACORE_VERSION=56.0 EFA_VERSION=1.38.1 AWS_OFI_NCCL_VERSION=1.14.0
ARG TARGETARCH=arm64
RUN cd /nvidia  && ( cd opt/rdma-core/                            && dpkg -i libibverbs1_*.deb                            libibverbs-dev_*.deb                         librdmacm1_*.deb                             librdmacm-dev_*.deb                          libibumad3_*.deb                             libibumad-dev_*.deb                          ibverbs-utils_*.deb                          ibverbs-providers_*.deb           && rm $(dpkg-query -L                                    libibverbs-dev                               librdmacm-dev                                libibumad-dev                            | grep "\(\.so\|\.a\)$")          )                                            && ( cd opt/gdrcopy/                              && dpkg -i libgdrapi_*.deb                   )                                         && ( cp -r opt/hpcx /opt/                                         && cp etc/ld.so.conf.d/hpcx.conf /etc/ld.so.conf.d/          && ln -sf /opt/hpcx/ompi /usr/local/mpi                      && ln -sf /opt/hpcx/ucx  /usr/local/ucx                      && sed -i 's/^\(hwloc_base_binding_policy\) = core$/\1 = none/' /opt/hpcx/ompi/etc/openmpi-mca-params.conf         && sed -i 's/^\(btl = self\)$/#\1/'                             /opt/hpcx/ompi/etc/openmpi-mca-params.conf       )                                                         && ( if [ ! -f /etc/ld.so.conf.d/nvidia-tegra.conf ]; then           cd opt/amazon/efa/                                           && dpkg -i libfabric*.deb                                    && rm /opt/amazon/efa/lib/libfabric.a                        && echo "/opt/amazon/efa/lib" > /etc/ld.so.conf.d/efa.conf;         fi                                                         )                                                         && ldconfig
ENV OPAL_PREFIX=/opt/hpcx/ompi PATH=/usr/local/mpi/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/ucx/bin:/opt/amazon/efa/bin
ENV OMPI_MCA_coll_hcoll_enable=0
ARG CUDA_VERSION=13.0.2.006
ARG CUDA_DRIVER_VERSION=580.95.05
ARG NVVM_VERSION=13.0.88
ARG DOCA_VERSION=3.1.0
ENV CUDA_VERSION=13.0.2.006 CUDA_DRIVER_VERSION=580.95.05 NVVM_VERSION=13.0.88 DOCA_VERSION=3.1.0
RUN BASE=min /nvidia/build-scripts/installCUDA.sh
ENV _CUDA_COMPAT_PATH=/usr/local/cuda/compat ENV=/etc/shinit_v2 BASH_ENV=/etc/bash.bashrc SHELL=/bin/bash NVIDIA_REQUIRE_CUDA=cuda>=9.0
LABEL com.nvidia.volumes.needed=nvidia_driver com.nvidia.cuda.version=9.0
ARG NCCL_VERSION=2.27.7 CUBLAS_VERSION=13.1.0.3 CUFFT_VERSION=12.0.0.61 CURAND_VERSION=10.4.0.35 CUSPARSE_VERSION=12.6.3.3 CUSOLVER_VERSION=12.0.4.66 NPP_VERSION=13.0.1.2 NVJPEG_VERSION=13.0.1.86 CUFILE_VERSION=1.15.1.6 NVJITLINK_VERSION=13.0.88 NVFATBIN_VERSION=13.0.85 CUBLASMP_VERSION=0.6.0.84 NVSHMEM_VERSION=3.4.5 CUDLA_VERSION=13.0.2.006 NVPTXCOMPILER_VERSION=13.0.88 CUDNN_VERSION=9.14.0.64 CUDNN_FRONTEND_VERSION=1.14.1 TRT_VERSION=10.13.3.9 TRTOSS_VERSION= NSIGHT_SYSTEMS_VERSION=2025.5.1.121 NSIGHT_COMPUTE_VERSION=2025.3.1.4 CUSPARSELT_VERSION=0.8.1.1 DALI_VERSION=1.51.2 DALI_BUILD= DALI_URL_SUFFIX=130 POLYGRAPHY_VERSION=0.49.26 TRANSFORMER_ENGINE_VERSION=2.8 MODEL_OPT_VERSION=0.35.1 CUDA_ARCH_LIST=8.0 8.6 9.0 10.0 11.0 12.0 MAXSMVER=121 NVRX_VERSION=0.4.1+cuda13
ENV NCCL_VERSION=2.27.7 CUBLAS_VERSION=13.1.0.3 CUFFT_VERSION=12.0.0.61 CURAND_VERSION=10.4.0.35 CUSPARSE_VERSION=12.6.3.3 CUSPARSELT_VERSION=0.8.1.1 CUSOLVER_VERSION=12.0.4.66 NPP_VERSION=13.0.1.2 NVJPEG_VERSION=13.0.1.86 CUFILE_VERSION=1.15.1.6 NVJITLINK_VERSION=13.0.88 NVFATBIN_VERSION=13.0.85 CUBLASMP_VERSION=0.6.0.84 NVSHMEM_VERSION=3.4.5 CUDLA_VERSION=13.0.2.006 NVPTXCOMPILER_VERSION=13.0.88 CUDNN_VERSION=9.14.0.64 CUDNN_FRONTEND_VERSION=1.14.1 TRT_VERSION=10.13.3.9 TRTOSS_VERSION= NSIGHT_SYSTEMS_VERSION=2025.5.1.121 NSIGHT_COMPUTE_VERSION=2025.3.1.4 DALI_VERSION=1.51.2 DALI_BUILD= DALI_URL_SUFFIX=130 POLYGRAPHY_VERSION=0.49.26 TRANSFORMER_ENGINE_VERSION=2.8 MODEL_OPT_VERSION=0.35.1 CUDA_ARCH_LIST=8.0 8.6 9.0 10.0 11.0 12.0 MAXSMVER=121 NVRX_VERSION=0.4.1+cuda13
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf  && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
ARG _LIBPATH_SUFFIX=
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/mpi/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/ucx/bin:/opt/amazon/efa/bin LD_LIBRARY_PATH=/usr/local/cuda/compat/lib:/usr/local/nvidia/lib:/usr/local/nvidia/lib64 NVIDIA_VISIBLE_DEVICES=all NVIDIA_DRIVER_CAPABILITIES=compute,utility,video
RUN if [ -n "${DOCA_VERSION}" ] && dpkg --compare-versions "${HPCX_VERSION}" "ge" "2.24"; then         /nvidia/build-scripts/installDOCA.sh;     else         echo "Not running installDOCA.sh";     fi
COPY /opt/amazon/aws-ofi-nccl /opt/amazon/aws-ofi-nccl
ENV NVIDIA_PRODUCT_NAME=CUDA
ENTRYPOINT ["/opt/nvidia/nvidia_entrypoint.sh"]
RUN mkdir -p /workspace && cp -f -p /opt/nvidia/entrypoint.d/30-container-license.txt /workspace/license.txt
RUN /tmp/manage_cert.sh uninstall
ARG ENABLE_MITMPROXY=0
RUN /tmp/manage_cert.sh install
RUN export DEBIAN_FRONTEND=noninteractive  && apt-get update  && apt-get install -y --no-install-recommends         apt-utils         build-essential         libncurses6         libncursesw6         unzip         jq         gnupg         libtcmalloc-minimal4  && rm -rf /var/lib/apt/lists/*
RUN /nvidia/build-scripts/installCUDA.sh
RUN /nvidia/build-scripts/installLIBS.sh  && /nvidia/build-scripts/installCUDNN.sh  && /nvidia/build-scripts/installTRT.sh  && /nvidia/build-scripts/installNSYS.sh  && /nvidia/build-scripts/installNCU.sh  && /nvidia/build-scripts/installCUSPARSELT.sh  && if [ -z "${JETPACK_HOST_MOUNTS}" ]; then       /nvidia/build-scripts/installNCCL.sh;     fi;
LABEL com.nvidia.nccl.version=2.27.7 com.nvidia.cublas.version=13.1.0.3 com.nvidia.cufft.version=12.0.0.61 com.nvidia.curand.version=10.4.0.35 com.nvidia.cusparse.version=12.6.3.3 com.nvidia.cusparselt.version=0.8.1.1 com.nvidia.cusolver.version=12.0.4.66 com.nvidia.npp.version=13.0.1.2 com.nvidia.nvjpeg.version=13.0.1.86 com.nvidia.cublasmp.version=0.6.0.84 com.nvidia.nvvm.version=13.0.88 com.nvidia.cudla.version=13.0.2.006 com.nvidia.cudnn.version=9.14.0.64 com.nvidia.tensorrt.version=10.13.3.9 com.nvidia.tensorrtoss.version= com.nvidia.nsightsystems.version=2025.5.1.121 com.nvidia.nsightcompute.version=2025.3.1.4
RUN /tmp/manage_cert.sh uninstall
ARG ENABLE_MITMPROXY=0
RUN /tmp/manage_cert.sh install
RUN export DEBIAN_FRONTEND=noninteractive  && apt-get update  && apt-get install -y --no-install-recommends         build-essential         git         libglib2.0-0         less         libhwloc15         libnuma-dev         libnuma1         libpmi2-0-dev         nano         numactl         openssh-client         vim         wget  && rm -rf /var/lib/apt/lists/*
RUN export DEVEL=1 BASE=0  && /nvidia/build-scripts/installNCU.sh  && /nvidia/build-scripts/installCUDA.sh  && /nvidia/build-scripts/installLIBS.sh  && if [ ! -f /etc/ld.so.conf.d/nvidia-tegra.conf ]; then /nvidia/build-scripts/installNCCL.sh; fi  && /nvidia/build-scripts/installCUDNN.sh  && /nvidia/build-scripts/installTRT.sh  && /nvidia/build-scripts/installNSYS.sh  && /nvidia/build-scripts/installCUSPARSELT.sh  && if [ -f "/tmp/cuda-${_CUDA_VERSION_MAJMIN}.patch" ]; then patch -p0 < /tmp/cuda-${_CUDA_VERSION_MAJMIN}.patch; fi  && rm -f /tmp/cuda-*.patch
ENV LIBRARY_PATH=/usr/local/cuda/lib64/stubs:
RUN /tmp/manage_cert.sh uninstall
ENV NVIDIA_PRODUCT_NAME=PyTorch
ARG NVIDIA_PYTORCH_VERSION=25.10
ARG PYTORCH_BUILD_VERSION=2.9.0a0+145a3a7
ARG NVFUSER_BUILD_VERSION=ed11f2b
ENV PYTORCH_BUILD_VERSION=2.9.0a0+145a3a7 PYTORCH_VERSION=2.9.0a0+145a3a7 PYTORCH_BUILD_NUMBER=0 NVIDIA_PYTORCH_VERSION=25.10
ENV NVFUSER_BUILD_VERSION=ed11f2b NVFUSER_VERSION=ed11f2b
LABEL com.nvidia.pytorch.version=2.9.0a0+145a3a7
ARG TARGETARCH=arm64
ARG PYVER=3.12
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ARG L4T=0
ARG ENABLE_MITMPROXY=0
RUN /tmp/manage_cert.sh install
RUN export PYSFX=`echo "${PYVER}" | cut -c1-1` &&     export DEBIAN_FRONTEND=noninteractive &&     apt-get update &&     apt-get install -y --no-install-recommends         python$PYVER-dev         python$PYSFX         python$PYSFX-dev         python$PYSFX-venv         python-is-python$PYSFX         autoconf         automake         libatlas-base-dev         libgoogle-glog-dev         libbz2-dev         libc-ares2         libre2-dev         libleveldb-dev         liblmdb-dev         libprotobuf-dev         libsnappy-dev         libtool         nasm         protobuf-compiler         pkg-config         unzip         sox         libsndfile1         libpng-dev         libhdf5-dev         gfortran         rapidjson-dev         ninja-build         libedit-dev         build-essential         patchelf     && rm -rf /var/lib/apt/lists/*
ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
RUN curl -O https://bootstrap.pypa.io/get-pip.py &&     python get-pip.py &&     rm get-pip.py
ENV PIP_CONSTRAINT=/etc/pip/constraint.txt
RUN pip install pip setuptools &&     pip install cmake
RUN if [ $TARGETARCH = "arm64" ]; then cd /opt &&     curl "https://gitlab-master.nvidia.com/api/v4/projects/105799/packages/generic/nvpl_slim_24.04/sbsa/nvpl_slim_24.04.tar" --output nvpl_slim_24.04.tar &&     tar -xf nvpl_slim_24.04.tar &&     cp -r nvpl_slim_24.04/lib/* /usr/local/lib &&     cp -r nvpl_slim_24.04/include/* /usr/local/include &&     rm -rf nvpl_slim_24.04.tar nvpl_slim_24.04 ; fi
ENV NVPL_LAPACK_MATH_MODE=PEDANTIC
WORKDIR /opt/pytorch
COPY . .
ENV PYTHONIOENCODING=utf-8
ENV LC_ALL=C.UTF-8
ENV PIP_DEFAULT_TIMEOUT=100
RUN pip install         numpy         scipy         PyYAML         astunparse         typing_extensions         cffi         mock         tqdm         librosa         expecttest         hypothesis         xdoctest         pytest         pytest-xdist         pytest-rerunfailures         pytest-shard         pytest-flakefinder         pybind11         Cython         regex         protobuf         six &&     if [[ $TARGETARCH = "amd64" ]] ; then pip install --no-cache-dir mkl mkl-include mkl-devel ;     find /usr/local/lib -maxdepth 1 -type f -regex '.*\/lib\(tbb\|mkl\).*\.so\($\|\.[0-9]*\.[0-9]*\)' -exec rm -v {} + ; fi
RUN git config --global url."https://github".insteadOf git://github &&     pip install jupyterlab notebook tensorboard     jupyterlab_code_formatter python-hostlist
WORKDIR /opt/pytorch
RUN pip install --no-cache-dir /builder/*.whl jupytext black isort  && mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/completer-extension/  && jupyter lab clean
COPY jupyter_config/jupyter_notebook_config.py /usr/local/etc/jupyter/
COPY jupyter_config/manager.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/completer-extension/
COPY jupyter_config/settings.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/completer-extension/
ENV JUPYTER_PORT=8888
ENV TENSORBOARD_PORT=6006
EXPOSE map[8888/tcp:{}]
EXPOSE map[6006/tcp:{}]
ENV UCC_CL_BASIC_TLS=^sharp
ENV UCC_EC_CUDA_EXEC_NUM_THREADS=256
ENV TORCH_CUDA_ARCH_LIST=8.0 8.6 9.0 10.0 11.0 12.0+PTX
ENV PYTORCH_HOME=/opt/pytorch/pytorch
ENV CUDA_HOME=/usr/local/cuda
ENV TORCH_ALLOW_TF32_CUBLAS_OVERRIDE=1
RUN echo "TORCH_CUDA_ARCH_LIST=${TORCH_CUDA_ARCH_LIST}"     && pip install /opt/transfer/torch*.whl     && patchelf --set-rpath '/usr/local/lib' /usr/local/lib/python${PYVER}/dist-packages/torch/lib/libtorch_global_deps.so
COPY /usr/local/lib64/libtorchvision.so.1.0 /usr/local/lib/libtorchvision.so.1.0
COPY /usr/local/lib64/libjpeg* /usr/local/lib/
RUN cd pytorch && pip install -v -r /opt/pytorch/pytorch/requirements.txt
RUN pip install --no-cache-dir /tmp/dist/*.whl
ENV TRITON_PTXAS_PATH=/usr/local/cuda/bin/ptxas
ENV TRITON_CUOBJDUMP_PATH=/usr/local/cuda/bin/cuobjdump
ENV TRITON_NVDISASM_PATH=/usr/local/cuda/bin/nvdisasm
ENV TRITON_CUDACRT_PATH=/usr/local/cuda/include
ENV TRITON_CUDART_PATH=/usr/local/cuda/include
ENV TRITON_CUPTI_PATH=/usr/local/cuda/include
ARG DALI_EXTRA_INDEX_URL=http://sqrl/nvdl/datasets/dali/pip-dali
RUN if [ -z "${DALI_VERSION}" ] ; then   echo "Not Installing DALI for L4T Build." ; exit 0; fi   && export CUDA_VERSION_MAJOR=$(ls /usr/local/cuda/lib64/libcudart.so.*.*.* | cut -d . -f 3)   && export DALI_PKG_SUFFIX="cuda${CUDA_VERSION_MAJOR}0"   && if [ -z "${DALI_URL_SUFFIX}" ] ; then export DALI_EXTRA_INDEX_URL="${DALI_EXTRA_INDEX_URL}-qa/nvidia-dali-cudagpgpu"; fi   && pip install                 --extra-index-url https://developer.download.nvidia.com/compute/redist                 --extra-index-url "${DALI_EXTRA_INDEX_URL}"                 --extra-index-url "http://sqrl/nvdl/datasets/dali/misc"                 --trusted-host sqrl         nvidia-dali-${DALI_PKG_SUFFIX}==${DALI_VERSION}
ENV COCOAPI_VERSION=2.0+nv0.8.1
RUN export COCOAPI_TAG=$(echo ${COCOAPI_VERSION} | sed 's/^.*+n//')  && pip install git+https://github.com/nvidia/cocoapi.git@${COCOAPI_TAG}#subdirectory=PythonAPI
RUN /tmp/manage_cert.sh install
RUN ( if [ "${L4T}" = "1" ]; then echo "Not installing nvshmem in iGPU container";       else cp /tmp/transfer/libnvshmem_device.bc /usr/local/cuda/lib64/libnvshmem_device.bc; fi )
RUN ( if [ "${L4T}" = "1" ]; then echo "Not installing nvshmem in iGPU container";       else /nvidia/build-scripts/installCUBLASMP.sh         && DPKG_DIVERT=1 BASE=1 /nvidia/build-scripts/installNVSHMEM.sh; fi )  && ( cd fuser && pip install -r requirements.txt && pip install -v ./python --no-build-isolation && rm -rf ./python/build && rm -rf ./bin)  && ( cd lightning-thunder && pip install --no-build-isolation . && rm -rf build *.egg-info)  && ( cd lightning-thunder && mkdir tmp && cd tmp && git clone -b v${CUDNN_FRONTEND_VERSION} --recursive --single-branch https://github.com/NVIDIA/cudnn-frontend.git cudnn_frontend && cd cudnn_frontend && pip install --no-build-isolation . && cd ../../ && rm -rf tmp )  && ( cd pytorch/third_party/onnx && pip uninstall typing -y && CMAKE_ARGS="-DONNX_USE_PROTOBUF_SHARED_LIBS=ON" pip install --no-build-isolation . )  && ( if [ "${L4T}" = "1" ]; then echo "Not installing torchao in iGPU container"; else cd ao && TORCH_CUDA_ARCH_LIST="9.0a 10.0a ${TORCH_CUDA_ARCH_LIST}" pip install --no-build-isolation . && python setup.py clean --all ; fi )
WORKDIR /workspace
COPY tutorials tutorials
RUN chmod -R a+w .
RUN set -x     && WHEELS=1 /nvidia/build-scripts/installTRT.sh
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/mpi/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/ucx/bin:/opt/amazon/efa/bin:/opt/tensorrt/bin
RUN pip --version && python -c 'import sys; print(sys.platform)'     && pip install --extra-index-url https://urm.nvidia.com/artifactory/api/pypi/sw-tensorrt-pypi/simple --no-cache-dir "polygraphy==${POLYGRAPHY_VERSION}"     && pip install  --index-url https://gitlab-master.nvidia.com/api/v4/projects/omniml%2Fmodelopt/packages/pypi/simple --extra-index-url https://pypi.nvidia.com "nvidia-modelopt[torch]==${MODEL_OPT_VERSION}"     && pip install nvidia-resiliency-ext==${NVRX_VERSION} --index-url https://gitlab-master.nvidia.com/api/v4/projects/dl%2Fosiris%2Fnvidia-resiliency-ext-ci/packages/pypi/simple     && pip uninstall -y pynvml
COPY torch_tensorrt/ /opt/pytorch/torch_tensorrt/
ARG PYVER=3.12
ENV LD_LIBRARY_PATH=/usr/local/lib/python3.12/dist-packages/torch/lib:/usr/local/lib/python3.12/dist-packages/torch_tensorrt/lib:/usr/local/cuda/compat/lib:/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV PATH=/usr/local/lib/python3.12/dist-packages/torch_tensorrt/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/mpi/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/ucx/bin:/opt/amazon/efa/bin:/opt/tensorrt/bin
RUN pip install --no-cache-dir /opt/pytorch/apex/dist/*.whl
RUN pip install --no-cache-dir /opt/pytorch/torch_tensorrt/dist/*.whl
RUN if [ "${L4T}" = "1" ]; then echo "Not installing Flash Attention wheel in iGPU as it is a requirement for Transformer Engine"; else     pip install --no-cache-dir /opt/transfer/flash_attn*.whl; fi
RUN if [ "${L4T}" = "1" ]; then echo "Not installing Transformer Engine in iGPU container until Version variable is set"; else     git clone -b release_v${TRANSFORMER_ENGINE_VERSION} --single-branch --recursive https://github.com/NVIDIA/TransformerEngine.git &&     pip install nvidia-mathdx==25.1.1 &&     _NVTE_CUDA_ARCHS=$(echo "${CUDA_ARCH_LIST}" | tr -d '.') &&     NVTE_CUDA_ARCHS=$(echo "${_NVTE_CUDA_ARCHS}" | tr ' ' ';') &&     env NVTE_CUDA_ARCHS="${NVTE_CUDA_ARCHS};89;100a;103a" NVTE_BUILD_THREADS_PER_JOB=8 pip install --no-cache-dir --no-build-isolation ./TransformerEngine &&     pip uninstall -y nvidia-mathdx && rm -rf TransformerEngine; fi
RUN /tmp/manage_cert.sh uninstall
ENV CUDA_MODULE_LOADING=LAZY
ENV TORCH_NCCL_USE_COMM_NONBLOCKING=0
COPY restricted_constraint.txt /etc/pip/constraint.txt
COPY entrypoint.d/ /opt/nvidia/entrypoint.d/
ARG NVIDIA_BUILD_ID=222161059
ENV NVIDIA_BUILD_ID=222161059
LABEL com.nvidia.build.id=222161059
ARG NVIDIA_BUILD_REF=fa6a0c2f25093d8e3e34af241bebbdbc3e202daf
LABEL com.nvidia.build.ref=fa6a0c2f25093d8e3e34af241bebbdbc3e202daf
COPY xformers/ /opt/xformers/
COPY vllm-flash-attn/ /opt/vllm/vllm-flash-attn/
COPY vllm-src/ /opt/vllm/vllm-src/
ARG TARGETARCH=arm64
ARG VLLM_VERSION=0.10.2+9dd9ca32
ENV VLLM_VERSION=0.10.2+9dd9ca32
ENV MAX_JOBS=12 PIP_NO_BUILD_ISOLATION=1 PYTORCH_TRITON_VERSION=3.4.0+gitc817b9b6
RUN sed -i -e 's/numba==.*//' /etc/pip/constraint.txt
RUN sed -i -e 's/llvmlite==.*//' /etc/pip/constraint.txt
RUN pip install /opt/transfer/*.whl
RUN mkdir -p /root/.cache/tiktoken_cache  && cd /root/.cache/tiktoken_cache  && wget -q https://openaipublic.blob.core.windows.net/encodings/o200k_base.tiktoken  && mv o200k_base.tiktoken fb374d419588a4632f3f557e76b4b70aebbca790
ENV TIKTOKEN_CACHE_DIR=/root/.cache/tiktoken_cache TIKTOKEN_RS_CACHE_DIR=/root/.cache/tiktoken_cache
ENV NVIDIA_PRODUCT_NAME=vLLM
LABEL com.nvidia.vllm.version=0.10.2+9dd9ca32
ARG NVIDIA_VLLM_VERSION=25.10
ENV NVIDIA_VLLM_VERSION=25.10
ARG NVIDIA_BUILD_ID=224204848
ENV NVIDIA_BUILD_ID=224204848
LABEL com.nvidia.build.id=224204848
ARG NVIDIA_BUILD_REF=13aa3ebd28c5236ad70c845a1c4ef7be5175729d
LABEL com.nvidia.build.ref=13aa3ebd28c5236ad70c845a1c4ef7be5175729d
