# single-cell-worm
The C. elegans transcriptome at single cell resolution

## Installation steps

### Install Python

```
cd ~/downloads
wget https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz
tar -xvzf Python-2.7.14.tgz
cd Python-2.7.14/
./configure
make
```

### Install pip

```
cd ~/downloads
wget https://pypi.python.org/packages/11/b6/abcb525026a4be042b486df43905d6893fb04f05aac21c32c638e939e447/pip-9.0.1.tar.gz#md5=35f01da33009719497f01a4ba69d63c9
tar -xvzf pip-9.0.1.tar.gz
cd pip-9.0.1/
python get-pip.py --user

# Add the following to .bash_profile
alias pip='python -m pip'
```

### Install cutadapt

```
cd ~/downloads
pip install --user --upgrade cutadapt

# Alternatively,
# python -m pip install --user --upgrade cutadapt
```

### Install TrimGalore

```
cd ~/downloads
wget https://github.com/FelixKrueger/TrimGalore/archive/0.4.5.zip
unzip 0.4.5.zip
cd TrimGalore-0.4.5/
cp trim_galore ~/bin/
```

### Install GNU parallel

```
cd ~/downloads
(wget -O - pi.dk/3 || curl pi.dk/3/ || fetch -o - http://pi.dk/3) | bash
```

### Install samtools

```
wget https://sourceforge.net/projects/samtools/files/samtools/1.3/samtools-1.3.tar.bz2
wget https://sourceforge.net/projects/samtools/files/samtools/1.3/htslib-1.3.tar.bz2
wget https://sourceforge.net/projects/samtools/files/samtools/1.3/bcftools-1.3.tar.bz2

tar -vxjf samtools-1.3.tar.bz2
tar -vxjf htslib-1.3.tar.bz2
tar -vxjf bcftools-1.3.tar.bz2

cd samtools-1.3/
./configure
make



```