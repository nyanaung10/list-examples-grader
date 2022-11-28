# Create your grading script here

set -e

#CPATH = ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"

rm -rf student-submission
mkdir student-submission
git clone $1 student-submission

cd student-submission/

FILE=ListExamples.java

if [[ -f "$FILE" ]]
then
        echo "File found"
        echo "File cloned"
else
        echo "File not available or file cannot be opened"
        echo "Score is 0"
        exit
fi

cp ../TestListExamples.java ./

set +e

SCORE=0

javac -cp ".;../lib/*" ListExamples.java TestListExamples.java

if [[ $? -eq 0 ]]
then
  SCORE=$(($SCORE+1))
  echo "Score is " $SCORE ""
  echo "Compilation is a success!"
else
  echo "Score is" $SCORE ""
  echo "Compilation unfortunately failed!"
  exit
fi

FAILED=$(java -cp ".;../lib/*" org.junit.runner.JUnitCore TestListExamples | grep -oP "(?<=,  Failures: )[0-9]+")

if [[ $? -eq 1 ]]
then
  SCORE=$(($SCORE+2))
  echo"Score is" $SCORE " "
else
  SCORE=$(($SCORE+2-$FAILED))
  echo"Score is" $SCORE " "
fi


