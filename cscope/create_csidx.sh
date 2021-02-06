find "$1" -name "*.c" -o -name  "*.cpp" -o -name "*.cc" -o -name "*.h" > cscope/"$1".files
cscope -bkq -i cscope/"$1".files -f cscope/"$1".out

echo "`ls cscope/*.out`" >cscope/load_list.vim
rm cscope/load.vim
sed 's/^/cs add &/g' cscope/load_list.vim >>cscope/load.vim
rm cscope/load_list.vim

echo "done"
