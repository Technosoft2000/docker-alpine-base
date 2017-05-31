#!/bin/bash

# set default values for userid, username, groupid and groupname if not set yet
PUID=${PUID:=15000}
PUSER=${PUSER:=app}
PGID=${PGID:=15000}
PGROUP=${PGROUP:=app}

# create internal APP group and user
# (which will be mapped to external group and user, and used to run the process)
GN=`getent group $PUID | awk -F':' '{print \$1}'`
if [ $GN ]; then
  echo "[WARNING] A group with id $PGID exists already [in use by $GN] and won't be created."
else
  echo "[INFO] Create group $PGROUP with id $PGID"
  # create group similar to:
  #  addgroup --gid $PGID $PGROUP
  # 
  # changed from:
  #  addgroup -g $PGID $PGROUP
  # to:
  groupmod -o -g "$PGID" "$PGROUP"
fi

UN=`grep "^.*:$PUID" /etc/passwd | awk -F':' '{print \$1}'`
if [ $UN ]; then
  echo "[WARNING] A user with id $PUID exists already [in use by $UN] and won't be created."
else
  echo "[INFO] Create user $PUSER with id $PUID"
  #create user similar to:
  #  adduser --shell /bin/bash --no-create-home --uid $PUID --ingroup $PGROUP --disabled-password --gecos "" $PUSER
  #
  # changed from:
  #  adduser -s /bin/bash -H -u $PUID -G $PGROUP -D -g "" $PUSER
  # to:
  usermod -o -u "$PUID" -g "$PGROUP" "$PUSER"
fi

# set the timezone
source /init/set_timezone.sh
