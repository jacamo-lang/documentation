HERE=`pwd`
for f in $(find .. -name "build.gradle"); do
	d=`dirname $f`
	echo $d
	cd $d
	gradle wrapper
	cd $HERE
done
