#!/bin/bash

LOCAL=`dirname $0`;
cd $LOCAL
cd ../


PWD=`pwd`

read INPUT_JSON
FILENAME=$(echo $INPUT_JSON | jq -r .parameters.alert.data.virustotal.source.file)
COMMAND=$(echo $INPUT_JSON | jq -r .command)
LOG_FILE="${PWD}/../logs/active-responses.log"
PASSWORD="SomePassword"
QUARANTINE="/var/ossec/quarantine"


if [ ${COMMAND} = "add" ]
then
 # Send control message to execd
 printf '{"version":1,"origin":{"name":"remove-threat","module":"active-response"},"command":"check_keys", "parameters":{"keys":[]}}\n'

 read RESPONSE
 COMMAND2=$(echo $RESPONSE | jq -r .command)
 if [ ${COMMAND2} != "continue" ]
 then
  echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Moviendo amenaza a cuarentena" >> ${LOG_FILE}
  exit 0;
 fi
fi

# Se mueve la amenaza al directorio de cuarentena que despues se recogera para analisis en honeypod y se elimina
NOW=$(date '+%Y%m%d_%H%M%S')
#echo "##DEBUG--> /usr/bin/zip -q --password $PASSWORD $QUARANTINE/${FILENAME##*/}_$NOW.zip $FILENAME" >> ${LOG_FILE}
/usr/bin/zip -q --password $PASSWORD $QUARANTINE/${FILENAME##*/}_$NOW.zip $FILENAME && rm -f $FILENAME && rm -f $FILENAME
if [ $? -eq 0 ]; then
 echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Se ha trasladado la amenaza a cuarentena correctamente" >> ${LOG_FILE}
else
 echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Error moviendo amenaza a la cuarentena" >> ${LOG_FILE}
fi

exit 0;
