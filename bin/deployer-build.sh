#! /bin/sh
# v1.1.0

# line format
LR="\033[0m"
cmdL=" ==\033[32m"
cmdR="\033[0m"
infoL="   |\033[36m"
infoR="\033[0m"
errL="\033[31m[error]"
errR="\033[0m"

root=$(cd `dirname $0`; pwd)

# handle options
while getopts "d:w:bc" arg
do
    case $arg in
    d)
        dir=$OPTARG
        registryDir=$dir/registry

    ;;
    w)
        workDir=$OPTARG
        ini=$workDir/phploy.ini
        phar=$workDir/phploy
    ;;
    b)
        echo ";; phploy.ini" > $ini
        for file in `$root/deployer-server.sh -fl $registryDir`
        do
            echo "\n" >> $ini
            cat $file >> $ini
        done
        echo "$infoL + ini: $infoR $ini"
        ln -fs $root/phploy.phar $phar
        echo "$infoL + phar: $infoR $phar"
    ;;
    c)
        if [ -f $ini ]; then
            rm $ini
        fi
        echo "$infoL - ini: $infoR $ini"
        if [ -f $phar ]; then
            rm $phar
        fi
        echo "$infoL - phar: $infoR $phar"
    ;;
    esac
done