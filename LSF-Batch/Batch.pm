package LSF::Batch;

no warnings 'once';
#use strict;
use Carp;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK $AUTOLOAD);

use Exporter;
use DynaLoader;
use LSF::Base;                                              
@ISA = qw(Exporter DynaLoader);    
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(
    ACT_DONE
    ACT_FAIL
    ACT_NO
    ACT_PREEMPT
    ACT_START
    ALL_CALENDARS
    ALL_EVENTS
    ALL_JOB
    ALL_QUEUE
    ALL_USERS
    CALADD
    CALDEL
    CALMOD
    CALOCCS
    CALUNDEL
    CAL_FORCE
    CHECK_HOST
    CHECK_USER
    CONF_CHECK
    CONF_EXPAND
    CONF_NO_CHECK
    CONF_NO_EXPAND
    CONF_RETURN_HOSTSPEC
    CUR_JOB
    DEFAULT_MSG_DESC
    DEFAULT_NUMPRO
    DELETE_NUMBER
    DEL_NUMPRO
    DFT_QUEUE
    DONE_JOB
    EVEADD
    EVEDEL
    EVEMOD
    EVENT_ACTIVE
    EVENT_CAL_DELETE
    EVENT_CAL_MODIFY
    EVENT_CAL_NEW
    EVENT_CAL_UNDELETE
    EVENT_CHKPNT
    EVENT_HOST_CTRL
    EVENT_INACTIVE
    EVENT_JGRP_ADD
    EVENT_JGRP_CTRL
    EVENT_JGRP_MOD
    EVENT_JGRP_STATUS
    EVENT_JOB_ACCEPT
    EVENT_JOB_ATTA_DATA
    EVENT_JOB_ATTR_SET
    EVENT_JOB_CHUNK
    EVENT_JOB_CLEAN
    EVENT_JOB_EXCEPTION
    EVENT_JOB_EXECUTE
    EVENT_JOB_EXT_MSG
    EVENT_JOB_FINISH
    EVENT_JOB_FORCE
    EVENT_JOB_FORWARD
    EVENT_JOB_MODIFY
    EVENT_JOB_MODIFY2
    EVENT_JOB_MOVE
    EVENT_JOB_MSG
    EVENT_JOB_MSG_ACK
    EVENT_JOB_NEW
    EVENT_JOB_OCCUPY_REQ
    EVENT_JOB_REQUEUE
    EVENT_JOB_ROUTE
    EVENT_JOB_SIGACT
    EVENT_JOB_SIGNAL
    EVENT_JOB_START
    EVENT_JOB_START_ACCEPT
    EVENT_JOB_STATUS
    EVENT_JOB_SWITCH
    EVENT_JOB_VACATED
    EVENT_LOAD_INDEX
    EVENT_LOG_SWITCH
    EVENT_MBD_DIE
    EVENT_MBD_START
    EVENT_MBD_UNFULFILL
    EVENT_MIG
    EVENT_PRE_EXEC_START
    EVENT_QUEUE_CTRL
    EVENT_REJECT
    EVENT_SBD_JOB_STATUS
    EVENT_SBD_UNREPORTED_STATUS
    EVENT_STATUS_ACK
    EVENT_TYPE_EXCLUSIVE
    EVENT_TYPE_LATCHED
    EVENT_TYPE_PULSE
    EVENT_TYPE_PULSEALL
    EVENT_TYPE_UNKNOWN
    EVE_HIST
    EV_EXCEPT
    EV_FILE
    EV_UNDEF
    EV_USER
    EXIT_INIT_ENVIRON
    EXIT_KILL_ZOMBIE
    EXIT_NORMAL
    EXIT_NO_MAPPING
    EXIT_PRE_EXEC
    EXIT_REMOTE_PERMISSION
    EXIT_REMOVE
    EXIT_REQUEUE
    EXIT_RERUN
    EXIT_RESTART
    EXIT_ZOMBIE
    EXIT_ZOMBIE_JOB
    EXT_ATTA_POST
    EXT_ATTA_READ
    EXT_DATA_AVAIL
    EXT_DATA_NOEXIST
    EXT_DATA_UNAVAIL
    EXT_DATA_UNKNOWN
    EXT_MSG_POST
    EXT_MSG_READ
    EXT_MSG_REPLAY
    FINISH_PEND
    GROUP_JLP
    GROUP_MAX
    GRP_ALL
    GRP_RECURSIVE
    GRP_SHARES
    HOST_BUSY_IO
    HOST_BUSY_IT
    HOST_BUSY_LS
    HOST_BUSY_MEM
    HOST_BUSY_NOT
    HOST_BUSY_PG
    HOST_BUSY_R15M
    HOST_BUSY_R15S
    HOST_BUSY_R1M
    HOST_BUSY_SWP
    HOST_BUSY_TMP
    HOST_BUSY_UT
    HOST_CLOSE
    HOST_GRP
    HOST_JLU
    HOST_NAME
    HOST_OPEN
    HOST_REBOOT
    HOST_SHUTDOWN
    HOST_STAT_BUSY
    HOST_STAT_DISABLED
    HOST_STAT_EXCLUSIVE
    HOST_STAT_FULL
    HOST_STAT_LOCKED
    HOST_STAT_NO_LIM
    HOST_STAT_OK
    HOST_STAT_UNAVAIL
    HOST_STAT_UNLICENSED
    HOST_STAT_UNREACH
    HOST_STAT_WIND
    HPART_HGRP
    H_ATTR_CHKPNTABLE
    H_ATTR_CHKPNT_COPY
    JGRP_ACTIVE
    JGRP_ARRAY_INFO
    JGRP_COUNT_NDONE
    JGRP_COUNT_NEXIT
    JGRP_COUNT_NJOBS
    JGRP_COUNT_NPSUSP
    JGRP_COUNT_NRUN
    JGRP_COUNT_NSSUSP
    JGRP_COUNT_NUSUSP
    JGRP_COUNT_PEND
    JGRP_DEL
    JGRP_HOLD
    JGRP_INACTIVE
    JGRP_INFO
    JGRP_NODE_ARRAY
    JGRP_NODE_GROUP
    JGRP_NODE_JOB
    JGRP_RECURSIVE
    JGRP_RELEASE
    JGRP_RELEASE_PARENTONLY
    JGRP_UNDEFINED
    JOBID_ONLY
    JOBID_ONLY_ALL
    JOB_STAT_DONE
    JOB_STAT_EXIT
    JOB_STAT_NULL
    JOB_STAT_PDONE
    JOB_STAT_PEND
    JOB_STAT_PERR
    JOB_STAT_PSUSP
    JOB_STAT_RUN
    JOB_STAT_SSUSP
    JOB_STAT_UNKWN
    JOB_STAT_USUSP
    JOB_STAT_WAIT
    LAST_JOB
    LOST_AND_FOUND
    LSBATCH_H
    LSBE_AFS_TOKENS
    LSBE_ARRAY_NULL
    LSBE_BAD_ARG
    LSBE_BAD_ATTA_DIR
    LSBE_BAD_CALENDAR
    LSBE_BAD_CHKLOG
    LSBE_BAD_CLUSTER
    LSBE_BAD_CMD
    LSBE_BAD_EVENT
    LSBE_BAD_EXT_MSGID
    LSBE_BAD_FRAME
    LSBE_BAD_GROUP
    LSBE_BAD_HOST
    LSBE_BAD_HOST_SPEC
    LSBE_BAD_HPART
    LSBE_BAD_IDX
    LSBE_BAD_JOB
    LSBE_BAD_JOBID
    LSBE_BAD_LIMIT
    LSBE_BAD_PROJECT_GROUP
    LSBE_BAD_QUEUE
    LSBE_BAD_RESOURCE
    LSBE_BAD_RESREQ
    LSBE_BAD_SIGNAL
    LSBE_BAD_SUBMISSION_HOST
    LSBE_BAD_TIME
    LSBE_BAD_TIMEEVENT
    LSBE_BAD_UGROUP
    LSBE_BAD_USER
    LSBE_BAD_USER_PRIORITY
    LSBE_BIG_IDX
    LSBE_CAL_CYC
    LSBE_CAL_DISABLED
    LSBE_CAL_EXIST
    LSBE_CAL_MODIFY
    LSBE_CAL_USED
    LSBE_CAL_VOID
    LSBE_CHKPNT_CALL
    LSBE_CHUNK_JOB
    LSBE_CONF_FATAL
    LSBE_CONF_WARNING
    LSBE_CONN_EXIST
    LSBE_CONN_NONEXIST
    LSBE_CONN_REFUSED
    LSBE_CONN_TIMEOUT
    LSBE_COPY_DATA
    LSBE_DEPEND_SYNTAX
    LSBE_DLOGD_ISCONN
    LSBE_EOF
    LSBE_ESUB_ABORT
    LSBE_EVENT_FORMAT
    LSBE_EXCEPT_ACTION
    LSBE_EXCEPT_COND
    LSBE_EXCEPT_SYNTAX
    LSBE_EXCLUSIVE
    LSBE_FRAME_BAD_IDX
    LSBE_FRAME_BIG_IDX
    LSBE_HJOB_LIMIT
    LSBE_HP_FAIRSHARE_DEF
    LSBE_INDEX_FORMAT
    LSBE_INTERACTIVE_CAL
    LSBE_INTERACTIVE_RERUN
    LSBE_JGRP_BAD
    LSBE_JGRP_CTRL_UNKWN
    LSBE_JGRP_EXIST
    LSBE_JGRP_HASJOB
    LSBE_JGRP_HOLD
    LSBE_JGRP_NULL
    LSBE_JOB_ARRAY
    LSBE_JOB_ATTA_LIMIT
    LSBE_JOB_CAL_MODIFY
    LSBE_JOB_DEP
    LSBE_JOB_ELEMENT
    LSBE_JOB_EXIST
    LSBE_JOB_FINISH
    LSBE_JOB_FORW
    LSBE_JOB_MODIFY
    LSBE_JOB_MODIFY_ONCE
    LSBE_JOB_MODIFY_USED
    LSBE_JOB_REQUEUED
    LSBE_JOB_REQUEUE_REMOTE
    LSBE_JOB_STARTED
    LSBE_JOB_SUSP
    LSBE_JS_DISABLED
    LSBE_J_UNCHKPNTABLE
    LSBE_J_UNREPETITIVE
    LSBE_LOCK_JOB
    LSBE_LSBLIB
    LSBE_LSLIB
    LSBE_MBATCHD
    LSBE_MC_CHKPNT
    LSBE_MC_EXCEPTION
    LSBE_MC_HOST
    LSBE_MC_REPETITIVE
    LSBE_MC_TIMEEVENT
    LSBE_MIGRATION
    LSBE_MOD_JOB_NAME
    LSBE_MSG_DELIVERED
    LSBE_MSG_RETRY
    LSBE_NOLSF_HOST
    LSBE_NOMATCH_CALENDAR
    LSBE_NOMATCH_EVENT
    LSBE_NOT_STARTED
    LSBE_NO_CALENDAR
    LSBE_NO_ENOUGH_HOST
    LSBE_NO_ENV
    LSBE_NO_ERROR
    LSBE_NO_EVENT
    LSBE_NO_FORK
    LSBE_NO_GROUP
    LSBE_NO_HOST
    LSBE_NO_HOST_GROUP
    LSBE_NO_HPART
    LSBE_NO_IFREG
    LSBE_NO_INTERACTIVE
    LSBE_NO_JOB
    LSBE_NO_JOBID
    LSBE_NO_JOBMSG
    LSBE_NO_JOB_PRIORITY
    LSBE_NO_LICENSE
    LSBE_NO_MEM
    LSBE_NO_OUTPUT
    LSBE_NO_RESOURCE
    LSBE_NO_USER
    LSBE_NO_USER_GROUP
    LSBE_NQS_BAD_PAR
    LSBE_NQS_NO_ARRJOB
    LSBE_NUM_ERR
    LSBE_ONLY_INTERACTIVE
    LSBE_OP_RETRY
    LSBE_OVER_LIMIT
    LSBE_OVER_RUSAGE
    LSBE_PEND_CAL_JOB
    LSBE_PERMISSION
    LSBE_PERMISSION_MC
    LSBE_PJOB_LIMIT
    LSBE_PORT
    LSBE_PREMATURE
    LSBE_PROC_NUM
    LSBE_PROTOCOL
    LSBE_PTY_INFILE
    LSBE_QJOB_LIMIT
    LSBE_QUEUE_CLOSED
    LSBE_QUEUE_HOST
    LSBE_QUEUE_NAME
    LSBE_QUEUE_USE
    LSBE_QUEUE_WINDOW
    LSBE_ROOT
    LSBE_RUN_CAL_JOB
    LSBE_SBATCHD
    LSBE_SBD_UNREACH
    LSBE_SERVICE
    LSBE_SP_CHILD_DIES
    LSBE_SP_CHILD_FAILED
    LSBE_SP_COPY_FAILED
    LSBE_SP_DELETE_FAILED
    LSBE_SP_FAILED_HOSTS_LIM
    LSBE_SP_FIND_HOST_FAILED
    LSBE_SP_FORK_FAILED
    LSBE_SP_SPOOLDIR_FAILED
    LSBE_SP_SRC_NOT_SEEN
    LSBE_START_TIME
    LSBE_STOP_JOB
    LSBE_SYNTAX_CALENDAR
    LSBE_SYSCAL_EXIST
    LSBE_SYS_CALL
    LSBE_TIME_OUT
    LSBE_UGROUP_MEMBER
    LSBE_UJOB_LIMIT
    LSBE_UNKNOWN_EVENT
    LSBE_UNSUPPORTED_MC
    LSBE_USER_JLIMIT
    LSBE_XDR
    LSB_CHKPERIOD_NOCHNG
    LSB_CHKPNT_COPY
    LSB_CHKPNT_FORCE
    LSB_CHKPNT_KILL
    LSB_CHKPNT_MIG
    LSB_CHKPNT_STOP
    LSB_EVENT_VERSION3_0
    LSB_EVENT_VERSION3_1
    LSB_EVENT_VERSION3_2
    LSB_EVENT_VERSION4_0
    LSB_KILL_REQUEUE
    LSB_MAX_ARRAY_IDX
    LSB_MAX_ARRAY_JOBID
    LSB_MAX_SD_LENGTH
    LSB_MODE_BATCH
    LSB_MODE_JS
    LSB_SIG_NUM
    LSF_JOBIDINDEX_FILENAME
    LSF_JOBIDINDEX_FILETAG
    MASTER_CONF
    MASTER_FATAL
    MASTER_MEM
    MASTER_NULL
    MASTER_RECONFIG
    MASTER_RESIGN
    MAXDESCLEN
    MAXPATHLEN
    MAX_CALENDARS
    MAX_CHARLEN
    MAX_CMD_DESC_LEN
    MAX_GROUPS
    MAX_HPART_USERS
    MAX_LSB_NAME_LEN
    MAX_USER_EQUIVALENT
    MAX_USER_MAPPING
    MAX_VERSION_LEN
    MBD_CKCONFIG
    MBD_RECONFIG
    MBD_RESTART
    MSGSIZE
    NO_PEND_REASONS
    NQSQ_GRP
    NQS_ROUTE
    NQS_SERVER
    NQS_SIG
    NUM_JGRP_COUNTERS
    PEND_ADMIN_STOP
    PEND_CHKPNT_DIR
    PEND_CHUNK_FAIL
    PEND_HAS_RUN
    PEND_HOST_ACCPT_ONE
    PEND_HOST_DISABLED
    PEND_HOST_EXCLUSIVE
    PEND_HOST_JOB_LIMIT
    PEND_HOST_JOB_RUSAGE
    PEND_HOST_JOB_SSUSP
    PEND_HOST_JS_DISABLED
    PEND_HOST_LESS_SLOTS
    PEND_HOST_LOAD
    PEND_HOST_LOCKED
    PEND_HOST_MISS_DEADLINE
    PEND_HOST_NONEXCLUSIVE
    PEND_HOST_NO_LIM
    PEND_HOST_NO_USER
    PEND_HOST_PART_PRIO
    PEND_HOST_PART_USER
    PEND_HOST_QUE_MEMB
    PEND_HOST_QUE_RESREQ
    PEND_HOST_QUE_RUSAGE
    PEND_HOST_RES_REQ
    PEND_HOST_SCHED_TYPE
    PEND_HOST_UNLICENSED
    PEND_HOST_USR_JLIMIT
    PEND_HOST_USR_SPEC
    PEND_HOST_WINDOW
    PEND_HOST_WIN_WILL_CLOSE
    PEND_JGRP_HOLD
    PEND_JGRP_INACT
    PEND_JGRP_RELEASE
    PEND_JGRP_WAIT
    PEND_JOB
    PEND_JOB_ARRAY_JLIMIT
    PEND_JOB_DELAY_SCHED
    PEND_JOB_DEPEND
    PEND_JOB_DEP_INVALID
    PEND_JOB_DEP_REJECT
    PEND_JOB_ENFUGRP
    PEND_JOB_ENV
    PEND_JOB_EXEC_INIT
    PEND_JOB_FORWARDED
    PEND_JOB_JS_DISABLED
    PEND_JOB_LOGON_FAIL
    PEND_JOB_MIG
    PEND_JOB_MODIFY
    PEND_JOB_NEW
    PEND_JOB_NO_FILE
    PEND_JOB_NO_PASSWD
    PEND_JOB_NO_SPAN
    PEND_JOB_OPEN_FILES
    PEND_JOB_PATHS
    PEND_JOB_PRE_EXEC
    PEND_JOB_QUE_REJECT
    PEND_JOB_RCLUS_UNREACH
    PEND_JOB_REASON
    PEND_JOB_REQUEUED
    PEND_JOB_RESTART_FILE
    PEND_JOB_RMT_ZOMBIE
    PEND_JOB_RSCHED_ALLOC
    PEND_JOB_RSCHED_START
    PEND_JOB_SPREAD_TASK
    PEND_JOB_START_FAIL
    PEND_JOB_START_TIME
    PEND_JOB_START_UNKNWN
    PEND_JOB_SWITCH
    PEND_JOB_TIME_INVALID
    PEND_LOAD_UNAVAIL
    PEND_NO_MAPPING
    PEND_NQS_FUN_OFF
    PEND_NQS_REASONS
    PEND_NQS_RETRY
    PEND_QUE_HOST_JLIMIT
    PEND_QUE_INACT
    PEND_QUE_JOB_LIMIT
    PEND_QUE_NO_SPAN
    PEND_QUE_PJOB_LIMIT
    PEND_QUE_PRE_FAIL
    PEND_QUE_PROC_JLIMIT
    PEND_QUE_SPREAD_TASK
    PEND_QUE_USR_JLIMIT
    PEND_QUE_USR_PJLIMIT
    PEND_QUE_WINDOW
    PEND_QUE_WINDOW_WILL_CLOSE
    PEND_RMT_PERMISSION
    PEND_SBD_GETPID
    PEND_SBD_JOB_ACCEPT
    PEND_SBD_JOB_QUOTA
    PEND_SBD_JOB_REQUEUE
    PEND_SBD_LOCK
    PEND_SBD_NO_MEM
    PEND_SBD_NO_PROCESS
    PEND_SBD_ROOT
    PEND_SBD_SOCKETPAIR
    PEND_SBD_UNREACH
    PEND_SBD_ZOMBIE
    PEND_SYS_NOT_READY
    PEND_SYS_UNABLE
    PEND_TIME_EXPIRED
    PEND_UGRP_JOB_LIMIT
    PEND_UGRP_PJOB_LIMIT
    PEND_UGRP_PROC_JLIMIT
    PEND_USER_JOB_LIMIT
    PEND_USER_PJOB_LIMIT
    PEND_USER_PROC_JLIMIT
    PEND_USER_RESUME
    PEND_USER_STOP
    PEND_WAIT_NEXT
    PREPARE_FOR_OP
    PRINT_LONG_NAMELIST
    PRINT_MCPU_HOSTS
    PRINT_SHORT_NAMELIST
    QUEUE_ACTIVATE
    QUEUE_CLOSED
    QUEUE_INACTIVATE
    QUEUE_OPEN
    QUEUE_STAT_ACTIVE
    QUEUE_STAT_DISC
    QUEUE_STAT_NOPERM
    QUEUE_STAT_OPEN
    QUEUE_STAT_RUN
    QUEUE_STAT_RUNWIN_CLOSE
    Q_ATTRIB_BACKFILL
    Q_ATTRIB_CHKPNT
    Q_ATTRIB_DEFAULT
    Q_ATTRIB_ENQUE_INTERACTIVE_AHEAD
    Q_ATTRIB_EXCLUSIVE
    Q_ATTRIB_EXCL_RMTJOB
    Q_ATTRIB_FAIRSHARE
    Q_ATTRIB_HOST_PREFER
    Q_ATTRIB_IGNORE_DEADLINE
    Q_ATTRIB_MC_FAST_SCHEDULE
    Q_ATTRIB_NONPREEMPTABLE
    Q_ATTRIB_NONPREEMPTIVE
    Q_ATTRIB_NO_HOST_TYPE
    Q_ATTRIB_NO_INTERACTIVE
    Q_ATTRIB_NQS
    Q_ATTRIB_ONLY_INTERACTIVE
    Q_ATTRIB_PREEMPTABLE
    Q_ATTRIB_PREEMPTIVE
    Q_ATTRIB_RECEIVE
    Q_ATTRIB_RERUNNABLE
    READY_FOR_OP
    RLIMIT_CORE
    RLIMIT_CPU
    RLIMIT_DATA
    RLIMIT_FSIZE
    RLIMIT_RSS
    RLIMIT_STACK
    RLIM_INFINITY
    RUNJOB_OPT_NORMAL
    RUNJOB_OPT_NOSTOP
    RUN_JOB
    SORT_HOST
    SUB2_BSUB_BLOCK
    SUB2_HOLD
    SUB2_HOST_NT
    SUB2_HOST_UX
    SUB2_IN_FILE_SPOOL
    SUB2_JOB_CMD_SPOOL
    SUB2_JOB_PRIORITY
    SUB2_MODIFY_CMD
    SUB2_QUEUE_CHKPNT
    SUB2_QUEUE_RERUNNABLE
    SUB_CHKPNTABLE
    SUB_CHKPNT_DIR
    SUB_CHKPNT_PERIOD
    SUB_DEPEND_COND
    SUB_ERR_FILE
    SUB_EXCEPT
    SUB_EXCLUSIVE
    SUB_HOST
    SUB_HOST_SPEC
    SUB_INTERACTIVE
    SUB_IN_FILE
    SUB_JOB_NAME
    SUB_LOGIN_SHELL
    SUB_MAIL_USER
    SUB_MODIFY
    SUB_MODIFY_ONCE
    SUB_NOTIFY_BEGIN
    SUB_NOTIFY_END
    SUB_OTHER_FILES
    SUB_OUT_FILE
    SUB_PRE_EXEC
    SUB_PROJECT_NAME
    SUB_PTY
    SUB_PTY_SHELL
    SUB_QUEUE
    SUB_REASON_CPULIMIT
    SUB_REASON_DEADLINE
    SUB_REASON_PROCESSLIMIT
    SUB_REASON_RUNLIMIT
    SUB_RERUNNABLE
    SUB_RESTART
    SUB_RESTART_FORCE
    SUB_RES_REQ
    SUB_TIME_EVENT
    SUB_USER_GROUP
    SUB_WINDOW_SIG
    SUSP_ADMIN_STOP
    SUSP_HOST_LOCK
    SUSP_JOB
    SUSP_LOAD_REASON
    SUSP_LOAD_UNAVAIL
    SUSP_MBD_LOCK
    SUSP_MBD_PREEMPT
    SUSP_PG_IT
    SUSP_QUEUE_REASON
    SUSP_QUEUE_WINDOW
    SUSP_QUE_RESUME_COND
    SUSP_QUE_STOP_COND
    SUSP_REASON_RESET
    SUSP_RESCHED_PREEMPT
    SUSP_RES_LIMIT
    SUSP_RES_RESERVE
    SUSP_SBD_PREEMPT
    SUSP_SBD_STARTUP
    SUSP_USER_REASON
    SUSP_USER_RESUME
    SUSP_USER_STOP
    THIS_VERSION
    TO_BOTTOM
    TO_TOP
    USER_GRP
    USER_JLP
    XF_OP_EXEC2SUB
    XF_OP_EXEC2SUB_APPEND
    XF_OP_SUB2EXEC
    XF_OP_SUB2EXEC_APPEND
    ZOMBIE_JOB
    _PATH_NULL
    LSB_HOST_OK
    LSB_HOST_BUSY
        LSB_HOST_CLOSED
        LSB_HOST_FULL
        LSB_HOST_UNLICENSED
        LSB_HOST_UNREACH
        LSB_HOST_UNAVAIL
        LSB_ISBUSYON
        IS_PEND
        IS_START
        IS_FINISH
        IS_SUSP
        IS_POST_DONE
        IS_POST_ERR
        IS_POST_FINISH
);
$VERSION = '1.01';

sub AUTOLOAD {
  # This AUTOLOAD is used to 'autoload' constants from the constant()
  # XS function.  If a constant is not found then control is passed
  # to the AUTOLOAD in AutoLoader.
  
  my $constname; 
  ($constname = $AUTOLOAD) =~ s/.*:://;
  my $val = constant($constname, @_ ? $_[0] : 0); 
  if ($! != 0) { 
    if ($! =~ /Invalid/) { 
        return if $constname eq "DESTROY";
        croak "LSF::Batch macro $constname not defined";
    } 
    else { 
      croak "Your vendor has not defined LSF::Batch macro $constname"; 
    } 
  } 
  eval "sub $AUTOLOAD { $val }";
  &$AUTOLOAD; 
}

bootstrap LSF::Batch $VERSION;

# Preloaded methods go here.

sub LSB_HOST_OK{my ($st) = @_; ($st & &HOST_STAT_OK) != 0; }
sub LSB_HOST_BUSY{my ($st) = @_; ($st & &HOST_STAT_BUSY) != 0;}
sub LSB_HOST_CLOSED{my ($st) = @_; ($st & (&HOST_STAT_WIND |
                    &HOST_STAT_DISABLED | 
                    &HOST_STAT_LOCKED | 
                    &HOST_STAT_FULL | 
                    &HOST_STAT_NO_LIM)) != 0;}
sub LSB_HOST_FULL{my ($st) = @_;($st & &HOST_STAT_FULL) != 0;}
sub LSB_HOST_UNLICENSED{ my ($st) = @_; ($st & &HOST_STAT_UNLICENSED) != 0;}
sub LSB_HOST_UNREACH{ my ($st) = @_; ($st & &HOST_STAT_UNREACH) != 0;}
sub LSB_HOST_UNAVAIL{ my ($st) = @_; ($st & &HOST_STAT_UNAVAIL) != 0;}
sub LSB_ISBUSYON{ my ($st, $in) = @_; (($st[$in/&INTEGER_BITS]) & 
                       (1 << $in % &INTEGER_BITS)) != 0;}

#removed for LSF 4.0. 64 bit job ID is broken down within the XS side 
#because of 32bit perl.
#sub LSB_JOBID{ my ($id, $ix) = @_; ($ix << 20) | $id;}
#sub LSB_ARRAY_IDX{ my ($id) = @_;($id == -1)?(0):($id >> 20);}
#sub LSB_ARRAY_JOBID{ my ($id) = @_;
#            ($id == -1)?(-1):($id & LSB_MAX_ARRAY_JOBID);}

sub IS_PEND{my ($s) = @_;($s & &JOB_STAT_PEND) || ($s & &JOB_STAT_PSUSP);}
sub IS_START{my ($s) = @_;($s & &JOB_STAT_RUN) || ($s & &JOB_STAT_SSUSP)
           || ($s & &JOB_STAT_USUSP);}
sub IS_FINISH{my ($s) = @_; ($s & &JOB_STAT_DONE) || ($s & &JOB_STAT_EXIT);}
sub IS_SUSP{my ($s) = @_; return ($s & &JOB_STAT_PSUSP) || ($s & &JOB_STAT_SSUSP)
          || ($s & &JOB_STAT_USUSP);}

sub IS_POST_DONE{my ($s) = @_; ($s & &JOB_STAT_PDONE) == &JOB_STAT_PDONE;}
sub IS_POST_ERR{my ($s) = @_; ($s & &JOB_STAT_PERR) == &JOB_STAT_PERR;}
sub IS_POST_FINISH{my ($s) = @_; &IS_POST_DONE($s) || &IS_POST_ERR($s);}

#constants that aren't exported using the constant() function since they
#are strings
sub ALL_USERS{"all";}
sub DEFAULT_MSG_DESC{"no description";}
sub LOST_AND_FOUND{"lost_and_found";}
sub LSF_JOBIDINDEX_FILENAME{"lsb.events.index";}
sub LSF_JOBIDINDEX_FILETAG{"#LSF_JOBID_INDEX_FILE";}
sub THIS_VERSION{"4.0";}
sub _PATH_NULL{"/dev/null";}

sub new{
  my $type = shift;
  my $appname = shift;
  my $self = {};

  return eval{
    if( -e "/etc/lsf.conf" or $ENV{LSF_ENVDIR} ){
      bless $self, $type;
      $self->init($appname) or die $@;
      return $self;
    }
    else{
      die "Can't access lsf.conf file or LSF_ENVDIR not set";
    }
  }
}
  

sub submit{
  my $self = shift;
  my %subreq;
  my ($key,$value,$job);

  #parse the arguments and build a hash to pass to the XS do_submit call.
  return eval{
  PARSE:
    while(@_){
      $_ = shift;
      #print "got flag $_\n";
      die "invalid argument $_ \n" unless /^-/;
      if( @_ and $_[0] !~ /^-/ ){
    $subreq{$_} = shift;
      }
      else{
    $subreq{$_} = "";
      }
    }
    $job = do_submit(\%subreq);
    return $job;
  }
}

sub limitInfo {
  my $self = shift;
  my %limitreq;
  my ($key,$value,$port,$size,$lsinfo,@limitInfo);

  #parse the arguments and build a hash to pass to the XS do_limitInfo call.
  return eval{
  PARSE:
    while(@_){
      $_ = shift;
      #print "got flag $_\n";
      die "invalid argument $_ \n" unless /^-/;
      if( @_ and $_[0] !~ /^-/ ){
    $limitreq{$_} = shift;
      }
      else{
    $limitreq{$_} = "";
      }
    }
    ($port,$size,$lsinfo,@limitInfo) = do_limitInfo(\%limitreq);
    return ($port,$size,$lsinfo,@limitInfo);
    #return do_limitInfo(\%limitreq);
  }
}

sub bjobs_psum {
  my $self = shift;
  my %jreq;

  #parse the arguments and build a hash to pass to the XS lsb_jobpendingsummary call.
  return eval{
  PARSE:
    while(@_){
      $_ = shift;
      #print "got flag $_\n";
      die "invalid argument $_ \n" unless /^-/;
      if( @_ and $_[0] !~ /^-/ ){
          $jreq{$_} = shift;
      }
      else{
          $jreq{$_} = "";
      }
    }
    return jobpendingsummary(\%jreq);
  }
}
 
sub bjobs_openjobinfo_req {
  my $self = shift;
  my %jreq;

  #parse the arguments and build a hash to pass to the XS lsb_openjobinfo_req call.
  return eval{
  PARSE:
    while(@_){
      $_ = shift;
      #print "got flag $_\n";
      die "invalid argument $_ \n" unless /^-/;
      if( @_ and $_[0] !~ /^-/ ){
          $jreq{$_} = shift;
      }
      else{
          $jreq{$_} = "";
      }
    }
    return openjobinfo_req(\%jreq);
  }
}
 
sub brsvadd {
  my $self = shift;
  my %subreq;
  my ($key, $rsvId);
  my (@btime, @etime);
  my ($btimesec, $etimesec);
  my $timeWindow;
  
  #parse the arguments and build a hash to pass to the XS do_rsvadd call.   
  return eval {
  PARSE:
    while(@_) {
      $_ = shift;
      #print "got flag $_\n";
      die "invalid argument $_ \n" unless /^-/;
      if (@_ and $_[0] !~ /^-/) {
         $subreq{$_} = shift;   
      } else {
        $subreq{$_} = "";
      }
    }
    
    die "inadequate necessary arguments \n" unless ((exists($subreq{'-u'}) || exists($subreq{'-g'}) || exists($subreq{'-s'})) && (exists($subreq{'-n'})) && (exists($subreq{'-m'}) || exists($subreq{'-R'})) && ((exists($subreq{'-b'}) && exists($subreq{'-e'})) || exists($subreq{'-t'})));
    die "invalid arguments: One of the -u, -g or -s can be specified\n" unless (exists($subreq{'-u'}) xor exists($subreq{'-g'}) xor exists($subreq{'-s'}));
    die "invalid time windows arguments: One of the (-b, -e) or -t can be specified, but not both\n" unless (((exists($subreq{'-b'}) && exists($subreq{'-e'})) && !exists($subreq{'-t'}))) || (!(exists($subreq{'-b'}) || exists($subreq{'-e'})) && exists($subreq{'-t'}));

    if ((exists($subreq{'-b'}) && exists($subreq{'-e'})) && (defined($subreq{'-b'}) && defined($subreq{'-e'}))) {
      my $tmp = $subreq{'-b'}.'-'.$subreq{'-e'}; 
      $timeWindow = timepaser::parseAndCheckTimeWindow($tmp, 1) or die $@;
    }
    if (exists($subreq{'-t'}) && defined($subreq{'-t'})) {
      $timeWindow = timepaser::parseAndCheckTimeWindow($subreq{'-t'}, 0) or die $@;
    }
    
    $subreq{'-t'} = $timeWindow;
    
    $rsvId=do_rsvadd(\%subreq) or die $@;
    return $rsvId;  
  }
}

sub launch {
  my $self = shift;
  my @hosts;
  my @argv;
  my $ret;
  #parse the arguments and build a hash to pass to the XS do_launch call.   
  return eval {
    @hosts = split(/ /, $_[0]);
    @argv = split(/ /, $_[1]);
    
    $ret = do_launch(\@hosts, \@argv, $_[2]);
    
    return $ret;
   
  }
 
}
1;

package LSF::Batch::jobPtr;

sub modify{
  my $self = shift;
  my %subreq;
  my ($key,$value);

  #parse the arguments and build a hash to pass to the XS do_modify call.
  return eval{
  PARSE:
    while(@_){
      $_ = shift;
      die "invalid argument $_ \n" unless /^-/;
      if( @_ and $_[0] !~ /^-/ ){
    $subreq{$_} = shift;
      }
      else{
    $subreq{$_} = 1;
      }
    }
    $self->do_modify(\%subreq) or die $@;
    1;
  }
}

sub jobArray{
  my $self = shift;
  my $start = shift;
  my $end = shift;
  my $step = 1;
  $step = shift if @_;
  my %array;

  for( $i = $start; $i <= $end; $i += $step ){
    $array{$i} = new LSF::Batch::jobPtr ($self->jobId, $i);
  }
  return %array;
}

sub readjobmsg{
  my $self = shift;
  my %subreq;
  my ($key, $port, $reply);
  
  #parse the arguments and build a hash to pass to the XS do_readjobmsg call.   
  return eval {
  PARSE:
    while(@_) {
      $_ = shift;
      #print "got flag $_\n";
      die "invalid argument $_ \n" unless /^-/;
      if (@_ and $_[0] !~ /^-/) {
         $subreq{$_} = shift;   
      } else {
        $subreq{$_} = "";
      }
    }
    ($port, $reply) = $self->do_readjobmsg(\%subreq);
    return ($port, $reply); 
  }
}

sub postjobmsg{
  my $self = shift;
  my %subreq;
  my ($key,$value);
  #parse the arguments and build a hash to pass to the XS do_postjobmsg call.
  return eval{
  PARSE:
    while(@_){
      $_ = shift;
      #print "got flag $_ \n";
      die "invalid argument $_ \n" unless /^-/ ;
      if(@_ and $_[0] !~ /^_/){
        $subreq{$_} = shift;
      }
      else{
        $subreq{$_} = "";
      }
    }
    $self->do_postjobmsg(\%subreq);
  }
}

package LSF::Batch::jobInfoPtr;
$base = new  LSF::Base;
our  @loadIndex;

sub initLoadIndex{
    my $self = shift;
    @defNames = ("r15s","r1m","r15m","ut","pg","io","ls","it","swp","mem","tmp");

    $lsInfo = $base->info();

    if(!defined($lsInfo)){
        @loadIndex = @defNames;
        return @loadIndex;
    }

    @resTable = $lsInfo->resTable;

    foreach (@resTable){
        $name = $_ ->name;
        push (@loadIndex , $name);
    }

    if($self -> numLicense ==0){
        return @loadIndex;
    }

    @licenseNames = $self -> licenseNames;
    
    if($self -> numLicense >0){
        for($j=$lsInfo->nRes; $j<$self->numLicense; $j++){
        $mn = $j - $lsInfo->nRes;
            push(@loadIndex, $licenseNames[$mn]);
        }
        return  @loadIndex ;
    }
}

# Autoload methods go after =cut, and are processed by the autosplit program.

1;

package timepaser;
use Time::Local;
sub timeStr2Hash {
  my %hash;
  my $errmsg = "invalid time window format\n";
  
  die $errmsg unless $_[0] =~ /^\d+[:\d+]*$/; 
  
  my @t = reverse(split(/:/, $_[0]));
  
  if($#t == 0){
    $hash{'hours'} = $t[0];
  } elsif ($#t == 1){
    $hash{'minutes'} = $t[0];
    $hash{'hours'} = $t[1];
  } elsif ($#t == 2){ 
    $hash{'minutes'} = $t[0];
    $hash{'hours'} = $t[1];
    $hash{'days'} = $t[2];
  } else {
      die $errmsg;
  }
  
  if (exists($hash{'minutes'}) && defined($hash{'minutes'})) {
    if ($hash{'minutes'} < 0 || $hash{'minutes'} > 60) {
      die $errmsg;
    }
  }

  if (exists($hash{'hours'}) && defined($hash{'hours'})) {
    if ($hash{'hours'} < 0 || $hash{'hours'} > 23) {
      die $errmsg;
    }
  }

  if (exists($hash{'days'}) && defined($hash{'days'})) {
    $hash{'days'} = 7 if $hash{'days'} == 0;
    if ($hash{'days'} < 1 || $hash{'days' > 7}) {
      die $errmsg;
    }
  }
  return %hash;
}


sub parseAndCheckTimeWindow {
  my $newWindow;
  my $errmsg = "invalid time window format\n";
  
  return eval {
    if ($_[1] == 0) {
        my @windows = split(/ /, $_[0]);
        my (@bhash, @ehash);
        my $j = 0;
        my $i;
        foreach $i (@windows) {
          die $errmsg unless $i =~ /^\d.*-.*\d$/;
          my ($btime, $etime) = split(/-/, $i);
          my %b = timeStr2Hash($btime) or die $@;
          my %e = timeStr2Hash($etime) or die $@;
          
          die $errmsg unless ((exists($b{'days'}) && exists($e{'days'})) || (!exists($b{'days'}) && !exists($e{'days'})));
          $bhash[$j] = $b{'days'} + ($b{'hours'} + $b{'minutes'} / 60) / 24;
          $ehash[$j] = $e{'days'} + ($e{'hours'} + $e{'minutes'} / 60) / 24;
          $j ++;
        }
        my $k = 0;
        for ($k = 0; $k <= $#bhash && $k <= $#ehash; $k ++) {
          my $i = 0;
          my $j = 1;
          if ($bhash[$k] <= 1 && $ehash[$k] <= 1) {
            while ($j <= 7) {
              for ($i = 0; $i < $#bhash; $i ++) {
                if ($i != $k) {
                  die $errmsg unless ($bhash[$k] + $j > $ehash[$i]) || ($ehash[$k] + $j> $bhash[$i]);
                }
              }
              $j ++;
            }
          } else {
            for ($i = 0; $i < $#bhash; $i ++) {
              if ($i != $k) {
                die $errmsg unless ($bhash[$k] > $ehash[$i]) || ($ehash[$k] > $bhash[$i]);
              }
            }
          }
        }
        $newWindow = $_[0];
    } elsif ($_[1] == 1) {
        die $errmsg unless $_[0] =~ /^\d+[:\d+]*-\d+[:\d+]*$/;
        my @window = split(/-/, $_[0]);
        my @btime = reverse(split(/:/, $window[0]));
        my @etime = reverse(split(/:/, $window[1]));
        
        die $errmsg unless ($#btime >= 1 || $#etime >= 1); 
      
        $btime[3] = $btime[3] - 1 if $#btime > 2;
        $btime[4] = $btime[4] - 1900 if $#btime > 3;
      
        $etime[3] = $etime[3] - 1 if $#etime > 2;
        $etime[4] = $etime[4] - 1900 if $#etime > 3;
      
        if ($#btime < 4) {
          $btimesec = timelocal(0, @btime, (localtime)[$#btime+2 .. 5]);
        } else {
          $btimesec = timelocal(0, @btime);
        }
        if ($#etime < 4) {
          $etimesec = timelocal(0, @etime, (localtime)[$#etime+2 .. 5]);
        } else {
          $etimesec = timelocal(0, @etime); 
        }
        die "the end time is not later than the start time.\n" if ($etimesec < $btimesec); 
        $newWindow = $btimesec.'-'.$etimesec; 
    } else {
      die $errmsg;
    }
    return $newWindow;
  }
} 
1;


__END__
# Below is the stub of documentation for your module. You had better edit it!

=head1 NAME

LSF::Batch - Perl extension for using with the Platform Computing
Corporation's Load Sharing Facility (LSF).

=head1 SYNOPSIS
  

  use LSF::Batch;

  #initialization and reconfiguration

  $batch = new LSF::Batch("appname"); (calls lsb_init)

  $batch->reconfig($options) or die $@;

  $batch->hostcontrol($host, $options) or die $@;

  $batch->queuecontrol($queue, $opcode) or die $@

  $msg = $batch->sysmsg();

  $batch->perror($usrMsg);

  #job submission and modification

  $job = $batch->submit( 
            -J         => "foo",              #job name
            -q         => "normal",           #queue name
            -m         => [qw(a b c d)],      #host names
            -R         => "select[solaris && r1m<1.0]"
                                              #resource requirement
            -c         => 300,                #cpu limit
            -W         => 3600,               #run time limit
            -F         => 100000,             #file limit
            -M         => 1000,               #memory limit
            -D         => 122121,             #disk limit
            -S         => 122331,             #stack limit
            -C         => 11111,              #core limit
            -w         => "ended(foo2)",      #ended(job name)
            -b         => time + 100,         #begin time
            -t         => time + 1000,        #terminate time
            -sig       => SIGINT,etc.         #signal
            -i         => "input",            #input file
            -o         => "output",           #output file
            -e         => "error",            #error file
            -command   => "sleep 30",         #command
            -k         => "/checkpoint",      #checkpoint
            -f         => "file1 > file2",    #copy file
            -f         => "file3 < file2",
            -E         => "run_me_first",     #Runs the specified
                                              #pre-execution command
                                              #on the execution host
                                              #before actually running
                                              #the job.
            
            -u         => "user@mail",        #mail user
            -P         => "work",             #project name
            -n         => 1,                  #number of processors
            -L         => "/bin/ksh",         #login shell
            -G         => "workers",          #user group name
            -x ,                              #exclusive mode
            -B ,                              #Sends mail to you when
                                              #the job is dispatched
                                              #and begins execution.
            
            -N ,                              #Sends the job report
                                              #to you by mail when
                                              #the job finishes.
            
            -r ,                              #If the execution host
                                           #becomes unavailable
                                              #while a job is running,
                                              #specifies that the job
                                              #be rerun on another host.
            
            -I ,                              #submit an interactive job
            -Ip,                              #Interactive pseudo-terminal mode
            -Is,                              #Interactive pseudo-terminal
                                              #shell mode
            -H ,                              #PSUSP job
            -K ,                              #Submits a batch job
                                              #and waits for the job
                                              #to complete.
            
            -T          => 2,                 #thread limit
            -app        => "file1"            #application profile name
            -is         => "file1",           #input file name
            -Zs         => "job.sh"           #job command file
            -v          => 20,                #swap limit
            -We         => Format is [hours:]minutes[/hostSpec],
                                              #run time
            -U          => reservation_id,    #reservation ID
            -rn,                              #specifies that the
                                              #job is never rerunnable
            -V,                               #version
            -Lp         => "License project", #license project name
            -oo         => "Output file. ",   #output file name
            -ext  | -extsched    => option,   #external scheduler options
            -eo         => "error",           #error file
            -sla        => "name",            #service class name
            -sp         => 5,                 #priority
            -p          => 5,                 #process limit
            -jsdl | -jsdl_strict => "file1",  #JSDL file name
            -ul,                              #Passes the current
                                              #operating system user
                                              #shell limits for the
                                              #job submission user to
                                              #the execution host.

            -cwd        => "/dir/",           #current working directory
            -g          => job_group,         #job group name
            -mig        => 2                  #migration threshold
            );               

  $job->modify( ... ) or die; #similar to submit interface

  #After LSF 4.0, the jobid is a 64 bit number. Instead of requiring
  #a 64 bit perl, I split the jobid and array index from within the library.
  #Therefore, many calls take a job object rather than the jobID. You
  #can create a new job object by using new:

  $newjob = new LSF::Batch::jobPtr ($id,$index);

  $id = $job->jobId;
  $index = $job->arrayIdx;
  $queue = $job->queue;

  $job->chkpnt($period, $options)

  $job->mig(\@hosts, $options);

  $position = $job->move($position, $opcode);

  $filename = $job->peek;

  $job->signal($signal);

  $job->switch($queue);

  $job->run(\@hosts, $slots, $options);

  $job->postjobmsg( 
            -d          =>  "description sentence", #message decription 
            -i          =>  4,                      #message index
            -a          =>  "dataout.txt"           #appendence file
            );

  $reply = $job->readjobmsg( 
            -i          =>  4,                     #message index
            -a          =>  "datain.txt",          #the file stroing appendence
            );
 
  $id            = $reply->jobId;
  $msgIdx        = $reply->msgIdx;
  $desc          = $reply->desc;
  $dataSize      = $reply->dataSize;
  $postTime      = $reply->postTime;
  $dataStatus    = $reply->dataStatus;
  $userName      = $reply->userName;

  $records = $batch->openjobinfo($job, $jobname, $user, $queue, $host, 
                                 $options);

  $info=$batch->openjobinfo_a($job,$jobName,$userName,
      $queueName,$hostName,$options);

  $numJobs        = $info ->numJobs;
  $jobIds         = $info ->jobIds;
  $numHosts       = $info ->numHosts;
  @hostNames      = $info ->hostNames;
  $numClusters    = $info ->numClusters;
  @clusterNames   = $info ->clusterNames;
  @numRemoteHosts = $info -> numRemoteHosts;
  @remoteHosts    = $info ->remoteHosts;
 
  $jobinfo = $batch->readjobinfo;

  $job        = $jobinfo->job;
  $id         = $jobinfo->jobId;
  $user       = $jobinfo->user;
  $status     = $jobinfo->status;
  $reasons    = $jobinfo->reasons;
  $subreasons = $jobinfo->subreasons;
  $fromhost   = $jobinfo->fromHost;
  $subtime    = $jobinfo->submitTime;
  $starttime  = $jobinfo->startTime;
  $endtime    = $jobinfo->endTime;
  $cputime    = $jobinfo->cpuTime;
  $umask      = $jobinfo->umask;
  $cwd        = $jobinfo->cwd;
  $homedir    = $jobinfo->subHomeDir;
  $numexhosts = $jobinfo->numExHosts;
  @exhosts    = $jobinfo->exHosts;
  $factor     = $jobinfo->cpiFactor;
  $arrayIdx   = $jobinfo->arrayIdx;
  $loadsched  = $jobinfo->loadSched;
  $loadstop   = $jobinfo->loadStop;
  $job        = $jobinfo->submit;
  $rusage     = $jobinfo->jRusage;
  $pendreason = $jobinfo->pendreason;
  $suspreason = $jobinfo->suspreason;
  $submit     = $jobinfo->submit;
  @loadIndex  = $jobinfo->initLoadIdex;

  #the submit object contains all the fields of the submit structure.
  $submit->jobName;
  $submit->queue;
  $submit->resReq;
  $submit->command;
  $submit->userPriority;
  #etc.

  $batch->closejobinfo();

  #Batch system information

  $params = $batch->parameterinfo();

  $params->defaultQueues;
  $params->defaultHostSpec;
  $params->mbatchdInterval;
  $params->sbatchdInterval;
  $params->jobAcceptInterval;
  $params->maxDispRetries;
  $params->maxSbdRetries;
  $params->preemptPeriod;
  $params->cleanPeriod;
  $params->maxNumJobs;
  $params->historyHours;
  $params->pgSuspendIt;
  
  @info = $batch->hostinfo(\@hosts);

  @info = $batch->hostinfo_ex(\@hosts, $resreq, $options);

  $hi          = $info[0];
  $host        = $hi->host;
  $status      = $hi->hStatus;
  $sched       = $hi->busySched;
  $stop        = $hi->busyStop;

  @load        = $hi->load;
  @loadsched   = $hi->loadSched;
  @loadstop    = $hi->loadStop;
  $windows     = $hi->windows;
  $ujl         = $hi->userJobLimit;
  $maxj        = $hi->maxJobs;
  $numj        = $hi->numJobs;
  $nrun        = $hi->numRUN;
  $nssusp      = $hi->numSSUSP;
  $nususp      = $hi->numUSUSP;
  $nresv       = $hi->numRESERVE;
  $mig         = $hi->mig;
  $attr        = $hi->attr;
  @realload    = $hi->realLoad;
  $sig         = $hi->chkSig;

  @info = $batch->userinfo(\@users);

  $ui = $info[0];

  $ui->user;
  $ui->procJobLimit;
  $ui->maxJobs;
  $ui->numStartJobs;
  $ui->numJobs;
  $ui->numPEND;
  $ui->numRUN;
  $ui->numSSUSP;
  $ui->numUSUSP;
  $ui->numRESERVE;

  %info = $batch->hostgrpinfo(\@groups, $options);

  @groups = keys %info;
  @members = values %info;

  %info = $batch->usergrpinfo(\@usergrps, $options)

  @groups = keys %info;
  @members = values %info;

  @queueinfo = $batch->queueinfo( \@queues, $host, $user, $options)

  $qi = $queueinfo[0];

  $queue           = $qi->queue;
  $desc            = $qi->description;
  $pri             = $qi->priority;
  $nice            = $qi->nice;
  @users           = $qi->userList;
  @hosts           = $qi->hostList;
  @loadSched       = $qi->loadSched;
  @loadStop        = $qi->loadStop;
  $ujoblim         = $qi->userJobLimit;
  $pjoblim         = $qi->procJobLimit;
  $windows         = $qi->windows;
  @limits          = $qi->rLimits;
  $hostspec        = $qi->hostSpec;
  $qattrib         = $qi->qAttrib;
  $qstat           = $qi->qStatus;
  $maxjobs         = $qi->maxJobs;
  $numjobs         = $qi->numJobs;
  $numpend         = $qi->numPEND;
  $numrun          = $qi->numRUN;
  $nssusp          = $qi->numSSUSP;
  $nususp          = $qi->numUSUSP;
  $mig             = $qi->mig;
  $dispatch        = $qi->windowsD;
  $nqsqueues       = $qi->nqsQueues;
  $usershared      = $qi->userShares;
  $defaulthostspec = $qi->defaultHostSpec;
  $proclimit       = $qi->procLimit;
  $admins          = $qi->admins;
  $precmd          = $qi->preCmd;
  $postcmd         = $qi->postCmd;
  $requeuevalues   = $qi->requeueEValues;
  $hostjoblimit    = $qi->hostJobLimit;
  $resreq          = $qi->resReq;
  $numreserve      = $qi->numRESERVE;
  $holdtime        = $qi->slotHoldTime;
  $sendto          = $qi->sndJobsTo;
  $recvfrom        = $qi->rcvJobsFrom;
  $resumecond      = $qi->resumeCond;
  $stopcond        = $qi->stopCond;
  $jobstarter      = $qi->jobStarter;
  $suspendaction   = $qi->suspendActCmd;
  $resumeaction    = $qi->resumeActCmd;
  $termaction      = $qi->terminateActCmd;
  @sigmap          = $qi->sigMap;
  $preemption      = $qi->preemption;
  @shareaccts      = $qi->shareAccts;

  $sa = pop @shareaccts;

  $path     = $sa->shareAcctPath
  $shares   = $sa->shares;
  $priority = $sa->priority;
  $njobs    = $sa->numStartJobs;
  $histtime = $sa->histCpuTime;
  $reserve  = $sa->numReserveJobs;
  $runtime  = $sa->runTime;
  
  @info = $batch->sharedresourceinfo(\@resources, $hostname, $options);

  $sri = @info[0];

  $name = $sri->resourceName;
  @instances = $sri->instances;

  $inst = @instances[0];

  $total = $inst->totalValue;
  $reserve = $inst->reserveValue;
  @hosts = $inst->hostList;


  @info = $batch->hostpartinfo(\@partitions);

  $part = $info[0];

  $name = $part->hostPart;
  $hosts = $part->hostList;
  @users = $part->users;

  $user = $users[0];

  $name = $user->user;
  $shares = $user->shares;
  $priority = $user->priority;
  $numstart = $user->numStartJobs;
  $numreserve = $user->numReserveJobs;
  $cpu = $user->histCpuTime;

  open LOG, "/usr/local/lsf/work/clustername/logdir/lsb.events";
  $line = 1;
  while( $er = $batch->geteventrecord( LOG, $line)){
      $el = $er->eventLog;
      $lt = localtime $er->eventTime;
      print "event $line at $lt:";
      if( $er->type == EVENT_JOB_NEW ){
      $id = $el->jobId;
      $user = $el->userName;
      $res = $el->resReq;
      $q = $el->queue;
      print "New job $job submitted to queue $q by $user\n";
      }
      ...
      else{
      print "Received event of type ", $er->type, "\n";
      }

  $batch->pendreason($numReason, \@rsTb, $jInfoH, \@loadIndex, $clusterId);

  $psum_str = $batch->bjobs_psum(
                -app             =>  "applicationName",
                -cluster_source  =>  "sourceClusterName",
                -description     =>  "jobDescription",
                -group           =>  "jobGroupName",
                -host            =>  "hostName",
                -index_array     =>  1                       #the job array index
                -jobid           =>  123
                -license_project =>  "licenseProjectName",
                -name            =>  "jobName",
                -project         =>  "projectName",
                -queue           =>  "queueName",
                -reasonLevel     =>  0,                       #0-3
                -sla             =>  "serviceClaseName",
                -user            =>  "userName",

  );
  print $psum_str;

  $batch->suspreason($reasons,$subreasons,\@loadIndex);

  $batch->brsvadd( -n     =>  4,
                   -m     =>  "hostName",
                   -u     =>  "userName",
                   -g     =>  "groupName",
                   -R     =>  "select[mem > 200]",
                   -s,    
                   -t     =>  "0:1:00-0:2:00",
                   -b     =>  "2008:08:08:08:08",
                   -e     =>  "2008:08:08:09:09",
                   -o
                 ) or die $@;

  @rsvInfo = $batch->reservationinfo($rsvid);
 
  $options         = $rsvInfo->options;
  $name            = $rsvInfo->name;
  $rsvId           = $rsvInfo->rsvId;
  $timeWindow      = $rsvInfo->timeWindow;
  $rsvHosts        = $rsvInfo->rsvHosts;
  $jobIds          = $rsvInfo->jobIds;
  $jobStatus       = $rsvInfo->jobStatus;

  $batch->removereservation($rsvid);

  $hosts = $batch->gethostlist;

  $batch->launch("hostlist", "command", $options);

  #error messages. Note: calls set $? and $@ and return appropriate
  #values upon failure.
  
  ($port, $size, $lsinfo, @limitInfo) = $batch->limitInfo(
                "-c",   #show config information
                "-a",   #show usage information
                "-u"               =>  "user",
                "-q"               =>  "queue",
                "-n"               =>  "limit name",
                "-P"               =>  "project",
                "-m"               =>  "host",
                "-A"               =>  "app",
                "-Lp"              =>  "license project"
  );

  print $port;
  print $size;
  $limit = $(limitInfo[0]);
  $name = $limit->name;
  $confInfo = $limit->confInfo;
  $usageC = $limit->usageC;
  @usageInfo = $limit->usageInfo;
  $ineligible = $limit->ineligible;
   

=head1 DESCRIPTION

LSF Batch provides access to batch queuing services across machines
within a cluster.

This library is designed to be used with LSF version 7.x. Please see
the "LSF Programmer's Guide" and the LSF home pages for detailed
documentation of this API.

The data structures used in the API have been wrapped in Perl objects
for ease of use. The functions set $@ and $? where appropriate, or you
can use the lserrno, sysmsg, and perror functions if you want.

The Perl version of this API has been modified to be more "perlish" than
the straightforward C API. For instance, return values have been changed
to more closely match what a Perl programmer expects from a function.
Other deviations from the original are noted in the documentation.

=over

=item $batch->reconfig(options);

This routine dynamically reconfigure the LSF batch system with C<options>. Here,
C<options> should be the one of these constant values: 
MBD_RESTART, MBD_RECONFIG or MBD_CKCONFIG.

=item $batch->hostcontrol(host, options);

This routine transforms two arguments, host name and constant value, to open or
close a host, or restart or shut down its slave batch daemon. The C<host> is the host
to be controlled in your cluster. if it is undefined, the local host is assumed.
C<options> should be one of the following : 
HOST_CLOSE, HOST_OPEN, HOST_REBOOT, HOST_SHUTDOWN.

=item $batch->queuecontrol(queue, opcode);

This routine takes two arguments (queue name and constant value) to change the
status of the queue. $queue is the name of the queue to be controlled. It can 
be acquired from the output of the bqueues command or from the lsb.queues file.
C<opcode> should be one of the following:
QUEUE_OPEN, QUEUE_CLOSED, QUEUE_ACTIVATE, QUEUE_INACTIVATE, QUEUE_CLEAN.

=item $msg = $batch->sysmsg();

This routine returns the system error message.

=item $batch->perror(usrMsg);

This routine takes a string and returns a LSF error message on stderr. The
C<usrMsg> is printed out first, followed by C<:> and the batch error message
corresponding to lsberrno. C<usrMsg> is an error message supplied by user.

=item $job = $batch->submit(params);

This routine submits a job to LSF according to the hash paramters C<params>.

=item ($port, $size, $lsInfo, @limitInfo) = $batch->limitInfo(params);

This routine query limitInfo per request. C<params> is a
hash variable to hold the request options. $port indicates successful or not.
< 0 for failed. $size is the size of @limitInfo. $lsInfo is the lsInfo need
to parse the limit.

=item $job->modify(params);

This routine modifies the information of the job specified in C<params>.

=item $job->chkpnt(period, options)

This routine takes two arguments (checkpoint period in seconds and constant 
value). for a checkpoint job, C<period> = 0 disables periodic checkpointing. 
C<options> should be one of the following: 
LSB_CHKPERIOD_NOCHNG, LSB_CHKPNT_KILL, LSB-CHKPNT_FORCE, LSB_CHKPNT_COPY,
LSB_CHKPNT_MIG, LSB_CHKPNT_STOP, LSB_KILL_REQUEUE.

=item $job->mig(hosts, options);

This routine takes two arguments (a reference of a host name array and constant
value) to migrate a job from one host to another. C<hosts> is a host name array
in the cluster; C<options> should be 0 or LSB_CHKPNT_FORCE.

=item $position = $job->move(position, opcode);

This routine takes two arguments, int value and constant value, to move a 
pending job to a new C<positon> that you specify in a queue relative to the
C<opcode>. C<positon> is the new position of the job in a queue, the C<opcode>
should be TO_TOP or TO_BOTTOM. 
For example, Position a job to the top of the queue, set $position =1 and 
$opcode = TO_TOP or $postion =3(assume the number of jobs in this queue is 3)
and $opcode = TO_BOTTOM.

=item $filename = $job->peek;

This routine returns the file name pointer on success.

=item $job->signal(signal);

This routine takes a C<signal> argument to send a signal to a job. C<signal> 
should be SIGSTOP, SIGCONT, SIGKILL or some other UNIX signal.

=item $job->switch(queue);

This routine takes queue name and to move an unfinished job to this queue. 
C<queue> is a queue name. Queue name can be found in lsb.queues file or results
of bqueues command.

=item $job->run(hosts, slots, options);

This routine starts a job immediately on a set of specified hosts. The 
job must have been submitted and is in PEND or FINISHED status. C<hosts> is an 
array of the hosts names on which the job will run; C<slots> is vector of number
of slots per host; C<options> should be one of the following:
RUNJOB_OPT_NORMAL, RUNJOB_OPT_NOSTOP, RUNJOB_OPT_PENDONLY, RUNJOB_OPT_FROM_BEGIN,
RUNJOB_OPT_FREE, RUNJOB_OPT_IGNORE_RUSAGE.

=item $job->postjobmsg(params); 

This routine sends messages and data posted to a job. C<params> is a hash 
variable.

=item ($port, $reply) = $job->readjobmsg(params);

This routine reads messages and attached data files from a job. C<params> is a
hash variable. $reply contains the message information of the job.

=item $records = $batch->openjobinfo(jobID, jobname, user, queue, host,
                                        options);
                                        
This routine passes information about jobs based on the value of C<jobID>, 
C<jobName>, C<user>, C<queue> or C<host>. Only one parameter can be chosen. The
other parameters must be undefined or 0. C<options> should be one or more (use 
bitwise OR) of the following:
ALL_JOB, DONE_JOB, PEND_JOB, SUSP_JOB, CUR_JOB, LAST_JOB,  RUN_JOB, JOBID_ONLY,
HOST_NAME, NO_PEND_REASONS, JGRP_INFO, JGRP_RECURSIVE, JGRP_ARRAY_INFO, 
JOBID_ONLY_ALL, ZOMBIE_JOB, TRANSPARENT_MC, EXCEPT_JOB, MUREX_JOB, TO_SYM_UA,
SYM_TOP_LEVEL_ONLY, JGRP_NAME, COND_HOSTNAME, FROM_BJOBSCMD, WITH_LOPTION,
APS_JOB, UGRP_INFO.

=item $info=$batch->openjobinfo_a(jobID, jobName, userName, queueName, 
                                 hostName, options);
                                 
This routine provides more information on pending, running and suspended jobs 
than openjobinfo(). Returns a pointer to jobInfoHead struct. The arguments
are the same as ones of openjobinfo().

=item $info=$batch->bjobs_openjobinfo_req(params);
 
This routine provides more information than openjobinfo() and openjobinfo_a(). 
Returns a pointer to jobInfoHeadExt struct. C<params> is a hash input parameter.
You can refer to bjobs_psum() for the valid parameter list.

=item $jobinfo = $batch->readjobinfo;

This routine returns the next job information record in master batch daemon.

=item $jobinfo = $batch->readjobinfo_cond(jobInfoHExt);
 
This routine returns the next job information record in master batch daemon.
The parameter C<jobInfoHExt> is the output of bjobs_openjobinfo_req().
 
=item $batch->closejobinfo();

This routine closes job information connection with the master batch daemon.

=item $params = $batch->parameterinfo();

This routine returns information about the LSF cluster.

=item @info = $batch->hostinfo(hosts);

This routine takes a reference of a host name array in the cluster and returns
information about job server C<hosts>.

=item @info = $batch->hostinfo_ex(hosts, resreq, options);

This routine takes three arguments: reference of host name array, resource 
requirement and constant value, returns information about job server hosts that
satisfy specified resource requirement. $options can only be set to 0. 
for example, 
@hosts = ("host1","host2"); $resreq = "mem > 100"; $options = 0;

=item @info = $batch->userinfo(users);

This routine returns the maximum number of job slots that a user can use 
simultaneously on any host and in the whole local LSF cluster. C<users> is an 
array of user names,returns the maximum number of job slots that a user can 
use simultaneously on any host and in the whole local LSF cluster.

=item %info = $batch->hostgrpinfo(groups, options);

This routine takes two arguments: a reference of a host group name array and a 
constant value. It returns LSF host group membership. Group names can be acquired
from lsb.hosts file. C<options> should be bitwise inclusive OR of some of following
flags: 
USER_GRP, HOST_GRP, HPART_HGRP, GRP_RECURSIVE, GRP_ALL, NQSQ_GRP, GRP_SHARES, 
DYNAMIC_GRP.

=item %info = $batch->usergrpinfo(usergrps, options);

This routine takes two arguments: reference of a user group name array and  
constant value, returns LSF user group membership. LSF user group is defined in
the configuration file lsb.users. C<options> is the same as the one of 
lsb_hostgrpinfo();

=item @queueinfo = $batch->queueinfo(queues, host, user, options);

This routine takes four arguments: reference of a queue name array, host name
of the lsf cluster, user name and constant value. Returns information about 
batch queues. Queue names can be obtained from the file lsb.queues. User names
can be obtained from the file lsb.users, and C<options> is reserved for future 
using; its default value is 0.

=item @info = $batch->sharedresourceinfo(resources, hostname, options);

This routine takes three arguments, reference of a NULL terminated string array
storing requesting resource names, host name of the LSF cluster and options code.
Returns the requested shared resource information in dynamic values. if set
C<resources> to undefined, returns all shared resources. If C<hostName> is undefined,
shared resource available on all hosts will be returned. C<options> is reserved
for future using. Currently, it should be set to 0.

=item @info = $batch->hostpartinfo(partitions);

This routine takes a reference of a host partition names array as the argument.
It returns information about host partitions. Host partition names can be obtained
from the configuration file lsb.hosts.

=item $er = $batch->geteventrecord(log, line);

This routine gets an event record from a C<log> file.

=item $batch->pendreason(numReason, rsTb, jInfoH, loadIndex, clusterId);

This routine explains why a job is pending. C<numReason> is the length of reason
Table, C<rsTb> is a job reason Table , C<jInfoH> is a pointer to jobInfoHead 
stucture, C<loadIndex> is an array of load Index and C<clusterId> is cluster Id.

C<numReason> and C<rsTb> can be obtained by calling numReasons and reasonTb
respectively, C<numReason> and C<rsTb> are members of the struct jobInfoEnt, and
this struct can be obtained by lsb_readjobinfo; C<jInfoH> can be obtained by
calling lsb_readjobinfo_a; C<loadIndex> can be obtained by calling 
LSF::Batch::jobInfoPtr::initLoadIndex(); C<clusterId> is one member of struct
jobInfoEnt, and this struct can be obtained by calling readjobinfo.

=item $batch->pendreason_ex(reasonLevel, jInfoE, jInfoH, clusterId);
 
This one is the updated version of pendreason(). The new parameter C<reasonLevel> 
is corresponding to bjobs -p (0-3).
 
=item $batch->suspreason(reasons, subreasons, loadIndex);

This routine explains why a job was suspended. C<reasons> and C<subreasons> are 
members of struct jobInfoEnt respectively, and this struct can be obtained by 
readjobinfo. C<loadIndex> is the same as the one of pendreason().
 
=item $batch->bjobs_psum(params);
 
This routine displays a summarized version of reasons for pending jobs.
C<params> is a hash input parameter.

=item $batch->brsvadd(params);

This routine makes an advance reservation. C<params> is a hash input parameter.

=item @rsvInfo = $batch->reservationinfo(rsvid);

This routine retrieves reservation information based on given C<rsvid>.
Retrieve all reservation information if C<rsvid> is undef. $rsvInfo[0] is 0, if
there is no reservations to match the C<rsvid>.

=item $batch->removereservation(rsvid);

This routine removes a reservation identified by the C<rsvid>.

=item $hosts = $batch->gethostlist;

This routine gets the host list to be used for launching parallel tasks through
the launch() API. It has to be used in the script which would be submit as a job 
in LSF.

=item $batch->launch(hostlist, command, options);

This routine launches parallel tasks on a set of hosts. C<hostlist> must be the 
same as or a subset of the hostlist retrieved by gethostlist(). It has to be 
used in the script which is submited as a job in LSF. C<options> could be
LSF_DJOB_DISABLE_STDIN, LSF_DJOB_NOWAIT, LSF_DJOB_STDERR_WITH_HOSTNAME or
LSF_DJOB_STDOUT_WITH_HOSTNAME.

=back

=head1 EXPORTED CONSTANTS

These constants are used into LSF APIs for convenience. You can find the detailed
explanations in the LSF man pages for relative APIs. 

  ACT_DONE
  ACT_FAIL
  ACT_NO
  ACT_PREEMPT
  ACT_START
  ALL_CALENDARS
  ALL_EVENTS
  ALL_JOB
  ALL_QUEUE
  ALL_USERS
  CALADD
  CALDEL
  CALMOD
  CALOCCS
  CALUNDEL
  CAL_FORCE
  CHECK_HOST
  CHECK_USER
  CONF_CHECK
  CONF_EXPAND
  CONF_NO_CHECK
  CONF_NO_EXPAND
  CONF_RETURN_HOSTSPEC
  CUR_JOB
  DEFAULT_MSG_DESC
  DEFAULT_NUMPRO
  DELETE_NUMBER
  DEL_NUMPRO
  DFT_QUEUE
  DONE_JOB
  EVEADD
  EVEDEL
  EVEMOD
  EVENT_ACTIVE
  EVENT_CAL_DELETE
  EVENT_CAL_MODIFY
  EVENT_CAL_NEW
  EVENT_CAL_UNDELETE
  EVENT_CHKPNT
  EVENT_HOST_CTRL
  EVENT_INACTIVE
  EVENT_JGRP_ADD
  EVENT_JGRP_CNT
  EVENT_JGRP_MOD
  EVENT_JGRP_STATUS
  EVENT_JOB_ACCEPT
  EVENT_JOB_ATTA_DATA
  EVENT_JOB_ATTR_SET
  EVENT_JOB_CHUNK
  EVENT_JOB_CLEAN
  EVENT_JOB_EXCEPTION
  EVENT_JOB_EXECUTE
  EVENT_JOB_EXT_MSG
  EVENT_JOB_FINISH
  EVENT_JOB_FORCE
  EVENT_JOB_FORWARD
  EVENT_JOB_MODIFY
  EVENT_JOB_MODIFY2
  EVENT_JOB_MOVE
  EVENT_JOB_MSG
  EVENT_JOB_MSG_ACK
  EVENT_JOB_NEW
  EVENT_JOB_OCCUPY_REQ
  EVENT_JOB_REQUEUE
  EVENT_JOB_ROUTE
  EVENT_JOB_SIGACT
  EVENT_JOB_SIGNAL
  EVENT_JOB_START
  EVENT_JOB_START_ACCEPT
  EVENT_JOB_STATUS
  EVENT_JOB_SWITCH
  EVENT_JOB_VACATED
  EVENT_LOAD_INDEX
  EVENT_LOG_SWITCH
  EVENT_MBD_DIE
  EVENT_MBD_START
  EVENT_MBD_UNFULFILL
  EVENT_MIG
  EVENT_PRE_EXEC_START
  EVENT_QUEUE_CTRL
  EVENT_REJECT
  EVENT_SBD_JOB_STATUS
  EVENT_SBD_UNREPORTED_STATUS
  EVENT_STATUS_ACK
  EVENT_TYPE_EXCLUSIVE
  EVENT_TYPE_LATCHED
  EVENT_TYPE_PULSE
  EVENT_TYPE_PULSEALL
  EVENT_TYPE_UNKNOWN
  EVE_HIST
  EV_EXCEPT
  EV_FILE
  EV_UNDEF
  EV_USER
  EXIT_INIT_ENVIRON
  EXIT_KILL_ZOMBIE
  EXIT_NORMAL
  EXIT_NO_MAPPING
  EXIT_PRE_EXEC
  EXIT_REMOTE_PERMISSION
  EXIT_REMOVE
  EXIT_REQUEUE
  EXIT_RERUN
  EXIT_RESTART
  EXIT_ZOMBIE
  EXIT_ZOMBIE_JOB
  EXT_ATTA_POST
  EXT_ATTA_READ
  EXT_DATA_AVAIL
  EXT_DATA_NOEXIST
  EXT_DATA_UNAVAIL
  EXT_DATA_UNKNOWN
  EXT_MSG_POST
  EXT_MSG_READ
  EXT_MSG_REPLAY
  FINISH_PEND
  GROUP_JLP
  GROUP_MAX
  GRP_ALL
  GRP_RECURSIVE
  GRP_SHARES
  HOST_BUSY_IO
  HOST_BUSY_IT
  HOST_BUSY_LS
  HOST_BUSY_MEM
  HOST_BUSY_NOT
  HOST_BUSY_PG
  HOST_BUSY_R15M
  HOST_BUSY_R15S
  HOST_BUSY_R1M
  HOST_BUSY_SWP
  HOST_BUSY_TMP
  HOST_BUSY_UT
  HOST_CLOSE
  HOST_GRP
  HOST_JLU
  HOST_NAME
  HOST_OPEN
  HOST_REBOOT
  HOST_SHUTDOWN
  HOST_STAT_BUSY
  HOST_STAT_DISABLED
  HOST_STAT_EXCLUSIVE
  HOST_STAT_FULL
  HOST_STAT_LOCKED
  HOST_STAT_NO_LIM
  HOST_STAT_OK
  HOST_STAT_UNAVAIL
  HOST_STAT_UNLICENSED
  HOST_STAT_UNREACH
  HOST_STAT_WIND
  HPART_HGRP
  H_ATTR_CHKPNTABLE
  H_ATTR_CHKPNT_COPY
  JGRP_ACTIVE
  JGRP_ARRAY_INFO
  JGRP_COUNT_NDONE
  JGRP_COUNT_NEXIT
  JGRP_COUNT_NJOBS
  JGRP_COUNT_NPSUSP
  JGRP_COUNT_NRUN
  JGRP_COUNT_NSSUSP
  JGRP_COUNT_NUSUSP
  JGRP_COUNT_PEND
  JGRP_DEL
  JGRP_HOLD
  JGRP_INACTIVE
  JGRP_INFO
  JGRP_NODE_ARRAY
  JGRP_NODE_GROUP
  JGRP_NODE_JOB
  JGRP_RECURSIVE
  JGRP_RELEASE
  JGRP_RELEASE_PARENTONLY
  JGRP_UNDEFINED
  JOBID_ONLY
  JOBID_ONLY_ALL
  JOB_STAT_DONE
  JOB_STAT_EXIT
  JOB_STAT_NULL
  JOB_STAT_PDONE
  JOB_STAT_PEND
  JOB_STAT_PERR
  JOB_STAT_PSUSP
  JOB_STAT_RUN
  JOB_STAT_SSUSP
  JOB_STAT_UNKWN
  JOB_STAT_USUSP
  JOB_STAT_WAIT
  LAST_JOB
  LOST_AND_FOUND
  LSBATCH_H
  LSBE_AFS_TOKENS
  LSBE_ARRAY_NULL
  LSBE_BAD_ARG
  LSBE_BAD_ATTA_DIR
  LSBE_BAD_CALENDAR
  LSBE_BAD_CHKLOG
  LSBE_BAD_CLUSTER
  LSBE_BAD_CMD
  LSBE_BAD_EVENT
  LSBE_BAD_EXT_MSGID
  LSBE_BAD_FRAME
  LSBE_BAD_GROUP
  LSBE_BAD_HOST
  LSBE_BAD_HOST_SPEC
  LSBE_BAD_HPART
  LSBE_BAD_IDX
  LSBE_BAD_JOB
  LSBE_BAD_JOBID
  LSBE_BAD_LIMIT
  LSBE_BAD_PROJECT_GROUP
  LSBE_BAD_QUEUE
  LSBE_BAD_RESOURCE
  LSBE_BAD_RESREQ
  LSBE_BAD_SIGNAL
  LSBE_BAD_SUBMISSION_HOST
  LSBE_BAD_TIME
  LSBE_BAD_TIMEEVENT
  LSBE_BAD_UGROUP
  LSBE_BAD_USER
  LSBE_BAD_USER_PRIORITY
  LSBE_BIG_IDX
  LSBE_CAL_CYC
  LSBE_CAL_DISABLED
  LSBE_CAL_EXIST
  LSBE_CAL_MODIFY
  LSBE_CAL_USED
  LSBE_CAL_VOID
  LSBE_CHKPNT_CALL
  LSBE_CHUNK_JOB
  LSBE_CONF_FATAL
  LSBE_CONF_WARNING
  LSBE_CONN_EXIST
  LSBE_CONN_NONEXIST
  LSBE_CONN_REFUSED
  LSBE_CONN_TIMEOUT
  LSBE_COPY_DATA
  LSBE_DEPEND_SYNTAX
  LSBE_DLOGD_ISCONN
  LSBE_EOF
  LSBE_ESUB_ABORT
  LSBE_EVENT_FORMAT
  LSBE_EXCEPT_ACTION
  LSBE_EXCEPT_COND
  LSBE_EXCEPT_SYNTAX
  LSBE_EXCLUSIVE
  LSBE_FRAME_BAD_IDX
  LSBE_FRAME_BIG_IDX
  LSBE_HJOB_LIMIT
  LSBE_HP_FAIRSHARE_DEF
  LSBE_INDEX_FORMAT
  LSBE_INTERACTIVE_CAL
  LSBE_INTERACTIVE_RERUN
  LSBE_JGRP_BAD
  LSBE_JGRP_CTRL_UNKWN
  LSBE_JGRP_EXIST
  LSBE_JGRP_HASJOB
  LSBE_JGRP_HOLD
  LSBE_JGRP_NULL
  LSBE_JOB_ARRAY
  LSBE_JOB_ATTA_LIMIT
  LSBE_JOB_CAL_MODIFY
  LSBE_JOB_DEP
  LSBE_JOB_ELEMENT
  LSBE_JOB_EXIST
  LSBE_JOB_FINISH
  LSBE_JOB_FORW
  LSBE_JOB_MODIFY
  LSBE_JOB_MODIFY_ONCE
  LSBE_JOB_MODIFY_USED
  LSBE_JOB_REQUEUED
  LSBE_JOB_REQUEUE_REMOTE
  LSBE_JOB_STARTED
  LSBE_JOB_SUSP
  LSBE_JS_DISABLED
  LSBE_J_UNCHKPNTABLE
  LSBE_J_UNREPETITIVE
  LSBE_LOCK_JOB
  LSBE_LSBLIB
  LSBE_LSLIB
  LSBE_MBATCHD
  LSBE_MC_CHKPNT
  LSBE_MC_EXCEPTION
  LSBE_MC_HOST
  LSBE_MC_REPETITIVE
  LSBE_MC_TIMEEVENT
  LSBE_MIGRATION
  LSBE_MOD_JOB_NAME
  LSBE_MSG_DELIVERED
  LSBE_MSG_RETRY
  LSBE_NOLSF_HOST
  LSBE_NOMATCH_CALENDAR
  LSBE_NOMATCH_EVENT
  LSBE_NOT_STARTED
  LSBE_NO_CALENDAR
  LSBE_NO_ENOUGH_HOST
  LSBE_NO_ENV
  LSBE_NO_ERROR
  LSBE_NO_EVENT
  LSBE_NO_FORK
  LSBE_NO_GROUP
  LSBE_NO_HOST
  LSBE_NO_HOST_GROUP
  LSBE_NO_HPART
  LSBE_NO_IFREG
  LSBE_NO_INTERACTIVE
  LSBE_NO_JOB
  LSBE_NO_JOBID
  LSBE_NO_JOBMSG
  LSBE_NO_JOB_PRIORITY
  LSBE_NO_LICENSE
  LSBE_NO_MEM
  LSBE_NO_OUTPUT
  LSBE_NO_RESOURCE
  LSBE_NO_USER
  LSBE_NO_USER_GROUP
  LSBE_NQS_BAD_PAR
  LSBE_NQS_NO_ARRJOB
  LSBE_NUM_ERR
  LSBE_ONLY_INTERACTIVE
  LSBE_OP_RETRY
  LSBE_OVER_LIMIT
  LSBE_OVER_RUSAGE
  LSBE_PEND_CAL_JOB
  LSBE_PERMISSION
  LSBE_PERMISSION_MC
  LSBE_PJOB_LIMIT
  LSBE_PORT
  LSBE_PREMATURE
  LSBE_PROC_NUM
  LSBE_PROTOCOL
  LSBE_PTY_INFILE
  LSBE_QJOB_LIMIT
  LSBE_QUEUE_CLOSED
  LSBE_QUEUE_HOST
  LSBE_QUEUE_NAME
  LSBE_QUEUE_USE
  LSBE_QUEUE_WINDOW
  LSBE_ROOT
  LSBE_RUN_CAL_JOB
  LSBE_SBATCHD
  LSBE_SBD_UNREACH
  LSBE_SERVICE
  LSBE_SP_CHILD_DIES
  LSBE_SP_CHILD_FAILED
  LSBE_SP_COPY_FAILED
  LSBE_SP_DELETE_FAILED
  LSBE_SP_FAILED_HOSTS_LIM
  LSBE_SP_FIND_HOST_FAILED
  LSBE_SP_FORK_FAILED
  LSBE_SP_SPOOLDIR_FAILED
  LSBE_SP_SRC_NOT_SEEN
  LSBE_START_TIME
  LSBE_STOP_JOB
  LSBE_SYNTAX_CALENDAR
  LSBE_SYSCAL_EXIST
  LSBE_SYS_CALL
  LSBE_TIME_OUT
  LSBE_UGROUP_MEMBER
  LSBE_UJOB_LIMIT
  LSBE_UNKNOWN_EVENT
  LSBE_UNSUPPORTED_MC
  LSBE_USER_JLIMIT
  LSBE_XDR
  LSB_CHKPERIOD_NOCHNG
  LSB_CHKPNT_COPY
  LSB_CHKPNT_FORCE
  LSB_CHKPNT_KILL
  LSB_CHKPNT_MIG
  LSB_CHKPNT_STOP
  LSB_EVENT_VERSION3_0
  LSB_EVENT_VERSION3_1
  LSB_EVENT_VERSION3_2
  LSB_EVENT_VERSION4_0
  LSB_KILL_REQUEUE
  LSB_MAX_ARRAY_IDX
  LSB_MAX_ARRAY_JOBID
  LSB_MAX_SD_LENGTH
  LSB_MODE_BATCH
  LSB_MODE_JS
  LSB_SIG_NUM
  LSF_JOBIDINDEX_FILENAME
  LSF_JOBIDINDEX_FILETAG
  MASTER_CONF
  MASTER_FATAL
  MASTER_MEM
  MASTER_NULL
  MASTER_RECONFIG
  MASTER_RESIGN
  MAXDESCLEN
  MAXPATHLEN
  MAX_CALENDARS
  MAX_CHARLEN
  MAX_CMD_DESC_LEN
  MAX_GROUPS
  MAX_HPART_USERS
  MAX_LSB_NAME_LEN
  MAX_USER_EQUIVALENT
  MAX_USER_MAPPING
  MAX_VERSION_LEN
  MBD_CKCONFIG
  MBD_RECONFIG
  MBD_RESTART
  MSGSIZE
  NO_PEND_REASONS
  NQSQ_GRP
  NQS_ROUTE
  NQS_SERVER
  NQS_SIG
  NUM_JGRP_COUNTERS
  PEND_ADMIN_STOP
  PEND_CHKPNT_DIR
  PEND_CHUNK_FAIL
  PEND_HAS_RUN
  PEND_HOST_ACCPT_ONE
  PEND_HOST_DISABLED
  PEND_HOST_EXCLUSIVE
  PEND_HOST_JOB_LIMIT
  PEND_HOST_JOB_RUSAGE
  PEND_HOST_JOB_SSUSP
  PEND_HOST_JS_DISABLED
  PEND_HOST_LESS_SLOTS
  PEND_HOST_LOAD
  PEND_HOST_LOCKED
  PEND_HOST_MISS_DEADLINE
  PEND_HOST_NONEXCLUSIVE
  PEND_HOST_NO_LIM
  PEND_HOST_NO_USER
  PEND_HOST_PART_PRIO
  PEND_HOST_PART_USER
  PEND_HOST_QUE_MEMB
  PEND_HOST_QUE_RESREQ
  PEND_HOST_QUE_RUSAGE
  PEND_HOST_RES_REQ
  PEND_HOST_SCHED_TYPE
  PEND_HOST_UNLICENSED
  PEND_HOST_USR_JLIMIT
  PEND_HOST_USR_SPEC
  PEND_HOST_WINDOW
  PEND_HOST_WIN_WILL_CLOSE
  PEND_JGRP_HOLD
  PEND_JGRP_INACT
  PEND_JGRP_RELEASE
  PEND_JGRP_WAIT
  PEND_JOB
  PEND_JOB_ARRAY_JLIMIT
  PEND_JOB_DELAY_SCHED
  PEND_JOB_DEPEND
  PEND_JOB_DEP_INVALID
  PEND_JOB_DEP_REJECT
  PEND_JOB_ENFUGRP
  PEND_JOB_ENV
  PEND_JOB_EXEC_INIT
  PEND_JOB_FORWARDED
  PEND_JOB_JS_DISABLED
  PEND_JOB_LOGON_FAIL
  PEND_JOB_MIG
  PEND_JOB_MODIFY
  PEND_JOB_NEW
  PEND_JOB_NO_FILE
  PEND_JOB_NO_PASSWD
  PEND_JOB_NO_SPAN
  PEND_JOB_OPEN_FILES
  PEND_JOB_PATHS
  PEND_JOB_PRE_EXEC
  PEND_JOB_QUE_REJECT
  PEND_JOB_RCLUS_UNREACH
  PEND_JOB_REASON
  PEND_JOB_REQUEUED
  PEND_JOB_RESTART_FILE
  PEND_JOB_RMT_ZOMBIE
  PEND_JOB_RSCHED_ALLOC
  PEND_JOB_RSCHED_START
  PEND_JOB_SPREAD_TASK
  PEND_JOB_START_FAIL
  PEND_JOB_START_TIME
  PEND_JOB_START_UNKNWN
  PEND_JOB_SWITCH
  PEND_JOB_TIME_INVALID
  PEND_LOAD_UNAVAIL
  PEND_NO_MAPPING
  PEND_NQS_FUN_OFF
  PEND_NQS_REASONS
  PEND_NQS_RETRY
  PEND_QUE_HOST_JLIMIT
  PEND_QUE_INACT
  PEND_QUE_JOB_LIMIT
  PEND_QUE_NO_SPAN
  PEND_QUE_PJOB_LIMIT
  PEND_QUE_PRE_FAIL
  PEND_QUE_PROC_JLIMIT
  PEND_QUE_SPREAD_TASK
  PEND_QUE_USR_JLIMIT
  PEND_QUE_USR_PJLIMIT
  PEND_QUE_WINDOW
  PEND_QUE_WINDOW_WILL_CLOSE
  PEND_RMT_PERMISSION
  PEND_SBD_GETPID
  PEND_SBD_JOB_ACCEPT
  PEND_SBD_JOB_QUOTA
  PEND_SBD_JOB_REQUEUE
  PEND_SBD_LOCK
  PEND_SBD_NO_MEM
  PEND_SBD_NO_PROCESS
  PEND_SBD_ROOT
  PEND_SBD_SOCKETPAIR
  PEND_SBD_UNREACH
  PEND_SBD_ZOMBIE
  PEND_SYS_NOT_READY
  PEND_SYS_UNABLE
  PEND_TIME_EXPIRED
  PEND_UGRP_JOB_LIMIT
  PEND_UGRP_PJOB_LIMIT
  PEND_UGRP_PROC_JLIMIT
  PEND_USER_JOB_LIMIT
  PEND_USER_PJOB_LIMIT
  PEND_USER_PROC_JLIMIT
  PEND_USER_RESUME
  PEND_USER_STOP
  PEND_WAIT_NEXT
  PREPARE_FOR_OP
  PRINT_LONG_NAMELIST
  PRINT_MCPU_HOSTS
  PRINT_SHORT_NAMELIST
  QUEUE_ACTIVATE
  QUEUE_CLOSED
  QUEUE_INACTIVATE
  QUEUE_OPEN
  QUEUE_STAT_ACTIVE
  QUEUE_STAT_DISC
  QUEUE_STAT_NOPERM
  QUEUE_STAT_OPEN
  QUEUE_STAT_RUN
  QUEUE_STAT_RUNWIN_CLOSE
  Q_ATTRIB_BACKFILL
  Q_ATTRIB_CHKPNT
  Q_ATTRIB_DEFAULT
  Q_ATTRIB_ENQUE_INTERACTIVE_AHEAD
  Q_ATTRIB_EXCLUSIVE
  Q_ATTRIB_EXCL_RMTJOB
  Q_ATTRIB_FAIRSHARE
  Q_ATTRIB_HOST_PREFER
  Q_ATTRIB_IGNORE_DEADLINE
  Q_ATTRIB_MC_FAST_SCHEDULE
  Q_ATTRIB_NONPREEMPTABLE
  Q_ATTRIB_NONPREEMPTIVE
  Q_ATTRIB_NO_HOST_TYPE
  Q_ATTRIB_NO_INTERACTIVE
  Q_ATTRIB_NQS
  Q_ATTRIB_ONLY_INTERACTIVE
  Q_ATTRIB_PREEMPTABLE
  Q_ATTRIB_PREEMPTIVE
  Q_ATTRIB_RECEIVE
  Q_ATTRIB_RERUNNABLE
  READY_FOR_OP
  RLIMIT_CORE
  RLIMIT_CPU
  RLIMIT_DATA
  RLIMIT_FSIZE
  RLIMIT_RSS
  RLIMIT_STACK
  RLIM_INFINITY
  RUNJOB_OPT_NORMAL
  RUNJOB_OPT_NOSTOP
  RUN_JOB
  SORT_HOST
  SUB2_BSUB_BLOCK
  SUB2_HOLD
  SUB2_HOST_NT
  SUB2_HOST_UX
  SUB2_IN_FILE_SPOOL
  SUB2_JOB_CMD_SPOOL
  SUB2_JOB_PRIORITY
  SUB2_MODIFY_CMD
  SUB2_QUEUE_CHKPNT
  SUB2_QUEUE_RERUNNABLE
  SUB_CHKPNTABLE
  SUB_CHKPNT_DIR
  SUB_CHKPNT_PERIOD
  SUB_DEPEND_COND
  SUB_ERR_FILE
  SUB_EXCEPT
  SUB_EXCLUSIVE
  SUB_HOST
  SUB_HOST_SPEC
  SUB_INTERACTIVE
  SUB_IN_FILE
  SUB_JOB_NAME
  SUB_LOGIN_SHELL
  SUB_MAIL_USER
  SUB_MODIFY
  SUB_MODIFY_ONCE
  SUB_NOTIFY_BEGIN
  SUB_NOTIFY_END
  SUB_OTHER_FILES
  SUB_OUT_FILE
  SUB_PRE_EXEC
  SUB_PROJECT_NAME
  SUB_PTY
  SUB_PTY_SHELL
  SUB_QUEUE
  SUB_REASON_CPULIMIT
  SUB_REASON_DEADLINE
  SUB_REASON_PROCESSLIMIT
  SUB_REASON_RUNLIMIT
  SUB_RERUNNABLE
  SUB_RESTART
  SUB_RESTART_FORCE
  SUB_RES_REQ
  SUB_TIME_EVENT
  SUB_USER_GROUP
  SUB_WINDOW_SIG
  SUSP_ADMIN_STOP
  SUSP_HOST_LOCK
  SUSP_JOB
  SUSP_LOAD_REASON
  SUSP_LOAD_UNAVAIL
  SUSP_MBD_LOCK
  SUSP_MBD_PREEMPT
  SUSP_PG_IT
  SUSP_QUEUE_REASON
  SUSP_QUEUE_WINDOW
  SUSP_QUE_RESUME_COND
  SUSP_QUE_STOP_COND
  SUSP_REASON_RESET
  SUSP_RESCHED_PREEMPT
  SUSP_RES_LIMIT
  SUSP_RES_RESERVE
  SUSP_SBD_PREEMPT
  SUSP_SBD_STARTUP
  SUSP_USER_REASON
  SUSP_USER_RESUME
  SUSP_USER_STOP
  THIS_VERSION
  TO_BOTTOM
  TO_TOP
  USER_GRP
  USER_JLP
  XF_OP_EXEC2SUB
  XF_OP_EXEC2SUB_APPEND
  XF_OP_SUB2EXEC
  XF_OP_SUB2EXEC_APPEND
  ZOMBIE_JOB
  _PATH_NULL

=head1 AUTHOR

Paul Franceus, Capita Technologies, Inc., paul@capita.com

=head1 MODIFIER

ISV Team, Platform Computing Corporation, support@platform.com

=head1 SEE ALSO

C<perl(1)>,
C<LSF::Base>,
C<LSF Programmer's guide>,
C<lslib(3)>,
C<LSF man pages for each function>

=cut
