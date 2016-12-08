#! /bin/sh
# line format
LR="\033[0m"
cmdL=" ==\033[32m"
cmdR="\033[0m"
infoL="   |\033[36m"
infoR="\033[0m"
errL="\033[31m[error]"
errR="\033[0m"

echo "\033[32mPHPloyDeployer by hoshino. Powered by PHPloy\033[0m"

# init env
root=$(cd `dirname $0`; pwd)
binDir="$root/bin"
serverDir="$root/servers"
registryDir="$serverDir/registry"
if [ ! -d $registryDir ]; then
    mkdir $registryDir
fi
workDir=$root

# handle options
while getopts "hew:sa:d:rbc" arg
do
    case $arg in
    h)
        echo "$cmdL commands: $cmdR"
        echo "   -h          show help"
        echo "   -e          show environment"
        echo "   -w <arg>    set working dir"
        echo "   -s          show available servers"
        echo "   -r          show registered servers"
        echo "   -a <arg>    add a server"
        echo "   -d <arg>    delete a server"
        echo "   -b          build phploy"
        echo "   -c          clean phploy"
        exit
    ;;
    e)
    echo "$cmdL show environment: $cmdR"
        echo "$infoL root $infoR $root"
        echo "$infoL bin $infoR $binDir"
        echo "$infoL servers $infoR $serverDir"
        echo "$infoL registry $infoR $registryDir"
        echo "$infoL working $infoR $workDir"
    ;;
    w)
        workDir=$OPTARG
        $binDir/deployer-env.sh -w $workDir -t
        if [ $? != 0 ]; then
            exit 1
        fi
        echo "$cmdL set working dir: $cmdR"
        echo "$infoL working $infoR $workDir"
    ;;
    s)
    echo "$cmdL show available servers: $cmdR"
        $binDir/deployer-server.sh -l $serverDir
    ;;
    a)
    echo "$cmdL add a server: $cmdR"
        $binDir/deployer-server.sh -d $serverDir -x $OPTARG
        if [ $? != 0 ]; then
            exit 1
        fi
        $binDir/deployer-server.sh -d $serverDir -bs $OPTARG -a
    ;;
    d) echo "$cmdL delete a server: $cmdR"
        $binDir/deployer-server.sh -d $serverDir -x $OPTARG
        if [ $? != 0 ]; then
            exit 1
        fi
        $binDir/deployer-server.sh -d $serverDir -bs $OPTARG -r
    ;;
    r) echo "$cmdL show registered servers: $cmdR"
        $binDir/deployer-server.sh -bl $registryDir
    ;;
    b)
        $binDir/deployer-env.sh -w $workDir -t
        if [ $? != 0 ]; then
            exit 1
        fi
        echo "$cmdL show registries: $cmdR \033[31mplease check with git branches!\033[0m"
        $binDir/deployer-server.sh -bl $registryDir
        echo "$cmdL build phploy $cmdR"
        echo "$infoL working $infoR $workDir"
        $binDir/deployer-build.sh -d $serverDir -w $workDir -b
    ;;
    c)
        echo "$cmdL clean phploy $cmdR"
        echo "$infoL working $infoR $workDir"
        $binDir/deployer-server.sh -d $serverDir -c
        $binDir/deployer-build.sh -d $serverDir -w $workDir -c
    ;;
    ?)
        echo "\033[31mhelp! -[hew:sa:d:rbc]\033[0m"
        exit 1
    ;;
    esac
done
echo "\033[37mall done.\033[0m"
exit