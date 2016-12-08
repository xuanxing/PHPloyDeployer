#! /bin/sh
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
while getopts "w:t" arg
do
    case $arg in
    w)
        workDir=$OPTARG
        if [[ $workDir == "." ]]; then
            cd $root
            cd ..
            workDir=`pwd`
            cd $root
        fi
    ;;
    t)
        echo "$cmdL test working dir: $cmdR"
        # test dir
        if [ ! -d $workDir ]; then
            echo "$infoL dir test: $infoR"
            echo "$errL is not a directory: $workDir $errR"
            exit 1
        else
            echo "$infoL dir test: $infoR $workDir "
        fi
        # test git
        if [ ! -d "$workDir/.git" ]; then
            echo "$infoL git test: $infoR"
            echo "$errL git not found in: $workDir $errR"
            exit 1
        else
            echo "$infoL git test: $infoR $workDir/.git"
        fi
        # show git branches
        echo "$infoL git branches: $infoR \033[31mplease confirm!\033[0m"
        for branch in `git branch`
        do
            if [ ! -d $branch ] && [ ! -f $branch ]; then
                echo "$infoL *$infoR $branch"
            fi
        done
    ;;
    esac
done