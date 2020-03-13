#Global Variables

MYFILENAME="git-software-report.txt"
FINALREPORT="git-software-final-report.txt"
GITTEMP="git-temp-status.txt"
MYHOSTNAME=`/bin/hostname`
MYEMAIL="webmaster@sofibox.com"
WARNING_STATUS="OK"
GIT_STATUS="N/A"

/bin/echo "Git software update checked on `date`" > /tmp/$MYFILENAME

## For testing the git status update script
cd /usr/local/bin/maxicron/test-update
echo "For git test"
git remote update
git status > /tmp/$GITTEMP
if (grep -e "Your branch is behind" /tmp/$GITTEMP) then
  echo "(0) [WARNING] git test update has something to update from git" >> /tmp/$MYFILENAME
  WARNING_STATUS="WARNING"
  #echo "TEST".$WARNING_STATUS
else
  # No changes
  #echo "TEST.WARNING STATUS NOT RUNNING"
  echo "(0) [OK] no update found for git test update" >> /tmp/$MYFILENAME
fi
echo "============================"

## For lynic core update for lynis
cd /usr/local/lynis/
echo "For lynis"
git remote update
git status > /tmp/$GITTEMP
#echo $GIT_STATUS
if (grep -e "Your branch is behind" /tmp/$GITTEMP) then
#if [[ `git status --porcelain` ]]; then
  # Changes
 echo "(1) [WARNING] lynis app has something to update from git" >> /tmp/$MYFILENAME
 WARNING_STATUS="WARNING"
 #bin/sed $'s/[^[:print:]\t]//g' /tmp/$MYFILENAME > /tmp/$FINALREPORT
 #bin/mail -s "[git-update-apps][$WARNING_STATUS|N] Git Application Update Scan Report @ $MYHOSTNAME" $MYEMAIL < /tmp/$FINALREPORT

else
  # No changes
  echo "(1) [OK] no update found for lynis app" >> /tmp/$MYFILENAME
fi
echo "============================"

## For twofactor_gauthenticator for roundcube
cd /usr/local/directadmin/custombuild/custom/roundcube/plugins/twofactor_gauthenticator/
echo "For roundcube twofactor gauthenticator"
git remote update
git status > /tmp/$GITTEMP
#if [[ `git status --porcelain` ]]; then
if (grep -e "Your branch is behind" /tmp/$GITTEMP) then
  # Changes
 echo "(2) [WARNING] roundcube twofactor gauthenticator app has something to update from git" >> /tmp/$MYFILENAME
 echo "(a) Use git pull. (b) then ./build roundcube to replace update files at /var/www/html/roundcube/plugins" >> /tmp/$MYFILENAME
 WARNING_STATUS="WARNING"
 #bin/sed $'s/[^[:print:]\t]//g' /tmp/$MYFILENAME > /tmp/$FINALREPORT
 #bin/mail -s "[git-update-apps][$WARNING_STATUS|N] Git Application Update Scan Report @ $MYHOSTNAME" $MYEMAIL < /tmp/$FINALREPORT

else
  # No changes
  echo "(2) [OK] no update found for roundcube twofactor gauthenticator app" >> /tmp/$MYFILENAME
fi
echo "============================"
cd /usr/local/directadmin/custombuild/custom/roundcube/plugins/rcguard/
echo "For rcgurad"
git remote update
git status > /tmp/$GITTEMP
#if [[ `git status --porcelain` ]]; then
if (grep -e "Your branch is behind" /tmp/$GITTEMP) then
  # Changes
 echo "(3) [WARNING] roundcube rcguard app has something to update from git" >> /tmp/$MYFILENAME
 WARNING_STATUS="WARNING"
 #/bin/sed $'s/[^[:print:]\t]//g' /tmp/$MYFILENAME > /tmp/$FINALREPORT
 #/bin/mail -s "[git-update-apps][$WARNING_STATUS|N] Git Application Update Scan Report @ $MYHOSTNAME" $MY$
else
  # No changes
  echo "(3) [OK] no update found for rcguard app" >> /tmp/$MYFILENAME
fi
echo "============================"
#if [ "$WARNING_STATUS" == "WARNING" ]; then
/bin/sed $'s/[^[:print:]\t]//g' /tmp/$MYFILENAME > /tmp/$FINALREPORT
/bin/mail -s "[git-update-apps][$WARNING_STATUS|N] Git Application Update Scan Report @ $MYHOSTNAME" $MYEMAIL < /tmp/$FINALREPORT
#fi

/bin/rm -rf /tmp/$FINALREPORT
/bin/rm -rf /tmp/$MYFILENAME
/bin/rm -rf /tmp/$GITTEMP

/bin/echo "[git-update-apps] Scan status: $WARNING_STATUS"
/bin/echo "[git-update-apps] Done checking system. Email is set to be sent to webmaster@sofibox.com"
/bin/echo "=============================================================================="
