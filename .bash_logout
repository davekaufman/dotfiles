# I like a truly permanent history please.  this works around bash and multiple
# logins/subshells sometimes truncating/losing history entries by temporarily
# offloading the contents of bash_history somewhere else.  awk ensures that the
# history file only contains unique commands and thus isn't full of cruft like
# "ls -al foo" a thousand times.

\cat ~/.bash_history >> ~/.history
awk '!x[$0]++' ~/.history > ~/.bash_history
sed -i 's/[[:blank:]]*$//' ~/.bash_history
cp ~/.bash_history ~/.history
rm ${XAUTHORITY} 2>/dev/null
