# BlazingSQL
## Description
BlazingSQL is a GPU accelerated SQL engine built on top of the RAPIDS data science framework. RAPIDS is a collection of open-source libraries for end-to-end data science pipelines entirely in the GPU. **BlazingSQL** extends RAPIDS and enables users to run SQL queries on Apache Arrow in GPU memory.

## Requirements

- Ubuntu 16.04 LTS
- CUDA 9.2
- conda
  - See installation:  https://conda.io/projects/continuumio-conda/en/latest/user-guide/install/index.html 

```shell-script
# Install supervisor dependency
sudo apt-get install -y supervisor

# Clone the repo to create a blazingsql conda environment
git clone https://github.com/BlazingDB/blazingsql-conda-environment
cd blazingsql-conda-environment

# Create blazingsql conda environment
conda env create -f blazingsql-py35.yml
 
# Activate the blazingsql conda environment
source activate blazingsql

# Once in the conda environment, you will need to execute a one time script to setup environment variables specific for this conda environment
./setup_environment_variables.sh

# Activate the environment again to make the changes take place
source activate blazingsql
```

## Usage

Once the installation is ready you will have the command *blazingsql*. This command will manage the engine, so before run any query with **PyBlazing** you need to make sure the blazingsql engine is running

The command line tool *blazingsql* has 4 options: start, stop, restart, status. 

```shell-script
# To start the engine
blazingsql start
# To stop the engine
blazingsql stop
# To restart the engine
blazingsql restart
# To check its status
blazingsql status
```

**Note:**
- To know more about blazingsql package: https://anaconda.org/BlazingDB/repo


## Try it out!

First check to make sure that BlazingSQL is running with:
```shell-script
blazingsql status
```
If is off, start it with:
```shell-script
blazingsql start
```

Then, lets create the file **nation.psv** with the content:
```shell-script
0|ALGERIA|0| haggle. carefully final deposits detect slyly agai
1|ARGENTINA|1|al foxes promise slyly according to the regular accounts. bold requests alon
2|BRAZIL|1|y alongside of the pending deposits. carefully special packages are about the ironic forges. slyly special
3|CANADA|1|eas hang ironic, silent packages. slyly regular packages are furiously over the tithes. fluffily bold
4|EGYPT|4|y above the carefully unusual theodolites. final dugouts are quickly across the furiously regular d
5|ETHIOPIA|0|ven packages wake quickly. regu
6|FRANCE|3|refully final requests. regular, ironi
7|GERMANY|3|l platelets. regular accounts x-ray: unusual, regular acco
8|INDIA|2|ss excuses cajole slyly across the packages. deposits print aroun
9|INDONESIA|2| slyly express asymptotes. regular deposits haggle slyly. carefully ironic hockey players sleep blithely. carefull
10|IRAN|4|efully alongside of the slyly final dependencies.
11|IRAQ|4|nic deposits boost atop the quickly final requests? quickly regula
12|JAPAN|2|ously. final, express gifts cajole a
13|JORDAN|4|ic deposits are blithely about the carefully regular pa
14|KENYA|0| pending excuses haggle furiously deposits. pending, express pinto beans wake fluffily past t
15|MOROCCO|0|rns. blithely bold courts among the closely regular packages use furiously bold platelets?
16|MOZAMBIQUE|0|s. ironic, unusual asymptotes wake blithely r
17|PERU|1|platelets. blithely pending dependencies use fluffily across the even pinto beans. carefully silent accoun
18|CHINA|2|c dependencies. furiously express notornis sleep slyly regular accounts. ideas sleep. depos
19|ROMANIA|3|ular asymptotes are about the furious multipliers. express dependencies nag above the ironically ironic account
20|SAUDI ARABIA|4|ts. silent requests haggle. closely express packages sleep across the blithely
21|VIETNAM|2|hely enticingly express accounts. even, final
22|RUSSIA|3| requests against the platelets use never according to the quickly regular pint
23|UNITED KINGDOM|3|eans boost carefully special requests. accounts are. carefull
24|UNITED STATES|1|y final packages. slow foxes cajole quickly. quickly silent platelets breach ironic accounts. unusual pinto be
```

Next, create the file __example_cudf.py__ with the content:
```shell-script
from blazingsql import pyblazing
import cudf
 
column_names = ['n_nationkey', 'n_name', 'n_regionkey', 'n_comments']
column_types = ['int32', 'int64', 'int32', 'int64']
nation_gdf = cudf.read_csv("./nation.psv", delimiter='|',
                           dtype=column_types, names=column_names)
 
print(nation_gdf)
 
tables = {'nation': nation_gdf}
sql = 'select n_nationkey, n_regionkey, n_nationkey + n_regionkey as addition from main.nation'
result_gdf = pyblazing.run_query(sql, tables)
 
print(sql)
print(result_gdf)
```
And finally run the script:
```shell-script
python example_cudf.py
```

## Pandas support
Another example, this time with pandas support. Create file __example_pandas.py__ with the content:

```shell-script
import pandas as pd
from blazingsql import pyblazing
 
column_names = ['n_nationkey', 'n_name', 'n_regionkey', 'n_comments']
column_types = {'n_nationkey': 'int32', 'n_regionkey': 'int64'}
nation_df = pd.read_csv("./nation.psv", delimiter='|',
                        dtype=column_types, names=column_names)
nation_df = nation_df[['n_nationkey', 'n_regionkey']]
 
print(nation_df)
 
tables = {'nation': nation_df}
sql = 'select n_nationkey, n_regionkey, n_nationkey + n_regionkey as addition from main.nation'
result_gdf = pyblazing.run_query_pandas(sql, tables)
 
print(sql)
print(result_gdf)
```

Run the script:
```shell-script
python example_pandas.py
```

Shutdown BlazingSQL
```shell-script
blazingsql stop
```

**Note:**
- You can find our **BlazingSQL** documentation at https://docs.blazingdb.com/
- To know more about *blazingsql* package: https://anaconda.org/BlazingDB/repo
- To find  out more about **BlazingDB** go next link: **https://blazingdb.com/#/**





