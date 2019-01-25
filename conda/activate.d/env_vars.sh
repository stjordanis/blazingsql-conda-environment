#!/bin/sh

# add blazingdb and blazingdb-protocol python packages

blazingsql_pypath=$CONDA_PREFIX/lib/python3.5/site-packages/blazingsql
blazingsql_runtime_lib_path=$blazingsql_pypath/runtime/lib
cudf_pypath=$blazingsql_runtime_lib_path/python3.5/site-packages/

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$blazingsql_runtime_lib_path:/usr/local/cuda-9.2/lib64/
export PYTHONPATH=$PYTHONPATH:$cudf_pypath:$blazingsql_pypath

# NOTE Fix some numba issues (NvvmSupportError: libNVVM cannot be found)
export NUMBAPRO_NVVM=/usr/local/cuda-9.2/nvvm/lib64/libnvvm.so
export NUMBAPRO_LIBDEVICE=/usr/local/cuda-9.2/nvvm/libdevice/
