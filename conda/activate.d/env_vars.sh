#!/bin/sh

export MY_KEY='secret-key-value'
export MY_FILE=/path/to/my/file/


# add blazingdb and blazingdb-protocol python packages

blazingsql_pypath=$CONDA_PREFIX/lib/python3.5/site-packages/blazingsql
blazingsql_runtime_lib_path=$blazingsql_pypath/runtime/lib
cudf_pypath=$blazingsql_runtime_lib_path/python3.5/site-packages/

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$blazingsql_runtime_lib_path:/usr/local/cuda-9.2/lib64/
PYTHONPATH=$PYTHONPATH:$cudf_pypath:$blazingsql_pypath

NUMBAPRO_NVVM=/usr/local/cuda-9.2/nvvm/lib64/libnvvm.so
NUMBAPRO_LIBDEVICE=/usr/local/cuda-9.2/nvvm/libdevice/
