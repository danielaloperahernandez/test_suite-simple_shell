#!/bin/bash
#
# check that the program ls -la is not found if the PATH is empty
# check also that an error message is printed to the user

command="ls -la"
tmp_file="checker_tmp_file_$RANDOM"

# clean up
stop_shell
rm -f $tmp_file

# create a pseudo random file
touch $tmp_file
# empty PATH
OLDPATH="$PATH"
PATH=""
# send commands
$ECHO "$command" | $SHELL > $OUTPUTFILE 2> $ERROROUTPUTFILE &

# put PATH back
PATH="$OLDPATH"

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result
nmatch=`$CAT $OUTPUTFILE | $GREP -c "$tmp_file"`
if [ $nmatch -eq 0 ]; then
    if [ `$CAT $ERROROUTPUTFILE | wc -c` -ge 5 ]; then
	   print_ok
    else
	   print_ok
    fi
else
    print_ko
fi

# clean up
stop_shell
$RM -f $tmp_file
