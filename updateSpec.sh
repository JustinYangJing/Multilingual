#!/bin/bash
#set -e 
set +u

podName=$1

if [ ! $podName ]; then
	echo -e "podName name cant be nil ,\nthe intput fatmat is ./updateSpec.sh podName \n"
	echo "press any key for exit"
	read end 
	exit 
fi

#commit code to server
git checkout master
git add .
git commit -m "for update pod specs"
git push origin master

version=`cat ${podName} | grep "s.version" | cut -d "\"" -f 2`
echo -e "💚  💚  💚  you want to update ${version} to pod pod sepc?  💚  💚  💚"
echo -e "💚  💚  💚  press y to continue,prees q to exit  💚  💚  💚"
read input
while ( [[ $input != "y" ]] && [[ $input != "q" ]] ); do
	echo -e "💚  💚  💚  press y to continue,press q to exit  💚  💚  💚"
	read input
done

if [[ $input == "q" ]]; then
	exit
fi

haveThisVersion="NO"
podSpecDir=${podName%%.podspec}
for v in `ls ~/.cocoapods/repos/mySpecs/`; do
	if [[ $v ==  ${podSpecDir} ]]; then
		haveThisVersion="YES"
	fi
done
if [[ ${haveThisVersion} == "NO" ]]; then
	mkdir ~/.cocoapods/repos/mySpecs/${podSpecDir}
fi

haveThisVersion="NO"
for v in `ls ~/.cocoapods/repos/mySpecs/${podSpecDir}`; do
	if [[ ${v} == ${version} ]]; then
		haveThisVersion="YES"
	fi
done

if [[ ${haveThisVersion} == "NO" ]]; then
	mkdir ~/.cocoapods/repos/mySpecs/${podSpecDir}/${version}
fi
cp ${podName} ~/.cocoapods/repos/mySpecs/${podSpecDir}/${version}/${podName}

#append commit id to .podspec
commitId=`git log --pretty=oneline | sed -n '1p' | cut -d " " -f 1`
preDir=`pwd`
cd  ~/.cocoapods/repos/mySpecs/
#echo -e "`pwd` -- ${podSpecDir}/${version}/${podName}"
commitStr=`cat ${podSpecDir}/${version}/${podName} | grep ":commit =>"`
if [[ ! $commitStr ]]; then
	source=`cat ${podSpecDir}/${version}/${podName} | grep "s.source"`
	source=${source#*https:}
	source=${source%%\}*}
	sed -i.bak "s:${source}:${source}, \:commit => \"${commitId}\":g" ${podSpecDir}/${version}/${podName}
	rm ${podSpecDir}/${version}/${podName}.bak
else
	sed -i.bak "s:\(commit =>\).*:\1 \"${commitId}\" \}:g" ${podSpecDir}/${version}/${podName}
	rm ${podSpecDir}/${version}/${podName}.bak
fi

git add .
git commit -m "update ${podSpecDir}/${version}"
git push origin master
cd ${preDir}