#!/bin/bash

# set default values for userid, username, groupid and groupname if not set yet
PUID=${PUID:=15000}
PUSER=${PUSER:=app}
PGID=${PGID:=15000}
PGROUP=${PGROUP:=app}

# create internal APP group and user
# (which will be mapped to external group and user, and used to run the process)
GN=`getent group $PGID | awk -F':' '{print \$1}'`
if [ $GN ]; then
  echo "[WARNING] A group with id $PGID exists already [in use by $GN] and will be modified."
  # rename the existing group to the specified app group name
  echo "[WARNING] The group $GN will be renamed to $PGROUP"
  groupmod -n $PGROUP $GN
else
  echo "[INFO] Create group $PGROUP with id $PGID"
  # create group similar to:
  #  addgroup --gid $PGID $PGROUP
  addgroup -g $PGID $PGROUP
fi

UN=`getent passwd $PUID | awk -F':' '{print \$1}'`
if [ $UN ]; then
  echo "[WARNING] A user with id $PUID exists already [in use by $UN]."
  # create the specified app user name with the same user id (non-unique)
  TEMPORARY_PUID=999
  echo "[WARNING] Create user $PUSER with temporary user id $TEMPORARY_PUID."
  adduser -s /bin/bash -H -u $TEMPORARY_PUID -G $PGROUP -D -g "" $PUSER
  #-o, --non-unique ... when used with the -u option, this option allows to change the user ID to a non-unique value.
  echo "[WARNING] Assign non-unique user id $PUID to created user $PUSER"
  usermod -o -u $PUID $PUSER
else
  echo "[INFO] Create user $PUSER with id $PUID"
  #create user similar to:
  #  adduser --shell /bin/bash --no-create-home --uid $PUID --ingroup $PGROUP --disabled-password --gecos "" $PUSER
  adduser -s /bin/bash -H -u $PUID -G $PGROUP -D -g "" $PUSER
fi

# set the timezone
source /init/set_timezone.sh
