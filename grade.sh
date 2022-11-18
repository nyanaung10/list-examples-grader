# Create your grading script here

set -e

#CPATH = ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"

rm -rf student-submission
mkdir student-submission
git clone $1 student-submission

cp GradeServer.java student-submission/
#cp Server.java student-submission/

cd student-submission
ls
echo "hi we are in the submission"
if test -f "ListExamples.java"
then set +e
echo "this worked"
else echo "Wrong File!" 
    exit
fi

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2>compiler-err.txt

if [[$? -eq 0]]
then echo "Compilation Success!"
else echo "Compilation Failed!"
    exit
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples.java

if [[$? -eq 0]]
then echo "passed!"
else echo "failed"
    exit
fi 

