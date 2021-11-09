#!/bin/bash
echo $1 | egrep '^[0-9]*$' &> /dev/null
if [ $? = 0 ]
then
  AIRLABS_API_KEY="fb6035e6-a333-41f1-8008-846c0e4d346b"
  curl https://airlabs.co/api/v9/airports.xml?api_key=${AIRLABS_API_KEY} > airports.xml
  curl https://airlabs.co/api/v9/countries.xml?api_key=${AIRLABS_API_KEY} > countries.xml
  curl https://airlabs.co/api/v9/flights.xml?api_key=${AIRLABS_API_KEY} > flights.xml
  java net.sf.saxon.Query extract_data.xq error='no'> flights_data.xml
  rm airports.xml
  rm countries.xml
  rm flights.xml
else
  java net.sf.saxon.Query extract_data.xq error='yes'> flights_data.xml
fi
echo $1 | egrep '^[0-9]+$' &> /dev/null
if [ $? = 0 ]
then
    java net.sf.saxon.Transform -s:flights_data.xml -xsl:flights_data.xsl qty=$1 -o:report.tex
else
    java net.sf.saxon.Transform -s:flights_data.xml -xsl:flights_data.xsl -o:report.tex
fi

pdflatex report.tex &> /dev/null
rm report.aux
rm report.log

