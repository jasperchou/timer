
#只列目錄：
#ls -la | awk '/^d/{print $NF}'

#只列文件：
#ls -la | awk '/^-/{print $NF}'

#显示文件     ls -l | grep -v '^d'
#显示目录    ls -l | grep '^d'
############################################
###
BaseDir=`pwd`		#默认当前路径
Prefix=$1			#第一个参数，前缀
NewPrefix=$2		#第二个参数，新前缀
#
#
############################################
echo $BaseDir
RenameFilePrefix()
{
	Files=`ls -l ${Prefix}* | awk '/^-/{print $NF}'`
	for File in $Files
	do
		echo $File
		mv "${File}" "${NewPrefix}${File#${Prefix}}"
	done
}

RenameFileAllDir()
{
	Dirs=`ls -l | awk '/^d/{print $NF}'`
	for Dir in $Dirs
	do
		echo $Dir 
		cd $Dir
		RenameFileAllDir $Dir
		cd ..
	done

	RenameFilePrefix 
}

RenameFileAllDir 
echo "rename all done."