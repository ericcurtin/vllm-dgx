#!/bin/bash
# Generated from history.txt
# This script contains all RUN commands from the Docker image
set -e

if [ -n "${JETPACK_HOST_MOUNTS}" ]; then        echo "/usr/lib/aarch64-linux-gnu/tegra" > /etc/ld.so.conf.d/nvidia-tegra.conf     && echo "/usr/lib/aarch64-linux-gnu/tegra-egl" >> /etc/ld.so.conf.d/nvidia-tegra.conf;     fi

/tmp/manage_cert.sh install

if [ -d /usr/share/ca-certificates ]; then exit; fi  && export DEBIAN_FRONTEND=noninteractive  && apt-get update  && apt-get install -y --no-install-recommends ca-certificates  && rm -rf /var/lib/apt/lists/*

/tmp/manage_cert.sh install

export DEBIAN_FRONTEND=noninteractive  && apt-get update  && apt-get install -y --no-install-recommends         adduser         curl         libnl-route-3-200         libnl-3-200         libnl-3-dev         libnl-route-3-dev         patch         wget  && rm -rf /var/lib/apt/lists/*  && echo "hsts=0" > /root/.wgetrc

cd /nvidia  && ( cd opt/rdma-core/                            && dpkg -i libibverbs1_*.deb                            libibverbs-dev_*.deb                         librdmacm1_*.deb                             librdmacm-dev_*.deb                          libibumad3_*.deb                             libibumad-dev_*.deb                          ibverbs-utils_*.deb                          ibverbs-providers_*.deb           && rm $(dpkg-query -L                                    libibverbs-dev                               librdmacm-dev                                libibumad-dev                            | grep "\(\.so\|\.a\)$")          )                                            && ( cd opt/gdrcopy/                              && dpkg -i libgdrapi_*.deb                   )                                         && ( cp -r opt/hpcx /opt/                                         && cp etc/ld.so.conf.d/hpcx.conf /etc/ld.so.conf.d/          && ln -sf /opt/hpcx/ompi /usr/local/mpi                      && ln -sf /opt/hpcx/ucx  /usr/local/ucx                      && sed -i 's/^\(hwloc_base_binding_policy\) = core$/\1 = none/' /opt/hpcx/ompi/etc/openmpi-mca-params.conf         && sed -i 's/^\(btl = self\)$/#\1/'                             /opt/hpcx/ompi/etc/openmpi-mca-params.conf       )                                                         && ( if [ ! -f /etc/ld.so.conf.d/nvidia-tegra.conf ]; then           cd opt/amazon/efa/                                           && dpkg -i libfabric*.deb                                    && rm /opt/amazon/efa/lib/libfabric.a                        && echo "/opt/amazon/efa/lib" > /etc/ld.so.conf.d/efa.conf;         fi                                                         )                                                         && ldconfig

BASE=min /nvidia/build-scripts/installCUDA.sh

echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf  && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

if [ -n "${DOCA_VERSION}" ] && dpkg --compare-versions "${HPCX_VERSION}" "ge" "2.24"; then         /nvidia/build-scripts/installDOCA.sh;     else         echo "Not running installDOCA.sh";     fi

mkdir -p /workspace && cp -f -p /opt/nvidia/entrypoint.d/30-container-license.txt /workspace/license.txt

/tmp/manage_cert.sh uninstall

/tmp/manage_cert.sh install

export DEBIAN_FRONTEND=noninteractive  && apt-get update  && apt-get install -y --no-install-recommends         apt-utils         build-essential         libncurses6         libncursesw6         unzip         jq         gnupg         libtcmalloc-minimal4  && rm -rf /var/lib/apt/lists/*

/nvidia/build-scripts/installCUDA.sh

/nvidia/build-scripts/installLIBS.sh  && /nvidia/build-scripts/installCUDNN.sh  && /nvidia/build-scripts/installTRT.sh  && /nvidia/build-scripts/installNSYS.sh  && /nvidia/build-scripts/installNCU.sh  && /nvidia/build-scripts/installCUSPARSELT.sh  && if [ -z "${JETPACK_HOST_MOUNTS}" ]; then       /nvidia/build-scripts/installNCCL.sh;     fi;

/tmp/manage_cert.sh uninstall

/tmp/manage_cert.sh install

export DEBIAN_FRONTEND=noninteractive  && apt-get update  && apt-get install -y --no-install-recommends         build-essential         git         libglib2.0-0         less         libhwloc15         libnuma-dev         libnuma1         libpmi2-0-dev         nano         numactl         openssh-client         vim         wget  && rm -rf /var/lib/apt/lists/*

export DEVEL=1 BASE=0  && /nvidia/build-scripts/installNCU.sh  && /nvidia/build-scripts/installCUDA.sh  && /nvidia/build-scripts/installLIBS.sh  && if [ ! -f /etc/ld.so.conf.d/nvidia-tegra.conf ]; then /nvidia/build-scripts/installNCCL.sh; fi  && /nvidia/build-scripts/installCUDNN.sh  && /nvidia/build-scripts/installTRT.sh  && /nvidia/build-scripts/installNSYS.sh  && /nvidia/build-scripts/installCUSPARSELT.sh  && if [ -f "/tmp/cuda-${_CUDA_VERSION_MAJMIN}.patch" ]; then patch -p0 < /tmp/cuda-${_CUDA_VERSION_MAJMIN}.patch; fi  && rm -f /tmp/cuda-*.patch

/tmp/manage_cert.sh uninstall

/tmp/manage_cert.sh install

export PYSFX=`echo "${PYVER}" | cut -c1-1` &&     export DEBIAN_FRONTEND=noninteractive &&     apt-get update &&     apt-get install -y --no-install-recommends         python$PYVER-dev         python$PYSFX         python$PYSFX-dev         python$PYSFX-venv         python-is-python$PYSFX         autoconf         automake         libatlas-base-dev         libgoogle-glog-dev         libbz2-dev         libc-ares2         libre2-dev         libleveldb-dev         liblmdb-dev         libprotobuf-dev         libsnappy-dev         libtool         nasm         protobuf-compiler         pkg-config         unzip         sox         libsndfile1         libpng-dev         libhdf5-dev         gfortran         rapidjson-dev         ninja-build         libedit-dev         build-essential         patchelf     && rm -rf /var/lib/apt/lists/*

curl -O https://bootstrap.pypa.io/get-pip.py &&     python get-pip.py &&     rm get-pip.py

pip install pip setuptools &&     pip install cmake

if [ $TARGETARCH = "arm64" ]; then cd /opt &&     curl "https://gitlab-master.nvidia.com/api/v4/projects/105799/packages/generic/nvpl_slim_24.04/sbsa/nvpl_slim_24.04.tar" --output nvpl_slim_24.04.tar &&     tar -xf nvpl_slim_24.04.tar &&     cp -r nvpl_slim_24.04/lib/* /usr/local/lib &&     cp -r nvpl_slim_24.04/include/* /usr/local/include &&     rm -rf nvpl_slim_24.04.tar nvpl_slim_24.04 ; fi

pip install         numpy         scipy         PyYAML         astunparse         typing_extensions         cffi         mock         tqdm         librosa         expecttest         hypothesis         xdoctest         pytest         pytest-xdist         pytest-rerunfailures         pytest-shard         pytest-flakefinder         pybind11         Cython         regex         protobuf         six &&     if [[ $TARGETARCH = "amd64" ]] ; then pip install --no-cache-dir mkl mkl-include mkl-devel ;     find /usr/local/lib -maxdepth 1 -type f -regex '.*\/lib\(tbb\|mkl\).*\.so\($\|\.[0-9]*\.[0-9]*\)' -exec rm -v {} + ; fi

git config --global url."https://github".insteadOf git://github &&     pip install jupyterlab notebook tensorboard     jupyterlab_code_formatter python-hostlist

pip install --no-cache-dir /builder/*.whl jupytext black isort  && mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/completer-extension/  && jupyter lab clean

echo "TORCH_CUDA_ARCH_LIST=${TORCH_CUDA_ARCH_LIST}"     && pip install /opt/transfer/torch*.whl     && patchelf --set-rpath '/usr/local/lib' /usr/local/lib/python${PYVER}/dist-packages/torch/lib/libtorch_global_deps.so

cd pytorch && pip install -v -r /opt/pytorch/pytorch/requirements.txt

pip install --no-cache-dir /tmp/dist/*.whl

if [ -z "${DALI_VERSION}" ] ; then   echo "Not Installing DALI for L4T Build." ; exit 0; fi   && export CUDA_VERSION_MAJOR=$(ls /usr/local/cuda/lib64/libcudart.so.*.*.* | cut -d . -f 3)   && export DALI_PKG_SUFFIX="cuda${CUDA_VERSION_MAJOR}0"   && if [ -z "${DALI_URL_SUFFIX}" ] ; then export DALI_EXTRA_INDEX_URL="${DALI_EXTRA_INDEX_URL}-qa/nvidia-dali-cudagpgpu"; fi   && pip install                 --extra-index-url https://developer.download.nvidia.com/compute/redist                 --extra-index-url "${DALI_EXTRA_INDEX_URL}"                 --extra-index-url "http://sqrl/nvdl/datasets/dali/misc"                 --trusted-host sqrl         nvidia-dali-${DALI_PKG_SUFFIX}==${DALI_VERSION}

export COCOAPI_TAG=$(echo ${COCOAPI_VERSION} | sed 's/^.*+n//')  && pip install git+https://github.com/nvidia/cocoapi.git@${COCOAPI_TAG}#subdirectory=PythonAPI

/tmp/manage_cert.sh install

( if [ "${L4T}" = "1" ]; then echo "Not installing nvshmem in iGPU container";       else cp /tmp/transfer/libnvshmem_device.bc /usr/local/cuda/lib64/libnvshmem_device.bc; fi )

( if [ "${L4T}" = "1" ]; then echo "Not installing nvshmem in iGPU container";       else /nvidia/build-scripts/installCUBLASMP.sh         && DPKG_DIVERT=1 BASE=1 /nvidia/build-scripts/installNVSHMEM.sh; fi )  && ( cd fuser && pip install -r requirements.txt && pip install -v ./python --no-build-isolation && rm -rf ./python/build && rm -rf ./bin)  && ( cd lightning-thunder && pip install --no-build-isolation . && rm -rf build *.egg-info)  && ( cd lightning-thunder && mkdir tmp && cd tmp && git clone -b v${CUDNN_FRONTEND_VERSION} --recursive --single-branch https://github.com/NVIDIA/cudnn-frontend.git cudnn_frontend && cd cudnn_frontend && pip install --no-build-isolation . && cd ../../ && rm -rf tmp )  && ( cd pytorch/third_party/onnx && pip uninstall typing -y && CMAKE_ARGS="-DONNX_USE_PROTOBUF_SHARED_LIBS=ON" pip install --no-build-isolation . )  && ( if [ "${L4T}" = "1" ]; then echo "Not installing torchao in iGPU container"; else cd ao && TORCH_CUDA_ARCH_LIST="9.0a 10.0a ${TORCH_CUDA_ARCH_LIST}" pip install --no-build-isolation . && python setup.py clean --all ; fi )

chmod -R a+w .

set -x     && WHEELS=1 /nvidia/build-scripts/installTRT.sh

pip --version && python -c 'import sys; print(sys.platform)'     && pip install --extra-index-url https://urm.nvidia.com/artifactory/api/pypi/sw-tensorrt-pypi/simple --no-cache-dir "polygraphy==${POLYGRAPHY_VERSION}"     && pip install  --index-url https://gitlab-master.nvidia.com/api/v4/projects/omniml%2Fmodelopt/packages/pypi/simple --extra-index-url https://pypi.nvidia.com "nvidia-modelopt[torch]==${MODEL_OPT_VERSION}"     && pip install nvidia-resiliency-ext==${NVRX_VERSION} --index-url https://gitlab-master.nvidia.com/api/v4/projects/dl%2Fosiris%2Fnvidia-resiliency-ext-ci/packages/pypi/simple     && pip uninstall -y pynvml

pip install --no-cache-dir /opt/pytorch/apex/dist/*.whl

pip install --no-cache-dir /opt/pytorch/torch_tensorrt/dist/*.whl

if [ "${L4T}" = "1" ]; then echo "Not installing Flash Attention wheel in iGPU as it is a requirement for Transformer Engine"; else     pip install --no-cache-dir /opt/transfer/flash_attn*.whl; fi

if [ "${L4T}" = "1" ]; then echo "Not installing Transformer Engine in iGPU container until Version variable is set"; else     git clone -b release_v${TRANSFORMER_ENGINE_VERSION} --single-branch --recursive https://github.com/NVIDIA/TransformerEngine.git &&     pip install nvidia-mathdx==25.1.1 &&     _NVTE_CUDA_ARCHS=$(echo "${CUDA_ARCH_LIST}" | tr -d '.') &&     NVTE_CUDA_ARCHS=$(echo "${_NVTE_CUDA_ARCHS}" | tr ' ' ';') &&     env NVTE_CUDA_ARCHS="${NVTE_CUDA_ARCHS};89;100a;103a" NVTE_BUILD_THREADS_PER_JOB=8 pip install --no-cache-dir --no-build-isolation ./TransformerEngine &&     pip uninstall -y nvidia-mathdx && rm -rf TransformerEngine; fi

/tmp/manage_cert.sh uninstall

sed -i -e 's/numba==.*//' /etc/pip/constraint.txt

sed -i -e 's/llvmlite==.*//' /etc/pip/constraint.txt

pip install /opt/transfer/*.whl

mkdir -p /root/.cache/tiktoken_cache  && cd /root/.cache/tiktoken_cache  && wget -q https://openaipublic.blob.core.windows.net/encodings/o200k_base.tiktoken  && mv o200k_base.tiktoken fb374d419588a4632f3f557e76b4b70aebbca790

