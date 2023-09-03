#!/bin/bash
test_file=$1
chmod +x $test_file
echo "Test for args started"
./$test_file > /dev/null
testOut=`echo $?`
if [[ $testOut -eq 1 ]]
then
    echo "Test passed"
else
    echo "Test failed"
    exit 1
fi
echo "Main test"
./$test_file 18 > /dev/null
echo "1"
testOut=`echo $?`
if [[ $testOut -eq 1 ]]
then
    echo "Test passed"
else
    echo "Test failed"
    exit 1
fi

