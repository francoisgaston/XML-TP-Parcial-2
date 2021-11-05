#!/bin/bash
AIRLABS_API_KEY="fb6035e6-a333-41f1-8008-846c0e4d346b"
curl https://airlabs.co/api/v9/airports.xml?api_key=${AIRLABS_API_KEY} > airports.xml
curl https://airlabs.co/api/v9/countries.xml?api_key=${AIRLABS_API_KEY} > countries.xml
curl https://airlabs.co/api/v9/flights.xml?api_key=${AIRLABS_API_KEY} > flights.xml