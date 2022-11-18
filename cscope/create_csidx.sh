#!/bin/bash

DYEL='\E[0;33m'
DYELL='\E[43;30m'
GRN='\E[1;32m'
RES='\E[0m'

exclude_files="./cscope/file.exclude"
file_type_cmd="-name *.c -o -name  *.cpp -o -name .cc -o -name *.h -o -name *.java"

exec_cscope_cmd()
{
    echo "Execute cscope command ..."
    for file in `ls cscope/*.files`
    do
        cscope -bkq -i $file -f ${file%%.files}.out
    done
}

generate_load_file()
{
    if [ `ls cscope/*.out | wc -l` -ge "1" ]; then
        echo "`ls cscope/*.out`" >cscope/load_list.vim
    else
        echo "there is no *.out"
    fi
    
    if [ -f cscope/load.vim ]; then
        rm cscope/load.vim
    fi
    
    if [ -f cscope/load_list.vim ]; then
        sed 's/^/cs add &/g' cscope/load_list.vim >>cscope/load.vim
    fi
    
    if [ -f cscope/load_list.vim ]; then
        rm cscope/load_list.vim
    fi
}

if [ $# == 0 ];then
    echo "Usage:"
    echo "  1. build all:  $0 <dir1> [<dir2> <dir3> ...]"
    echo "  2. rebuild:    $0 rebuild"
    exit 1
elif [ "$1" == "rebuild" ];then
    if [ `ls cscope/*.files | wc -l` -le "0" ];then
        echo -e "${DYEL}Warning, cannot rebuild because of no cscope/*.files${RES}"
        exit -1
    else
        echo "Rebuilding ..."
        exec_cscope_cmd
        generate_load_file
        echo -e "${GRN}Done.${RES}"
        exit 0
    fi
else
    echo -e "${DYEL}No $exclude_files, you can edit it to exclude directory.${RES}"
    echo "Building all ..."
    #删除原有的文件
    if [ `ls cscope/*.files | wc -l` -ge "1" ];then
        rm cscope/*.files
    fi
    for i in $*;
    do
        if [ $1 != '' ];then
            #当前目录需要排除的文件列表
            exfiles_cmd=""
            for file in `cat $exclude_files`;
            do
               if [ $1 == ${1::${#file}} ];then
                   exfiles_cmd="$exfiles_cmd -not ( -path ${file%%/} -prune )"
               fi
            done
            #保存源文件
            file_name=${1%%/}
            file_name=${file_name//\//+}
            find $1 $exfiles_cmd $file_type_cmd > cscope/$file_name.files

            shift
        fi
    done
fi

exec_cscope_cmd
generate_load_file
echo -e "${GRN}Success.${RES}"
exit 0
