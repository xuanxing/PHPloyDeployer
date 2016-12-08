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
withBranch=0
while getopts "d:l:x:s:bfarc" arg
do
    case $arg in
    d)
        dir=$OPTARG
        registryDir=$dir/registry
    ;;
    b)
        withBranch=1
    ;;
    f)
        fileName=1
    ;;
    x)
        file=$OPTARG.ini
        if [ ! -f $dir/$file ]; then
            echo "$errL server not found: $OPTARG $errR"
            exit 1
        fi
    ;;
    s)
        file=$OPTARG.ini
        server=$OPTARG
        if [[ $withBranch == 1 ]]; then
            branch=`cat $dir/$file | grep 'branch = *'`
            branch=${branch/branch = /}
        fi
    ;;
    a)
        if [ -f "$dir/$file" ]; then
            if [ ! -f "$registryDir/$file" ]; then
                cp "$dir/$file" "$registryDir/$file"
            fi
            if [[ $withBranch == 1 ]]; then
                echo "$infoL + $server: *$infoR $branch"
            else
                echo "$infoL + $server $infoR"
            fi
        else
            echo "$errL server not found: $OPTARG $errR"
            exit 1
        fi
    ;;
    r)
        if [ -f "$dir/$file" ]; then
            if [ -f "$registryDir/$file" ]; then
                rm "$registryDir/$file"
            fi
            if [[ $withBranch == 1 ]]; then
                echo "$infoL + $server: *$infoR $branch"
            else
                echo "$infoL - $server $infoR"
            fi
        else
            echo "$errL server not found: $OPTARG $errR"
            exit 1
        fi
    ;;
    l)
        targetDir=$OPTARG
        for file in `ls -1 $targetDir | grep '.ini$'`
        do
            if [[ $fileName == 1 ]]; then
                echo "$targetDir/$file"
            else
                server=${file/.ini/}
                if [[ $withBranch == 1 ]]; then
                    branch=`cat $targetDir/$file | grep 'branch = *'`
                    branch=${branch/branch = /}
                    echo "$infoL $server: *$infoR $branch"
                else
                    echo "$infoL $server $infoR"
                fi
            fi
        done
    ;;
    c)
        for file in `ls -1 $registryDir | grep '.ini$'`
        do
            server=${file/.ini/}
            rm "$registryDir/$file"
            echo "$infoL - $server $infoR"
        done
    esac
done
exit

dir=$1
branch=$2
for filename in `ls -1 $dir | grep '.ini$'`
do
    if [[ $2 == "--branch" ]]; then
        branchInfo=`cat $dir/$filename | grep 'branch = *'`
        echo "   | \033[35m${filename/.ini/}\033[0m: * ${branchInfo/branch = /}"
    elif [[ $2 == "--file" ]]; then
        echo "$dir/$filename"
    elif [[ $2 == "--delete" ]]; then
        rm $dir/$filename
        echo "   \033[35m- ${filename/.ini/}\033[0m"
    else
        echo "   | \033[36m${filename/.ini/}\033[0m"
    fi
done