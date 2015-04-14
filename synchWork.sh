#!/bin/sh
from=~/Desktop/dev/work/localspace
to=~/Desktop/dev/work/synch

if [ $# -ge 1 ]; then
	from=$1
fi

if [ $# -ge 2 ]; then
	to=$2
fi

fromvision=$from/.vision.m

tovision=$to/.vision.m
if [ ! -f "$fromvision" ]; then
	echo '创建$fromvision文件'
	touch $fromvision
	echo '1' >> $fromvision 
fi

if [ ! -f "$tovision" ]; then
        echo '创建$tovision文件'
        touch $tovision
        echo '0' >> $tovision
fi

fromvar=$(cat $fromvision)
tovar=$(cat $tovision)

if [ ! "$fromvar" = "$tovar" ]; then
   #开始拷贝文件
   cp -fr $from/ $to/
  
   if [ -d "$to/.svn" ]; then
	rm -fr $to/.svn
   fi

   #上传到github
	cd $to
	git pull
	git add .
	git commit -m 'update'
	git push origin master
	
	cd -
   #拷贝完后，给来源方版本加1
   let "fromvar = $fromvar + 1"
   echo $fromvar >> $fromvision
fi



