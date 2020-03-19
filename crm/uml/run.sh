#!/bin/sh

if [ ! -f plantuml.jar ]; then
    curl -L https://downloads.sourceforge.net/project/plantuml/plantuml.jar --output plantuml.jar
fi

java -jar plantuml.jar -o images .
