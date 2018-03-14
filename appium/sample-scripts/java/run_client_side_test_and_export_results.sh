#!/bin/bash

file=target/sessionid.txt
if [ -f $file ]
then 
    rm $file
fi 

mvn clean install -X -Dtest=$test -DexecutionType=$executionType -DapiKey=$bitbarApiKey -DapplicationPath=$applicationPath -Dtestdroid_project=$testdroid_project
#mvn clean test -DexportResults=true ${@} 

sessionid=$(head -n 1 target/sessionid.txt)
echo "Uploading results file for "$sessionid
cp target/surefire-reports/junitreports/TEST-*.xml target/TEST-all.xml
address="http://appium.testdroid.com/upload/result?sessionId="$sessionid
results=$PWD"/target/TEST-all.xml"
curl -i -F result=@$results $address
