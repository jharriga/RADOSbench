# runTEST.sh
# - runs rados bench sequence as listed in Capter 9 of RHCS Admin Guide
# https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/3/html/administration_guide/benchmarking_performance

#--------------------------------------
# FUNCTIONS
function updatelog {
# Echoes passed string to LOGFILE and stdout
    logfn=$2
# Logfile date format, customize it to your wishes
#   - see man date for help
    DATE='date +%Y/%m/%d:%H:%M:%S'

    echo `$DATE`": $1" 2>&1 | tee -a $logfn
}

myPath="${BASH_SOURCE%/*}"
if [[ ! -d "$myPath" ]]; then
    myPath="$PWD" 
fi

# Variables
source "$myPath/vars.shinc"

#--------------------------------------
# Create log file - named in vars.shinc
if [ ! -d $RESULTSDIR ]; then
  mkdir -p $RESULTSDIR || \
    error_exit "$LINENO: Unable to create RESULTSDIR."
fi
touch $LOGFILE || error_exit "$LINENO: Unable to create LOGFILE."
updatelog "${PROGNAME} - Created logfile: $LOGFILE" $LOGFILE

#--------------------------------------
# Begin: RADOS BENCH Sequence

updatelog "${PROGNAME} - Creating pool: $pool" $LOGFILE
ceph osd pool create $pool 100 100 &>> $LOGFILE

echo "++++++++" >> $LOGFILE
updatelog "${PROGNAME} - rados bench WRITE" $LOGFILE
rados bench -p $pool 10 write --no-cleanup &>> $LOGFILE

echo "++++++++" >> $LOGFILE
updatelog "${PROGNAME} - rados bench SEQ" $LOGFILE
rados bench -p $pool 10 seq &>> $LOGFILE

echo "++++++++" >> $LOGFILE
updatelog "${PROGNAME} - rados bench RAND" $LOGFILE
rados bench -p $pool 10 rand &>> $LOGFILE

# End: RADOS Bench Sequence

echo "++++++++" >> $LOGFILE
updatelog "$PROGNAME: Done" $LOGFILE
updatelog "${PROGNAME} - DID NOT delete pool: $pool" $LOGFILE

# DONE
