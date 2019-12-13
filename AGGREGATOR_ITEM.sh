#!/bin/sh
ID="X"
GROUP="A"
#
BUFFER=500
TODAY=`date +"%Y%m%d"`
LOGFILE="/tmp/item_$TODAY.log"
LOCK_FILE="/tmp/item.lock"
CMD="/root/update_item $LOGFILE $BUFFER 0 U"
OKFILE="/mnt/search/${ID}.ok"
GROUP_LOCK="/mnt/search/update_item_group_${GROUP}.lock"
LOCK_CHECK_LIST="/mnt/search/BIG_LOCK.lock $GROUP_LOCK $OKFILE $LOCK_FILE"
LOCK_CHECK_LIST="/mnt/search/BIG_LOCK.lock $LOCK_FILE"
#
echo ""
echo "START "`date`
#
if [ "$1" = "FORCE" ]; then
  echo "FORCE mode"
  echo $CMD
  touch $LOCK_FILE
  $CMD
  rm -f $LOCK_FILE
  touch $OKFILE
  echo "FINISH "`date`
  exit
fi
#
if [ ! -f $GROUP_LOCK ]; then
  echo "NOT THIS GROUP"
  exit
fi
#
RUN="Y"
for LOCKER in $LOCK_CHECK_LIST
do
  echo -n "... check ${LOCKER} "
  if [ -f $LOCKER ]; then
    echo "EXIST!"
    RUN="N"
  else
    echo "notexist"
  fi
done
#
echo ""
if [ $RUN = "Y" ]; then
  echo $CMD
  touch $LOCK_FILE
  $CMD
  rm -f $LOCK_FILE
  touch $OKFILE
else
  echo "DO NOTHING"
fi
#
echo "FINISH "`date`
