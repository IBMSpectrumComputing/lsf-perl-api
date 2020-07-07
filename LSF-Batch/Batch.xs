#ifdef __cplusplus
extern "C" {
#endif
#ifdef sun
#include "netdb.h"
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"
#include "Av_CharPtrPtr.h"  /* XS_*_charPtrPtr() */
#include "Av_IntPtr.h"  /* XS_*_intPtr() */
#include <lsf/lsf.h>
#include <lsf/lsbatch.h>
#include <sys/time.h>
#ifdef __cplusplus
}
#endif

#ifndef PL_errgv
#define PL_errgv errgv
#endif

#define SET_LSB_ERRMSG sv_setpv(GvSV(PL_errgv),lsb_sysmsg())
#define SET_LSB_ERRMSG_TO(msg)  sv_setpv(GvSV(PL_errgv),msg)
#define SET_LSF_ERRMSG sv_setpv(GvSV(PL_errgv),ls_sysmsg())

#ifndef STATUS_NATIVE_SET
#define STATUS_NATIVE_SET STATUS_NATIVE_CHILD_SET
#endif

#define LSF_NSIGNAL   31

#define NSIG 0
#define SIGTRAP SIGTERM
#define SIGIOT  SIGTERM
#define SIGEMT  SIGTERM
#define SIGBUS  SIGTERM
#define SIGSYS  SIGTERM
#define SIGIO   SIGTERM
#define SIGXCPU SIGTERM
#define SIGXFSZ SIGTERM
#define SIGVTALRM SIGTERM
#define SIGPROF SIGTERM
#define SIGWINCH SIGTERM
#define SIGLOST SIGTERM
#define SIGURG  SIGTERM

#define RETSTR_SIZE 4096

char *sigSym[] = {"", "HUP", "INT", "QUIT", "ILL", "TRAP", "IOT", "EMT", "FPE", "KILL", "BUS", "SEGV", "SYS", "PIPE", "ALRM", "TERM", "STOP", "TSTP", "CONT", "CHLD", "TTIN", "TTOU", "IO", "XCPU", "XFSZ", "VTALRM", "PROF", "WINCH", "LOST", "URG", "USR1", "USR2"};

int signal_map[] = {0, SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGTRAP, SIGIOT, SIGEMT, SIGFPE, SIGKILL, SIGBUS, SIGSEGV, SIGSYS, SIGPIPE, SIGALRM, SIGTERM, SIGSTOP, SIGTSTP, SIGCONT, SIGCHLD, SIGTTIN, SIGTTOU, SIGIO, SIGXCPU, SIGXFSZ, SIGVTALRM, SIGPROF, SIGWINCH, SIGLOST, SIGURG, SIGUSR1, SIGUSR2};

int NSIGNAL_MAP = (sizeof(signal_map)/sizeof(int));

static int
not_here(s)
char *s;
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

static double
constant(name, arg)
char *name;
int arg;
{
    errno = 0;
    switch (*name) {
    case 'A':
	if (strEQ(name, "ACT_DONE"))
#ifdef ACT_DONE
	    return ACT_DONE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ACT_FAIL"))
#ifdef ACT_FAIL
	    return ACT_FAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ACT_NO"))
#ifdef ACT_NO
	    return ACT_NO;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ACT_PREEMPT"))
#ifdef ACT_PREEMPT
	    return ACT_PREEMPT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ACT_START"))
#ifdef ACT_START
	    return ACT_START;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ALL_CALENDARS"))
#ifdef ALL_CALENDARS
	    return ALL_CALENDARS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ALL_EVENTS"))
#ifdef ALL_EVENTS
	    return ALL_EVENTS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ALL_JOB"))
#ifdef ALL_JOB
	    return ALL_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "ALL_QUEUE"))
#ifdef ALL_QUEUE
	    return ALL_QUEUE;
#else
	    goto not_there;
#endif
	break;
    case 'B':
	break;
    case 'C':
	if (strEQ(name, "CALADD"))
#ifdef CALADD
	    return CALADD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CALDEL"))
#ifdef CALDEL
	    return CALDEL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CALMOD"))
#ifdef CALMOD
	    return CALMOD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CALOCCS"))
#ifdef CALOCCS
	    return CALOCCS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CALUNDEL"))
#ifdef CALUNDEL
	    return CALUNDEL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CAL_FORCE"))
#ifdef CAL_FORCE
	    return CAL_FORCE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CHECK_HOST"))
#ifdef CHECK_HOST
	    return CHECK_HOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CHECK_USER"))
#ifdef CHECK_USER
	    return CHECK_USER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CONF_CHECK"))
#ifdef CONF_CHECK
	    return CONF_CHECK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CONF_EXPAND"))
#ifdef CONF_EXPAND
	    return CONF_EXPAND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CONF_NO_CHECK"))
#ifdef CONF_NO_CHECK
	    return CONF_NO_CHECK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CONF_NO_EXPAND"))
#ifdef CONF_NO_EXPAND
	    return CONF_NO_EXPAND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CONF_RETURN_HOSTSPEC"))
#ifdef CONF_RETURN_HOSTSPEC
	    return CONF_RETURN_HOSTSPEC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "CUR_JOB"))
#ifdef CUR_JOB
	    return CUR_JOB;
#else
	    goto not_there;
#endif
	break;
    case 'D':
	if (strEQ(name, "DEFAULT_NUMPRO"))
#ifdef DEFAULT_NUMPRO
	    return DEFAULT_NUMPRO;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DELETE_NUMBER"))
#ifdef DELETE_NUMBER
	    return DELETE_NUMBER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DEL_NUMPRO"))
#ifdef DEL_NUMPRO
	    return DEL_NUMPRO;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DFT_QUEUE"))
#ifdef DFT_QUEUE
	    return DFT_QUEUE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "DONE_JOB"))
#ifdef DONE_JOB
	    return DONE_JOB;
#else
	    goto not_there;
#endif
	break;
    case 'E':
	if (strEQ(name, "EVEADD"))
#ifdef EVEADD
	    return EVEADD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVEDEL"))
#ifdef EVEDEL
	    return EVEDEL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVEMOD"))
#ifdef EVEMOD
	    return EVEMOD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_ACTIVE"))
#ifdef EVENT_ACTIVE
	    return EVENT_ACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_CAL_DELETE"))
#ifdef EVENT_CAL_DELETE
	    return EVENT_CAL_DELETE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_CAL_MODIFY"))
#ifdef EVENT_CAL_MODIFY
	    return EVENT_CAL_MODIFY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_CAL_NEW"))
#ifdef EVENT_CAL_NEW
	    return EVENT_CAL_NEW;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_CAL_UNDELETE"))
#ifdef EVENT_CAL_UNDELETE
	    return EVENT_CAL_UNDELETE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_CHKPNT"))
#ifdef EVENT_CHKPNT
	    return EVENT_CHKPNT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_HOST_CTRL"))
#ifdef EVENT_HOST_CTRL
	    return EVENT_HOST_CTRL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_INACTIVE"))
#ifdef EVENT_INACTIVE
	    return EVENT_INACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JGRP_ADD"))
#ifdef EVENT_JGRP_ADD
	    return EVENT_JGRP_ADD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JGRP_CTRL"))
#ifdef EVENT_JGRP_CTRL
	    return EVENT_JGRP_CTRL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JGRP_MOD"))
#ifdef EVENT_JGRP_MOD
	    return EVENT_JGRP_MOD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JGRP_STATUS"))
#ifdef EVENT_JGRP_STATUS
	    return EVENT_JGRP_STATUS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_ACCEPT"))
#ifdef EVENT_JOB_ACCEPT
	    return EVENT_JOB_ACCEPT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_ATTA_DATA"))
#ifdef EVENT_JOB_ATTA_DATA
	    return EVENT_JOB_ATTA_DATA;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_ATTR_SET"))
#ifdef EVENT_JOB_ATTR_SET
	    return EVENT_JOB_ATTR_SET;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_CHUNK"))
#ifdef EVENT_JOB_CHUNK
	    return EVENT_JOB_CHUNK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_CLEAN"))
#ifdef EVENT_JOB_CLEAN
	    return EVENT_JOB_CLEAN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_EXCEPTION"))
#ifdef EVENT_JOB_EXCEPTION
	    return EVENT_JOB_EXCEPTION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_EXECUTE"))
#ifdef EVENT_JOB_EXECUTE
	    return EVENT_JOB_EXECUTE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_EXT_MSG"))
#ifdef EVENT_JOB_EXT_MSG
	    return EVENT_JOB_EXT_MSG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_FINISH"))
#ifdef EVENT_JOB_FINISH
	    return EVENT_JOB_FINISH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_FORCE"))
#ifdef EVENT_JOB_FORCE
	    return EVENT_JOB_FORCE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_FORWARD"))
#ifdef EVENT_JOB_FORWARD
	    return EVENT_JOB_FORWARD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_MODIFY"))
#ifdef EVENT_JOB_MODIFY
	    return EVENT_JOB_MODIFY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_MODIFY2"))
#ifdef EVENT_JOB_MODIFY2
	    return EVENT_JOB_MODIFY2;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_MOVE"))
#ifdef EVENT_JOB_MOVE
	    return EVENT_JOB_MOVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_MSG"))
#ifdef EVENT_JOB_MSG
	    return EVENT_JOB_MSG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_MSG_ACK"))
#ifdef EVENT_JOB_MSG_ACK
	    return EVENT_JOB_MSG_ACK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_NEW"))
#ifdef EVENT_JOB_NEW
	    return EVENT_JOB_NEW;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_OCCUPY_REQ"))
#ifdef EVENT_JOB_OCCUPY_REQ
	    return EVENT_JOB_OCCUPY_REQ;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_REQUEUE"))
#ifdef EVENT_JOB_REQUEUE
	    return EVENT_JOB_REQUEUE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_ROUTE"))
#ifdef EVENT_JOB_ROUTE
	    return EVENT_JOB_ROUTE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_SIGACT"))
#ifdef EVENT_JOB_SIGACT
	    return EVENT_JOB_SIGACT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_SIGNAL"))
#ifdef EVENT_JOB_SIGNAL
	    return EVENT_JOB_SIGNAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_START"))
#ifdef EVENT_JOB_START
	    return EVENT_JOB_START;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_START_ACCEPT"))
#ifdef EVENT_JOB_START_ACCEPT
	    return EVENT_JOB_START_ACCEPT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_STATUS"))
#ifdef EVENT_JOB_STATUS
	    return EVENT_JOB_STATUS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_SWITCH"))
#ifdef EVENT_JOB_SWITCH
	    return EVENT_JOB_SWITCH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_JOB_VACATED"))
#ifdef EVENT_JOB_VACATED
	    return EVENT_JOB_VACATED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_LOAD_INDEX"))
#ifdef EVENT_LOAD_INDEX
	    return EVENT_LOAD_INDEX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_LOG_SWITCH"))
#ifdef EVENT_LOG_SWITCH
	    return EVENT_LOG_SWITCH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_MBD_DIE"))
#ifdef EVENT_MBD_DIE
	    return EVENT_MBD_DIE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_MBD_START"))
#ifdef EVENT_MBD_START
	    return EVENT_MBD_START;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_MBD_UNFULFILL"))
#ifdef EVENT_MBD_UNFULFILL
	    return EVENT_MBD_UNFULFILL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_MIG"))
#ifdef EVENT_MIG
	    return EVENT_MIG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_PRE_EXEC_START"))
#ifdef EVENT_PRE_EXEC_START
	    return EVENT_PRE_EXEC_START;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_QUEUE_CTRL"))
#ifdef EVENT_QUEUE_CTRL
	    return EVENT_QUEUE_CTRL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_REJECT"))
#ifdef EVENT_REJECT
	    return EVENT_REJECT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_SBD_JOB_STATUS"))
#ifdef EVENT_SBD_JOB_STATUS
	    return EVENT_SBD_JOB_STATUS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_SBD_UNREPORTED_STATUS"))
#ifdef EVENT_SBD_UNREPORTED_STATUS
	    return EVENT_SBD_UNREPORTED_STATUS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_STATUS_ACK"))
#ifdef EVENT_STATUS_ACK
	    return EVENT_STATUS_ACK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_TYPE_EXCLUSIVE"))
#ifdef EVENT_TYPE_EXCLUSIVE
	    return EVENT_TYPE_EXCLUSIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_TYPE_LATCHED"))
#ifdef EVENT_TYPE_LATCHED
	    return EVENT_TYPE_LATCHED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_TYPE_PULSE"))
#ifdef EVENT_TYPE_PULSE
	    return EVENT_TYPE_PULSE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_TYPE_PULSEALL"))
#ifdef EVENT_TYPE_PULSEALL
	    return EVENT_TYPE_PULSEALL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EVENT_TYPE_UNKNOWN"))
#ifdef EVENT_TYPE_UNKNOWN
	    return EVENT_TYPE_UNKNOWN;
#else
	    goto not_there;
#endif
        if (strEQ(name, "EVENT_ADRSV_FINISH"))
#ifdef EVENT_ADRSV_FINISH
            return EVENT_ADRSV_FINISH;
#else
            goto not_there;
#endif
        if (strEQ(name, "EVENT_HGHOST_CTRL"))
#ifdef EVENT_HGHOST_CTRL
            return EVENT_HGHOST_CTRL;
#else
            goto not_there;
#endif
        if (strEQ(name, "EVENT_CPUPROFILE_STATUS"))
#ifdef EVENT_CPUPROFILE_STATUS
            return EVENT_CPUPROFILE_STATUS;
#else
            goto not_there;
#endif
        if (strEQ(name, "EVENT_DATA_LOGGING"))
#ifdef EVENT_DATA_LOGGING
            return EVENT_DATA_LOGGING;
#else
            goto not_there;
#endif
        if (strEQ(name, "EVENT_JOB_RUN_RUSAGE"))
#ifdef EVENT_JOB_RUN_RUSAGE
            return EVENT_JOB_RUN_RUSAGE;
#else
            goto not_there;
#endif
        if (strEQ(name, "EVENT_END_OF_STREAM"))
#ifdef EVENT_END_OF_STREAM
            return EVENT_END_OF_STREAM;
#else
            goto not_there;
#endif
        if (strEQ(name, "EVENT_SLA_RECOMPUTE"))
#ifdef EVENT_SLA_RECOMPUTE
            return EVENT_SLA_RECOMPUTE;
#else
            goto not_there;
#endif
        if (strEQ(name, "EVENT_METRIC_LOG"))
#ifdef EVENT_METRIC_LOG
            return EVENT_METRIC_LOG;
#else
            goto not_there;
#endif
	if (strEQ(name, "EVE_HIST"))
#ifdef EVE_HIST
	    return EVE_HIST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EV_EXCEPT"))
#ifdef EV_EXCEPT
	    return EV_EXCEPT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EV_FILE"))
#ifdef EV_FILE
	    return EV_FILE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EV_UNDEF"))
#ifdef EV_UNDEF
	    return EV_UNDEF;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EV_USER"))
#ifdef EV_USER
	    return EV_USER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_INIT_ENVIRON"))
#ifdef EXIT_INIT_ENVIRON
	    return EXIT_INIT_ENVIRON;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_KILL_ZOMBIE"))
#ifdef EXIT_KILL_ZOMBIE
	    return EXIT_KILL_ZOMBIE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_NORMAL"))
#ifdef EXIT_NORMAL
	    return EXIT_NORMAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_NO_MAPPING"))
#ifdef EXIT_NO_MAPPING
	    return EXIT_NO_MAPPING;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_PRE_EXEC"))
#ifdef EXIT_PRE_EXEC
	    return EXIT_PRE_EXEC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_REMOTE_PERMISSION"))
#ifdef EXIT_REMOTE_PERMISSION
	    return EXIT_REMOTE_PERMISSION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_REMOVE"))
#ifdef EXIT_REMOVE
	    return EXIT_REMOVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_REQUEUE"))
#ifdef EXIT_REQUEUE
	    return EXIT_REQUEUE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_RERUN"))
#ifdef EXIT_RERUN
	    return EXIT_RERUN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_RESTART"))
#ifdef EXIT_RESTART
	    return EXIT_RESTART;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_ZOMBIE"))
#ifdef EXIT_ZOMBIE
	    return EXIT_ZOMBIE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXIT_ZOMBIE_JOB"))
#ifdef EXIT_ZOMBIE_JOB
	    return EXIT_ZOMBIE_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXT_ATTA_POST"))
#ifdef EXT_ATTA_POST
	    return EXT_ATTA_POST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXT_ATTA_READ"))
#ifdef EXT_ATTA_READ
	    return EXT_ATTA_READ;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXT_DATA_AVAIL"))
#ifdef EXT_DATA_AVAIL
	    return EXT_DATA_AVAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXT_DATA_NOEXIST"))
#ifdef EXT_DATA_NOEXIST
	    return EXT_DATA_NOEXIST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXT_DATA_UNAVAIL"))
#ifdef EXT_DATA_UNAVAIL
	    return EXT_DATA_UNAVAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXT_DATA_UNKNOWN"))
#ifdef EXT_DATA_UNKNOWN
	    return EXT_DATA_UNKNOWN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXT_MSG_POST"))
#ifdef EXT_MSG_POST
	    return EXT_MSG_POST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXT_MSG_READ"))
#ifdef EXT_MSG_READ
	    return EXT_MSG_READ;
#else
	    goto not_there;
#endif
	if (strEQ(name, "EXT_MSG_REPLAY"))
#ifdef EXT_MSG_REPLAY
	    return EXT_MSG_REPLAY;
#else
	    goto not_there;
#endif
	break;
    case 'F':
	if (strEQ(name, "FINISH_PEND"))
#ifdef FINISH_PEND
	    return FINISH_PEND;
#else
	    goto not_there;
#endif
	break;
    case 'G':
	if (strEQ(name, "GROUP_JLP"))
#ifdef GROUP_JLP
	    return GROUP_JLP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "GROUP_MAX"))
#ifdef GROUP_MAX
	    return GROUP_MAX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "GRP_ALL"))
#ifdef GRP_ALL
	    return GRP_ALL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "GRP_RECURSIVE"))
#ifdef GRP_RECURSIVE
	    return GRP_RECURSIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "GRP_SHARES"))
#ifdef GRP_SHARES
	    return GRP_SHARES;
#else
	    goto not_there;
#endif
	break;
    case 'H':
	if (strEQ(name, "HOST_BUSY_IO"))
#ifdef HOST_BUSY_IO
	    return HOST_BUSY_IO;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_IT"))
#ifdef HOST_BUSY_IT
	    return HOST_BUSY_IT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_LS"))
#ifdef HOST_BUSY_LS
	    return HOST_BUSY_LS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_MEM"))
#ifdef HOST_BUSY_MEM
	    return HOST_BUSY_MEM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_NOT"))
#ifdef HOST_BUSY_NOT
	    return HOST_BUSY_NOT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_PG"))
#ifdef HOST_BUSY_PG
	    return HOST_BUSY_PG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_R15M"))
#ifdef HOST_BUSY_R15M
	    return HOST_BUSY_R15M;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_R15S"))
#ifdef HOST_BUSY_R15S
	    return HOST_BUSY_R15S;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_R1M"))
#ifdef HOST_BUSY_R1M
	    return HOST_BUSY_R1M;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_SWP"))
#ifdef HOST_BUSY_SWP
	    return HOST_BUSY_SWP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_TMP"))
#ifdef HOST_BUSY_TMP
	    return HOST_BUSY_TMP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_BUSY_UT"))
#ifdef HOST_BUSY_UT
	    return HOST_BUSY_UT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_CLOSE"))
#ifdef HOST_CLOSE
	    return HOST_CLOSE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_GRP"))
#ifdef HOST_GRP
	    return HOST_GRP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_JLU"))
#ifdef HOST_JLU
	    return HOST_JLU;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_NAME"))
#ifdef HOST_NAME
	    return HOST_NAME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_OPEN"))
#ifdef HOST_OPEN
	    return HOST_OPEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_REBOOT"))
#ifdef HOST_REBOOT
	    return HOST_REBOOT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_SHUTDOWN"))
#ifdef HOST_SHUTDOWN
	    return HOST_SHUTDOWN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_BUSY"))
#ifdef HOST_STAT_BUSY
	    return HOST_STAT_BUSY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_DISABLED"))
#ifdef HOST_STAT_DISABLED
	    return HOST_STAT_DISABLED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_EXCLUSIVE"))
#ifdef HOST_STAT_EXCLUSIVE
	    return HOST_STAT_EXCLUSIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_FULL"))
#ifdef HOST_STAT_FULL
	    return HOST_STAT_FULL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_LOCKED"))
#ifdef HOST_STAT_LOCKED
	    return HOST_STAT_LOCKED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_NO_LIM"))
#ifdef HOST_STAT_NO_LIM
	    return HOST_STAT_NO_LIM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_OK"))
#ifdef HOST_STAT_OK
	    return HOST_STAT_OK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_UNAVAIL"))
#ifdef HOST_STAT_UNAVAIL
	    return HOST_STAT_UNAVAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_UNLICENSED"))
#ifdef HOST_STAT_UNLICENSED
	    return HOST_STAT_UNLICENSED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_UNREACH"))
#ifdef HOST_STAT_UNREACH
	    return HOST_STAT_UNREACH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HOST_STAT_WIND"))
#ifdef HOST_STAT_WIND
	    return HOST_STAT_WIND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "HPART_HGRP"))
#ifdef HPART_HGRP
	    return HPART_HGRP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "H_ATTR_CHKPNTABLE"))
#ifdef H_ATTR_CHKPNTABLE
	    return H_ATTR_CHKPNTABLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "H_ATTR_CHKPNT_COPY"))
#ifdef H_ATTR_CHKPNT_COPY
	    return H_ATTR_CHKPNT_COPY;
#else
	    goto not_there;
#endif
	break;
    case 'I':
	break;
    case 'J':
	if (strEQ(name, "JGRP_ACTIVE"))
#ifdef JGRP_ACTIVE
	    return JGRP_ACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_ARRAY_INFO"))
#ifdef JGRP_ARRAY_INFO
	    return JGRP_ARRAY_INFO;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_COUNT_NDONE"))
#ifdef JGRP_COUNT_NDONE
	    return JGRP_COUNT_NDONE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_COUNT_NEXIT"))
#ifdef JGRP_COUNT_NEXIT
	    return JGRP_COUNT_NEXIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_COUNT_NJOBS"))
#ifdef JGRP_COUNT_NJOBS
	    return JGRP_COUNT_NJOBS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_COUNT_NPSUSP"))
#ifdef JGRP_COUNT_NPSUSP
	    return JGRP_COUNT_NPSUSP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_COUNT_NRUN"))
#ifdef JGRP_COUNT_NRUN
	    return JGRP_COUNT_NRUN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_COUNT_NSSUSP"))
#ifdef JGRP_COUNT_NSSUSP
	    return JGRP_COUNT_NSSUSP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_COUNT_NUSUSP"))
#ifdef JGRP_COUNT_NUSUSP
	    return JGRP_COUNT_NUSUSP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_COUNT_PEND"))
#ifdef JGRP_COUNT_PEND
	    return JGRP_COUNT_PEND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_DEL"))
#ifdef JGRP_DEL
	    return JGRP_DEL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_HOLD"))
#ifdef JGRP_HOLD
	    return JGRP_HOLD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_INACTIVE"))
#ifdef JGRP_INACTIVE
	    return JGRP_INACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_INFO"))
#ifdef JGRP_INFO
	    return JGRP_INFO;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_NODE_ARRAY"))
#ifdef JGRP_NODE_ARRAY
	    return JGRP_NODE_ARRAY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_NODE_GROUP"))
#ifdef JGRP_NODE_GROUP
	    return JGRP_NODE_GROUP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_NODE_JOB"))
#ifdef JGRP_NODE_JOB
	    return JGRP_NODE_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_RECURSIVE"))
#ifdef JGRP_RECURSIVE
	    return JGRP_RECURSIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_RELEASE"))
#ifdef JGRP_RELEASE
	    return JGRP_RELEASE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_RELEASE_PARENTONLY"))
#ifdef JGRP_RELEASE_PARENTONLY
	    return JGRP_RELEASE_PARENTONLY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JGRP_UNDEFINED"))
#ifdef JGRP_UNDEFINED
	    return JGRP_UNDEFINED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOBID_ONLY"))
#ifdef JOBID_ONLY
	    return JOBID_ONLY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOBID_ONLY_ALL"))
#ifdef JOBID_ONLY_ALL
	    return JOBID_ONLY_ALL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_DONE"))
#ifdef JOB_STAT_DONE
	    return JOB_STAT_DONE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_EXIT"))
#ifdef JOB_STAT_EXIT
	    return JOB_STAT_EXIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_NULL"))
#ifdef JOB_STAT_NULL
	    return JOB_STAT_NULL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_PDONE"))
#ifdef JOB_STAT_PDONE
	    return JOB_STAT_PDONE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_PEND"))
#ifdef JOB_STAT_PEND
	    return JOB_STAT_PEND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_PERR"))
#ifdef JOB_STAT_PERR
	    return JOB_STAT_PERR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_PSUSP"))
#ifdef JOB_STAT_PSUSP
	    return JOB_STAT_PSUSP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_RUN"))
#ifdef JOB_STAT_RUN
	    return JOB_STAT_RUN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_SSUSP"))
#ifdef JOB_STAT_SSUSP
	    return JOB_STAT_SSUSP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_UNKWN"))
#ifdef JOB_STAT_UNKWN
	    return JOB_STAT_UNKWN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_USUSP"))
#ifdef JOB_STAT_USUSP
	    return JOB_STAT_USUSP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "JOB_STAT_WAIT"))
#ifdef JOB_STAT_WAIT
	    return JOB_STAT_WAIT;
#else
	    goto not_there;
#endif
	break;
    case 'K':
	break;
    case 'L':
	if (strEQ(name, "LAST_JOB"))
#ifdef LAST_JOB
	    return LAST_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBATCH_H"))
#ifdef LSBATCH_H
	    return LSBATCH_H;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_AFS_TOKENS"))
#ifdef LSBE_AFS_TOKENS
	    return LSBE_AFS_TOKENS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_ARRAY_NULL"))
#ifdef LSBE_ARRAY_NULL
	    return LSBE_ARRAY_NULL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_ARG"))
#ifdef LSBE_BAD_ARG
	    return LSBE_BAD_ARG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_ATTA_DIR"))
#ifdef LSBE_BAD_ATTA_DIR
	    return LSBE_BAD_ATTA_DIR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_CALENDAR"))
#ifdef LSBE_BAD_CALENDAR
	    return LSBE_BAD_CALENDAR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_CHKLOG"))
#ifdef LSBE_BAD_CHKLOG
	    return LSBE_BAD_CHKLOG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_CLUSTER"))
#ifdef LSBE_BAD_CLUSTER
	    return LSBE_BAD_CLUSTER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_CMD"))
#ifdef LSBE_BAD_CMD
	    return LSBE_BAD_CMD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_EVENT"))
#ifdef LSBE_BAD_EVENT
	    return LSBE_BAD_EVENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_EXT_MSGID"))
#ifdef LSBE_BAD_EXT_MSGID
	    return LSBE_BAD_EXT_MSGID;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_FRAME"))
#ifdef LSBE_BAD_FRAME
	    return LSBE_BAD_FRAME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_GROUP"))
#ifdef LSBE_BAD_GROUP
	    return LSBE_BAD_GROUP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_HOST"))
#ifdef LSBE_BAD_HOST
	    return LSBE_BAD_HOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_HOST_SPEC"))
#ifdef LSBE_BAD_HOST_SPEC
	    return LSBE_BAD_HOST_SPEC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_HPART"))
#ifdef LSBE_BAD_HPART
	    return LSBE_BAD_HPART;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_IDX"))
#ifdef LSBE_BAD_IDX
	    return LSBE_BAD_IDX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_JOB"))
#ifdef LSBE_BAD_JOB
	    return LSBE_BAD_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_JOBID"))
#ifdef LSBE_BAD_JOBID
	    return LSBE_BAD_JOBID;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_LIMIT"))
#ifdef LSBE_BAD_LIMIT
	    return LSBE_BAD_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_PROJECT_GROUP"))
#ifdef LSBE_BAD_PROJECT_GROUP
	    return LSBE_BAD_PROJECT_GROUP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_QUEUE"))
#ifdef LSBE_BAD_QUEUE
	    return LSBE_BAD_QUEUE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_RESOURCE"))
#ifdef LSBE_BAD_RESOURCE
	    return LSBE_BAD_RESOURCE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_RESREQ"))
#ifdef LSBE_BAD_RESREQ
	    return LSBE_BAD_RESREQ;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_SIGNAL"))
#ifdef LSBE_BAD_SIGNAL
	    return LSBE_BAD_SIGNAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_SUBMISSION_HOST"))
#ifdef LSBE_BAD_SUBMISSION_HOST
	    return LSBE_BAD_SUBMISSION_HOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_TIME"))
#ifdef LSBE_BAD_TIME
	    return LSBE_BAD_TIME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_TIMEEVENT"))
#ifdef LSBE_BAD_TIMEEVENT
	    return LSBE_BAD_TIMEEVENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_UGROUP"))
#ifdef LSBE_BAD_UGROUP
	    return LSBE_BAD_UGROUP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_USER"))
#ifdef LSBE_BAD_USER
	    return LSBE_BAD_USER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BAD_USER_PRIORITY"))
#ifdef LSBE_BAD_USER_PRIORITY
	    return LSBE_BAD_USER_PRIORITY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_BIG_IDX"))
#ifdef LSBE_BIG_IDX
	    return LSBE_BIG_IDX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CAL_CYC"))
#ifdef LSBE_CAL_CYC
	    return LSBE_CAL_CYC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CAL_DISABLED"))
#ifdef LSBE_CAL_DISABLED
	    return LSBE_CAL_DISABLED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CAL_EXIST"))
#ifdef LSBE_CAL_EXIST
	    return LSBE_CAL_EXIST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CAL_MODIFY"))
#ifdef LSBE_CAL_MODIFY
	    return LSBE_CAL_MODIFY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CAL_USED"))
#ifdef LSBE_CAL_USED
	    return LSBE_CAL_USED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CAL_VOID"))
#ifdef LSBE_CAL_VOID
	    return LSBE_CAL_VOID;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CHKPNT_CALL"))
#ifdef LSBE_CHKPNT_CALL
	    return LSBE_CHKPNT_CALL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CHUNK_JOB"))
#ifdef LSBE_CHUNK_JOB
	    return LSBE_CHUNK_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CONF_FATAL"))
#ifdef LSBE_CONF_FATAL
	    return LSBE_CONF_FATAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CONF_WARNING"))
#ifdef LSBE_CONF_WARNING
	    return LSBE_CONF_WARNING;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CONN_EXIST"))
#ifdef LSBE_CONN_EXIST
	    return LSBE_CONN_EXIST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CONN_NONEXIST"))
#ifdef LSBE_CONN_NONEXIST
	    return LSBE_CONN_NONEXIST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CONN_REFUSED"))
#ifdef LSBE_CONN_REFUSED
	    return LSBE_CONN_REFUSED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_CONN_TIMEOUT"))
#ifdef LSBE_CONN_TIMEOUT
	    return LSBE_CONN_TIMEOUT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_COPY_DATA"))
#ifdef LSBE_COPY_DATA
	    return LSBE_COPY_DATA;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_DEPEND_SYNTAX"))
#ifdef LSBE_DEPEND_SYNTAX
	    return LSBE_DEPEND_SYNTAX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_DLOGD_ISCONN"))
#ifdef LSBE_DLOGD_ISCONN
	    return LSBE_DLOGD_ISCONN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_EOF"))
#ifdef LSBE_EOF
	    return LSBE_EOF;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_ESUB_ABORT"))
#ifdef LSBE_ESUB_ABORT
	    return LSBE_ESUB_ABORT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_EVENT_FORMAT"))
#ifdef LSBE_EVENT_FORMAT
	    return LSBE_EVENT_FORMAT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_EXCEPT_ACTION"))
#ifdef LSBE_EXCEPT_ACTION
	    return LSBE_EXCEPT_ACTION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_EXCEPT_COND"))
#ifdef LSBE_EXCEPT_COND
	    return LSBE_EXCEPT_COND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_EXCEPT_SYNTAX"))
#ifdef LSBE_EXCEPT_SYNTAX
	    return LSBE_EXCEPT_SYNTAX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_EXCLUSIVE"))
#ifdef LSBE_EXCLUSIVE
	    return LSBE_EXCLUSIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_FRAME_BAD_IDX"))
#ifdef LSBE_FRAME_BAD_IDX
	    return LSBE_FRAME_BAD_IDX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_FRAME_BIG_IDX"))
#ifdef LSBE_FRAME_BIG_IDX
	    return LSBE_FRAME_BIG_IDX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_HJOB_LIMIT"))
#ifdef LSBE_HJOB_LIMIT
	    return LSBE_HJOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_HP_FAIRSHARE_DEF"))
#ifdef LSBE_HP_FAIRSHARE_DEF
	    return LSBE_HP_FAIRSHARE_DEF;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_INDEX_FORMAT"))
#ifdef LSBE_INDEX_FORMAT
	    return LSBE_INDEX_FORMAT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_INTERACTIVE_CAL"))
#ifdef LSBE_INTERACTIVE_CAL
	    return LSBE_INTERACTIVE_CAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_INTERACTIVE_RERUN"))
#ifdef LSBE_INTERACTIVE_RERUN
	    return LSBE_INTERACTIVE_RERUN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JGRP_BAD"))
#ifdef LSBE_JGRP_BAD
	    return LSBE_JGRP_BAD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JGRP_CTRL_UNKWN"))
#ifdef LSBE_JGRP_CTRL_UNKWN
	    return LSBE_JGRP_CTRL_UNKWN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JGRP_EXIST"))
#ifdef LSBE_JGRP_EXIST
	    return LSBE_JGRP_EXIST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JGRP_HASJOB"))
#ifdef LSBE_JGRP_HASJOB
	    return LSBE_JGRP_HASJOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JGRP_HOLD"))
#ifdef LSBE_JGRP_HOLD
	    return LSBE_JGRP_HOLD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JGRP_NULL"))
#ifdef LSBE_JGRP_NULL
	    return LSBE_JGRP_NULL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_ARRAY"))
#ifdef LSBE_JOB_ARRAY
	    return LSBE_JOB_ARRAY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_ATTA_LIMIT"))
#ifdef LSBE_JOB_ATTA_LIMIT
	    return LSBE_JOB_ATTA_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_CAL_MODIFY"))
#ifdef LSBE_JOB_CAL_MODIFY
	    return LSBE_JOB_CAL_MODIFY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_DEP"))
#ifdef LSBE_JOB_DEP
	    return LSBE_JOB_DEP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_ELEMENT"))
#ifdef LSBE_JOB_ELEMENT
	    return LSBE_JOB_ELEMENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_EXIST"))
#ifdef LSBE_JOB_EXIST
	    return LSBE_JOB_EXIST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_FINISH"))
#ifdef LSBE_JOB_FINISH
	    return LSBE_JOB_FINISH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_FORW"))
#ifdef LSBE_JOB_FORW
	    return LSBE_JOB_FORW;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_MODIFY"))
#ifdef LSBE_JOB_MODIFY
	    return LSBE_JOB_MODIFY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_MODIFY_ONCE"))
#ifdef LSBE_JOB_MODIFY_ONCE
	    return LSBE_JOB_MODIFY_ONCE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_MODIFY_USED"))
#ifdef LSBE_JOB_MODIFY_USED
	    return LSBE_JOB_MODIFY_USED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_REQUEUED"))
#ifdef LSBE_JOB_REQUEUED
	    return LSBE_JOB_REQUEUED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_REQUEUE_REMOTE"))
#ifdef LSBE_JOB_REQUEUE_REMOTE
	    return LSBE_JOB_REQUEUE_REMOTE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_STARTED"))
#ifdef LSBE_JOB_STARTED
	    return LSBE_JOB_STARTED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JOB_SUSP"))
#ifdef LSBE_JOB_SUSP
	    return LSBE_JOB_SUSP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_JS_DISABLED"))
#ifdef LSBE_JS_DISABLED
	    return LSBE_JS_DISABLED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_J_UNCHKPNTABLE"))
#ifdef LSBE_J_UNCHKPNTABLE
	    return LSBE_J_UNCHKPNTABLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_J_UNREPETITIVE"))
#ifdef LSBE_J_UNREPETITIVE
	    return LSBE_J_UNREPETITIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_LOCK_JOB"))
#ifdef LSBE_LOCK_JOB
	    return LSBE_LOCK_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_LSBLIB"))
#ifdef LSBE_LSBLIB
	    return LSBE_LSBLIB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_LSLIB"))
#ifdef LSBE_LSLIB
	    return LSBE_LSLIB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_MBATCHD"))
#ifdef LSBE_MBATCHD
	    return LSBE_MBATCHD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_MC_CHKPNT"))
#ifdef LSBE_MC_CHKPNT
	    return LSBE_MC_CHKPNT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_MC_EXCEPTION"))
#ifdef LSBE_MC_EXCEPTION
	    return LSBE_MC_EXCEPTION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_MC_HOST"))
#ifdef LSBE_MC_HOST
	    return LSBE_MC_HOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_MC_REPETITIVE"))
#ifdef LSBE_MC_REPETITIVE
	    return LSBE_MC_REPETITIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_MC_TIMEEVENT"))
#ifdef LSBE_MC_TIMEEVENT
	    return LSBE_MC_TIMEEVENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_MIGRATION"))
#ifdef LSBE_MIGRATION
	    return LSBE_MIGRATION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_MOD_JOB_NAME"))
#ifdef LSBE_MOD_JOB_NAME
	    return LSBE_MOD_JOB_NAME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_MSG_DELIVERED"))
#ifdef LSBE_MSG_DELIVERED
	    return LSBE_MSG_DELIVERED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_MSG_RETRY"))
#ifdef LSBE_MSG_RETRY
	    return LSBE_MSG_RETRY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NOLSF_HOST"))
#ifdef LSBE_NOLSF_HOST
	    return LSBE_NOLSF_HOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NOMATCH_CALENDAR"))
#ifdef LSBE_NOMATCH_CALENDAR
	    return LSBE_NOMATCH_CALENDAR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NOMATCH_EVENT"))
#ifdef LSBE_NOMATCH_EVENT
	    return LSBE_NOMATCH_EVENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NOT_STARTED"))
#ifdef LSBE_NOT_STARTED
	    return LSBE_NOT_STARTED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_CALENDAR"))
#ifdef LSBE_NO_CALENDAR
	    return LSBE_NO_CALENDAR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_ENOUGH_HOST"))
#ifdef LSBE_NO_ENOUGH_HOST
	    return LSBE_NO_ENOUGH_HOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_ENV"))
#ifdef LSBE_NO_ENV
	    return LSBE_NO_ENV;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_ERROR"))
#ifdef LSBE_NO_ERROR
	    return LSBE_NO_ERROR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_EVENT"))
#ifdef LSBE_NO_EVENT
	    return LSBE_NO_EVENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_FORK"))
#ifdef LSBE_NO_FORK
	    return LSBE_NO_FORK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_GROUP"))
#ifdef LSBE_NO_GROUP
	    return LSBE_NO_GROUP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_HOST"))
#ifdef LSBE_NO_HOST
	    return LSBE_NO_HOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_HOST_GROUP"))
#ifdef LSBE_NO_HOST_GROUP
	    return LSBE_NO_HOST_GROUP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_HPART"))
#ifdef LSBE_NO_HPART
	    return LSBE_NO_HPART;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_IFREG"))
#ifdef LSBE_NO_IFREG
	    return LSBE_NO_IFREG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_INTERACTIVE"))
#ifdef LSBE_NO_INTERACTIVE
	    return LSBE_NO_INTERACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_JOB"))
#ifdef LSBE_NO_JOB
	    return LSBE_NO_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_JOBID"))
#ifdef LSBE_NO_JOBID
	    return LSBE_NO_JOBID;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_JOBMSG"))
#ifdef LSBE_NO_JOBMSG
	    return LSBE_NO_JOBMSG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_JOB_PRIORITY"))
#ifdef LSBE_NO_JOB_PRIORITY
	    return LSBE_NO_JOB_PRIORITY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_LICENSE"))
#ifdef LSBE_NO_LICENSE
	    return LSBE_NO_LICENSE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_MEM"))
#ifdef LSBE_NO_MEM
	    return LSBE_NO_MEM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_OUTPUT"))
#ifdef LSBE_NO_OUTPUT
	    return LSBE_NO_OUTPUT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_RESOURCE"))
#ifdef LSBE_NO_RESOURCE
	    return LSBE_NO_RESOURCE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_USER"))
#ifdef LSBE_NO_USER
	    return LSBE_NO_USER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NO_USER_GROUP"))
#ifdef LSBE_NO_USER_GROUP
	    return LSBE_NO_USER_GROUP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NQS_BAD_PAR"))
#ifdef LSBE_NQS_BAD_PAR
	    return LSBE_NQS_BAD_PAR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NQS_NO_ARRJOB"))
#ifdef LSBE_NQS_NO_ARRJOB
	    return LSBE_NQS_NO_ARRJOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_NUM_ERR"))
#ifdef LSBE_NUM_ERR
	    return LSBE_NUM_ERR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_ONLY_INTERACTIVE"))
#ifdef LSBE_ONLY_INTERACTIVE
	    return LSBE_ONLY_INTERACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_OP_RETRY"))
#ifdef LSBE_OP_RETRY
	    return LSBE_OP_RETRY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_OVER_LIMIT"))
#ifdef LSBE_OVER_LIMIT
	    return LSBE_OVER_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_OVER_RUSAGE"))
#ifdef LSBE_OVER_RUSAGE
	    return LSBE_OVER_RUSAGE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_PEND_CAL_JOB"))
#ifdef LSBE_PEND_CAL_JOB
	    return LSBE_PEND_CAL_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_PERMISSION"))
#ifdef LSBE_PERMISSION
	    return LSBE_PERMISSION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_PERMISSION_MC"))
#ifdef LSBE_PERMISSION_MC
	    return LSBE_PERMISSION_MC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_PJOB_LIMIT"))
#ifdef LSBE_PJOB_LIMIT
	    return LSBE_PJOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_PORT"))
#ifdef LSBE_PORT
	    return LSBE_PORT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_PREMATURE"))
#ifdef LSBE_PREMATURE
	    return LSBE_PREMATURE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_PROC_NUM"))
#ifdef LSBE_PROC_NUM
	    return LSBE_PROC_NUM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_PROTOCOL"))
#ifdef LSBE_PROTOCOL
	    return LSBE_PROTOCOL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_PTY_INFILE"))
#ifdef LSBE_PTY_INFILE
	    return LSBE_PTY_INFILE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_QJOB_LIMIT"))
#ifdef LSBE_QJOB_LIMIT
	    return LSBE_QJOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_QUEUE_CLOSED"))
#ifdef LSBE_QUEUE_CLOSED
	    return LSBE_QUEUE_CLOSED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_QUEUE_HOST"))
#ifdef LSBE_QUEUE_HOST
	    return LSBE_QUEUE_HOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_QUEUE_NAME"))
#ifdef LSBE_QUEUE_NAME
	    return LSBE_QUEUE_NAME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_QUEUE_USE"))
#ifdef LSBE_QUEUE_USE
	    return LSBE_QUEUE_USE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_QUEUE_WINDOW"))
#ifdef LSBE_QUEUE_WINDOW
	    return LSBE_QUEUE_WINDOW;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_ROOT"))
#ifdef LSBE_ROOT
	    return LSBE_ROOT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_RUN_CAL_JOB"))
#ifdef LSBE_RUN_CAL_JOB
	    return LSBE_RUN_CAL_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SBATCHD"))
#ifdef LSBE_SBATCHD
	    return LSBE_SBATCHD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SBD_UNREACH"))
#ifdef LSBE_SBD_UNREACH
	    return LSBE_SBD_UNREACH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SERVICE"))
#ifdef LSBE_SERVICE
	    return LSBE_SERVICE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SP_CHILD_DIES"))
#ifdef LSBE_SP_CHILD_DIES
	    return LSBE_SP_CHILD_DIES;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SP_CHILD_FAILED"))
#ifdef LSBE_SP_CHILD_FAILED
	    return LSBE_SP_CHILD_FAILED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SP_COPY_FAILED"))
#ifdef LSBE_SP_COPY_FAILED
	    return LSBE_SP_COPY_FAILED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SP_DELETE_FAILED"))
#ifdef LSBE_SP_DELETE_FAILED
	    return LSBE_SP_DELETE_FAILED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SP_FAILED_HOSTS_LIM"))
#ifdef LSBE_SP_FAILED_HOSTS_LIM
	    return LSBE_SP_FAILED_HOSTS_LIM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SP_FIND_HOST_FAILED"))
#ifdef LSBE_SP_FIND_HOST_FAILED
	    return LSBE_SP_FIND_HOST_FAILED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SP_FORK_FAILED"))
#ifdef LSBE_SP_FORK_FAILED
	    return LSBE_SP_FORK_FAILED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SP_SPOOLDIR_FAILED"))
#ifdef LSBE_SP_SPOOLDIR_FAILED
	    return LSBE_SP_SPOOLDIR_FAILED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SP_SRC_NOT_SEEN"))
#ifdef LSBE_SP_SRC_NOT_SEEN
	    return LSBE_SP_SRC_NOT_SEEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_START_TIME"))
#ifdef LSBE_START_TIME
	    return LSBE_START_TIME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_STOP_JOB"))
#ifdef LSBE_STOP_JOB
	    return LSBE_STOP_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SYNTAX_CALENDAR"))
#ifdef LSBE_SYNTAX_CALENDAR
	    return LSBE_SYNTAX_CALENDAR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SYSCAL_EXIST"))
#ifdef LSBE_SYSCAL_EXIST
	    return LSBE_SYSCAL_EXIST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_SYS_CALL"))
#ifdef LSBE_SYS_CALL
	    return LSBE_SYS_CALL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_TIME_OUT"))
#ifdef LSBE_TIME_OUT
	    return LSBE_TIME_OUT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_UGROUP_MEMBER"))
#ifdef LSBE_UGROUP_MEMBER
	    return LSBE_UGROUP_MEMBER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_UJOB_LIMIT"))
#ifdef LSBE_UJOB_LIMIT
	    return LSBE_UJOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_UNKNOWN_EVENT"))
#ifdef LSBE_UNKNOWN_EVENT
	    return LSBE_UNKNOWN_EVENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_UNSUPPORTED_MC"))
#ifdef LSBE_UNSUPPORTED_MC
	    return LSBE_UNSUPPORTED_MC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_USER_JLIMIT"))
#ifdef LSBE_USER_JLIMIT
	    return LSBE_USER_JLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSBE_XDR"))
#ifdef LSBE_XDR
	    return LSBE_XDR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_CHKPERIOD_NOCHNG"))
#ifdef LSB_CHKPERIOD_NOCHNG
	    return LSB_CHKPERIOD_NOCHNG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_CHKPNT_COPY"))
#ifdef LSB_CHKPNT_COPY
	    return LSB_CHKPNT_COPY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_CHKPNT_FORCE"))
#ifdef LSB_CHKPNT_FORCE
	    return LSB_CHKPNT_FORCE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_CHKPNT_KILL"))
#ifdef LSB_CHKPNT_KILL
	    return LSB_CHKPNT_KILL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_CHKPNT_MIG"))
#ifdef LSB_CHKPNT_MIG
	    return LSB_CHKPNT_MIG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_CHKPNT_STOP"))
#ifdef LSB_CHKPNT_STOP
	    return LSB_CHKPNT_STOP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_EVENT_VERSION3_0"))
#ifdef LSB_EVENT_VERSION3_0
	    return LSB_EVENT_VERSION3_0;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_EVENT_VERSION3_1"))
#ifdef LSB_EVENT_VERSION3_1
	    return LSB_EVENT_VERSION3_1;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_EVENT_VERSION3_2"))
#ifdef LSB_EVENT_VERSION3_2
	    return LSB_EVENT_VERSION3_2;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_EVENT_VERSION4_0"))
#ifdef LSB_EVENT_VERSION4_0
	    return LSB_EVENT_VERSION4_0;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_KILL_REQUEUE"))
#ifdef LSB_KILL_REQUEUE
	    return LSB_KILL_REQUEUE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_MAX_ARRAY_IDX"))
#ifdef LSB_MAX_ARRAY_IDX
	    return LSB_MAX_ARRAY_IDX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_MAX_ARRAY_JOBID"))
#ifdef LSB_MAX_ARRAY_JOBID
	    return LSB_MAX_ARRAY_JOBID;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_MAX_SD_LENGTH"))
#ifdef LSB_MAX_SD_LENGTH
	    return LSB_MAX_SD_LENGTH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_MODE_BATCH"))
#ifdef LSB_MODE_BATCH
	    return LSB_MODE_BATCH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_MODE_JS"))
#ifdef LSB_MODE_JS
	    return LSB_MODE_JS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "LSB_SIG_NUM"))
#ifdef LSB_SIG_NUM
	    return LSB_SIG_NUM;
#else
	    goto not_there;
#endif
	break;
    case 'M':
	if (strEQ(name, "MASTER_CONF"))
#ifdef MASTER_CONF
	    return MASTER_CONF;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MASTER_FATAL"))
#ifdef MASTER_FATAL
	    return MASTER_FATAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MASTER_MEM"))
#ifdef MASTER_MEM
	    return MASTER_MEM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MASTER_NULL"))
#ifdef MASTER_NULL
	    return MASTER_NULL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MASTER_RECONFIG"))
#ifdef MASTER_RECONFIG
	    return MASTER_RECONFIG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MASTER_RESIGN"))
#ifdef MASTER_RESIGN
	    return MASTER_RESIGN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAXDESCLEN"))
#ifdef MAXDESCLEN
	    return MAXDESCLEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAXPATHLEN"))
#ifdef MAXPATHLEN
	    return MAXPATHLEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_CALENDARS"))
#ifdef MAX_CALENDARS
	    return MAX_CALENDARS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_CHARLEN"))
#ifdef MAX_CHARLEN
	    return MAX_CHARLEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_CMD_DESC_LEN"))
#ifdef MAX_CMD_DESC_LEN
	    return MAX_CMD_DESC_LEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_GROUPS"))
#ifdef MAX_GROUPS
	    return MAX_GROUPS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_HPART_USERS"))
#ifdef MAX_HPART_USERS
	    return MAX_HPART_USERS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_LSB_NAME_LEN"))
#ifdef MAX_LSB_NAME_LEN
	    return MAX_LSB_NAME_LEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_USER_EQUIVALENT"))
#ifdef MAX_USER_EQUIVALENT
	    return MAX_USER_EQUIVALENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_USER_MAPPING"))
#ifdef MAX_USER_MAPPING
	    return MAX_USER_MAPPING;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MAX_VERSION_LEN"))
#ifdef MAX_VERSION_LEN
	    return MAX_VERSION_LEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MBD_CKCONFIG"))
#ifdef MBD_CKCONFIG
	    return MBD_CKCONFIG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MBD_RECONFIG"))
#ifdef MBD_RECONFIG
	    return MBD_RECONFIG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MBD_RESTART"))
#ifdef MBD_RESTART
	    return MBD_RESTART;
#else
	    goto not_there;
#endif
	if (strEQ(name, "MSGSIZE"))
#ifdef MSGSIZE
	    return MSGSIZE;
#else
	    goto not_there;
#endif
	break;
    case 'N':
	if (strEQ(name, "NO_PEND_REASONS"))
#ifdef NO_PEND_REASONS
	    return NO_PEND_REASONS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "NQSQ_GRP"))
#ifdef NQSQ_GRP
	    return NQSQ_GRP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "NQS_ROUTE"))
#ifdef NQS_ROUTE
	    return NQS_ROUTE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "NQS_SERVER"))
#ifdef NQS_SERVER
	    return NQS_SERVER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "NQS_SIG"))
#ifdef NQS_SIG
	    return NQS_SIG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "NUM_JGRP_COUNTERS"))
#ifdef NUM_JGRP_COUNTERS
	    return NUM_JGRP_COUNTERS;
#else
	    goto not_there;
#endif
	break;
    case 'O':
	break;
    case 'P':
	if (strEQ(name, "PEND_ADMIN_STOP"))
#ifdef PEND_ADMIN_STOP
	    return PEND_ADMIN_STOP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_CHKPNT_DIR"))
#ifdef PEND_CHKPNT_DIR
	    return PEND_CHKPNT_DIR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_CHUNK_FAIL"))
#ifdef PEND_CHUNK_FAIL
	    return PEND_CHUNK_FAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HAS_RUN"))
#ifdef PEND_HAS_RUN
	    return PEND_HAS_RUN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_ACCPT_ONE"))
#ifdef PEND_HOST_ACCPT_ONE
	    return PEND_HOST_ACCPT_ONE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_DISABLED"))
#ifdef PEND_HOST_DISABLED
	    return PEND_HOST_DISABLED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_EXCLUSIVE"))
#ifdef PEND_HOST_EXCLUSIVE
	    return PEND_HOST_EXCLUSIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_JOB_LIMIT"))
#ifdef PEND_HOST_JOB_LIMIT
	    return PEND_HOST_JOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_JOB_RUSAGE"))
#ifdef PEND_HOST_JOB_RUSAGE
	    return PEND_HOST_JOB_RUSAGE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_JOB_SSUSP"))
#ifdef PEND_HOST_JOB_SSUSP
	    return PEND_HOST_JOB_SSUSP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_JS_DISABLED"))
#ifdef PEND_HOST_JS_DISABLED
	    return PEND_HOST_JS_DISABLED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_LESS_SLOTS"))
#ifdef PEND_HOST_LESS_SLOTS
	    return PEND_HOST_LESS_SLOTS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_LOAD"))
#ifdef PEND_HOST_LOAD
	    return PEND_HOST_LOAD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_LOCKED"))
#ifdef PEND_HOST_LOCKED
	    return PEND_HOST_LOCKED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_MISS_DEADLINE"))
#ifdef PEND_HOST_MISS_DEADLINE
	    return PEND_HOST_MISS_DEADLINE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_NONEXCLUSIVE"))
#ifdef PEND_HOST_NONEXCLUSIVE
	    return PEND_HOST_NONEXCLUSIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_NO_LIM"))
#ifdef PEND_HOST_NO_LIM
	    return PEND_HOST_NO_LIM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_NO_USER"))
#ifdef PEND_HOST_NO_USER
	    return PEND_HOST_NO_USER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_PART_PRIO"))
#ifdef PEND_HOST_PART_PRIO
	    return PEND_HOST_PART_PRIO;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_PART_USER"))
#ifdef PEND_HOST_PART_USER
	    return PEND_HOST_PART_USER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_QUE_MEMB"))
#ifdef PEND_HOST_QUE_MEMB
	    return PEND_HOST_QUE_MEMB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_QUE_RESREQ"))
#ifdef PEND_HOST_QUE_RESREQ
	    return PEND_HOST_QUE_RESREQ;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_QUE_RUSAGE"))
#ifdef PEND_HOST_QUE_RUSAGE
	    return PEND_HOST_QUE_RUSAGE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_RES_REQ"))
#ifdef PEND_HOST_RES_REQ
	    return PEND_HOST_RES_REQ;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_SCHED_TYPE"))
#ifdef PEND_HOST_SCHED_TYPE
	    return PEND_HOST_SCHED_TYPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_UNLICENSED"))
#ifdef PEND_HOST_UNLICENSED
	    return PEND_HOST_UNLICENSED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_USR_JLIMIT"))
#ifdef PEND_HOST_USR_JLIMIT
	    return PEND_HOST_USR_JLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_USR_SPEC"))
#ifdef PEND_HOST_USR_SPEC
	    return PEND_HOST_USR_SPEC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_WINDOW"))
#ifdef PEND_HOST_WINDOW
	    return PEND_HOST_WINDOW;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_HOST_WIN_WILL_CLOSE"))
#ifdef PEND_HOST_WIN_WILL_CLOSE
	    return PEND_HOST_WIN_WILL_CLOSE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JGRP_HOLD"))
#ifdef PEND_JGRP_HOLD
	    return PEND_JGRP_HOLD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JGRP_INACT"))
#ifdef PEND_JGRP_INACT
	    return PEND_JGRP_INACT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JGRP_RELEASE"))
#ifdef PEND_JGRP_RELEASE
	    return PEND_JGRP_RELEASE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JGRP_WAIT"))
#ifdef PEND_JGRP_WAIT
	    return PEND_JGRP_WAIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB"))
#ifdef PEND_JOB
	    return PEND_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_ARRAY_JLIMIT"))
#ifdef PEND_JOB_ARRAY_JLIMIT
	    return PEND_JOB_ARRAY_JLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_DELAY_SCHED"))
#ifdef PEND_JOB_DELAY_SCHED
	    return PEND_JOB_DELAY_SCHED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_DEPEND"))
#ifdef PEND_JOB_DEPEND
	    return PEND_JOB_DEPEND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_DEP_INVALID"))
#ifdef PEND_JOB_DEP_INVALID
	    return PEND_JOB_DEP_INVALID;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_DEP_REJECT"))
#ifdef PEND_JOB_DEP_REJECT
	    return PEND_JOB_DEP_REJECT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_ENFUGRP"))
#ifdef PEND_JOB_ENFUGRP
	    return PEND_JOB_ENFUGRP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_ENV"))
#ifdef PEND_JOB_ENV
	    return PEND_JOB_ENV;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_EXEC_INIT"))
#ifdef PEND_JOB_EXEC_INIT
	    return PEND_JOB_EXEC_INIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_FORWARDED"))
#ifdef PEND_JOB_FORWARDED
	    return PEND_JOB_FORWARDED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_JS_DISABLED"))
#ifdef PEND_JOB_JS_DISABLED
	    return PEND_JOB_JS_DISABLED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_LOGON_FAIL"))
#ifdef PEND_JOB_LOGON_FAIL
	    return PEND_JOB_LOGON_FAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_MIG"))
#ifdef PEND_JOB_MIG
	    return PEND_JOB_MIG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_MODIFY"))
#ifdef PEND_JOB_MODIFY
	    return PEND_JOB_MODIFY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_NEW"))
#ifdef PEND_JOB_NEW
	    return PEND_JOB_NEW;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_NO_FILE"))
#ifdef PEND_JOB_NO_FILE
	    return PEND_JOB_NO_FILE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_NO_PASSWD"))
#ifdef PEND_JOB_NO_PASSWD
	    return PEND_JOB_NO_PASSWD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_NO_SPAN"))
#ifdef PEND_JOB_NO_SPAN
	    return PEND_JOB_NO_SPAN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_OPEN_FILES"))
#ifdef PEND_JOB_OPEN_FILES
	    return PEND_JOB_OPEN_FILES;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_PATHS"))
#ifdef PEND_JOB_PATHS
	    return PEND_JOB_PATHS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_PRE_EXEC"))
#ifdef PEND_JOB_PRE_EXEC
	    return PEND_JOB_PRE_EXEC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_QUE_REJECT"))
#ifdef PEND_JOB_QUE_REJECT
	    return PEND_JOB_QUE_REJECT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_RCLUS_UNREACH"))
#ifdef PEND_JOB_RCLUS_UNREACH
	    return PEND_JOB_RCLUS_UNREACH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_REASON"))
#ifdef PEND_JOB_REASON
	    return PEND_JOB_REASON;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_REQUEUED"))
#ifdef PEND_JOB_REQUEUED
	    return PEND_JOB_REQUEUED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_RESTART_FILE"))
#ifdef PEND_JOB_RESTART_FILE
	    return PEND_JOB_RESTART_FILE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_RMT_ZOMBIE"))
#ifdef PEND_JOB_RMT_ZOMBIE
	    return PEND_JOB_RMT_ZOMBIE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_RSCHED_ALLOC"))
#ifdef PEND_JOB_RSCHED_ALLOC
	    return PEND_JOB_RSCHED_ALLOC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_RSCHED_START"))
#ifdef PEND_JOB_RSCHED_START
	    return PEND_JOB_RSCHED_START;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_SPREAD_TASK"))
#ifdef PEND_JOB_SPREAD_TASK
	    return PEND_JOB_SPREAD_TASK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_START_FAIL"))
#ifdef PEND_JOB_START_FAIL
	    return PEND_JOB_START_FAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_START_TIME"))
#ifdef PEND_JOB_START_TIME
	    return PEND_JOB_START_TIME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_START_UNKNWN"))
#ifdef PEND_JOB_START_UNKNWN
	    return PEND_JOB_START_UNKNWN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_SWITCH"))
#ifdef PEND_JOB_SWITCH
	    return PEND_JOB_SWITCH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_JOB_TIME_INVALID"))
#ifdef PEND_JOB_TIME_INVALID
	    return PEND_JOB_TIME_INVALID;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_LOAD_UNAVAIL"))
#ifdef PEND_LOAD_UNAVAIL
	    return PEND_LOAD_UNAVAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_NO_MAPPING"))
#ifdef PEND_NO_MAPPING
	    return PEND_NO_MAPPING;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_NQS_FUN_OFF"))
#ifdef PEND_NQS_FUN_OFF
	    return PEND_NQS_FUN_OFF;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_NQS_REASONS"))
#ifdef PEND_NQS_REASONS
	    return PEND_NQS_REASONS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_NQS_RETRY"))
#ifdef PEND_NQS_RETRY
	    return PEND_NQS_RETRY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_HOST_JLIMIT"))
#ifdef PEND_QUE_HOST_JLIMIT
	    return PEND_QUE_HOST_JLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_INACT"))
#ifdef PEND_QUE_INACT
	    return PEND_QUE_INACT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_JOB_LIMIT"))
#ifdef PEND_QUE_JOB_LIMIT
	    return PEND_QUE_JOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_NO_SPAN"))
#ifdef PEND_QUE_NO_SPAN
	    return PEND_QUE_NO_SPAN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_PJOB_LIMIT"))
#ifdef PEND_QUE_PJOB_LIMIT
	    return PEND_QUE_PJOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_PRE_FAIL"))
#ifdef PEND_QUE_PRE_FAIL
	    return PEND_QUE_PRE_FAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_PROC_JLIMIT"))
#ifdef PEND_QUE_PROC_JLIMIT
	    return PEND_QUE_PROC_JLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_SPREAD_TASK"))
#ifdef PEND_QUE_SPREAD_TASK
	    return PEND_QUE_SPREAD_TASK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_USR_JLIMIT"))
#ifdef PEND_QUE_USR_JLIMIT
	    return PEND_QUE_USR_JLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_USR_PJLIMIT"))
#ifdef PEND_QUE_USR_PJLIMIT
	    return PEND_QUE_USR_PJLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_WINDOW"))
#ifdef PEND_QUE_WINDOW
	    return PEND_QUE_WINDOW;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_QUE_WINDOW_WILL_CLOSE"))
#ifdef PEND_QUE_WINDOW_WILL_CLOSE
	    return PEND_QUE_WINDOW_WILL_CLOSE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_RMT_PERMISSION"))
#ifdef PEND_RMT_PERMISSION
	    return PEND_RMT_PERMISSION;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_GETPID"))
#ifdef PEND_SBD_GETPID
	    return PEND_SBD_GETPID;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_JOB_ACCEPT"))
#ifdef PEND_SBD_JOB_ACCEPT
	    return PEND_SBD_JOB_ACCEPT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_JOB_QUOTA"))
#ifdef PEND_SBD_JOB_QUOTA
	    return PEND_SBD_JOB_QUOTA;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_JOB_REQUEUE"))
#ifdef PEND_SBD_JOB_REQUEUE
	    return PEND_SBD_JOB_REQUEUE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_LOCK"))
#ifdef PEND_SBD_LOCK
	    return PEND_SBD_LOCK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_NO_MEM"))
#ifdef PEND_SBD_NO_MEM
	    return PEND_SBD_NO_MEM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_NO_PROCESS"))
#ifdef PEND_SBD_NO_PROCESS
	    return PEND_SBD_NO_PROCESS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_ROOT"))
#ifdef PEND_SBD_ROOT
	    return PEND_SBD_ROOT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_SOCKETPAIR"))
#ifdef PEND_SBD_SOCKETPAIR
	    return PEND_SBD_SOCKETPAIR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_UNREACH"))
#ifdef PEND_SBD_UNREACH
	    return PEND_SBD_UNREACH;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SBD_ZOMBIE"))
#ifdef PEND_SBD_ZOMBIE
	    return PEND_SBD_ZOMBIE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SYS_NOT_READY"))
#ifdef PEND_SYS_NOT_READY
	    return PEND_SYS_NOT_READY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_SYS_UNABLE"))
#ifdef PEND_SYS_UNABLE
	    return PEND_SYS_UNABLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_TIME_EXPIRED"))
#ifdef PEND_TIME_EXPIRED
	    return PEND_TIME_EXPIRED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_UGRP_JOB_LIMIT"))
#ifdef PEND_UGRP_JOB_LIMIT
	    return PEND_UGRP_JOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_UGRP_PJOB_LIMIT"))
#ifdef PEND_UGRP_PJOB_LIMIT
	    return PEND_UGRP_PJOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_UGRP_PROC_JLIMIT"))
#ifdef PEND_UGRP_PROC_JLIMIT
	    return PEND_UGRP_PROC_JLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_USER_JOB_LIMIT"))
#ifdef PEND_USER_JOB_LIMIT
	    return PEND_USER_JOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_USER_PJOB_LIMIT"))
#ifdef PEND_USER_PJOB_LIMIT
	    return PEND_USER_PJOB_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_USER_PROC_JLIMIT"))
#ifdef PEND_USER_PROC_JLIMIT
	    return PEND_USER_PROC_JLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_USER_RESUME"))
#ifdef PEND_USER_RESUME
	    return PEND_USER_RESUME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_USER_STOP"))
#ifdef PEND_USER_STOP
	    return PEND_USER_STOP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PEND_WAIT_NEXT"))
#ifdef PEND_WAIT_NEXT
	    return PEND_WAIT_NEXT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PREPARE_FOR_OP"))
#ifdef PREPARE_FOR_OP
	    return PREPARE_FOR_OP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PRINT_LONG_NAMELIST"))
#ifdef PRINT_LONG_NAMELIST
	    return PRINT_LONG_NAMELIST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PRINT_MCPU_HOSTS"))
#ifdef PRINT_MCPU_HOSTS
	    return PRINT_MCPU_HOSTS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PRINT_SHORT_NAMELIST"))
#ifdef PRINT_SHORT_NAMELIST
	    return PRINT_SHORT_NAMELIST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "PS_SXNQS"))
#ifdef PS_SXNQS
	    return PS_SXNQS;
#else
	    goto not_there;
#endif
	break;
    case 'Q':
	if (strEQ(name, "QUEUE_ACTIVATE"))
#ifdef QUEUE_ACTIVATE
	    return QUEUE_ACTIVATE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "QUEUE_CLOSED"))
#ifdef QUEUE_CLOSED
	    return QUEUE_CLOSED;
#else
	    goto not_there;
#endif
	if (strEQ(name, "QUEUE_INACTIVATE"))
#ifdef QUEUE_INACTIVATE
	    return QUEUE_INACTIVATE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "QUEUE_OPEN"))
#ifdef QUEUE_OPEN
	    return QUEUE_OPEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "QUEUE_STAT_ACTIVE"))
#ifdef QUEUE_STAT_ACTIVE
	    return QUEUE_STAT_ACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "QUEUE_STAT_DISC"))
#ifdef QUEUE_STAT_DISC
	    return QUEUE_STAT_DISC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "QUEUE_STAT_NOPERM"))
#ifdef QUEUE_STAT_NOPERM
	    return QUEUE_STAT_NOPERM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "QUEUE_STAT_OPEN"))
#ifdef QUEUE_STAT_OPEN
	    return QUEUE_STAT_OPEN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "QUEUE_STAT_RUN"))
#ifdef QUEUE_STAT_RUN
	    return QUEUE_STAT_RUN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "QUEUE_STAT_RUNWIN_CLOSE"))
#ifdef QUEUE_STAT_RUNWIN_CLOSE
	    return QUEUE_STAT_RUNWIN_CLOSE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_BACKFILL"))
#ifdef Q_ATTRIB_BACKFILL
	    return Q_ATTRIB_BACKFILL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_CHKPNT"))
#ifdef Q_ATTRIB_CHKPNT
	    return Q_ATTRIB_CHKPNT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_DEFAULT"))
#ifdef Q_ATTRIB_DEFAULT
	    return Q_ATTRIB_DEFAULT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_ENQUE_INTERACTIVE_AHEAD"))
#ifdef Q_ATTRIB_ENQUE_INTERACTIVE_AHEAD
	    return Q_ATTRIB_ENQUE_INTERACTIVE_AHEAD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_EXCLUSIVE"))
#ifdef Q_ATTRIB_EXCLUSIVE
	    return Q_ATTRIB_EXCLUSIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_EXCL_RMTJOB"))
#ifdef Q_ATTRIB_EXCL_RMTJOB
	    return Q_ATTRIB_EXCL_RMTJOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_FAIRSHARE"))
#ifdef Q_ATTRIB_FAIRSHARE
	    return Q_ATTRIB_FAIRSHARE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_HOST_PREFER"))
#ifdef Q_ATTRIB_HOST_PREFER
	    return Q_ATTRIB_HOST_PREFER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_IGNORE_DEADLINE"))
#ifdef Q_ATTRIB_IGNORE_DEADLINE
	    return Q_ATTRIB_IGNORE_DEADLINE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_MC_FAST_SCHEDULE"))
#ifdef Q_ATTRIB_MC_FAST_SCHEDULE
	    return Q_ATTRIB_MC_FAST_SCHEDULE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_NONPREEMPTABLE"))
#ifdef Q_ATTRIB_NONPREEMPTABLE
	    return Q_ATTRIB_NONPREEMPTABLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_NONPREEMPTIVE"))
#ifdef Q_ATTRIB_NONPREEMPTIVE
	    return Q_ATTRIB_NONPREEMPTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_NO_HOST_TYPE"))
#ifdef Q_ATTRIB_NO_HOST_TYPE
	    return Q_ATTRIB_NO_HOST_TYPE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_NO_INTERACTIVE"))
#ifdef Q_ATTRIB_NO_INTERACTIVE
	    return Q_ATTRIB_NO_INTERACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_NQS"))
#ifdef Q_ATTRIB_NQS
	    return Q_ATTRIB_NQS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_ONLY_INTERACTIVE"))
#ifdef Q_ATTRIB_ONLY_INTERACTIVE
	    return Q_ATTRIB_ONLY_INTERACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_PREEMPTABLE"))
#ifdef Q_ATTRIB_PREEMPTABLE
	    return Q_ATTRIB_PREEMPTABLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_PREEMPTIVE"))
#ifdef Q_ATTRIB_PREEMPTIVE
	    return Q_ATTRIB_PREEMPTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_RECEIVE"))
#ifdef Q_ATTRIB_RECEIVE
	    return Q_ATTRIB_RECEIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "Q_ATTRIB_RERUNNABLE"))
#ifdef Q_ATTRIB_RERUNNABLE
	    return Q_ATTRIB_RERUNNABLE;
#else
	    goto not_there;
#endif
	break;
    case 'R':
	if (strEQ(name, "READY_FOR_OP"))
#ifdef READY_FOR_OP
	    return READY_FOR_OP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RLIMIT_CORE"))
#ifdef RLIMIT_CORE
	    return RLIMIT_CORE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RLIMIT_CPU"))
#ifdef RLIMIT_CPU
	    return RLIMIT_CPU;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RLIMIT_DATA"))
#ifdef RLIMIT_DATA
	    return RLIMIT_DATA;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RLIMIT_FSIZE"))
#ifdef RLIMIT_FSIZE
	    return RLIMIT_FSIZE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RLIMIT_RSS"))
#ifdef RLIMIT_RSS
	    return RLIMIT_RSS;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RLIMIT_STACK"))
#ifdef RLIMIT_STACK
	    return RLIMIT_STACK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RLIM_INFINITY"))
#ifdef RLIM_INFINITY
	    return RLIM_INFINITY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RUNJOB_OPT_NORMAL"))
#ifdef RUNJOB_OPT_NORMAL
	    return RUNJOB_OPT_NORMAL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RUNJOB_OPT_NOSTOP"))
#ifdef RUNJOB_OPT_NOSTOP
	    return RUNJOB_OPT_NOSTOP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "RUN_JOB"))
#ifdef RUN_JOB
	    return RUN_JOB;
#else
	    goto not_there;
#endif
	break;
    case 'S':
	if (strEQ(name, "SORT_HOST"))
#ifdef SORT_HOST
	    return SORT_HOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB2_BSUB_BLOCK"))
#ifdef SUB2_BSUB_BLOCK
	    return SUB2_BSUB_BLOCK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB2_HOLD"))
#ifdef SUB2_HOLD
	    return SUB2_HOLD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB2_HOST_NT"))
#ifdef SUB2_HOST_NT
	    return SUB2_HOST_NT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB2_HOST_UX"))
#ifdef SUB2_HOST_UX
	    return SUB2_HOST_UX;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB2_IN_FILE_SPOOL"))
#ifdef SUB2_IN_FILE_SPOOL
	    return SUB2_IN_FILE_SPOOL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB2_JOB_CMD_SPOOL"))
#ifdef SUB2_JOB_CMD_SPOOL
	    return SUB2_JOB_CMD_SPOOL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB2_JOB_PRIORITY"))
#ifdef SUB2_JOB_PRIORITY
	    return SUB2_JOB_PRIORITY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB2_MODIFY_CMD"))
#ifdef SUB2_MODIFY_CMD
	    return SUB2_MODIFY_CMD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB2_QUEUE_CHKPNT"))
#ifdef SUB2_QUEUE_CHKPNT
	    return SUB2_QUEUE_CHKPNT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB2_QUEUE_RERUNNABLE"))
#ifdef SUB2_QUEUE_RERUNNABLE
	    return SUB2_QUEUE_RERUNNABLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_CHKPNTABLE"))
#ifdef SUB_CHKPNTABLE
	    return SUB_CHKPNTABLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_CHKPNT_DIR"))
#ifdef SUB_CHKPNT_DIR
	    return SUB_CHKPNT_DIR;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_CHKPNT_PERIOD"))
#ifdef SUB_CHKPNT_PERIOD
	    return SUB_CHKPNT_PERIOD;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_DEPEND_COND"))
#ifdef SUB_DEPEND_COND
	    return SUB_DEPEND_COND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_ERR_FILE"))
#ifdef SUB_ERR_FILE
	    return SUB_ERR_FILE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_EXCEPT"))
#ifdef SUB_EXCEPT
	    return SUB_EXCEPT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_EXCLUSIVE"))
#ifdef SUB_EXCLUSIVE
	    return SUB_EXCLUSIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_HOST"))
#ifdef SUB_HOST
	    return SUB_HOST;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_HOST_SPEC"))
#ifdef SUB_HOST_SPEC
	    return SUB_HOST_SPEC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_INTERACTIVE"))
#ifdef SUB_INTERACTIVE
	    return SUB_INTERACTIVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_IN_FILE"))
#ifdef SUB_IN_FILE
	    return SUB_IN_FILE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_JOB_NAME"))
#ifdef SUB_JOB_NAME
	    return SUB_JOB_NAME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_LOGIN_SHELL"))
#ifdef SUB_LOGIN_SHELL
	    return SUB_LOGIN_SHELL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_MAIL_USER"))
#ifdef SUB_MAIL_USER
	    return SUB_MAIL_USER;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_MODIFY"))
#ifdef SUB_MODIFY
	    return SUB_MODIFY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_MODIFY_ONCE"))
#ifdef SUB_MODIFY_ONCE
	    return SUB_MODIFY_ONCE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_NOTIFY_BEGIN"))
#ifdef SUB_NOTIFY_BEGIN
	    return SUB_NOTIFY_BEGIN;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_NOTIFY_END"))
#ifdef SUB_NOTIFY_END
	    return SUB_NOTIFY_END;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_OTHER_FILES"))
#ifdef SUB_OTHER_FILES
	    return SUB_OTHER_FILES;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_OUT_FILE"))
#ifdef SUB_OUT_FILE
	    return SUB_OUT_FILE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_PRE_EXEC"))
#ifdef SUB_PRE_EXEC
	    return SUB_PRE_EXEC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_PROJECT_NAME"))
#ifdef SUB_PROJECT_NAME
	    return SUB_PROJECT_NAME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_PTY"))
#ifdef SUB_PTY
	    return SUB_PTY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_PTY_SHELL"))
#ifdef SUB_PTY_SHELL
	    return SUB_PTY_SHELL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_QUEUE"))
#ifdef SUB_QUEUE
	    return SUB_QUEUE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_REASON_CPULIMIT"))
#ifdef SUB_REASON_CPULIMIT
	    return SUB_REASON_CPULIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_REASON_DEADLINE"))
#ifdef SUB_REASON_DEADLINE
	    return SUB_REASON_DEADLINE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_REASON_PROCESSLIMIT"))
#ifdef SUB_REASON_PROCESSLIMIT
	    return SUB_REASON_PROCESSLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_REASON_RUNLIMIT"))
#ifdef SUB_REASON_RUNLIMIT
	    return SUB_REASON_RUNLIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_RERUNNABLE"))
#ifdef SUB_RERUNNABLE
	    return SUB_RERUNNABLE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_RESTART"))
#ifdef SUB_RESTART
	    return SUB_RESTART;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_RESTART_FORCE"))
#ifdef SUB_RESTART_FORCE
	    return SUB_RESTART_FORCE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_RES_REQ"))
#ifdef SUB_RES_REQ
	    return SUB_RES_REQ;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_TIME_EVENT"))
#ifdef SUB_TIME_EVENT
	    return SUB_TIME_EVENT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_USER_GROUP"))
#ifdef SUB_USER_GROUP
	    return SUB_USER_GROUP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUB_WINDOW_SIG"))
#ifdef SUB_WINDOW_SIG
	    return SUB_WINDOW_SIG;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_ADMIN_STOP"))
#ifdef SUSP_ADMIN_STOP
	    return SUSP_ADMIN_STOP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_HOST_LOCK"))
#ifdef SUSP_HOST_LOCK
	    return SUSP_HOST_LOCK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_JOB"))
#ifdef SUSP_JOB
	    return SUSP_JOB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_LOAD_REASON"))
#ifdef SUSP_LOAD_REASON
	    return SUSP_LOAD_REASON;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_LOAD_UNAVAIL"))
#ifdef SUSP_LOAD_UNAVAIL
	    return SUSP_LOAD_UNAVAIL;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_MBD_LOCK"))
#ifdef SUSP_MBD_LOCK
	    return SUSP_MBD_LOCK;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_MBD_PREEMPT"))
#ifdef SUSP_MBD_PREEMPT
	    return SUSP_MBD_PREEMPT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_PG_IT"))
#ifdef SUSP_PG_IT
	    return SUSP_PG_IT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_QUEUE_REASON"))
#ifdef SUSP_QUEUE_REASON
	    return SUSP_QUEUE_REASON;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_QUEUE_WINDOW"))
#ifdef SUSP_QUEUE_WINDOW
	    return SUSP_QUEUE_WINDOW;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_QUE_RESUME_COND"))
#ifdef SUSP_QUE_RESUME_COND
	    return SUSP_QUE_RESUME_COND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_QUE_STOP_COND"))
#ifdef SUSP_QUE_STOP_COND
	    return SUSP_QUE_STOP_COND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_REASON_RESET"))
#ifdef SUSP_REASON_RESET
	    return SUSP_REASON_RESET;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_RESCHED_PREEMPT"))
#ifdef SUSP_RESCHED_PREEMPT
	    return SUSP_RESCHED_PREEMPT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_RES_LIMIT"))
#ifdef SUSP_RES_LIMIT
	    return SUSP_RES_LIMIT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_RES_RESERVE"))
#ifdef SUSP_RES_RESERVE
	    return SUSP_RES_RESERVE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_SBD_PREEMPT"))
#ifdef SUSP_SBD_PREEMPT
	    return SUSP_SBD_PREEMPT;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_SBD_STARTUP"))
#ifdef SUSP_SBD_STARTUP
	    return SUSP_SBD_STARTUP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_USER_REASON"))
#ifdef SUSP_USER_REASON
	    return SUSP_USER_REASON;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_USER_RESUME"))
#ifdef SUSP_USER_RESUME
	    return SUSP_USER_RESUME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "SUSP_USER_STOP"))
#ifdef SUSP_USER_STOP
	    return SUSP_USER_STOP;
#else
	    goto not_there;
#endif
	break;
    case 'T':
	if (strEQ(name, "TO_BOTTOM"))
#ifdef TO_BOTTOM
	    return TO_BOTTOM;
#else
	    goto not_there;
#endif
	if (strEQ(name, "TO_TOP"))
#ifdef TO_TOP
	    return TO_TOP;
#else
	    goto not_there;
#endif
	break;
    case 'U':
	if (strEQ(name, "USER_GRP"))
#ifdef USER_GRP
	    return USER_GRP;
#else
	    goto not_there;
#endif
	if (strEQ(name, "USER_JLP"))
#ifdef USER_JLP
	    return USER_JLP;
#else
	    goto not_there;
#endif
	break;
    case 'V':
	break;
    case 'W':
	break;
    case 'X':
	if (strEQ(name, "XF_OP_EXEC2SUB"))
#ifdef XF_OP_EXEC2SUB
	    return XF_OP_EXEC2SUB;
#else
	    goto not_there;
#endif
	if (strEQ(name, "XF_OP_EXEC2SUB_APPEND"))
#ifdef XF_OP_EXEC2SUB_APPEND
	    return XF_OP_EXEC2SUB_APPEND;
#else
	    goto not_there;
#endif
	if (strEQ(name, "XF_OP_SUB2EXEC"))
#ifdef XF_OP_SUB2EXEC
	    return XF_OP_SUB2EXEC;
#else
	    goto not_there;
#endif
	if (strEQ(name, "XF_OP_SUB2EXEC_APPEND"))
#ifdef XF_OP_SUB2EXEC_APPEND
	    return XF_OP_SUB2EXEC_APPEND;
#else
	    goto not_there;
#endif
	break;
    case 'Y':
	break;
    case 'Z':
	if (strEQ(name, "ZOMBIE_JOB"))
#ifdef ZOMBIE_JOB
	    return ZOMBIE_JOB;
#else
	    goto not_there;
#endif
	break;
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}

int
set_jobname( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_JOB_NAME ){
    SET_LSB_ERRMSG_TO("Job Name can only be specified once");
    return -1;
  }
  s->jobName = (char*)SvPV(value, len);
  s->options |= SUB_JOB_NAME;
  return 0;
}

int
set_queue( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_QUEUE ){
    SET_LSB_ERRMSG_TO("Queue can only be specified once");
    return -1;
  }
  s->queue = (char*)SvPV(value, len);
  s->options |= SUB_QUEUE;
  return 0;
}

int
set_resreq( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_RES_REQ ){
    SET_LSB_ERRMSG_TO("Resource requirements can only be specified once");
    return -1;
  }
  s->resReq = (char*)SvPV(value, len);
  s->options |= SUB_RES_REQ;
  return 0;
}


int
set_hosts( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char **hosts;

  if( s->options & SUB_HOST ){
    SET_LSB_ERRMSG_TO("Hosts can only be specified once");
    return -1;
  }
  /* could be a single host, or an array */
  if( SvPOK(value) ){
    /*assume a single host*/
    hosts = (char**)safemalloc(sizeof(char *));
    *hosts = (char*)SvPV(value, len);
    s->askedHosts = hosts;
    s->numAskedHosts = 1;
    s->options |= SUB_HOST;
  }
  else if( SvROK(value) && SvTYPE(SvRV(value)) == SVt_PVAV ){
    AV* array;
    int length, i;
    /*this is an array reference*/
    array = (AV*)SvRV(value);
    length = av_len(array) + 1;
    hosts = (char**)safemalloc(length*sizeof(char *));
    for( i = 0; i < length; i++){
      hosts[i] = (char *)SvPV(*av_fetch(array,i,0),len);
    }
    s->askedHosts = hosts;
    s->numAskedHosts = length;
    s->options |= SUB_HOST;
  }
  else{
    SET_LSB_ERRMSG_TO("argument requires a string or array");
    return -1;
  }
  return 0;  
}

int
set_memlimit( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->rLimits[LSF_RLIMIT_RSS] != DEFAULT_RLIMIT ){
    SET_LSB_ERRMSG_TO("memlimit can only be specified once");
    return -1;
  }
  s->rLimits[LSF_RLIMIT_RSS] = atoi((char*)SvPV(value, len));
  return 0;
}

int
set_cpulimit( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->rLimits[LSF_RLIMIT_CPU] != DEFAULT_RLIMIT ){
    SET_LSB_ERRMSG_TO("cpulimit can only be specified once");
    return -1;
  }
  s->rLimits[LSF_RLIMIT_CPU] = atoi((char*)SvPV(value, len));
  return 0;
}

int
set_filelimit( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->rLimits[LSF_RLIMIT_FSIZE] != DEFAULT_RLIMIT ){
    SET_LSB_ERRMSG_TO("filelimit can only be specified once");
    return -1;
  }
  s->rLimits[LSF_RLIMIT_FSIZE] = atoi((char*)SvPV(value, len));
  return 0;
}

int
set_datalimit( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->rLimits[LSF_RLIMIT_DATA] != DEFAULT_RLIMIT ){
    SET_LSB_ERRMSG_TO("datalimit can only be specified once");
  }
  s->rLimits[LSF_RLIMIT_DATA] = atoi((char*)SvPV(value, len));
  return 0;
}

int
set_stacklimit( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->rLimits[LSF_RLIMIT_STACK] != DEFAULT_RLIMIT ){
    SET_LSB_ERRMSG_TO("stacklimit can only be specified once");
    return -1;
  }
  s->rLimits[LSF_RLIMIT_STACK] = atoi((char*)SvPV(value, len));
  return 0;
}

int
set_corelimit( struct submit *s, char *key, SV* value ){
  STRLEN len;
  if( s->rLimits[LSF_RLIMIT_CORE] != DEFAULT_RLIMIT ){
    SET_LSB_ERRMSG_TO("corelimit can only be specified once");
    return -1;
  }
  s->rLimits[LSF_RLIMIT_CORE] = atoi((char*)SvPV(value, len));
  return 0;
}

int
set_runlimit( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->rLimits[LSF_RLIMIT_RUN] != DEFAULT_RLIMIT ){
    SET_LSB_ERRMSG_TO("runlimit can only be specified once");
    return -1;
  }
  s->rLimits[LSF_RLIMIT_RUN] = atoi((char*)SvPV(value, len));
  return 0;
}

int
set_processlimit( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->rLimits[LSF_RLIMIT_PROCESS] != DEFAULT_RLIMIT ){
    SET_LSB_ERRMSG_TO("processlimit can only be specified once");
    return -1;
  }
  s->rLimits[LSF_RLIMIT_PROCESS] = atoi((char*)SvPV(value, len));
  return 0;
}

int
set_mailuser( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->mailUser ){
    SET_LSB_ERRMSG_TO("mail user can only be specified once");
    return -1;
  }
  s->mailUser = (char*)SvPV(value, len);
  s->options |= SUB_MAIL_USER;
  return 0;
}

int
set_hostspec( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_HOST_SPEC ){
    SET_LSB_ERRMSG_TO("hostspec can only be specified once");
    return -1;
  }
  s->hostSpec = (char*)SvPV(value, len);
  s->options |= SUB_HOST_SPEC;
  return 0;
}

int
set_hold( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options2 & SUB2_HOLD ){
    SET_LSB_ERRMSG_TO("hold can only be specified once");
    return -1;
  }
  s->options2 |= SUB2_HOLD;
  return 0;
}

int
set_rerunnable( struct submit *s, char *key, SV* value ){
  if( s->options & SUB_MODIFY )
  {
      if( s->options3 & SUB3_NOT_RERUNNABLE )
      {
          SET_LSB_ERRMSG_TO("You cannot set a job to be rerunnable and not-rerunnable at the same time");
          return -1;
      }
      s->options |= SUB_RERUNNABLE;
  }
  else
  {
      if( s->options & SUB_RERUNNABLE )
      {
          SET_LSB_ERRMSG_TO("You cannot set a job to be rerunnable and not-rerunnable at the same time");
          return -1;
      }
      s->options3 |= SUB3_NOT_RERUNNABLE;
  }
  
  return 0;
}

int
set_command( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->command ){
    SET_LSB_ERRMSG_TO("command can only be specified once");
    return -1;
  }
  s->command = (char*)SvPV(value, len);
  return 0;
}

int 
set_checkpointperiod( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_CHKPNT_PERIOD ){
    SET_LSB_ERRMSG_TO("checkpoint period can only be specified once");
    return -1;
  }
  s->chkpntPeriod = (time_t)atoi((char*)SvPV(value, len));
  s->options |= SUB_CHKPNT_PERIOD;
  return 0;
}

int
set_checkpointable( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_CHKPNTABLE ){
    SET_LSB_ERRMSG_TO("checkpointable can only be specified once");
    return -1;
  }
  s->chkpntDir = (char *)SvPV(value, len);
  s->options |= SUB_CHKPNTABLE;
  return 0;
}

/* these flags are undefined in lsbatch.h 
int
set_checkpointcopy( struct submit *s, char *key, SV* value ){
  if( s->options & SUB_CHKPNT_COPY ){
    SET_LSB_ERRMSG_TO("checkpoint copy can only be specified once");
    return -1;
  }
  s->options |= SUB_CHKPNT_COPY;
  return 0;
}

int
set_checkpointforce( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_CHKPNT_FORCE ){
    SET_LSB_ERRMSG_TO("checkpoint force can only be specified once");
    return -1;
  }
  s->options |= SUB_CHKPNT_FORCE;
  return 0;
}
*/

int is_op(char *token){
  return *token == '>' || *token == '<';
}

int set_xfile(struct xFile *xf, char *operation){
  typedef enum {LFILE, OP, RFILE} State;
  char *token, lfile[MAXFILENAMELEN], rfile[MAXFILENAMELEN];
  int nextl = 0, nextr = 0;
  State state = LFILE;
  int op;
  char *res;

  token = strtok( operation, " ");
  while(token){
    switch(state){
    case LFILE:
      if( nextl ){
        strcat(lfile," ");
        strcat(lfile,token);
      }
      else{
        strcpy(lfile, token);
        nextl = 1;
      } 
      token = strtok(NULL, " ");
      if( is_op(token) ) state = OP;
      break;
    case OP:
      if( strcmp(token,">") == 0 ){
        op = XF_OP_SUB2EXEC;
      }
      else if( strcmp(token,"<") == 0 ){
        op = XF_OP_EXEC2SUB;
      }
      else if( strcmp(token,">>") == 0 ){
        op = XF_OP_SUB2EXEC_APPEND;
      }
      else if( strcmp(token,"<<") == 0 ){
        op = XF_OP_EXEC2SUB_APPEND;
      }
      else if( (strcmp(token,"<>") == 0) || (strcmp(token,"><") == 0)){
        op = XF_OP_SUB2EXEC | XF_OP_EXEC2SUB;
      }
      else{
        SET_LSB_ERRMSG_TO("transfer: invalid operator");
        return -1;
      }
      token = strtok(NULL, " ");
      state = RFILE;
      break;
    case RFILE:
      if( nextr ){
        strcat(rfile," ");
        strcat(rfile,token);
      }
      else{
        strcpy(rfile, token);
        nextr = 1;
      }
      token = strtok(NULL, " ");
      break;
    }
  }
  strncpy(xf->subFn, lfile, MAXFILENAMELEN);
  strncpy(xf->execFn, rfile, MAXFILENAMELEN);
  xf->options = op;
  return 0;
}

int set_transfer( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *command;

  if(s->options & SUB_OTHER_FILES)
    SET_LSB_ERRMSG_TO("File transfer can only be specified once");
  /* could be a single transfer, or an array */
  if( SvPOK(value) ){
    /*assume a single transfer*/
    if( (s->xf = (struct xFile *)safemalloc(sizeof(struct xFile))) == NULL ){
      STATUS_NATIVE_SET(errno);
      SET_LSB_ERRMSG_TO(strerror(errno));
      return -1;
    }
    
    if( (s->xf->subFn = (char *)safemalloc(MAXFILENAMELEN)) == NULL ){
      STATUS_NATIVE_SET(errno);
      SET_LSB_ERRMSG_TO(strerror(errno));
      return -1;
    }

    if( (s->xf->execFn = (char *)safemalloc(MAXFILENAMELEN)) == NULL ){
      STATUS_NATIVE_SET(errno);
      SET_LSB_ERRMSG_TO(strerror(errno));
      return -1;
    }
    
    command = (char*)SvPV(value, len);
    if( set_xfile(s->xf, command) < 0 )
      return -1;
    s->nxf = 1;
  }
  else if( SvROK(value) && SvTYPE(SvRV(value)) == SVt_PVAV ){
    AV* array;
    int length, i;
    /*this is an array reference*/
    array = (AV*)SvRV(value);
    length = av_len(array) + 1;
    s->nxf = length;
    if( (s->xf = (struct xFile *)safemalloc(sizeof(struct xFile))) == NULL ){
      STATUS_NATIVE_SET(errno);
      SET_LSB_ERRMSG_TO(strerror(errno));
      return -1;
    }
    for( i = 0; i < length; i++){
      command = (char *)SvPV(*av_fetch(array,i,0),len);
      if( set_xfile(s->xf + i, command) < 0)
	return -1;
    }
  }
  s->options |= SUB_OTHER_FILES;
  return 0;
}

int set_dependcond( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_DEPEND_COND ){
    SET_LSB_ERRMSG_TO("dependency condition can only be specified once");
    return -1;
  }
  s->dependCond = (char *)SvPV(value, len);
  s->options |= SUB_DEPEND_COND;
  return 0;
}

int
getSignalValue(char *signal)
{
    int i;
    char sigStr[16];

    if (signal == NULL)
        return -1;
    if (signal[0] == '\0')
        return -1;

    for (i = 0; i < NSIGNAL_MAP; i++) {
        sprintf(sigStr, "%s%s", "SIG", sigSym[i]);
        if ((strcmp(sigSym[i], signal) == 0) || (strcmp( sigStr, signal) == 0))
            return (signal_map[i]);
    }

    if ( 0 < atoi(signal) && (atoi(signal)) <= LSF_NSIGNAL ){
        return (atoi(signal));
    }

    return -1; 
}

int 
gettimefortoday (char *toptarg, time_t *tTime)
{
    struct tm *tmPtr;
    char *cp;
    int tindex, ttime[5];
    int currhour,currmin,currday;

    *tTime = time(0);
    tmPtr = localtime(tTime);
    tmPtr->tm_sec = 0;
    currhour = tmPtr->tm_hour;
    currmin  = tmPtr->tm_min;
    currday  = tmPtr->tm_mday;

    for (tindex = 0; toptarg; tindex++) {
        ttime[tindex] = 0;
        cp = strrchr(toptarg, ':');
        if ( cp != NULL ) {
            if (!isint_(cp+1))
		return(-1);
            ttime[tindex] = atoi(cp+1);
            *cp = '\000';
        } else {
            if (!isint_(toptarg))
		return(-1);
            ttime[tindex] = atoi(toptarg);
            tindex++;
            break;
        }
    }     
    if ( tindex < 2 || tindex > 4 ) {
	return(-1);
    }
    if ( ttime[0] < 0 || ttime[0] > 59 ) {
	return(-1);
    }
    tmPtr->tm_min = ttime[0];

    if ( ttime[1] < 0 || ttime[1] > 23 ) {
	return(-1);
    }
    tmPtr->tm_hour = ttime[1];

    tindex -= 2;
    if ( tindex > 0 ) {
        if ( ttime[2] < 1 || ttime[2] > 31 ) {
	    return(-1);
        }
        if (( (ttime[2] < tmPtr->tm_mday) ||
              ((ttime[2] == tmPtr->tm_mday) && (ttime[1] < currhour)) || 
              ((ttime[2] == tmPtr->tm_mday) && (ttime[1] == currhour) &&
               (ttime[0] < currmin))
            ) && tindex == 1)
            tmPtr->tm_mon++;
        tmPtr->tm_mday = ttime[2];

        tindex--;
        switch (tindex) {
        case 1:
            if ( ttime[3] < 0 || ttime[3] > 12 ) {
		return(-1);
            }
            if ( (((ttime[3]-1) < tmPtr->tm_mon) ||
                 (((ttime[3]-1) == tmPtr->tm_mon) && (ttime[2] < currday)) ||
                 (((ttime[3]-1) == tmPtr->tm_mon) && (ttime[2] == currday) &&
                  (ttime[1] < currhour)) ||
                 (((ttime[3]-1) == tmPtr->tm_mon) && (ttime[2] == currday) &&
                  (ttime[1] == currhour) && (ttime[0] < currmin)))
               )
                tmPtr->tm_year++;
            tmPtr->tm_mon = ttime[3] - 1;
            break;
        default:
            break;
        }
    }

    /*
     * start or terminate time may be daylight saving time while current
     * time may not be, or vice versa.  "-1" means that we don't know whether
     * the time is daylight saving time or not.
     */
    tmPtr->tm_isdst = -1;

    *tTime = mktime(tmPtr);

    return(0);
}

int set_begintime( struct submit *s, char *key, SV* value ){
  STRLEN len;
  time_t tTime;
  char * toptarg;
  int rc;

  if( s->beginTime ){
    SET_LSB_ERRMSG_TO("begin time can only be specified once");
    return -1;
  }
  
  toptarg = (char*)SvPV(value, len);

  if(len == 0)
  {
    SET_LSB_ERRMSG_TO("begin time is not valid.");
    return -1;
  }
  
  rc = gettimefortoday(toptarg, &tTime);
  if (rc >= 0) {
    tTime = (tTime < time(0)) ? tTime + 86400 : tTime ;
  }
  
  s->beginTime = tTime;
  
  return 0;
}

int set_termtime( struct submit *s, char *key, SV* value ){
  STRLEN len;
  time_t tTime;
  char * toptarg;
  int rc;

  if( s->termTime ){
    SET_LSB_ERRMSG_TO("term time can only be specified once");
    return -1;
  }
  
  toptarg = (char*)SvPV(value, len);
  if(len == 0)
  {
    SET_LSB_ERRMSG_TO("term time is not valid.");
    return -1;
  }
  rc = gettimefortoday(toptarg, &tTime);
  if (rc >= 0) {
    tTime = (tTime < time(0)) ? tTime + 86400 : tTime ;
  }
  
  s->termTime = tTime;
  return 0;
}

int set_block( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options2 & SUB2_BSUB_BLOCK ){
    SET_LSB_ERRMSG_TO("block can only be specified once");
    return -1;
  }
  s->options2 |= SUB2_BSUB_BLOCK;
  return 0;
}

int set_infile( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_IN_FILE ){
    SET_LSB_ERRMSG_TO("input file can only be specified once");
    return -1;
  }
  s->inFile = (char *)SvPV(value, len);
  s->options |= SUB_IN_FILE;
  return 0;
}

int set_outfile( struct submit *s, char *key, SV* value, int flag ){
  STRLEN len;
  char * out;

  if( s->options & SUB_OUT_FILE ){
    SET_LSB_ERRMSG_TO("output file can only be specified once");
    return -1;
  }
  
  out = (char *)SvPV(value, len);

  if (strlen(out) > MAXFULLFILENAMELEN - 1)
  {
    SET_LSB_ERRMSG_TO("File name is too long.");
    return -1;
  }
  
  s->outFile = out;
  s->options |= SUB_OUT_FILE;
  s->options2 &= ~SUB2_OVERWRITE_OUT_FILE;

  if(flag == 1)
  {
    s->options2 |= SUB2_OVERWRITE_OUT_FILE;
  }
  
  return 0;
}

int set_errfile( struct submit *s, char *key, SV* value, int flag){
  STRLEN len;

  if( s->options & SUB_ERR_FILE ){
    SET_LSB_ERRMSG_TO("error file can only be specified once");
    return -1;
  }
  s->errFile = (char *)SvPV(value, len);
  s->options |= SUB_ERR_FILE;
  
  if(flag == 1)
  {
     s->options2 |= SUB2_OVERWRITE_ERR_FILE;
  }
  
  return 0;
}

int set_interactive( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_INTERACTIVE ){
    SET_LSB_ERRMSG_TO("interactive can only be specified once");
    return -1;
  }
  s->options |= SUB_INTERACTIVE;
  return 0;
}

int set_interactive_pty( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_PTY ){
    SET_LSB_ERRMSG_TO("pty can only be specified once");
    return -1;
  }
  s->options |= SUB_INTERACTIVE | SUB_PTY;
  return 0;
}

int set_interactive_shell( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_PTY_SHELL ){
    SET_LSB_ERRMSG_TO("pty shell can only be specified once");
    return -1;
  }
  s->options |= SUB_INTERACTIVE | SUB_PTY | SUB_PTY_SHELL;
  return 0;
}

int set_exclusive( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_EXCLUSIVE ){
    SET_LSB_ERRMSG_TO("exclusive can only be specified once");
    return -1;
  }
  s->options |= SUB_EXCLUSIVE;
  return 0;
}

int set_preexec( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_PRE_EXEC ){
    SET_LSB_ERRMSG_TO("preexec can only be specified once");
    return -1;
  }
  s->preExecCmd = (char *)SvPV(value, len);
  s->options |= SUB_PRE_EXEC;
  return 0;
}

int set_usergroup( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->userGroup ){
    SET_LSB_ERRMSG_TO("user group can only be specified once");
    return -1;
  }
  s->userGroup = (char *)SvPV(value, len);
  s->options |= SUB_USER_GROUP;
  return 0;
}

int set_projectname( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->projectName ){
    SET_LSB_ERRMSG_TO("project name can only be specified once");
    return -1;
  }
  s->projectName = (char *)SvPV(value, len);
  s->options |= SUB_PROJECT_NAME;
  return 0;
}

int set_numprocessors( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char * numproc;
  char *p;

  if( s->numProcessors > 0){
    SET_LSB_ERRMSG_TO("num procs can only be specified once");
    return -1;
  }
  
  numproc = (char *)SvPV(value, len);
  p = strchr(numproc, ',');
  
  if(p != NULL)
  {
     *p = '\0';
     s->numProcessors = atoi(numproc);
     s->maxNumProcessors = atoi(p+1);     
  }
  else
  {
    s->numProcessors = atoi(numproc);
    s->maxNumProcessors = atoi(numproc);
  }
 
  if(s->numProcessors > s->maxNumProcessors)
  {
    SET_LSB_ERRMSG_TO("Bad argument for option -n");
    return -1;
  }
  
  return 0;
}

int set_sigvalue( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->sigValue ){
    SET_LSB_ERRMSG_TO("sigvalue can only be specified once");
    return -1;
  }
  s->sigValue = atoi((char *)SvPV(value, len));
  s->options |= SUB_WINDOW_SIG;
  return 0;
}

int set_notifybegin( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_NOTIFY_BEGIN ){
    SET_LSB_ERRMSG_TO("notify begin can only be specified once");
    return -1;
  }
  s->options |= SUB_NOTIFY_BEGIN;  
  return 0;
}

int set_notifyend( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_NOTIFY_END ){
    SET_LSB_ERRMSG_TO("notify end can only be specified once");
    return -1;
  }
  s->options |= SUB_NOTIFY_END;  
  return 0;
}

int set_loginshell( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options & SUB_LOGIN_SHELL ){
    SET_LSB_ERRMSG_TO("login shell can only be specified once");
    return -1;
  }
  s->loginShell = (char *)SvPV(value, len);
  s->options |= SUB_LOGIN_SHELL;
  return 0;
}

int set_postexec( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options3 & SUB3_POST_EXEC ){
    SET_LSB_ERRMSG_TO("postexec can only be specified once");
    return -1;
  }
  s->postExecCmd = (char *)SvPV(value, len);
  s->options3 |= SUB_PRE_EXEC;
  return 0;
}

int set_appoption( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *appname;

  if( s->options3 & SUB3_APP ){
    SET_LSB_ERRMSG_TO("appoption can only be specified once");
    return -1;
  }
  
  appname = (char *)SvPV(value, len);
  if (strlen(appname) > MAX_LSB_NAME_LEN)
  {
    SET_LSB_ERRMSG_TO("Application profile name too long");
    return -1;
  }
  s->app = appname;
  s->options3 |= SUB3_APP;
  return 0;
} 

int set_apsoption( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options3 & SUB3_APP ){
    SET_LSB_ERRMSG_TO("apsoption can only be specified once");
    return -1;
  }
  
  s->apsString = (char *)SvPV(value, len);
  s->options3 |= SUB3_ABSOLUTE_PRIORITY;
  return 0;
} 

int set_inspool( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *infile;
  
  if( (s->options & SUB_IN_FILE) ||  (s->delOptions & SUB_IN_FILE)){
    SET_LSB_ERRMSG_TO("is|i options are exclusive");
    return -1;
  }
  
  if( s->options2 & SUB2_IN_FILE_SPOOL ){
    SET_LSB_ERRMSG_TO("SPOOL_DIR can only be specified once");
    return -1;
  }
  
  infile = (char *)SvPV(value, len);
  
  if( strlen(infile) > MAXFULLFILENAMELEN - 1){
    SET_LSB_ERRMSG_TO("File name is too long");
    return -1;
  }  
  
  s->inFile = infile;
  s->options2 |= SUB2_IN_FILE_SPOOL;
  return 0;
}

int set_newCommand( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *CommandName;
  
  if( (s->options2 & SUB2_JOB_CMD_SPOOL) ||  (s->delOptions2 & SUB2_JOB_CMD_SPOOL)){
    SET_LSB_ERRMSG_TO("Zsn|Zs|Z options are exclusive");
    return -1;
  }
  
  CommandName = (char *)SvPV(value, len);
  
  if( strlen(CommandName) > MAXFULLFILENAMELEN){
    SET_LSB_ERRMSG_TO("File name is too long");
    return -1;
  }  
 
  if (s->options & SUB_MODIFY) {
    s->newCommand = CommandName;
    s->options2 |= SUB2_MODIFY_CMD;
  }
 
  s->options2 |= SUB2_JOB_CMD_SPOOL;
  
  return 0;
}

int set_swapoption( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *SwapLimitValue;
  char *p;
  int errflag = 0;
  
  if( s->rLimits[LSF_RLIMIT_SWAP] != DEFAULT_RLIMIT ){
    SET_LSB_ERRMSG_TO("SWAPLIMIT value can only be specified once");
    return -1;
  }
  
  SwapLimitValue = (char *)SvPV(value, len);
  p = SwapLimitValue;
  
  while( strlen(p) > 0 )
  {
      if(*p < '0' || *p > '9')
      {
          errflag = 1;
          break;
      }
      p++;
  }
  
  if(1 == errflag)
  {
    SET_LSB_ERRMSG_TO("SWAPLIMIT value can not be converted to digital.");
    return -1;
  }
  
  if(atoi(SwapLimitValue) < 0)
  {
    SET_LSB_ERRMSG_TO("SWAPLIMIT value should be a positive integer.");
    return -1;
  }
  
  s->rLimits[LSF_RLIMIT_SWAP] = atoi(SwapLimitValue);
  return 0;
}

int set_runtime( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *RunTimeValue;
  char *p;
  char *cp;
  int errflag = 0;
  
  RunTimeValue = (char *)SvPV(value, len);  
  p = strchr(RunTimeValue, '/');
  
  if(p != NULL)
  {
      s->options |= SUB_HOST_SPEC;
      if (s->hostSpec && strcmp (s->hostSpec, p + 1) != 0) 
      {
          SET_LSB_ERRMSG_TO("RunTime value can only be specified once");
          return -1;
      }      
      s->hostSpec = p + 1;
      *p = '\0';
  }
  
  cp = RunTimeValue;
  
  while( strlen(cp) > 0 )
  {
      if(*cp < '0' || *cp > '9')
      {
          errflag = 1;
          break;
      }
      cp++;
  }
  
  if(1 == errflag)
  {
    SET_LSB_ERRMSG_TO("RunTime value can not be converted to digital.");
    return -1;
  }
  
  if(atoi(RunTimeValue) < 0)
  {
    SET_LSB_ERRMSG_TO("RunTime value should be a positive integer.");
    return -1;
  }
  
  s->runtimeEstimation = atoi(RunTimeValue);
  cp = cp + 1;
  RunTimeValue = cp;
  p = strchr(RunTimeValue, ':');
  
  if(p != NULL)
  {
     *p = '\0';
     while( strlen(cp) > 0 )
     {
         if(*cp < '0' || *cp > '9')
         {
             errflag = 1;
             break;
         }
         cp++;
     }
     if(1 == errflag)
     {
        SET_LSB_ERRMSG_TO("RunTime value can not be converted to digital.");
        return -1;
     }
     if(atoi(RunTimeValue) < 0)
     {
        SET_LSB_ERRMSG_TO("RunTime value should be a positive integer.");
        return -1;
     }
     s->runtimeEstimation *= 60;
     s->runtimeEstimation += atoi(RunTimeValue);
  }
  
  s->runtimeEstimation *= 60; /*Converted to second.*/
  s->options3 |= SUB3_RUNTIME_ESTIMATION;
    
  return 0;
}

int set_rsvId( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->options2 & SUB2_USE_RSV ){
    SET_LSB_ERRMSG_TO("rsvId can only be specified once");
    return -1;
  }
  s->rsvId = (char *)SvPV(value, len);
  s->options2 |= SUB2_USE_RSV;
  
  return 0;
}

int set_extsched( struct submit *s, char *key, SV* value ){
  STRLEN len;

  if( s->extsched != NULL ){
    SET_LSB_ERRMSG_TO("extsched can only be specified once");
    return -1;
  }

  s->extsched = (char *)SvPV(value, len);
  s->options2 |= SUB2_EXTSCHED;
 
  return 0;
}

int set_slaname( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *slaname;

  if( s->options2 & SUB2_SLA ){
    SET_LSB_ERRMSG_TO("slaname can only be specified once");
    return -1;
  }
  
  slaname = (char *)SvPV(value, len);
  
  if(strlen(slaname) > MAX_LSB_NAME_LEN - 1)
  {
     SET_LSB_ERRMSG_TO("SLA name is too long");
     return -1;
  }

  s->sla = slaname;
  s->options2 |= SUB2_SLA;
 
  return 0;
}

int set_proclimit( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *proclimit;
  char *p;
  int errflag = 0;

  if( s->rLimits[LSF_RLIMIT_PROCESS] != DEFAULT_RLIMIT ){
    SET_LSB_ERRMSG_TO("Processlimit can only be specified once");
    return -1;
  }
  
  proclimit = (char *)SvPV(value, len);
  p = proclimit;
  
  while( strlen(p) > 0 )
  {
      if(*p < '0' || *p > '9')
      {
          errflag = 1;
          break;
      }
      p++;
  }
  
  if(1 == errflag)
  {
    SET_LSB_ERRMSG_TO("processlimit value can not be converted to digital.");
    return -1;
  }
  
  s->rLimits[LSF_RLIMIT_PROCESS] = atoi(proclimit);
  
  
  if((s->rLimits[LSF_RLIMIT_PROCESS]) < 0)
  {
     SET_LSB_ERRMSG_TO("PROCESSLIMIT value should be positive");
     return -1;
  }
 
  return 0;
}

int set_jsdl( struct submit *s, char *key, SV* value, int flag ){
  STRLEN len;

  s->jsdlFlag = flag;
  s->jsdlDoc = (char *)SvPV(value, len);
 
  return 0;
}

int set_usershelllimits( struct submit *s, char *key, SV* value){

  if(s->options3 & SUB3_USER_SHELL_LIMITS)
  {
     SET_LSB_ERRMSG_TO("user shell limits value should be positive");
     return -1;
  }
  
  s->options3 |= SUB3_USER_SHELL_LIMITS;
  return 0;
}

int set_currentworkdir( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *curworkdir;
  
  if(s->options3 & SUB3_CWD)
  {
     SET_LSB_ERRMSG_TO("Current work directory can only be specified once");
     return -1;
  }
  
  curworkdir = (char *)SvPV(value, len);
  
  if(strlen(curworkdir) >= MAXFULLFILENAMELEN - 1)
  {
     SET_LSB_ERRMSG_TO("current working directory name is too long");
     return -1;
  }
   
  s->cwd = curworkdir;
  s->options3 |= SUB3_CWD;
  return 0;
}

int set_jobgroup( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *jobgrp;
  
  if(s->options2 & SUB2_JOB_GROUP)
  {
     SET_LSB_ERRMSG_TO("Job group can only be specified once");
     return -1;
  }
    
  jobgrp = (char *)SvPV(value, len);  
  
  if(strlen(jobgrp) >= MAXLINELEN - 1)
  {
     SET_LSB_ERRMSG_TO("Job group name is too long");
     return -1;
  }
   
  s->jobGroup = jobgrp;
  s->options2 |= SUB2_JOB_GROUP;
  s->options3 &= ~SUB3_DEFAULT_JOBGROUP;
  return 0;
}

int set_ThreadLimit( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char *threadlimit;
  char *p;
  int errflag = 0; 
  
  if(s->rLimits[LSF_RLIMIT_THREAD] != DEFAULT_RLIMIT)
  {
     SET_LSB_ERRMSG_TO("Thread limit can only be specified once");
     return -1;
  }
  
  threadlimit = (char *)SvPV(value, len); 
  p = threadlimit;
  
  while( strlen(p) > 0 )
  {
      if(*p < '0' || *p > '9')
      {
          errflag = 1;
          break;
      }
      p++;
  }
  
  if(1 == errflag)
  {
    SET_LSB_ERRMSG_TO("Thread limit value can not be converted to digital.");
    return -1;
  }
  
  s->rLimits[LSF_RLIMIT_THREAD] = atoi(threadlimit);
  
  if((s->rLimits[LSF_RLIMIT_THREAD]) < 0)
  {
     SET_LSB_ERRMSG_TO("THREADLIMIT value should be positive");
     return -1;
  }

  return 0;
}

int set_licenseprj( struct submit *s, char *key, SV* value ){
  STRLEN len; 
  s->licenseProject = (char *)SvPV(value, len);
  s->options2 |= SUB2_LICENSE_PROJECT;
  return 0;
}

int set_jobpriority( struct submit *s, char *key, SV* value ){
  STRLEN len; 
  char * jobpri;
  char *p;
  int errflag = 0;
  
  if( s->options2 & SUB2_JOB_PRIORITY )
  {
     SET_LSB_ERRMSG_TO("Job priority can only be specified once");
     return -1;
  }
  
  jobpri = (char *)SvPV(value, len);
  p = jobpri;
  
  while( strlen(p) > 0 )
  {
      if(*p < '0' || *p > '9')
      {
          errflag = 1;
          break;
      }
      p++;
  }
  
  if(1 == errflag)
  {
    SET_LSB_ERRMSG_TO("Job priority value can not be converted to digital.");
    return -1;
  }
  
  s->userPriority = atoi(jobpri);
  
  if(s->userPriority < 0)
  {
     SET_LSB_ERRMSG_TO("Job priority value should be positive");
     return -1;
  }

  s->options2 |= SUB2_JOB_PRIORITY;
  return 0;
}

#if LSF_VERSION >= 20

int set_requeue_value( struct submit *s, char *key, SV* value ){
  STRLEN len;
  char * revalue;

  revalue = (char *)SvPV(value, len);

  if( strlen(revalue) > MAXLINELEN - 1 )
  {
    SET_LSB_ERRMSG_TO("Requeue value is too long");
    return -1;
  }

  s->requeueEValues = revalue;
  s->options3 |= SUB3_JOB_REQUEUE;

  return 0;
}

int set_mig( struct submit *s, char *key, SV* value ){
  STRLEN len; 
  char * migvale;
  char *p;
  int errflag = 0;

  if( s->options3 & SUB3_MIG_THRESHOLD )
  {
     SET_LSB_ERRMSG_TO("Migration threshold value can only be specified once");
     return -1;
  }
  
  migvale = (char *)SvPV(value, len);
  p = migvale;
  
  while( strlen(p) > 0 )
  {
      if(*p < '0' || *p > '9')
      {
          errflag = 1;
          break;
      }
      p++;
  }
  
  if(1 == errflag)
  {
    SET_LSB_ERRMSG_TO("Migration threshold value can not be converted to digital.");
    return -1;
  }
  
  s->migThreshold = atoi(migvale);
  s->options3 |= SUB3_MIG_THRESHOLD;
  
  return 0;
}

#endif

void initialize_submit(struct submit *s){
  int i;

  bzero(s,sizeof(struct submit));
  for( i = 0; i < LSF_RLIM_NLIMITS; i++ ){
    s->rLimits[i] = DEFAULT_RLIMIT;
  }
  s->numProcessors = 0;
  s->maxNumProcessors = 0;
}

void free_submit(struct submit *s){
  int i;
  safefree(s->askedHosts);
  safefree(s);
}

int format_submit(struct submit *s, HV* sub ){
  int size;
  I32 keylen;
  unsigned long len;
  char *key;
  HE* entry;
  SV* value;
  int err = 0;

  size = hv_iterinit(sub);
#ifdef _AIX
  size++; /* Why the size is off by one on AIX who knows*/
#endif
  while(size--){
    char *flag;
    entry = hv_iternext(sub);
    key = hv_iterkey(entry, &keylen);
    value = hv_iterval(sub,entry);
    flag = key + 1;

    /*printf("format: got flag %s\n",key);*/
    switch( *flag ){
    case 'J':
    /*jobname*/
      err = set_jobname(s, key, value);
      break;
    case 'j':
      if( memcmp( flag, "jsdl_strict", strlen("jsdl_strict")) == 0 ){
        err = set_jsdl(s, key, value, 0);
      }
      else if( memcmp( flag, "jsdl", 4) == 0 ){
        err = set_jsdl(s, key, value,1);
      }
      else
      {
        SET_LSB_ERRMSG_TO( "invalid flag" );
        err = -1;
      }
      break;
    case 'q':
      /*queue*/
      err = set_queue(s, key, value);
      break;
    case 'R':
      /*resreq*/
      err = set_resreq(s, key, value);
      break;
    case 'm':
      if( keylen == 2 ){
	/*m - hosts*/	
	err = set_hosts(s, key, value);
      }
      else if( memcmp( flag, "me", 2) == 0 ){
	/*memlimit*/
	err = set_memlimit(s, key, value);
      }
      else if( memcmp( flag, "mai", 3) == 0 ){
	/*mailuser*/
	err = set_mailuser(s, key, value);
      }
#if LSF_VERSION >= 20      
      else if( memcmp( flag, "mig", 3) == 0 ){
        err = set_mig(s, key, value);
      }
#endif
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
        err = -1;
      }
      break;
    case 'h':
      if( memcmp( flag, "hostsp", 6 ) == 0 ){
	/*hostspec*/
	err = set_hostspec( s, key, value );
      }
      else if( memcmp( flag, "hosts", 5 ) == 0 ){
	/*hosts*/
	err = set_hosts( s, key, value );
      }
      else if( memcmp( flag, "hol", 3 ) == 0 ){
	/*hold*/
	err = set_hold(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
        err = -1;
      }
      break;
    case 'r':
      if( keylen == 2 ){
	/*rerunnable*/
	err = set_rerunnable(s, key, value);
      }
      else if( memcmp( flag, "ru", 2 ) == 0 ){
	/*runlimit*/
	err = set_runlimit(s, key, value);
      }
      else if( memcmp( flag, "rn", 2 ) == 0 ){
	/*rerunnable*/
	err = set_rerunnable(s, key, value);
      }
      else if( memcmp( flag, "resr", 4 ) == 0 ){
	/*resreq*/
	err = set_resreq(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
 	err = -1;
      }
      break;
    case 'c':
      if( keylen == 2 || memcmp( flag, "cp", 2 ) == 0 ){
	/*c-cpulimit*/
	err = set_cpulimit(s, key, value);
      }
      else if( memcmp( flag, "cor", 3 ) == 0 ){
	/*corelimit*/
	err = set_corelimit(s, key, value);
      }
      else if( memcmp( flag, "com", 3 ) == 0 ){
	/*command*/
	err = set_command(s, key, value);
      }
      else if( memcmp( flag, "checkpointp", 11 ) == 0 ){
	/*checkpointperiod*/
	err = set_checkpointperiod(s, key, value);
      }
      else if( memcmp( flag, "checkpointa", 11 ) == 0 ){
	/*checkpointable*/
	err = set_checkpointable(s, key, value);
      }
      else if( memcmp( flag, "cwd", 3 ) == 0 ){
        err = set_currentworkdir(s, key, value);
      } 
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;       
    case 'W':
      /*runlimit*/
      if( keylen == 2 )
      {
        err = set_runlimit(s, key, value);
      }
      else if( memcmp( flag, "We", 2) == 0 )
      {
        err = set_runtime(s, key, value);
      }
      else
      {
        SET_LSB_ERRMSG_TO( "invalid flag" );
        err = -1;
      }
      break;
    case 'F':
      /*filelimit*/
      err = set_filelimit(s, key, value);
      break;
    case 'f':
      if( keylen == 2 ){
	/*f-transfer*/
	err = set_transfer(s, key, value);
      }
      else if( memcmp( flag, "fi", 2 ) == 0){
	/*filelimit*/
	err = set_filelimit(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;
    case 'M':
      /*memlimit*/ 
      err = set_memlimit(s, key, value);
      break;
    case 'D':
      /*datalimit*/
      err = set_datalimit(s, key, value);
      break;
    case 'd':
      if( memcmp( flag, "da", 2 ) == 0){
	/*datalimit*/
	err = set_datalimit(s, key, value);
      }
      else if( memcmp( flag, "de", 2 ) == 0 ){
	/*dependCond*/
	err = set_dependcond(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;	
    case 'S':
      /*stacklimit*/
      err = set_stacklimit(s, key, value);
      break;
    case 's':
      if( keylen == 2 ){
	/*s-hostspec*/
	err = set_hostspec(s, key, value);
      }
      else if( memcmp( flag, "st", 2 ) == 0 ){
	/*stacklimit*/
	err = set_stacklimit(s, key, value);
      }
      else if( memcmp( flag, "si", 2 ) == 0 ){
	/*sigvalue*/
	err = set_sigvalue(s, key, value);
      }
      else if( memcmp( flag, "sla", 3 ) == 0 ){
        err = set_slaname(s, key, value);
      }
      else if( memcmp(flag,"sp",2 ) == 0){
        err = set_jobpriority(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;	
    case 'C':
      /*corelimit*/
      err = set_corelimit(s, key, value);
      break;
    case 'w':
      /*dependCond*/
      err = set_dependcond(s, key, value);
      break;
    case 'b':
      if( keylen == 2 ){
	/*b-begintime*/
	err = set_begintime(s, key, value);
      }
      else if( memcmp( flag, "bl", 2) == 0 ){
	/*block*/
	err = set_block(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;              
    case 't':
      if( keylen == 2 ){
        /*t-termtime*/
	err = set_termtime(s, key, value);
      }
      else if( memcmp( flag, "tr", 2 ) == 0 ){
	/*transfer*/
	err = set_transfer(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;	
    case 'i':
      if( keylen == 2 ){
	/*i-infile*/
	err = set_infile(s, key, value);
      }
      else if ( memcmp(flag, "in", 2) == 0 ){
	/*interactive*/
	err = set_interactive(s, key, value);
      }
      else if ( memcmp(flag, "is", 2) == 0 ){
        err = set_inspool(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;	
    case 'o':
      /*outfile*/
      if( keylen == 2 || memcmp(flag, "output", 6) == 0)
      {
        err = set_outfile(s, key, value, 0);
      }
      else if( memcmp(flag, "oo", 2) == 0 ){
        err = set_outfile(s, key, value, 1);
      }
      else
      {
        SET_LSB_ERRMSG_TO( "invalid flag" );
        err = -1;
      }
      break;
    case 'e':
      if( keylen == 2 ){
	/*e-errfile*/
	err = set_errfile(s, key, value,0);
      }
      else if( memcmp(flag, "ex", 2) == 0 ){
	/*exclusive*/
	err = set_exclusive(s, key, value);
      }
      else if( memcmp(flag, "extsched", strlen("extsched")) == 0 
              || memcmp(flag, "ext", strlen("ext")) == 0){
        err = set_extsched(s, key, value);
      }
      else if( memcmp(flag, "eo", 2) == 0 ){
        err = set_errfile(s, key, value,1);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;	
    case 'k':
      /*checkpointable*/
      err = set_checkpointable(s, key, value);
      break;
    case 'p':
      if( keylen == 2 )
      {
        err = set_proclimit(s, key, value);
      }
      else if( memcmp(flag, "pr", 2) == 0 ){
	/*preexec*/
	err = set_preexec(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;	
    case 'E':
      /*preexec*/
      if( keylen == 2){
        err = set_preexec(s, key, value);
      }
      else if( memcmp( flag, "Ep", 2) == 0 )
      {
        err = set_postexec(s, key, value);
      }
      else
      {
        SET_LSB_ERRMSG_TO( "invalid flag" );
        err = -1;
      }
      break;
    case 'u':
      if( keylen == 2){
	/*u-mailuser*/
	err = set_mailuser(s, key, value);
      }
      else if( memcmp( flag, "us", 2) == 0 ){
	/*usergroup*/
	err = set_usergroup(s, key, value);
      }
      else if( memcmp( flag, "ul", 2) == 0 ){
        err = set_usershelllimits(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;	
    case 'P':
      /*projectname*/
      err = set_projectname(s, key, value);
      break;
    case 'n':
      if( keylen == 2 ){
	/*n-numprocessors*/
	err = set_numprocessors(s, key, value);
      }
      else if( memcmp( flag, "notifyB", 7) == 0 ){
	/*notifybegin*/
	err = set_notifybegin(s, key, value);
      }
      else if( memcmp( flag, "notifyE", 7) == 0 ){
	/*notifyend*/
	err = set_notifyend(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;	
    case 'L':
      if( keylen == 2 ){
          err = set_loginshell(s, key, value);
      }
      else if(memcmp( flag, "Lp", 2) == 0)
      {
        err = set_licenseprj(s, key, value);
      }
      else
      {
        SET_LSB_ERRMSG_TO( "invalid flag" );
        err = -1;
      }
      break;
    case 'l':
      /*loginshell*/
      err = set_loginshell(s, key, value);
      break;
    case 'G':
      /*userGroup*/
      err = set_usergroup(s, key, value);
      break;
    case 'x':
      /*exclusive*/
      err = set_exclusive(s, key, value);
      break;
    case 'B':
      /*notifybegin*/
      err = set_notifybegin(s, key, value);
      break;
    case 'N':
      /*notifyend*/
      err = set_notifyend(s, key, value);
      break;
    case 'I':
      if( keylen == 2 ){
	/*I-interactive*/
	err = set_interactive(s, key, value);
      }
      else if( memcmp( flag, "Ip", 2) == 0 ){
	/*Ip-pty*/
	err = set_interactive_pty(s, key, value);
      }
      else if( memcmp( flag, "Is", 2) == 0 ){
	/*Is-ptyshell*/
	err = set_interactive_shell(s, key, value);
      }
      else{
	SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;
    case 'H':
      /*hold*/
      err = set_hold(s, key, value);
      break;
    case 'K':
      /*block*/
      err = set_block(s, key, value);
      break;

#if LSF_VERSION >= 20
    case 'Q':
      if( keylen == 2 )
      {
        err = set_requeue_value(s, key, value);
      }
      else
      {
        SET_LSB_ERRMSG_TO( "invalid flag" );
	err = -1;
      }
      break;
#endif

    case 'a':
      if( memcmp( flag, "app", 3) == 0 )
      {
        err = set_appoption(s, key, value);
      }
      else if( memcmp( flag, "aps", 3) == 0 )
      {
        err = set_apsoption(s, key, value);
      }
      else
      {
        SET_LSB_ERRMSG_TO( "window signal option" );
        err = -1;
      }
      break;      
    case 'T':
      err = set_ThreadLimit(s, key, value);
      break;
    case 'Z':
      if( memcmp( flag, "Zs", 2) == 0 && memcmp( flag, "Zsn", 3) != 0)
      {
        err = set_newCommand(s, key, value);
      }
      else
      {
        SET_LSB_ERRMSG_TO( "invalid flag" );
        err = -1;
      }
      break;
    case 'v':
      if( keylen == 2 )
      {
        err = set_swapoption(s, key, value);
      }
      else
      {
        SET_LSB_ERRMSG_TO( "invalid flag" );
        err = -1;
      }
      break;
    case 'U':
      err = set_rsvId(s, key, value);
      break;      
    case 'V':
      fputs(_LS_VERSION_, stderr);
      break;
    case 'g':
      err = set_jobgroup(s, key, value);
      break;
    default:
	break;
    };
    if( err == -1 )
      return -1;
  }
  return 0;
}

struct myjob{
  int jobId;
  int arrayIdx;
  char queue[MAX_LSB_NAME_LEN];
  int badJobId;
  char badJobName[MAX_LSB_NAME_LEN];
  int badReqIndx;
};

int
set_range(struct addRsvRequest *req, SV *rag)
{
  STRLEN len;
  char *range;
  char *p;
  char *dltr;
  
  range = (char *)SvPV(rag, len);
  p = range;
  
  while (strlen(p) > 0) {
    if ((*p < '0' || *p > '9') && *p != ',') {
      SET_LSB_ERRMSG_TO("Processor number range value can not be converted to digital.");
      return -1;	
    }
    p ++;
  }
  dltr = strchr(range, ',');
  if (dltr == NULL) {
    req->procRange.minNumProcs = atoi(range);
    req->procRange.maxNumProcs = req->procRange.minNumProcs;
  } else {
    *dltr = '\0';
	req->procRange.minNumProcs = atoi(range);
	req->procRange.maxNumProcs = atoi(dltr+1);
  }
  if (req->procRange.minNumProcs <= 0 || req->procRange.maxNumProcs <= 0) {
    SET_LSB_ERRMSG_TO("Only a single positive (non-zero) integer can appear in the -n option.");
    return -1;	
  }
  return 0;
}

int 
set_machines(struct addRsvRequest *req, SV *m)
{
  STRLEN len;
  char **hosts;
  
  /* could be a single host, or an array */
  if( SvPOK(m) ){
    /*assume a single host*/
    hosts = (char**)safemalloc(sizeof(char *));
    *hosts = (char*)SvPV(m, len);
    req->askedHosts = hosts;
    req->numAskedHosts = 1;
    req->options |= RSV_OPTION_HOST;
  } else if( SvROK(m) && SvTYPE(SvRV(m)) == SVt_PVAV ){
    AV* array;
    int length, i;
    /*this is an array reference*/
    array = (AV*)SvRV(m);
    length = av_len(array) + 1;
    hosts = (char**)safemalloc(length*sizeof(char *));
    for( i = 0; i < length; i++){
      hosts[i] = (char *)SvPV(*av_fetch(array,i,0),len);
    }
    req->askedHosts = hosts;
    req->numAskedHosts = length;
    req->options |= RSV_OPTION_HOST;
  } else {
    SET_LSB_ERRMSG_TO("argument requires a string or array");
    return -1;
  }
  return 0;	
}

int 
set_username(struct addRsvRequest *req, SV *name)
{
  STRLEN len;
  
  if (req->options & (RSV_OPTION_GROUP | RSV_OPTION_SYSTEM)) {
    SET_LSB_ERRMSG_TO("You must specify exactly one of the '-u', '-g' and '-s' options");
    return -1;
  }
  req->options |= RSV_OPTION_USER;
  req->name = (char *)SvPV(name, len);
  return 0;	
}

int 
set_groupname(struct addRsvRequest *req, SV *name)
{
  STRLEN len;
  
  if (req->options & (RSV_OPTION_USER | RSV_OPTION_SYSTEM)) {
    SET_LSB_ERRMSG_TO("You must specify exactly one of the '-u', '-g' and '-s' options");
    return -1;
  }
  req->options |= RSV_OPTION_GROUP;
  req->name = (char *)SvPV(name, len);
  return 0;	
}

int 
set_rsvresreq(struct addRsvRequest *req, SV *resreq)
{
  STRLEN len;
  
  if (req->options & RSV_OPTION_RESREQ) {
    SET_LSB_ERRMSG_TO("You can specify only one -R option");
    return -1;
  }
  req->options |= RSV_OPTION_RESREQ;
  req->resReq = (char *)SvPV(resreq, len);
  return 0;	
}

int 
set_sys(struct addRsvRequest *req, SV *sys)
{
  if (req->options & (RSV_OPTION_USER | RSV_OPTION_GROUP)) {
    SET_LSB_ERRMSG_TO("You must specify exactly one of the '-u', '-g' and '-s' options");
    return -1;
  }
  req->options |= RSV_OPTION_SYSTEM;
  req->name = "system";
  return 0;
}

int set_twin(struct addRsvRequest *req, SV *tw)
{
  STRLEN len;
  
  req->timeWindow = (char *)SvPV(tw, len);
  req->options |= RSV_OPTION_RECUR;

  return 0;	
}

int 
set_open(struct addRsvRequest *req, SV *val)
{ 
  req->options |= RSV_OPTION_OPEN;

  return 0;	
}

int 
format_rsvaddreq(struct addRsvRequest *req, HV *hv) 
{
  SV *val;
  I32 keylen;
  unsigned long len;
  char *key;
  HE* entry;
  int ret = -1;
  int size;

  size = hv_iterinit(hv);
#ifdef _AIX
  size++; /* Why the size is off by one on AIX who knows*/
#endif
  while(size--){
    char *flag;
    entry = hv_iternext(hv);
    key = hv_iterkey(entry, &keylen);
    val = hv_iterval(hv,entry);
    flag = key + 1;
    switch (*flag) {
      case 'n':
        if (set_range(req, val) < 0)
          goto END;
        break;
      case 'm':
        if (set_machines(req, val) < 0)
          goto END;
        break;
      case 'u':
        if (set_username(req, val) < 0)
          goto END;
        break;
      case 'g':
        if (set_groupname(req, val) < 0)
          goto END;
        break; 
      case 'R':
        if (set_rsvresreq(req, val) < 0)
          goto END;
        break;       
      case 's':
        if (set_sys(req, val) < 0)
          goto END;
        break; 
      case 't':
        if (set_twin(req, val) < 0)
          goto END;
        break;
      case 'o':
        if (set_open(req, val) < 0)
          goto END;
        break;
      case 'e':
      case 'b':
	    if (req->options & RSV_OPTION_RECUR) {
		  req->options &= ~RSV_OPTION_RECUR;
		}
	    break;
      default :
        SET_LSB_ERRMSG_TO( "invalid flag" );            
        goto END;
    }
  }
  if (!(req->options & RSV_OPTION_RESREQ)) {
      req->resReq = "";
  }
  ret = 0;
END:
  return ret;	
}

void
free_rsvaddreq(struct addRsvRequest *req)
{
  safefree(req->askedHosts);
  safefree(req);
}

void add_pair2submit_ext(struct submit_ext **, int , char *);
 
int format_jobinforeq(struct jobInfoReq * req, HV *hv, char * caller) {
 
     int    ret    = -1;
     int    size   = 0;
     HE   * entry  = NULL;
     char * key    = NULL;
     I32    keylen = 0;
     SV   * val    = NULL;
     char * flag   = NULL;
     STRLEN len    = 0;
     char * string = NULL;
     int    number = 0;
     int    jobid  = 0;
     int    jobid_arrindex = 0;
 
     if ( req == NULL || hv == NULL || caller == NULL) return -1;
 
     size = hv_iterinit(hv);
 #ifdef _AIX
     size++; /* Why the size is off by one on AIX who knows*/
 #endif
     while(size--){
         entry = hv_iternext(hv);
         key = hv_iterkey(entry, &keylen);
         val = hv_iterval(hv,entry);
         flag = key + 1;
         string = strdup((char *)SvPV(val, len));
         number = (int)SvIV(val);
         switch (*flag) {
             case 'a': req->app                = string; break;       
             case 'c': req->sourceClusterName  = string; break;       
             case 'd': req->jobDescription     = string; break;    
             case 'g': req->jobGroupName       = string; break;  
             case 'h': req->host               = string; break; 
             case 'i': jobid_arrindex          = number; break; 
             case 'j': jobid                   = number; break; 
             case 'l': req->licenseProjectName = string; break;
             case 'n': req->jobName            = string; break;
             case 'p': req->projectName        = string; break;
             case 'q': req->queue              = string; break;

/* LSF 10.1 or above*/
#if LSF_VERSION >= 34
             case 'r': req->reasonLevel        = number; break;
#endif
             case 's': req->serviceClassName   = string; break;
             case 'u': req->userName           = string; break;
             default : SET_LSB_ERRMSG_TO( "invalid flag" ); goto END;
         }
     }
 
     req->options  = COND_HOSTNAME | FROM_BJOBSCMD | PEND_JOB;

#if LSF_VERSION >= 34
     if ( strcmp(caller, "bjobs_psum") == 0) req->options2 = PEND_REASON_SUM; 
#endif
 
     if (jobid) {
         req->jobId = LSB_JOBID(jobid, jobid_arrindex);
         req->options |= ALL_JOB;
     }
 
 /*  add_pair2submit_ext(&req->submitExt, JDATA_EXT_AFFINITYINFO, ""); *//* no -aff  */
 /*  add_pair2submit_ext(&req->submitExt, JDATA_EXT_DATAINFO,     ""); *//* no -data */
 /*  add_pair2submit_ext(&req->submitExt, JDATA_EXT_EST_RESULTS,  ""); *//* no -o    */
 
     ret = 0;
 END:
     return ret;	
}
 
void freeSubmitExt(struct submit_ext **);
 
void free_jobinforeq(struct jobInfoReq * req) {
     
     if (req) {
         safefree(req->userName);
         safefree(req->jobName);
         safefree(req->queue);
         safefree(req->host);
         safefree(req->app);
         safefree(req->jobDescription);
         safefree(req->jobGroupName);
         safefree(req->projectName);
         safefree(req->licenseProjectName);
         safefree(req->serviceClassName);
         safefree(req->sourceClusterName);
 
         freeSubmitExt(&req->submitExt);
 
         safefree(req);
     }
}
 
char *rtrim(char *str) {
         char    *end;
         char    *trim = " \t\n\r";
 
         if (!str) return NULL;
 
         end = str + strlen(str);
 
         while (end-- > str) {
                 if (!strchr(trim, *end)) return str;
 
                 *end = 0;
         }
 
         return str;
}
 
char *ltrim(char *str) {
         char    *trim = " \t\n\r";
 
         if (!str) return NULL;
 
         while (*str) {
                 if (!strchr(trim, *str)) return str;
 
                 ++str;
         }
 
        return str;
} 
 
char *trim(char *str) {
         return ltrim(rtrim(str));
}
 
#if LSF_VERSION >= 34

/* -1 will be returned if the size is not enough for the content.*/
static int getstr_jobpendingsummary(
                       char * retstr, 
                         int   retstr_size, 
    struct jobPendingSummary * jobpendingsummary, 
                         int   reasonlevel) {
 
 #define UNORGANIZED_REASON            0
 #define SINGLE_REASON                 1
 #define CANDIDATE_REASON              2
 #define CATEGORIZED_REASON            3
 
     int ret = -1, cc = 0, sum = 0, left = retstr_size;
     
     int i=0, totalpendjobs=0;
     char* enterptr = NULL;
     char* format1 = "  %s: %d jobs\n";
     char* format1_1 = "  %s: %d job\n";
     char* format2 = "  %s: %d occurrences\n";
     char* format2_1 = "  %s: %d occurrence\n";
     char* clustername = NULL;
     clustername = ls_getclustername();
 
     for(i = 0; i<jobpendingsummary->nMainreasons; i++){
     	totalpendjobs += (jobpendingsummary->mainreasons[i]).pendjobsnum;
     	enterptr = strchr((jobpendingsummary->mainreasons[i]).reasonmsg, '\n');
     	if(enterptr)
     		*enterptr = '\0';
     	enterptr = strchr((jobpendingsummary->mainreasons[i]).reasonmsg, ';');
     	if(enterptr)
     		*enterptr = '\0';
     	trim((jobpendingsummary->mainreasons[i]).reasonmsg);
     }
     for(i = 0; i<jobpendingsummary->nHostreasons; i++){
         enterptr = strchr((jobpendingsummary->hostreasons[i]).reasonmsg, '\n');
         if(enterptr)
             *enterptr = '\0';
     	enterptr = strchr((jobpendingsummary->hostreasons[i]).reasonmsg, ';');
     	if(enterptr)
     		*enterptr = '\0';
         trim((jobpendingsummary->hostreasons[i]).reasonmsg);
     }
     cc = snprintf( retstr, left, "\nSummarizing %d pending jobs in cluster (%s): \n", 
                totalpendjobs, clustername);
 
     if ( cc < 0 || cc >= left) goto LABEL_OUT;
     left -= cc;
     sum += cc;
     
     i = 0;
 
     /* display main reasons */
     while(i<jobpendingsummary->nMainreasons){
     	if((jobpendingsummary->mainreasons[i]).pendjobsnum > 0){
     	   if((jobpendingsummary->mainreasons[i]).pendjobsnum == 1){
                cc = snprintf(retstr + sum, left, format1_1,
                        (jobpendingsummary->mainreasons[i]).reasonmsg, 
                        (jobpendingsummary->mainreasons[i]).pendjobsnum);
                if ( cc < 0 || cc >= left) goto LABEL_OUT;
                left -= cc;
                sum += cc;
            }
            else{
                cc = snprintf(retstr + sum, left, format1,
                         (jobpendingsummary->mainreasons[i]).reasonmsg, 
                         (jobpendingsummary->mainreasons[i]).pendjobsnum);
                if ( cc < 0 || cc >= left) goto LABEL_OUT;
                left -= cc;
                sum += cc;
            }
     	}
     	i++;
     }
 
     /* display host based reasons */
     if(jobpendingsummary->nHostreasons > 0){
     	i=0;
         cc = snprintf(retstr + sum, left, "\nIndividual host based reasons:\n");
         if ( cc < 0 || cc >= left) goto LABEL_OUT;
         left -= cc;
         sum += cc;
         if((reasonlevel != CANDIDATE_REASON)&&(reasonlevel != CATEGORIZED_REASON)){
             while(i<jobpendingsummary->nHostreasons){
                 if((jobpendingsummary->hostreasons[i]).occurrence > 0){
                     if((jobpendingsummary->hostreasons[i]).occurrence == 1){
                         cc = snprintf(retstr + sum, left, format2_1,
                                 (jobpendingsummary->hostreasons[i]).reasonmsg,
                                 (jobpendingsummary->hostreasons[i]).occurrence);
                         if ( cc < 0 || cc >= left) goto LABEL_OUT;
                         left -= cc;
                         sum += cc;
                     }
                     else{
                         cc = snprintf(retstr + sum, left, format2,
                                 (jobpendingsummary->hostreasons[i]).reasonmsg,
                                 (jobpendingsummary->hostreasons[i]).occurrence);
                         if ( cc < 0 || cc >= left) goto LABEL_OUT;
                         left -= cc;
                         sum += cc;
                     }
                 }
                 i++;
             }
         }
     }
 
     /* display candidate host based reasons for (-p2, -p3)*/
     if((reasonlevel == CANDIDATE_REASON)||(reasonlevel == CATEGORIZED_REASON)){
         if(jobpendingsummary->nCandidaterns > 0){
             i=0;
             cc = snprintf(retstr + sum, left, " Candidate host pending reasons:\n");
             if ( cc < 0 || cc >= left) goto LABEL_OUT;
             left -= cc;
             sum += cc;
             while(i<jobpendingsummary->nCandidaterns){
                 if((jobpendingsummary->hostreasons[i]).occurrence > 0){
                     if((jobpendingsummary->hostreasons[i]).occurrence == 1){
                         cc = snprintf(retstr + sum, left, format2_1,
                                 (jobpendingsummary->candidaterns[i]).reasonmsg,
                                 (jobpendingsummary->candidaterns[i]).occurrence);
                         if ( cc < 0 || cc >= left) goto LABEL_OUT;
                         left -= cc;
                         sum += cc;
                     }
                     else{
                         cc = snprintf(retstr + sum, left, format2,
                                 (jobpendingsummary->candidaterns[i]).reasonmsg,
                                 (jobpendingsummary->candidaterns[i]).occurrence);
                         if ( cc < 0 || cc >= left) goto LABEL_OUT;
                         left -= cc;
                         sum += cc;
                     }
                 }
                 i++;
             }
         }
     }
 
 	/* display non-candidate host based reasons for (-p3) */
     if(reasonlevel == CATEGORIZED_REASON){
         if(jobpendingsummary->nNoncandidaterns > 0){
             i=0;
             cc = snprintf(retstr + sum, left, "\n Non-candidate host pending reasons:\n");
             if ( cc < 0 || cc >= left) goto LABEL_OUT;
             left -= cc;
             sum += cc;
             while(i<jobpendingsummary->nNoncandidaterns){
                 if((jobpendingsummary->noncandidaterns[i]).occurrence > 0){
                    if((jobpendingsummary->noncandidaterns[i]).occurrence == 1){
                      cc = snprintf(retstr + sum, left, format2_1,
                              (jobpendingsummary->noncandidaterns[i]).reasonmsg,
                              (jobpendingsummary->noncandidaterns[i]).occurrence);
                      if ( cc < 0 || cc >= left) goto LABEL_OUT;
                      left -= cc;
                      sum += cc;
                    }
                    else{
                      cc = snprintf(retstr + sum, left, format2,
                              (jobpendingsummary->noncandidaterns[i]).reasonmsg,
                              (jobpendingsummary->noncandidaterns[i]).occurrence);
                      if ( cc < 0 || cc >= left) goto LABEL_OUT;
                      left -= cc;
                      sum += cc;
                    }
                 }
                 i++;
             }
         }
     }
 
     ret = 0;
 
LABEL_OUT:
 
     return ret;
}

#endif
 
int                                                                               
set_fileName(char* key, SV* value, char **fileName){ 
  STRLEN len;                                                                     
  *fileName = (char*)SvPV(value, len);                                            
  return 0;                                                                       
}    

int
set_desc(struct jobExternalMsgReq *s, char* key, SV* value){
  STRLEN len;
  s->desc = (char*)SvPV(value, len);
  return 0;
}

int
set_jobName(struct jobExternalMsgReq *s, char* key, SV* value){
  STRLEN len;
  s->jobName = (char*)SvPV(value, len);
  return 0;
}

int
set_msgIdx(struct jobExternalMsgReq *s, char* key, SV* value){
  s->msgIdx = (int)SvIV(value);
  return 0;
}                                                                             

void 
initialize_jobExternalMsgReq(struct jobExternalMsgReq *s){ 
  bzero(s,sizeof(struct jobExternalMsgReq));                    
}                                                               
 
int format_jobExternalMsgReq(struct jobExternalMsgReq *s, HV* req, char **fileName){
  int size;
  I32 keylen;
  unsigned long len;
  char *key;
  HE* entry;
  SV* value;
  int err = 0;

  size = hv_iterinit(req);
#ifdef _AIX
  size++; /* Why the size is off by one on AIX who knows*/
#endif
  while(size--){
    char *flag;
    entry = hv_iternext(req);
    key = hv_iterkey(entry, &keylen);
    value = hv_iterval(req,entry);
    flag = key + 1;
    /*printf("format: got flag %s\n",key);*/
    switch( *flag ){
      case 'a':
      /*fileName*/
        err = set_fileName(key, value, fileName);
        break;
      case 'd':
      /*description*/
        err = set_desc(s,key,value);
        break;
      case 'J':
      /*jobname*/
        err = set_jobName (s,key,value);
        break;
      case 'i':
      /*msgIdx*/
        err = set_msgIdx (s,key,value);
        break;
      default:
        break;
    }
    if(err==-1){
      return -1;
    }
  }
  return 0;
}

int 
readfile(int s, char *fileName, int fileSize)
{
  int fd;
  char buf[4096];
  int rSize;
  int len, ret = -1;

  bzero(buf, sizeof(buf));
  if ((fd = open(fileName, O_CREAT | O_RDWR | O_TRUNC, 0600)) <0){
    return -1;
  }
  
  rSize = fileSize;
  while (rSize > 0) {
    if ((len = read(s, buf, sizeof(buf))) < 0) {
      goto END;
    }
    if((ret = write(fd, buf, len)) < 0) {
      goto END;
    }
    rSize = rSize - len;
    bzero(buf, sizeof(buf));
  }
  ret = 0;
END:
  close(fd);
  return ret;
}

int 
format_rjmreq(struct jobExternalMsgReq *req, HV *hv, char **fileName) 
{ 
  char *key;
  I32 klen;
  SV *val;
  int ret = -1;
  STRLEN len;
  
  (void)hv_iterinit(hv);
  while ((val = hv_iternextsv(hv, (char **)&key, &klen))) {
    switch (key[1]) {
      case 'i':
      	req->msgIdx = atoi((char*)SvPV(val, len));
      	break;
      case 'a':
      	if (val != NULL)
           req->options |= EXT_ATTA_READ;
	   *fileName = (char*)SvPV(val, len);
      	break;
      case 'J':
        if (val != NULL)
          req->jobName = (char*)SvPV(val, len);
        break;
      default :
        SET_LSB_ERRMSG_TO( "invalid flag" );            
        goto END;
    }
  }
  req->options |= EXT_MSG_READ;
  ret = 0;
END:
  return ret;
}

int
free_rjmreq(struct jobExternalMsgReq *req)
{
    safefree(req);
    return 0;
}

typedef struct jobInfoHead LSF_Batch_jobInfoHead;
typedef struct jobInfoHeadExt LSF_Batch_jobInfoHeadExt;
typedef struct myjob LSF_Batch_job;
typedef struct submit LSF_Batch_submit;
typedef struct jobInfoEnt LSF_Batch_jobInfo;
typedef struct jRusage LSF_Batch_jRusage;
typedef struct hostInfoEnt LSF_Batch_hostInfo;
typedef struct userInfoEnt LSF_Batch_userInfo;
typedef LSB_SHARED_RESOURCE_INFO_T LSF_Batch_sharedResourceInfo;
typedef LSB_SHARED_RESOURCE_INST_T LSF_Batch_sharedResourceInstance;
typedef struct shareAcctInfoEnt LSF_Batch_shareAcctInfo;
typedef struct queueInfoEnt LSF_Batch_queueInfo;
typedef struct parameterInfo LSF_Batch_parameterInfo;
typedef struct hostPartInfoEnt LSF_Batch_hostPartInfo;
typedef struct hostPartUserInfo LSF_Batch_hostPartUserInfo;
typedef struct jobExternalMsgReq LSF_Batch_jobExternalMsgReq;
typedef struct jobExternalMsgReply LSF_Batch_jobExternalMsgReply;
typedef struct jobExternalMsgLog LSF_Batch_jobExternalMsgLog;
/* typedefs for LSF Event logging */
typedef struct eventRec  LSF_Batch_eventRec ;
typedef struct logSwitchLog LSF_Batch_logSwitchLog;
typedef struct jgrpNewLog LSF_Batch_jgrpNewLog;
typedef struct jgrpCtrlLog LSF_Batch_jgrpCtrlLog;
typedef struct jgrpStatusLog LSF_Batch_jgrpStatusLog;
typedef struct jobNewLog LSF_Batch_jobNewLog;
typedef struct jobModLog LSF_Batch_jobModLog;
typedef struct jobStartLog LSF_Batch_jobStartLog;
typedef struct jobStartAcceptLog LSF_Batch_jobStartAcceptLog;
typedef struct jobExecuteLog LSF_Batch_jobExecuteLog;
typedef struct jobStatusLog LSF_Batch_jobStatusLog;
typedef struct sbdJobStatusLog LSF_Batch_sbdJobStatusLog;
typedef struct sbdUnreportedStatusLog LSF_Batch_sbdUnreportedStatusLog;
typedef struct jobSwitchLog LSF_Batch_jobSwitchLog;
typedef struct jobMoveLog LSF_Batch_jobMoveLog;
typedef struct chkpntLog LSF_Batch_chkpntLog;
typedef struct jobRequeueLog LSF_Batch_jobRequeueLog;
typedef struct jobCleanLog LSF_Batch_jobCleanLog;
typedef struct jobExceptionLog LSF_Batch_jobExceptionLog;
typedef struct sigactLog LSF_Batch_sigactLog;
typedef struct migLog LSF_Batch_migLog;
typedef struct signalLog LSF_Batch_signalLog;
typedef struct queueCtrlLog LSF_Batch_queueCtrlLog;
typedef struct newDebugLog LSF_Batch_newDebugLog;
typedef struct hostCtrlLog LSF_Batch_hostCtrlLog;
typedef struct mbdStartLog LSF_Batch_mbdStartLog;
typedef struct mbdDieLog LSF_Batch_mbdDieLog;
typedef struct unfulfillLog LSF_Batch_unfulfillLog;
typedef struct jobFinishLog LSF_Batch_jobFinishLog;
typedef struct loadIndexLog LSF_Batch_loadIndexLog;
typedef struct calendarLog LSF_Batch_calendarLog;
typedef struct jobForwardLog LSF_Batch_jobForwardLog;
typedef struct jobAcceptLog LSF_Batch_jobAcceptLog;
typedef struct statusAckLog LSF_Batch_statusAckLog;
typedef struct jobMsgLog LSF_Batch_jobMsgLog;
typedef struct jobMsgAckLog LSF_Batch_jobMsgAckLog;
typedef struct jobOccupyReqLog LSF_Batch_jobOccupyReqLog;
typedef struct jobVacatedLog LSF_Batch_jobVacatedLog;
typedef struct jobForceRequestLog LSF_Batch_jobForceRequestLog;
typedef struct jobChunkLog LSF_Batch_jobChunkLog;
typedef struct jobAttrSetLog LSF_Batch_jobAttrSetLog;
typedef struct rsvFinishLog  LSF_Batch_rsvFinishLog;
typedef struct hgCtrlLog  LSF_Batch_hgCtrlLog;
typedef struct cpuProfileLog LSF_Batch_cpuProfileLog;
typedef struct dataLoggingLog LSF_Batch_dataLoggingLog;
typedef struct jobRunRusageLog LSF_Batch_jobRunRusageLog;
typedef struct eventEOSLog LSF_Batch_eventEOSLog;
typedef struct slaLog LSF_Batch_slaLog;
typedef struct perfmonLog LSF_Batch_perfmonLog;
typedef struct xFile LSF_Batch_xFile;
typedef struct lsfRusage LSF_Batch_lsfRusage;
typedef struct rsvRes LSF_Batch_rsvRes;
typedef struct apsFactorInfo LSF_Batch_apsFactorInfo;
typedef struct apsFactorMap LSF_Batch_apsFactorMap;
typedef struct apsLongNameMap LSF_Batch_apsLongNameMap;
typedef struct rsvInfoEnt LSF_Batch_rsvInfoEnt;
typedef struct hostRsvInfoEnt LSF_Batch_hostRsvInfoEnt;
typedef struct pidInfo LSF_Batch_pidInfo;
typedef struct jobResizeReleaseLog LSF_Batch_jobResizeReleaseLog;
typedef struct jobResizeCancelLog  LSF_Batch_jobResizeCancelLog;


MODULE = LSF::Batch PACKAGE = LSF::Batch::xFilePtr PREFIX = xf_

char *
xf_subFn(self)
	LSF_Batch_xFile *self
    CODE:
	RETVAL = self->subFn;
    OUTPUT:
	RETVAL

char *
xf_execFn(self)
	LSF_Batch_xFile *self
    CODE:
	RETVAL = self->execFn;
    OUTPUT:
	RETVAL

int
xf_options(self)
	LSF_Batch_xFile *self
    CODE:
	RETVAL = self->options;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch		PACKAGE = LSF::Batch		PREFIX = lsb_

PROTOTYPES:DISABLE

double
constant(name,arg)
	char *		name
	int		arg

void
lsb_perror(self, usrMsg)
	void *self
	char *usrMsg
    CODE:
	lsb_perror(usrMsg);

char *
lsb_sysmsg(self)
	void *self
    CODE:
	RETVAL = lsb_sysmsg();
    OUTPUT:
	RETVAL

int
lsb_init(self, appname)
        void *self
	char *appname
    PREINIT:
	int err;
    CODE:
	err = lsb_init(appname);
	RETVAL = (err == 0) ? 1:0;
 	if( !RETVAL ){
          STATUS_NATIVE_SET(lsberrno);
	  SET_LSB_ERRMSG;
	}
    OUTPUT:
	RETVAL

int
lsb_reconfig(self, option)
	void *self
        int option
   PREINIT:
        struct mbdCtrlReq *req;   
   CODE:
        req = (struct mbdCtrlReq *)safemalloc(sizeof(struct mbdCtrlReq));
	req->name = "";
	req->message = "";
	if(req->name == NULL || req->message == NULL) {
	   RETVAL = 0;
	}
	req->opCode = option;
        if(lsb_reconfig(req) < 0)
        {
            STATUS_NATIVE_SET(lsberrno);
	          SET_LSB_ERRMSG;
            RETVAL = 0;
        }
        else
        {
            RETVAL = 1;
        }
        safefree(req);
   OUTPUT:
	RETVAL

char *
do_rsvadd(sub)
	HV *sub
    PREINIT:
        struct addRsvRequest *req;
        int ret;
        char *rsvid = NULL;
    CODE:
        req = (struct addRsvRequest*)safemalloc(sizeof(struct addRsvRequest));
        bzero(req, sizeof(struct addRsvRequest));
        req->PKVPs = (PKVP*)safemalloc(sizeof(PKVP));
        req->PKVPs->num_params = 0;
        rsvid = (char *)safemalloc(MAXLSFNAMELEN * 2 * sizeof(char));
        if (format_rsvaddreq(req, sub) < 0) {
            free_rsvaddreq(req);
            safefree(rsvid);
            SET_LSB_ERRMSG;
            XSRETURN_EMPTY;	
        }
        if (lsb_addreservation(req, rsvid) < 0) {
            free_rsvaddreq(req);
            safefree(rsvid);
            STATUS_NATIVE_SET(lsberrno);
            SET_LSB_ERRMSG;
            XSRETURN_EMPTY;	
        }
        free_rsvaddreq(req);
        RETVAL = rsvid;
	OUTPUT:
	RETVAL

LSF_Batch_job *
do_submit(sub)
        HV*  sub;
    PREINIT:
        SV *rv;
        struct submit *s;
        struct submitReply reply;
        LSF_Batch_job *j;
        LS_LONG_INT jobId;
    CODE:
        s = (struct submit *)safemalloc(sizeof(struct submit));
        j = (LSF_Batch_job *)safemalloc(sizeof(LSF_Batch_job));
        initialize_submit(s);
        memset(&reply, 0, sizeof(reply));
       if( format_submit(s, sub) == 0 ){
          jobId = lsb_submit( s, &reply);
          j->jobId = LSB_ARRAY_JOBID(jobId);
          j->arrayIdx = LSB_ARRAY_IDX(jobId);
          if(jobId != -1){
	    strncpy(j->queue, reply.queue, MAX_LSB_NAME_LEN);
          }
          else{
	    j->badJobId = reply.badJobId;
            j->badReqIndx = reply.badReqIndx;
            if (reply.badJobName) strncpy(j->badJobName, reply.badJobName, MAX_LSB_NAME_LEN);
            STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
          }
        }
        else{
	  j->jobId = -1;
        }
	free_submit(s);
        RETVAL = j;
    OUTPUT:
        RETVAL 

#if LSF_VERSION >= 25 
		
int
lsb_addmember(self, ob_type, identity, key_value, comments)
	void *self
	char *ob_type
	char *identity
	char *key_value 
	char *comments
   PREINIT:
	LiveConfReq liveReq;
        char * retErrMsg = NULL;
        int ret = 0, i = 0, j = 0;
	memset(&liveReq, 0, sizeof(LiveConfReq));
   CODE:
	/*Firstly, deal with all parameters*/
	if ( strcmp(ob_type, "usergroup") == 0) {liveReq.object_type =  LiC_OBJECT_USERGROUP;}
	else if ( strcmp(ob_type, "hostgroup") == 0) {liveReq.object_type =  LiC_OBJECT_HOSTGROUP;}
	else if ( strcmp(ob_type, "queue") == 0) {liveReq.object_type =  LiC_OBJECT_QUEUE;}
	else if ( strcmp(ob_type, "limit") == 0) {liveReq.object_type =  LiC_OBJECT_LIMIT;}
	else if ( strcmp(ob_type, "gpool") == 0) {liveReq.object_type =  LiC_OBJECT_GUARPOOL;}
	else if ( strcmp(ob_type, "user") == 0) {liveReq.object_type =  LiC_OBJECT_USER;}
	else if ( strcmp(ob_type, "host") == 0) {liveReq.object_type =  LiC_OBJECT_HOST;}
	else if ( strcmp(ob_type, "application") == 0) {liveReq.object_type =  LiC_OBJECT_APPLICATION;}
	else { 
	    char e[100];
	    sprintf(e, "Unknown object type or type can't be matched");
	    SET_LSB_ERRMSG_TO(e);
	    return -1;
	}
        liveReq.actions = LiC_ACTION_ADDMEMBER;
	liveReq.identity = identity;
        i = 0, j = 0;
	liveReq.key_value = (char *)calloc(strlen(key_value) + 1, sizeof(char));
        while (key_value[i] != 0) {
            if (isspace(key_value[i])){
                if (j != 0 && !isspace(liveReq.key_value[j-1])) {
                    liveReq.key_value[j++] = ' ';/*reserve only one space if it has several consecutive spaces */
                }
            } else {
                liveReq.key_value[j++] = key_value[i];
            }
            i++;
        }
        liveReq.key_value[j] = 0;
	liveReq.comments = comments;
        liveReq.seq = 0;
	/*send live configuration request to master*/
	ret = lsb_liveconfig(&liveReq, &retErrMsg);
        if (ret != 0){
            char e[MSGSIZE];
	    STATUS_NATIVE_SET(lsberrno);
	    if (lsberrno == LSBE_LIVECONF_MBD_RETERR) {
            	sprintf(e, "6021, %s: Request for %s <%s> partially succeeded \nErrors: %s\n", "addmember", ob_type, liveReq.identity, retErrMsg);
	    } 
#if LSF_VERSION >= 26
	    else if (lsberrno == LSBE_MBD_IN_RESTART) {
		sprintf(e, "6034, %s\n", "mbatchd is restarting. Try again later.");
	    }
#endif
	    else {
		sprintf(e, "6022, %s: Request for %s <%s> rejected\n", "addmember", ob_type, liveReq.identity); 
		if (lsberrno == LSBE_LIVECONF_MBD_REJECT) {
		    sprintf(e, "6023, Errors: %s\n", retErrMsg); 
		} else {
		    sprintf(e, "Errors: %s\n", lsb_sysmsg()); 
		}
            }
	    SET_LSB_ERRMSG_TO(e);
        }
        RETVAL = ret;
   OUTPUT:
	RETVAL

int
lsb_rmmember(self, ob_type, identity, key_value, comments)
	void *self
        char *ob_type
        char *identity
        char *key_value
        char *comments
   PREINIT:
        LiveConfReq liveReq;
        char * retErrMsg = NULL;
        int ret = 0, i = 0, j = 0;
        memset(&liveReq, 0, sizeof(LiveConfReq));
   CODE:
        /*Firstly, deal with all parameters*/
	if (strcmp(ob_type, "usergroup") == 0) {liveReq.object_type =  LiC_OBJECT_USERGROUP;}
        else if (strcmp(ob_type, "hostgroup") == 0) {liveReq.object_type =  LiC_OBJECT_HOSTGROUP;}
        else if (strcmp(ob_type, "queue") == 0) {liveReq.object_type =  LiC_OBJECT_QUEUE;}
        else if (strcmp(ob_type, "limit") == 0) {liveReq.object_type =  LiC_OBJECT_LIMIT;}
        else if (strcmp(ob_type, "gpool") == 0) {liveReq.object_type =  LiC_OBJECT_GUARPOOL;}
        else if ( strcmp(ob_type, "user") == 0) {liveReq.object_type =  LiC_OBJECT_USER;}
        else if ( strcmp(ob_type, "host") == 0) {liveReq.object_type =  LiC_OBJECT_HOST;}
        else if ( strcmp(ob_type, "application") == 0) {liveReq.object_type =  LiC_OBJECT_APPLICATION;}
	else {
            char e[100];
            sprintf(e, "Unknown object type or type can't be matched");
            SET_LSB_ERRMSG_TO(e);
        }
        liveReq.actions = LiC_ACTION_RMMEMBER;
        liveReq.identity = identity; 
	i = 0, j = 0;
	liveReq.key_value = (char *)calloc(strlen(key_value) + 1, sizeof(char));
        while (key_value[i] != 0) {
            if (isspace(key_value[i])){
                if (j != 0 && !isspace(liveReq.key_value[j-1])) {
                    liveReq.key_value[j++] = ' ';/*reserve only one space if it has several consecutive spaces */
                }
            } else {
                liveReq.key_value[j++] = key_value[i];
            }
            i++;
        }
        liveReq.key_value[j] = 0;
	liveReq.comments = comments;
        liveReq.seq = 0;
	/*send live configuration request to master*/
        ret = lsb_liveconfig(&liveReq, &retErrMsg);
        if (ret != 0){
            char e[MSGSIZE];
            STATUS_NATIVE_SET(lsberrno);
            if (lsberrno == LSBE_LIVECONF_MBD_RETERR) {
                sprintf(e, "6021, %s: Request for %s <%s> partially succeeded \nErrors: %s\n", "rmmember", ob_type, liveReq.identity, retErrMsg);
            }
#if LSF_VERSION >= 26
	    else if (lsberrno == LSBE_MBD_IN_RESTART) {
                sprintf(e, "6034, %s\n", "mbatchd is restarting. Try again later.");
            }
#endif
	    else {
                sprintf(e, "6022, %s: Request for %s <%s> rejected\n", "rmmember", ob_type, liveReq.identity);
                if (lsberrno == LSBE_LIVECONF_MBD_REJECT) {
                    sprintf(e, "6023, Errors: %s\n", retErrMsg);
                } else {
                    sprintf(e, "Errors: %s\n", lsb_sysmsg());
                }
            }
            SET_LSB_ERRMSG_TO(e);
        }
        RETVAL = ret;
   OUTPUT:
	RETVAL

#endif
	
int
lsb_hostcontrol(self, host, opcode)
	void *self
	char *host
	int opcode;
   PREINIT:
        struct hostCtrlReq *req;
   CODE:
	req = (struct hostCtrlReq *)safemalloc(sizeof(struct hostCtrlReq));
	bzero(req,sizeof(struct hostCtrlReq));
	req->host = host;
	req->opCode = opcode;
	if( lsb_hostcontrol(req) < 0 ){
	    STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
	    RETVAL = 0;
        }
	else{
	  RETVAL = 1;
	}
	safefree(req);
    OUTPUT:
	RETVAL

void
lsb_hostinfo(self, hosts)
	void *self
	char **hosts
    PREINIT:
	SV *rv;
	char **h;
	int i, count = 0, num = 0;
	LSF_Batch_hostInfo *p, *hinfo;
    PPCODE:
	for( h = hosts; hosts && *h; h++ )count++;
	num = count;
	if( count == 0 ) hosts = NULL;
	hinfo = lsb_hostinfo(hosts, &num);
	if(hinfo == NULL){
	    STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
	    XSRETURN_EMPTY;
 	}
	for( i = 0, p = hinfo; i < num; i++,p++ ){
	    if(NULL == p){
	        continue;
	    }

	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::hostInfoPtr",(IV)p);
	    XPUSHs(sv_2mortal(rv));
	}
	XSRETURN(num);
	
void
lsb_hostinfo_ex(self, hosts, resreq, options)
	void *self
	char **hosts
	char *resreq
	int options
    PREINIT:
	SV *rv;
	char **h;
	int i, count = 0, num;
	LSF_Batch_hostInfo *p, *hinfo;
    PPCODE:
	for( h = hosts; hosts && *h; h++ )count++;
	num = count;
	if( count == 0 ) hosts = NULL;
        if(strlen(resreq)==0) resreq = NULL;
	hinfo = lsb_hostinfo_ex(hosts, &num, resreq, options);
	if(hinfo == NULL){
	    STATUS_NATIVE_SET(lsberrno);
    SET_LSB_ERRMSG;
	    XSRETURN_EMPTY;
 	}
	for( i = 0, p = hinfo; i < num; i++,p++ ){
	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::hostInfoPtr",(IV)p);
	    XPUSHs(sv_2mortal(rv));
	}
	XSRETURN(num);
	
void
lsb_gethostlist(self)
        void *self
    PREINIT:
        int ret;
        int nhosts = 0;
        char **p = NULL;
        char **hosts = NULL;
    PPCODE:
        ret = lsb_getalloc(&hosts);
        if (ret < 0) {
            STATUS_NATIVE_SET(lsberrno);
            SET_LSB_ERRMSG;
            XSRETURN_EMPTY;	
        } else {
	    for(p = hosts; *p != NULL; p ++ ){
            nhosts ++;
	        XPUSHs(sv_2mortal(newSVpv(*p,0)));
            }	
        }
        XSRETURN(nhosts);

int
do_launch(where, argv, userOptions)
	char **where
	char **argv
	int userOptions
    PREINIT:
        int count = 0;
        char **p;
    CODE:
        for (p = where; where && *p != NULL; p ++) count ++;
        if (count == 0) where =NULL;
        
        for (p = argv; argv && *p != NULL; p ++) count ++;
        if (count == 0) argv =NULL;
        if ((RETVAL = lsb_launch(where, argv, userOptions, NULL)) < 0) {
	        STATUS_NATIVE_SET(lsberrno);
	        SET_LSB_ERRMSG;
            RETVAL = 0;
        }
    OUTPUT:
	RETVAL

int
lsb_removereservation (self, rvsid)
	void * self
	char * rvsid
    CODE:
    	if(lsb_removereservation(rvsid) <0) {
    	    STATUS_NATIVE_SET(lsberrno);
            SET_LSB_ERRMSG;
            RETVAL = 0;
        } else {
	    RETVAL = 1;
	}
    OUTPUT:
	RETVAL

void
lsb_reservationinfo (self, rvsid)
	void * self
	char * rvsid
    PREINIT:
    	struct rsvInfoEnt *res;
    	int num;
    	int j;
    	SV *rv;
	LSF_Batch_rsvInfoEnt *p;
    PPCODE:
    	if (strlen(rvsid) == 0) rvsid = NULL;
    	res = lsb_reservationinfo(rvsid, &num, 0);
    	
    	if (lsberrno != LSBE_NO_ERROR) {
    	    STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
	    XSRETURN_EMPTY;	
    	}
        if (num == 0) {
            XPUSHs(sv_2mortal(newSVnv(0)));
            XSRETURN(1);
        }	
    	for (j = 0, p = res; j < num; j ++, p ++) {
    	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::rsvInfoEntPtr", (IV)p);
	     XPUSHs(sv_2mortal(rv));   	
    	}
    	XSRETURN(num);

MODULE = LSF::Batch	PACKAGE = LSF::Batch::rsvInfoEntPtr PREFIX = rie_

char *
rie_options(self)
	LSF_Batch_rsvInfoEnt *self
    CODE:
	if (self->options & RSV_OPTION_SYSTEM) {
	    RETVAL = "sys";
	} else if(self->options & RSV_OPTION_GROUP) {
	    RETVAL = "group";
	} else if(self->options & RSV_OPTION_USER) {
	    RETVAL = "user";
	} else {
	    RETVAL = "-";
	}
    OUTPUT:
	RETVAL

char *
rie_name(self)
	LSF_Batch_rsvInfoEnt *self
    CODE:
	RETVAL = self->name;
    OUTPUT:
	RETVAL

char *
rie_rsvId(self)
	LSF_Batch_rsvInfoEnt *self
    CODE:
	RETVAL = self->rsvId;
    OUTPUT:
	RETVAL
	
char *
rie_timeWindow(self)
	LSF_Batch_rsvInfoEnt *self
    CODE:
	RETVAL = self->timeWindow;
    OUTPUT:
	RETVAL

int
rie_numRsvHosts(self)
        LSF_Batch_rsvInfoEnt *self
    CODE:
        RETVAL = self->numRsvHosts;
    OUTPUT:
        RETVAL
	
void
rie_rsvHosts(self)
	LSF_Batch_rsvInfoEnt *self
    PREINIT:
	int i;
	SV *rv;
    PPCODE:
	for (i = 0; i < self->numRsvHosts; i ++) {
	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::hostRsvInfoEntPtr", (IV)(self->rsvHosts+i));
	    XPUSHs(sv_2mortal(rv));
	}
    	XSRETURN(self->numRsvHosts);

int
rie_numRsvJobs(self)
        LSF_Batch_rsvInfoEnt *self
    CODE:
        RETVAL = self->numRsvJobs;
    OUTPUT:
        RETVAL

void
rie_jobIds(self)
	LSF_Batch_rsvInfoEnt *self
    PREINIT:
	int i;
        char jobIdStr[256];
    PPCODE:
	for (i = 0; i < self->numRsvJobs; i ++) {
            lsb_jobid2str_r(self->jobIds[i], jobIdStr);
            XPUSHs(sv_2mortal(newSVpv(jobIdStr, 0)));
	}
	XSRETURN(self->numRsvJobs);

void
rie_jobStatus(self)
	LSF_Batch_rsvInfoEnt *self
    PREINIT:
	int i;
    PPCODE:
	for (i = 0; i < self->numRsvJobs; i ++) {
	    XPUSHs(sv_2mortal(newSViv(self->jobStatus[i])));
	}
	XSRETURN(self->numRsvJobs);

char *
rie_desc(self)
        LSF_Batch_rsvInfoEnt *self
    CODE:
        RETVAL = self->desc;
    OUTPUT:
        RETVAL

void
rie_disabledDurations(self)
        LSF_Batch_rsvInfoEnt *self
    PREINIT:
       int i;
    PPCODE:
        for (i = 0; self->disabledDurations[i]; i++) {
            XPUSHs(sv_2mortal(newSVpv(self->disabledDurations[i], 0)));
        }
        XSRETURN(i);

int
rie_state(self)
        LSF_Batch_rsvInfoEnt *self
    CODE:
        RETVAL = self->state;
    OUTPUT:
        RETVAL

char *
rie_nextInstance(self)
        LSF_Batch_rsvInfoEnt *self
    CODE:
        RETVAL = self->nextInstance;
    OUTPUT:
        RETVAL

char *
rie_creator(self)
        LSF_Batch_rsvInfoEnt *self
    CODE:
        RETVAL = self->creator;
    OUTPUT:
        RETVAL

#if LSF_PRODUCT_MAJOR_VERSION    >= 9 && \
    LSF_PRODUCT_MINOR_VERSION    >= 1 && \
    LSF_PRODUCT_MAINTAIN_VERSION >= 3

char *
rie_rsvUnit(self)
        LSF_Batch_rsvInfoEnt *self
    CODE:
        RETVAL = self->rsvUnit;
    OUTPUT:
        RETVAL

#endif

MODULE = LSF::Batch	PACKAGE = LSF::Batch::hostRsvInfoEntPtr PREFIX = hrie_

char *
hrie_host(self)
	LSF_Batch_hostRsvInfoEnt *self
    CODE:
	RETVAL = self->host;
    OUTPUT:
	RETVAL

int
hrie_numCPUs(self)
	LSF_Batch_hostRsvInfoEnt *self
    CODE:
	RETVAL = self->numCPUs;
    OUTPUT:
	RETVAL

int
hrie_numSlots(self)
	LSF_Batch_hostRsvInfoEnt *self
    CODE:
	RETVAL = self->numSlots;
    OUTPUT:
	RETVAL

int
hrie_numRsvProcs(self)
	LSF_Batch_hostRsvInfoEnt *self
    CODE:
	RETVAL = self->numRsvProcs;
    OUTPUT:
	RETVAL

int
hrie_numUsedProcs(self)
	LSF_Batch_hostRsvInfoEnt *self
    CODE:
	RETVAL = self->numUsedProcs;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch	PACKAGE = LSF::Batch::hostInfoPtr	PREFIX = hi_

char *
hi_host(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->host;
    OUTPUT:
	RETVAL

int
hi_hStatus(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->hStatus;
    OUTPUT:
	RETVAL

void
hi_busySched(self)
	LSF_Batch_hostInfo *self;
    PREINIT:
        int i;
    PPCODE:
  	for( i = 0; i < self->nIdx; i++)
          XPUSHs(sv_2mortal(newSVnv(self->busySched[i])));	
	XSRETURN(self->nIdx);

void
hi_busyStop(self)
	LSF_Batch_hostInfo *self;
    PREINIT:
	int i;
    PPCODE:
  	for( i = 0; i < self->nIdx; i++)
          XPUSHs(sv_2mortal(newSVnv(self->busyStop[i])));	
	XSRETURN(self->nIdx);
	
void
hi_load(self)
	LSF_Batch_hostInfo *self;
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->nIdx; i++)
          XPUSHs(sv_2mortal(newSVnv(self->load[i])));	
	XSRETURN(self->nIdx);

void
hi_loadSched(self)
	LSF_Batch_hostInfo *self;
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->nIdx; i++)
          XPUSHs(sv_2mortal(newSVnv(self->loadSched[i])));	
	XSRETURN(self->nIdx);

void
hi_loadStop(self)
	LSF_Batch_hostInfo *self;
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->nIdx; i++)
          XPUSHs(sv_2mortal(newSVnv(self->loadStop[i])));
	XSRETURN(self->nIdx);

char *
hi_windows(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->windows;
    OUTPUT:
	RETVAL

int
hi_userJobLimit(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->userJobLimit;
    OUTPUT:
	RETVAL

int
hi_maxJobs(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->maxJobs;
    OUTPUT:
	RETVAL

int
hi_numJobs(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->numJobs;
    OUTPUT:
	RETVAL

int
hi_numRUN(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->numRUN;
    OUTPUT:
	RETVAL

int
hi_numSSUSP(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->numSSUSP;
    OUTPUT:
	RETVAL

int
hi_numUSUSP(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->numUSUSP;
    OUTPUT:
	RETVAL

int
hi_numRESERVE(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->numRESERVE;
    OUTPUT:
	RETVAL

int
hi_mig(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->mig;
    OUTPUT:
	RETVAL

int
hi_attr(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->attr;
    OUTPUT:
	RETVAL

void
hi_realLoad(self)
	LSF_Batch_hostInfo *self;
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->nIdx; i++)
          XPUSHs(sv_2mortal(newSVnv(self->realLoad[i])));	
	XSRETURN(self->nIdx);

int
hi_chkSig(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->chkSig;
    OUTPUT:
	RETVAL

#if LSF_VERSION >= 18

float
hi_cpuFactor(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->cpuFactor;
    OUTPUT:
	RETVAL

int
hi_nIdxr(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->nIdx;
    OUTPUT:
	RETVAL

float
hi_cnsmrUsage(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->cnsmrUsage;
    OUTPUT:
	RETVAL

float
hi_prvdrUsage(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->prvdrUsage;
    OUTPUT:
	RETVAL

float
hi_cnsmrAvail(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->cnsmrAvail;
    OUTPUT:
	RETVAL

float
hi_prvdrAvail(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->prvdrAvail;
    OUTPUT:
	RETVAL

float
hi_maxAvail(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->maxAvail;
    OUTPUT:
	RETVAL

float
hi_maxExitRate(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->maxExitRate;
    OUTPUT:
	RETVAL

float
hi_numExitRate(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->numExitRate;
    OUTPUT:
	RETVAL

char *
hi_hCtrlMsg(self)
	LSF_Batch_hostInfo *self;
    CODE:
	RETVAL = self->hCtrlMsg;
    OUTPUT:
	RETVAL

#endif

MODULE = LSF::Batch		PACKAGE = LSF::Batch		PREFIX = lsb_

void
lsb_usergrpinfo(self, groups, options)
	void *self
	char **groups
	int options
    PREINIT:
	char **g;
	int i, count = 0, num;
	struct groupInfoEnt *p, *gi;
    PPCODE:
	for( g = groups; groups && *g; g++ )count++;
	num = count;
	if( count == 0 ) groups = NULL;
	gi = lsb_usergrpinfo(groups, &num, options);
	if(gi == NULL){
	    STATUS_NATIVE_SET(lsberrno);
	    if(lsberrno == LSBE_BAD_GROUP){
	      char e[100];
              sprintf(e,"group %s is unknown to LSF", groups[num]);
	      SET_LSB_ERRMSG_TO(e);
            }
	    else
	      SET_LSB_ERRMSG;
	    XSRETURN_EMPTY;
 	}
	for( i = 0, p = gi; i < num; i++,p++ ){
          XPUSHs(sv_2mortal(newSVpv(p->group,0)));
	  XPUSHs(sv_2mortal(newSVpv(p->memberList,0)));
	}
	XSRETURN(num*2);
	

void
lsb_hostgrpinfo(self, groups, options)
	void *self
	char **groups
	int options
    PREINIT:
	char **g;
	int i, count = 0, num;
	struct groupInfoEnt *p, *gi;
    PPCODE:
	for( g = groups; groups && *g; g++ )count++;
	num = count;
	if( count == 0 ) groups = NULL;
	gi = lsb_hostgrpinfo(groups, &num, options);
	if(gi == NULL){
	    STATUS_NATIVE_SET(lsberrno);
	    if(lsberrno == LSBE_BAD_GROUP){
	      char e[100];
              sprintf(e,"group %s is unknown to LSF", groups[num]);
	      SET_LSB_ERRMSG_TO(e);
            }
	    else
	      SET_LSB_ERRMSG;
	    XSRETURN_EMPTY;
 	}
	for( i = 0, p = gi; i < num; i++,p++ ){
          XPUSHs(sv_2mortal(newSVpv(p->group,0)));
	  XPUSHs(sv_2mortal(newSVpv(p->memberList,0)));
	}
	XSRETURN(num*2);
	

void
lsb_userinfo(self, users)
	void *self
	char **users
    PREINIT:
	SV *rv;	
	int i, count=0, num;
	LSF_Batch_userInfo *ui, *p;
	char **c;
    PPCODE:
	for( c = users; users && *c; c++ ) count++;
	num = count;
	if( count == 0 ) users = NULL;
	ui = lsb_userinfo(users, &num );
	fflush(stdout);
	if(ui == NULL){
	    STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
	    XSRETURN_EMPTY;
 	}
	for( i = 0, p = ui; i < num; i++,p++ ){
	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::userInfoPtr",(IV)p);
	    XPUSHs(sv_2mortal(rv));
	}
	XSRETURN(num);

MODULE = LSF::Batch	PACKAGE = LSF::Batch::userInfoPtr	PREFIX = ui_

char *
ui_user(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->user;
    OUTPUT:
	RETVAL

int
ui_procJobLimit(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->procJobLimit;
    OUTPUT:
	RETVAL

int
ui_maxJobs(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->maxJobs;
    OUTPUT:
	RETVAL

int
ui_numStartJobs(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->numStartJobs;
    OUTPUT:
	RETVAL

int
ui_numJobs(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->numJobs;
    OUTPUT:
	RETVAL

int
ui_numPEND(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->numPEND;
    OUTPUT:
	RETVAL

int
ui_numRUN(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->numRUN;
    OUTPUT:
	RETVAL

int
ui_numSSUSP(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->numSSUSP;
    OUTPUT:
	RETVAL

int
ui_numUSUSP(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->numUSUSP;
    OUTPUT:
	RETVAL

int
ui_numRESERVE(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->numRESERVE;
    OUTPUT:
	RETVAL

#if LSF_VERSION >= 18

int
ui_maxPendJobs(self)
	LSF_Batch_userInfo *self
    CODE:
	RETVAL = self->maxPendJobs;
    OUTPUT:
	RETVAL

#endif

MODULE = LSF::Batch	PACKAGE = LSF::Batch	PREFIX = lsb_

LSF_Batch_parameterInfo *
lsb_parameterinfo(self)
	void *self
    CODE:
	RETVAL = lsb_parameterinfo(NULL, NULL, 0);
    OUTPUT:
	RETVAL

MODULE = LSF::Batch	PACKAGE = LSF::Batch::parameterInfoPtr	PREFIX = pi_

char *
pi_pjobSpoolDir(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->pjobSpoolDir;
    OUTPUT:
	RETVAL

int
pi_mbdRefreshTime(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mbdRefreshTime;
    OUTPUT:
	RETVAL


int
pi_updJobRusageInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->updJobRusageInterval;
    OUTPUT:
	RETVAL

char *
pi_defaultQueues(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->defaultQueues;
    OUTPUT:
	RETVAL

char *
pi_defaultHostSpec(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->defaultHostSpec;
    OUTPUT:
	RETVAL

int
pi_mbatchdInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mbatchdInterval;
    OUTPUT:
	RETVAL

int
pi_sbatchdInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sbatchdInterval;
    OUTPUT:
	RETVAL

int
pi_jobAcceptInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobAcceptInterval;
    OUTPUT:
	RETVAL

int
pi_maxDispRetries(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxDispRetries;
    OUTPUT:
	RETVAL

int
pi_maxSbdRetries(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxSbdRetries;
    OUTPUT:
	RETVAL

int
pi_preemptPeriod(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->preemptPeriod;
    OUTPUT:
	RETVAL

int
pi_cleanPeriod(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->cleanPeriod;
    OUTPUT:
	RETVAL

int
pi_maxNumJobs(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxNumJobs;
    OUTPUT:
	RETVAL

float
pi_historyHours(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->historyHours;
    OUTPUT:
	RETVAL

int
pi_maxUserPriority(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxUserPriority;
    OUTPUT:
	RETVAL

int
pi_jobPriorityValue(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobPriorityValue;
    OUTPUT:
	RETVAL

int
pi_jobPriorityTime(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobPriorityTime;
    OUTPUT:
	RETVAL

int
pi_pgSuspendIt(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->pgSuspendIt;
    OUTPUT:
	RETVAL

#if LSF_VERSION >= 18

char *
pi_defaultProject(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->defaultProject;
    OUTPUT:
	RETVAL

int 
pi_retryIntvl(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->retryIntvl;
    OUTPUT:
	RETVAL

int 
pi_nqsQueuesFlags(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->nqsQueuesFlags;
    OUTPUT:
	RETVAL

int 
pi_nqsRequestsFlags(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->nqsRequestsFlags;
    OUTPUT:
	RETVAL

int 
pi_maxPreExecRetry(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxPreExecRetry;
    OUTPUT:
	RETVAL

int 
pi_eventWatchTime(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->eventWatchTime;
    OUTPUT:
	RETVAL

float
pi_runTimeFactor(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->runTimeFactor;
    OUTPUT:
	RETVAL

float
pi_waitTimeFactor(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->waitTimeFactor;
    OUTPUT:
	RETVAL

float
pi_runJobFactor(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->runJobFactor;
    OUTPUT:
	RETVAL

int
pi_eEventCheckIntvl(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->eEventCheckIntvl;
    OUTPUT:
	RETVAL

int
pi_rusageUpdateRate(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->rusageUpdateRate;
    OUTPUT:
	RETVAL

int
pi_rusageUpdatePercent(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->rusageUpdatePercent;
    OUTPUT:
	RETVAL

int
pi_condCheckTime(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->condCheckTime;
    OUTPUT:
	RETVAL

int
pi_maxSbdConnections(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxSbdConnections;
    OUTPUT:
	RETVAL

int
pi_rschedInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->rschedInterval;
    OUTPUT:
	RETVAL

int
pi_maxSchedStay(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxSchedStay;
    OUTPUT:
	RETVAL

int
pi_freshPeriod(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->freshPeriod;
    OUTPUT:
	RETVAL

int
pi_preemptFor(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->preemptFor;
    OUTPUT:
	RETVAL

int
pi_adminSuspend(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->adminSuspend;
    OUTPUT:
	RETVAL

int
pi_userReservation(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->userReservation;
    OUTPUT:
	RETVAL

float
pi_cpuTimeFactor(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->cpuTimeFactor;
    OUTPUT:
	RETVAL

int
pi_fyStart(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->fyStart;
    OUTPUT:
	RETVAL

int
pi_maxJobArraySize(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxJobArraySize;
    OUTPUT:
	RETVAL

time_t
pi_exceptReplayPeriod(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->exceptReplayPeriod;
    OUTPUT:
	RETVAL

int
pi_jobTerminateInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobTerminateInterval;
    OUTPUT:
	RETVAL

int
pi_disableUAcctMap(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->disableUAcctMap;
    OUTPUT:
	RETVAL

int
pi_enforceFSProj(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->enforceFSProj;
    OUTPUT:
	RETVAL

int
pi_enforceProjCheck(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->enforceProjCheck;
    OUTPUT:
	RETVAL

int
pi_jobRunTimes(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobRunTimes;
    OUTPUT:
	RETVAL

int
pi_dbHjobCountIntval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->dbHjobCountIntval;
    OUTPUT:
	RETVAL

int
pi_dbQjobCountIntval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->dbQjobCountIntval;
    OUTPUT:
	RETVAL
	
int
pi_dbUjobCountIntval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->dbUjobCountIntval;
    OUTPUT:
	RETVAL

int
pi_dbDefaultIntval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->dbDefaultIntval;
    OUTPUT:
	RETVAL

int
pi_dbJobResUsageIntval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->dbJobResUsageIntval;
    OUTPUT:
	RETVAL

int
pi_dbLoadIntval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->dbLoadIntval;
    OUTPUT:
	RETVAL

int
pi_dbJobInfoIntval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->dbJobInfoIntval;
    OUTPUT:
	RETVAL

int
pi_jobDepLastSub(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobDepLastSub;
    OUTPUT:
	RETVAL

int
pi_maxJobNameDep(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxJobNameDep;
    OUTPUT:
	RETVAL

char *
pi_dbSelectLoad(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->dbSelectLoad;
    OUTPUT:
	RETVAL

int
pi_jobSynJgrp(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobSynJgrp;
    OUTPUT:
	RETVAL

int
pi_enableAutoAdjust(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->enableAutoAdjust;
    OUTPUT:
	RETVAL

int
pi_autoAdjustAtNumPend(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->autoAdjustAtNumPend;
    OUTPUT:
	RETVAL

float
pi_autoAdjustAtPercent(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->autoAdjustAtPercent;
    OUTPUT:
	RETVAL

int
pi_sharedResourceUpdFactor(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sharedResourceUpdFactor;
    OUTPUT:
	RETVAL

int
pi_scheRawLoad(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->scheRawLoad;
    OUTPUT:
	RETVAL

char *
pi_jobAttaDir(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobAttaDir;
    OUTPUT:
	RETVAL

int
pi_maxJobMsgNum(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxJobMsgNum;
    OUTPUT:
	RETVAL

int
pi_maxJobAttaSize(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxJobAttaSize;
    OUTPUT:
	RETVAL

char *
pi_sysMapAcct(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sysMapAcct;
    OUTPUT:
	RETVAL

int
pi_preExecDelay(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->preExecDelay;
    OUTPUT:
	RETVAL

int
pi_updEventUpdateInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->updEventUpdateInterval;
    OUTPUT:
	RETVAL

int
pi_resourceReservePerSlot(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->resourceReservePerSlot;
    OUTPUT:
	RETVAL

int
pi_maxJobId(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxJobId;
    OUTPUT:
	RETVAL

char *
pi_preemptResourceList(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->preemptResourceList;
    OUTPUT:
	RETVAL

int
pi_preemptionWaitTime(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->preemptionWaitTime;
    OUTPUT:
	RETVAL

int
pi_maxAcctArchiveNum(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxAcctArchiveNum;
    OUTPUT:
	RETVAL

int
pi_acctArchiveInDays(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->acctArchiveInDays;
    OUTPUT:
	RETVAL

int
pi_acctArchiveInSize(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->acctArchiveInSize;
    OUTPUT:
	RETVAL

float
pi_committedRunTimeFactor(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->committedRunTimeFactor;
    OUTPUT:
	RETVAL

#ifdef PS_SXNQS

int
pi_nqsUpdateInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->nqsUpdateInterval;
    OUTPUT:
	RETVAL

#endif


int
pi_enableHistRunTime(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->enableHistRunTime;
    OUTPUT:
	RETVAL

int
pi_mcbOlmReclaimTimeDelay(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mcbOlmReclaimTimeDelay;
    OUTPUT:
	RETVAL

int
pi_chunkJobDuration(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->chunkJobDuration;
    OUTPUT:
	RETVAL

int
pi_sessionInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sessionInterval;
    OUTPUT:
	RETVAL

int
pi_publishReasonJobNum(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->publishReasonJobNum;
    OUTPUT:
	RETVAL

int
pi_publishReasonInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->publishReasonInterval;
    OUTPUT:
	RETVAL

int
pi_publishReason4AllJobInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->publishReason4AllJobInterval;
    OUTPUT:
	RETVAL

int
pi_mcUpdPendingReasonInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mcUpdPendingReasonInterval;
    OUTPUT:
	RETVAL

int
pi_mcUpdPendingReasonPkgSize(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mcUpdPendingReasonPkgSize;
    OUTPUT:
	RETVAL

int
pi_noPreemptRunTime(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->noPreemptRunTime;
    OUTPUT:
	RETVAL

int
pi_noPreemptFinishTime(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->noPreemptFinishTime;
    OUTPUT:
	RETVAL

char *
pi_acctArchiveAt(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->acctArchiveAt;
    OUTPUT:
	RETVAL

int
pi_absoluteRunLimit(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->absoluteRunLimit;
    OUTPUT:
	RETVAL

int
pi_lsbExitRateDuration(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->lsbExitRateDuration;
    OUTPUT:
	RETVAL

int
pi_lsbTriggerDuration(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->lsbTriggerDuration;
    OUTPUT:
	RETVAL

int
pi_maxJobinfoQueryPeriod(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxJobinfoQueryPeriod;
    OUTPUT:
	RETVAL

int
pi_jobSubRetryInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobSubRetryInterval;
    OUTPUT:
	RETVAL

int
pi_pendingJobThreshold(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->pendingJobThreshold;
    OUTPUT:
	RETVAL

int
pi_maxConcurrentJobQuery(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxConcurrentJobQuery;
    OUTPUT:
	RETVAL

int
pi_minSwitchPeriod(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->minSwitchPeriod;
    OUTPUT:
	RETVAL

int
pi_condensePendingReasons(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->condensePendingReasons;
    OUTPUT:
	RETVAL

int
pi_slotBasedParallelSched(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->slotBasedParallelSched;
    OUTPUT:
	RETVAL

int
pi_disableUserJobMovement(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->disableUserJobMovement;
    OUTPUT:
	RETVAL

int
pi_detectIdleJobAfter(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->detectIdleJobAfter;
    OUTPUT:
	RETVAL

int
pi_useSymbolPriority(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->useSymbolPriority;
    OUTPUT:
	RETVAL

int
pi_JobPriorityRound(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->JobPriorityRound;
    OUTPUT:
	RETVAL

char *
pi_priorityMapping(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->priorityMapping;
    OUTPUT:
	RETVAL

int
pi_maxInfoDirs(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxInfoDirs;
    OUTPUT:
	RETVAL

int
pi_minMbdRefreshTime(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->minMbdRefreshTime;
    OUTPUT:
	RETVAL

int
pi_enableStopAskingLicenses2LS(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->enableStopAskingLicenses2LS;
    OUTPUT:
	RETVAL

char *
pi_mbdQueryCPUs(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mbdQueryCPUs;
    OUTPUT:
	RETVAL

char *
pi_defaultApp(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->defaultApp;
    OUTPUT:
	RETVAL

int
pi_enableStream(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->enableStream;
    OUTPUT:
	RETVAL

char *
pi_streamFile(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->streamFile;
    OUTPUT:
	RETVAL

int
pi_streamSize(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->streamSize;
    OUTPUT:
	RETVAL
	
int
pi_syncUpHostStatusWithLIM(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->syncUpHostStatusWithLIM;
    OUTPUT:
	RETVAL	
	
char *
pi_defaultSLA(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->defaultSLA;
    OUTPUT:
	RETVAL	
	
int
pi_slaTimer(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->slaTimer;
    OUTPUT:
	RETVAL		
	
int
pi_mbdEgoTtl(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mbdEgoTtl;
    OUTPUT:
	RETVAL			
	
int
pi_mbdEgoConnTimeout(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mbdEgoConnTimeout;
    OUTPUT:
	RETVAL			
	
int
pi_mbdEgoReadTimeout(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mbdEgoReadTimeout;
    OUTPUT:
	RETVAL			
	
int
pi_mbdUseEgoMXJ(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mbdUseEgoMXJ;
    OUTPUT:
	RETVAL
	
int
pi_mbdEgoReclaimByQueue(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->mbdEgoReclaimByQueue;
    OUTPUT:
	RETVAL	
	
int
pi_defaultSLAvelocity(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->defaultSLAvelocity;
    OUTPUT:
	RETVAL		
	
char *
pi_exitRateTypes(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->exitRateTypes;
    OUTPUT:
	RETVAL			
	
float
pi_globalJobExitRate(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->globalJobExitRate;
    OUTPUT:
	RETVAL			
	
int
pi_enableJobExitRatePerSlot(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->enableJobExitRatePerSlot;
    OUTPUT:
	RETVAL	
	
int
pi_enableMetric(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->enableMetric;
    OUTPUT:
	RETVAL		
	
int
pi_schMetricsSample(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->schMetricsSample;
    OUTPUT:
	RETVAL	
	
float
pi_maxApsValue(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->maxApsValue;
    OUTPUT:
	RETVAL	
	
float
pi_newjobRefresh(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->newjobRefresh;
    OUTPUT:
	RETVAL		
	
float
pi_preemptJobType(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->preemptJobType;
    OUTPUT:
	RETVAL		
	
char *
pi_defaultJgrp(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->defaultJgrp;
    OUTPUT:
	RETVAL	
	
int
pi_jobRunlimitRatio(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobRunlimitRatio;
    OUTPUT:
	RETVAL		
		
int
pi_jobIncludePostproc(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobIncludePostproc;
    OUTPUT:
	RETVAL	
	
int
pi_jobPostprocTimeout(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->jobPostprocTimeout;
    OUTPUT:
	RETVAL		
	
int
pi_sschedUpdateSummaryInterval(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sschedUpdateSummaryInterval;
    OUTPUT:
	RETVAL	
	
int
pi_sschedUpdateSummaryByTask(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sschedUpdateSummaryByTask;
    OUTPUT:
	RETVAL		
	
int
pi_sschedRequeueLimit(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sschedRequeueLimit;
    OUTPUT:
	RETVAL	
	
int
pi_sschedRetryLimit(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sschedRetryLimit;
    OUTPUT:
	RETVAL		
	
int
pi_sschedMaxTasks(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sschedMaxTasks;
    OUTPUT:
	RETVAL			
	
int
pi_sschedMaxRuntime(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sschedMaxRuntime;
    OUTPUT:
	RETVAL				
	
char *
pi_sschedAcctDir(self)
	LSF_Batch_parameterInfo *self;
    CODE:
	RETVAL = self->sschedAcctDir;
    OUTPUT:
	RETVAL	
	
#endif


MODULE = LSF::Batch	PACKAGE = LSF::Batch	PREFIX = lsb_

int
lsb_queuecontrol(self, queue, opcode)
	void *self
	char *queue
	int opcode
    PREINIT:
        struct queueCtrlReq *req;
    CODE:
	req = (struct queueCtrlReq *)safemalloc(sizeof(struct queueCtrlReq));
	bzero(req,sizeof(struct queueCtrlReq));
	req->queue = queue;
	req->opCode = opcode;
	if( lsb_queuecontrol(req) < 0 ){
	  STATUS_NATIVE_SET(lsberrno);
	  SET_LSB_ERRMSG;
	  RETVAL = 0;
	}
	else{
	  RETVAL = 1;
	}
	safefree(req);
    OUTPUT:
	RETVAL


void
lsb_queueinfo(self, queues, host, user, options)
	void *self
	char **queues
	char *host
	char *user
	int options
    PREINIT:
	SV *rv;
	char **q;
	int i, count = 0, num = 0;
	LSF_Batch_queueInfo *p, *qinfo;
    PPCODE:
	for( q = queues; queues && *q; q++ ) count++;
	num = count;
	if( count == 0 ) queues = NULL;
	if(strlen(host)==0) host = NULL;
	if(strlen(user)==0) user = NULL;
	qinfo = lsb_queueinfo(queues, &num, host, user, options);
	if(qinfo == NULL){
	    STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
	    XSRETURN_EMPTY;
 	}
	for( i = 0, p = qinfo; i < num; i++,p++ ){
	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::queueInfoPtr",(IV)p);
	    XPUSHs(sv_2mortal(rv));
	}
	XSRETURN(num);

MODULE = LSF::Batch	PACKAGE = LSF::Batch::queueInfoPtr	PREFIX = qi_

char *
qi_queue(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->queue;
    OUTPUT:
	RETVAL

char *
qi_description(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->description;
    OUTPUT:
	RETVAL

int
qi_priority(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->priority;
    OUTPUT:
	RETVAL

short
qi_nice(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->nice;
    OUTPUT:
	RETVAL

char *
qi_userList(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->userList;
    OUTPUT:
	RETVAL

char *
qi_hostList(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->hostList;
    OUTPUT:
	RETVAL

void
qi_loadSched(self)
	LSF_Batch_queueInfo *self
    PREINIT:
	int i;
	float *f;
    PPCODE:
	for( i = 0; i < self->nIdx; i++){
          XPUSHs(sv_2mortal(newSVnv(self->loadSched[i])));	
        }
	XSRETURN(self->nIdx);


void
qi_loadStop(self)
	LSF_Batch_queueInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->nIdx; i++){
          XPUSHs(sv_2mortal(newSVnv(self->loadSched[i])));
	}	
	XSRETURN(self->nIdx);


int
qi_userJobLimit(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->userJobLimit;
    OUTPUT:
	RETVAL

int
qi_procJobLimit(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->procJobLimit;
    OUTPUT:
	RETVAL

char *
qi_windows(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->windows;
    OUTPUT:
	RETVAL

void
qi_rLimits(self)
	LSF_Batch_queueInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < LSF_RLIM_NLIMITS; i++){
          XPUSHs(sv_2mortal(newSViv(self->rLimits[i])));	
        }
	XSRETURN(LSF_RLIM_NLIMITS);

void
qi_defLimits(self)
	LSF_Batch_queueInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < LSF_RLIM_NLIMITS; i++){
          XPUSHs(sv_2mortal(newSViv(self->defLimits[i])));	
        }
	XSRETURN(LSF_RLIM_NLIMITS);

char *
qi_hostSpec(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->hostSpec;
    OUTPUT:
	RETVAL

int
qi_qAttrib(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->qAttrib;
    OUTPUT:
	RETVAL

int
qi_qStatus(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->qStatus;
    OUTPUT:
	RETVAL

int
qi_maxJobs(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->maxJobs;
    OUTPUT:
	RETVAL

int
qi_numJobs(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numJobs;
    OUTPUT:
	RETVAL

int
qi_numPEND(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numPEND;
    OUTPUT:
	RETVAL

int
qi_numRUN(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numRUN;
    OUTPUT:
	RETVAL

int
qi_numSSUSP(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numSSUSP;
    OUTPUT:
	RETVAL

int
qi_numUSUSP(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numUSUSP;
    OUTPUT:
	RETVAL

int
qi_mig(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->mig;
    OUTPUT:
	RETVAL

char *
qi_windowsD(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->windowsD;
    OUTPUT:
	RETVAL

char *
qi_nqsQueues(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->nqsQueues;
    OUTPUT:
	RETVAL

char *
qi_userShares(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->userShares;
    OUTPUT:
	RETVAL

char * 
qi_defaultHostSpec(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->defaultHostSpec;
    OUTPUT:
	RETVAL

int
qi_procLimit(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->procLimit;
    OUTPUT:
	RETVAL

char *
qi_admins(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->admins;
    OUTPUT:
	RETVAL

char *
qi_preCmd(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->preCmd;
    OUTPUT:
	RETVAL

char *
qi_postCmd(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->postCmd;
    OUTPUT:
	RETVAL

char *
qi_requeueEValues(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->requeueEValues;
    OUTPUT:
	RETVAL

int
qi_hostJobLimit(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->hostJobLimit;
    OUTPUT:
	RETVAL

char *
qi_resReq(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->resReq;
    OUTPUT:
	RETVAL

int
qi_numRESERVE(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numRESERVE;
    OUTPUT:
	RETVAL

int
qi_slotHoldTime(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->slotHoldTime;
    OUTPUT:
	RETVAL

char *
qi_sndJobsTo(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->sndJobsTo;
    OUTPUT:
	RETVAL

char *
qi_rcvJobsFrom(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->rcvJobsFrom;
    OUTPUT:
	RETVAL

char *
qi_resumeCond(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->resumeCond;
    OUTPUT:
	RETVAL

char *
qi_stopCond(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->stopCond;
    OUTPUT:
	RETVAL

char *
qi_jobStarter(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->jobStarter;
    OUTPUT:
	RETVAL

char *
qi_suspendActCmd(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->suspendActCmd;
    OUTPUT:
	RETVAL

char *
qi_resumeActCmd(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->resumeActCmd;
    OUTPUT:
	RETVAL

char *
qi_terminateActCmd(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->terminateActCmd;
    OUTPUT:
	RETVAL

void
qi_sigMap(self)
	LSF_Batch_queueInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < LSB_SIG_NUM; i++){
          XPUSHs(sv_2mortal(newSViv(self->sigMap[i])));	
        }
	XSRETURN(LSB_SIG_NUM);

char *	
qi_preemption(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->preemption;
    OUTPUT:
	RETVAL


void
qi_shareAccts(self)
	LSF_Batch_queueInfo *self
    PREINIT:
	SV *rv;
	LSF_Batch_shareAcctInfo *p;
	int i;
    PPCODE:
	for( i = 0, p = self->shareAccts; i < self->numOfSAccts; i++,p++ ){
	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::shareAcctInfoPtr",(IV)p);
	    XPUSHs(sv_2mortal(rv));
	}
	XSRETURN(self->numOfSAccts);

int
qi_chunkJobSize(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->chunkJobSize;
    OUTPUT:
	RETVAL

#if LSF_VERSION >= 18

char *
qi_hostStr(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->hostStr;
    OUTPUT:
	RETVAL

int
qi_schedDelay(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->schedDelay;
    OUTPUT:
	RETVAL

int
qi_acceptIntvl(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->acceptIntvl;
    OUTPUT:
	RETVAL

int
qi_maxRschedTime(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->maxRschedTime;
    OUTPUT:
	RETVAL

int
qi_numOfSAccts(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numOfSAccts;
    OUTPUT:
	RETVAL
	
char *
qi_chkpntDir(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->chkpntDir;
    OUTPUT:
	RETVAL

int
qi_chkpntPeriod(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->chkpntPeriod;
    OUTPUT:
	RETVAL
	
int
qi_imptJobBklg(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->imptJobBklg;
    OUTPUT:
	RETVAL

int
qi_minProcLimit(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->minProcLimit;
    OUTPUT:
	RETVAL

int
qi_defProcLimit(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->defProcLimit;
    OUTPUT:
	RETVAL

char *
qi_fairshareQueues(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->fairshareQueues;
    OUTPUT:
	RETVAL

char *
qi_defExtSched(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->defExtSched;
    OUTPUT:
	RETVAL

char *
qi_mandExtSched(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->mandExtSched;
    OUTPUT:
	RETVAL

int
qi_slotShare(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->slotShare;
    OUTPUT:
	RETVAL

char *
qi_slotPool(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->slotPool;
    OUTPUT:
	RETVAL

int
qi_underRCond(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->underRCond;
    OUTPUT:
	RETVAL

int
qi_overRCond(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->overRCond;
    OUTPUT:
	RETVAL

float
qi_idleCond(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->idleCond;
    OUTPUT:
	RETVAL

int
qi_underRJobs(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->underRJobs;
    OUTPUT:
	RETVAL

int
qi_overRJobs(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->overRJobs;
    OUTPUT:
	RETVAL

int
qi_idleJobs(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->idleJobs;
    OUTPUT:
	RETVAL

int
qi_warningTimePeriod(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->warningTimePeriod;
    OUTPUT:
	RETVAL

char *
qi_warningAction(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->warningAction;
    OUTPUT:
	RETVAL

char *
qi_qCtrlMsg(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->qCtrlMsg;
    OUTPUT:
	RETVAL
	
char *
qi_acResReq(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->acResReq;
    OUTPUT:
	RETVAL	

int
qi_symJobLimit(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->symJobLimit;
    OUTPUT:
	RETVAL	

char *
qi_cpuReq(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->cpuReq;
    OUTPUT:
	RETVAL	

int
qi_proAttr(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->proAttr;
    OUTPUT:
	RETVAL	

int
qi_lendLimit(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->lendLimit;
    OUTPUT:
	RETVAL	

int
qi_hostReallocInterval(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->hostReallocInterval;
    OUTPUT:
	RETVAL	

int
qi_numCPURequired(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numCPURequired;
    OUTPUT:
	RETVAL	

int
qi_numCPUAllocated(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numCPUAllocated;
    OUTPUT:
	RETVAL	

int
qi_numCPUBorrowed(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numCPUBorrowed;
    OUTPUT:
	RETVAL	

int
qi_numCPULent(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numCPULent;
    OUTPUT:
	RETVAL	

int
qi_schGranularity(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->schGranularity;
    OUTPUT:
	RETVAL	

int
qi_symTaskGracePeriod(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->symTaskGracePeriod;
    OUTPUT:
	RETVAL	

int
qi_minOfSsm(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->minOfSsm;
    OUTPUT:
	RETVAL	
	
int
qi_maxOfSsm(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->maxOfSsm;
    OUTPUT:
	RETVAL	

int
qi_numOfAllocSlots(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numOfAllocSlots;
    OUTPUT:
	RETVAL	

char *
qi_servicePreemption(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->servicePreemption;
    OUTPUT:
	RETVAL

int
qi_provisionStatus(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->provisionStatus;
    OUTPUT:
	RETVAL

int
qi_minTimeSlice(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->minTimeSlice;
    OUTPUT:
	RETVAL

char *
qi_queueGroup(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->queueGroup;
    OUTPUT:
	RETVAL

int
qi_numApsFactors(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->numApsFactors;
    OUTPUT:
	RETVAL

void
qi_apsFactorInfoList(self)
	LSF_Batch_queueInfo *self
    PREINIT:
	SV *rv;
	LSF_Batch_apsFactorInfo *p;
	int i;
    PPCODE:
	for( i = 0, p = self->apsFactorInfoList; i < self->numApsFactors; i++,p++ ){
	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::apsFactorInfoPtr",(IV)p);
	    XPUSHs(sv_2mortal(rv));
	}
	XSRETURN(self->numApsFactors);

LSF_Batch_apsFactorMap *
qi_apsFactorMaps(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->apsFactorMaps;
    OUTPUT:
	RETVAL

LSF_Batch_apsLongNameMap *
qi_apsLongNames(self)
	LSF_Batch_queueInfo *self
    CODE:
	RETVAL = self->apsLongNames;
    OUTPUT:
	RETVAL

#endif


MODULE = LSF::Batch PACKAGE = LSF::Batch::shareAcctInfoPtr PREFIX = sai_

char *
sai_shareAcctPath(self)
	LSF_Batch_shareAcctInfo *self;
    CODE:
	RETVAL = self->shareAcctPath;
    OUTPUT:
	RETVAL

int
sai_shares(self)
	LSF_Batch_shareAcctInfo *self;
    CODE:
	RETVAL = self->shares;
    OUTPUT:
	RETVAL

float
sai_priority(self)
	LSF_Batch_shareAcctInfo *self;
    CODE:
	RETVAL = self->priority;
    OUTPUT:
	RETVAL

int
sai_numStartJobs(self)
	LSF_Batch_shareAcctInfo *self;
    CODE:
	RETVAL = self->numStartJobs;
    OUTPUT:
	RETVAL

float
sai_histCpuTime(self)
	LSF_Batch_shareAcctInfo *self;
    CODE:
	RETVAL = self->histCpuTime;
    OUTPUT:
	RETVAL

int
sai_numReserveJobs(self)
	LSF_Batch_shareAcctInfo *self;
    CODE:
	RETVAL = self->numReserveJobs;
    OUTPUT:
	RETVAL

int
sai_runTime(self)
	LSF_Batch_shareAcctInfo *self;
    CODE:
	RETVAL = self->runTime;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch	PACKAGE = LSF::Batch	PREFIX = lsb_

int
lsb_openjobinfo(self, job, jobname, user, queue, host, options)
	void *self
	LSF_Batch_job *job
	char *jobname
	char *user
	char *queue
	char *host
	int options
 PREINIT:
	LS_LONG_INT jobId;
    CODE:
        if(job == NULL){
	  jobId = 0;
        }
        else{
	  jobId = LSB_JOBID(job->jobId,job->arrayIdx);
        }
	if(strlen(jobname)==0)jobname = NULL;
	if(strlen(user)==0)user = NULL;
	if(strlen(queue)==0)queue = NULL;
	if(strlen(host)==0)host = NULL;
	if( (RETVAL = lsb_openjobinfo(jobId, 
	jobname, user, queue, host, options)) < 0){
	  STATUS_NATIVE_SET(lsberrno);
	  SET_LSB_ERRMSG;
	  XSRETURN_UNDEF;
	}
    OUTPUT:
	RETVAL

LSF_Batch_jobInfoHead *
lsb_openjobinfo_a(self,job,jobName,userName,queueName,hostName,options)
	void          *self
	LSF_Batch_job *job
	char          *jobName
	char          *userName
	char          *queueName
	char          *hostName
	int           options
    PREINIT:
        LS_LONG_INT   jobId;
    CODE:
        if(job == NULL){
            jobId =0;
        }
        else{
            jobId = LSB_JOBID(job->jobId,job->arrayIdx);
        }
        if(strlen(jobName)==0) jobName =NULL;
        if(strlen(userName)==0) userName = NULL;
        if(strlen(queueName)==0) queueName = NULL;
        if(strlen(hostName)==0) hostName = NULL;
        RETVAL = lsb_openjobinfo_a(jobId,jobName,userName,queueName,hostName,options);
	if(RETVAL == NULL){
	    STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
	    XSRETURN_UNDEF;
	}
   OUTPUT:
        RETVAL

LSF_Batch_jobInfoHeadExt *
lsb_openjobinfo_req(hvreq)
       HV * hvreq
 PREINIT:
     struct jobInfoReq     * jreq    = NULL;
     struct jobInfoHeadExt * ret     = NULL;
 CODE:
     jreq = (struct jobInfoReq *)safemalloc(sizeof(struct jobInfoReq));
     bzero(jreq, sizeof(struct jobInfoReq));
 
     if (format_jobinforeq(jreq, hvreq, "lsb_openjobinfo_req") < 0) {
         free_jobinforeq(jreq);
         SET_LSB_ERRMSG;
         XSRETURN_EMPTY;	
     }
 
     ret = lsb_openjobinfo_req(jreq);
     if (ret == NULL) {
         free_jobinforeq(jreq);
         STATUS_NATIVE_SET(lsberrno);
         SET_LSB_ERRMSG;
         XSRETURN_EMPTY;	
     }
     
     free_jobinforeq(jreq);
     RETVAL = ret;
 OUTPUT:
     RETVAL
     
LSF_Batch_jobInfo *
lsb_readjobinfo(self)
	void *self;
    PREINIT:
	int more;
    CODE:
	RETVAL = lsb_readjobinfo(&more);
	if(RETVAL == NULL){
	   STATUS_NATIVE_SET(lsberrno);
	   SET_LSB_ERRMSG;
           XSRETURN_UNDEF;
	}
    OUTPUT:
	RETVAL
	
LSF_Batch_jobInfo *
lsb_readjobinfo_cond(self, jInfoHExt)
     void                     * self;
     LSF_Batch_jobInfoHeadExt * jInfoHExt;
 PREINIT:
     int more = 0;
 CODE:
     RETVAL = lsb_readjobinfo_cond(&more, jInfoHExt);
     if(RETVAL == NULL){
	   STATUS_NATIVE_SET(lsberrno);
 	   SET_LSB_ERRMSG;
           XSRETURN_UNDEF;
     }
 OUTPUT:
     RETVAL

void
lsb_closejobinfo(self)
	void *self;
    CODE:
	lsb_closejobinfo();

MODULE = LSF::Batch	PACKAGE = LSF::Batch::jobInfoHeadExtPtr	PREFIX = head_
 
LSF_Batch_jobInfoHead *
head_jobInfoHead(self)
    LSF_Batch_jobInfoHeadExt * self
CODE:
    RETVAL = self->jobInfoHead;
OUTPUT:
    RETVAL


MODULE = LSF::Batch     PACKAGE = LSF::Batch::jobInfoHeadPtr    PREFIX = head_

int
head_numJobs(self)
	LSF_Batch_jobInfoHead  *self
    CODE:
        RETVAL = self ->numJobs;
    OUTPUT:
        RETVAL
	
void
head_jobIds(self)
	LSF_Batch_jobInfoHead   *self
    PREINIT:
        int i;
    PPCODE:
        for(i=0; i<self->numJobs; i++){
            XPUSHs(sv_2mortal(newSViv(self-> jobIds [i])));
        }
        XSRETURN(self -> numJobs);

int
head_numHosts(self)
	LSF_Batch_jobInfoHead   *self
    CODE:
        RETVAL = self ->numHosts;
    OUTPUT:
        RETVAL

void
head_hostNames(self)
	LSF_Batch_jobInfoHead   *self
    PREINIT:
        int i;
    PPCODE:
        for(i=0; i<self->numHosts; i++){
            XPUSHs(sv_2mortal(newSVpv(self->hostNames[i],0)));
        }
        XSRETURN(self -> numHosts);

int
head_numClusters(self)
	LSF_Batch_jobInfoHead   *self
    CODE:
        RETVAL = self ->numClusters;
    OUTPUT:
        RETVAL

void
head_clusterNames(self)
	LSF_Batch_jobInfoHead   *self
    PREINIT:
        int i;
    PPCODE:
        for(i=0; i< self->numClusters; i++){
            XPUSHs(sv_2mortal(newSVpv(self->clusterNames[i],0)));
        }
        XSRETURN(self->numClusters);

void 
head_numRemoteHosts(self)
	LSF_Batch_jobInfoHead   *self
    PREINIT:
        int i;
    PPCODE:
        for(i=0; i< (self->numClusters); i++){
	    XPUSHs(sv_2mortal(newSViv(self->numRemoteHosts[i])));
	}  
       XSRETURN(self->numClusters);

void
head_remoteHosts(self)
	LSF_Batch_jobInfoHead   *self
    PREINIT:
        int  *numReHosts;
        int  i;
        int  numClusters,p;
        int  count=0;
    PPCODE:
        numReHosts = self -> numRemoteHosts;
        numClusters = self -> numClusters;
        for(p=0; p<numClusters; p++){
            for(i=0; i<numReHosts[p]; i++){
                XPUSHs(sv_2mortal(newSVpv(self->remoteHosts[p][i],0)));
            }
        }
	for(p=0; p<numClusters; p++){
	    count += self->numRemoteHosts[p]; 
	}
        XSRETURN(count);


MODULE = LSF::Batch	PACKAGE = LSF::Batch::jobInfoPtr	PREFIX = ji_

LSF_Batch_job *
ji_job(self)
	LSF_Batch_jobInfo *self
    CODE:
	if((RETVAL=(LSF_Batch_job *)safemalloc(sizeof(LSF_Batch_job))) == NULL){
	  STATUS_NATIVE_SET(errno);
	  SET_LSB_ERRMSG_TO("unable to allocate memory for job object");
	  XSRETURN_UNDEF;
        }
        RETVAL->jobId = LSB_ARRAY_JOBID(self->jobId);
        RETVAL->arrayIdx = LSB_ARRAY_IDX(self->jobId);
	strncpy(RETVAL->queue, self->submit.queue, MAX_LSB_NAME_LEN);
	RETVAL->badJobId = 0;
	RETVAL->badJobName[0] = 0;
	RETVAL->badReqIndx = 0;
    OUTPUT:
	RETVAL

int
ji_jobId(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = LSB_ARRAY_JOBID(self->jobId);
    OUTPUT:
	RETVAL

int
ji_arrayIdx(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = LSB_ARRAY_IDX(self->jobId);
    OUTPUT:
	RETVAL

int                                    
ji_numReasons(self)                    
        LSF_Batch_jobInfo *self        
    CODE:                              
       RETVAL = self -> numReasons;    
    OUTPUT:                            
       RETVAL                          

char *
ji_user(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->user;
    OUTPUT:
	RETVAL

int
ji_status(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->status;
    OUTPUT:
	RETVAL

#if LSF_VERSION >= 26

int
ji_maxMem(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->maxMem;
    OUTPUT:
	RETVAL

int
ji_avgMem(self)
        LSF_Batch_jobInfo *self
    CODE:
        RETVAL = self->avgMem;
    OUTPUT:
        RETVAL

char *
ji_appResReq(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->appResReq;
    OUTPUT:
	RETVAL

char *
ji_qResReq(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->qResReq;
    OUTPUT:
	RETVAL

char *
ji_combinedResReq(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->combinedResReq;
    OUTPUT:
	RETVAL

char *
ji_effectiveResReq(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->effectiveResReq;
    OUTPUT:
	RETVAL

#endif

int
ji_reasons(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->reasons;
    OUTPUT:
	RETVAL

int
ji_subreasons(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->subreasons;
    OUTPUT:
	RETVAL

void
ji_reasonTb(self)
	LSF_Batch_jobInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numReasons; i++)
          XPUSHs(sv_2mortal(newSViv(self->reasonTb[i])));	
	XSRETURN(self->numReasons);

int
ji_jobPid(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->jobPid;
    OUTPUT:
	RETVAL

char *
ji_fromHost(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->fromHost;
    OUTPUT:
	RETVAL

int
ji_submitTime(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->submitTime;
    OUTPUT:
	RETVAL

int
ji_reserveTime(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->reserveTime;
    OUTPUT:
	RETVAL

int
ji_startTime(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->startTime;
    OUTPUT:
	RETVAL

int
ji_predictedStartTime(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->predictedStartTime;
    OUTPUT:
	RETVAL

int
ji_endTime(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->endTime;
    OUTPUT:
	RETVAL

int
ji_lastEvent(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->lastEvent;
    OUTPUT:
	RETVAL

int
ji_nextEvent(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->nextEvent;
    OUTPUT:
	RETVAL

int
ji_duration(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->duration;
    OUTPUT:
	RETVAL

float
ji_cpuTime(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->cpuTime;
    OUTPUT:
	RETVAL

int
ji_umask(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->umask;
    OUTPUT:
	RETVAL

char *
ji_subHomeDir(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->subHomeDir;
    OUTPUT:
	RETVAL

char *
ji_cwd(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->cwd;
    OUTPUT:
	RETVAL

void
ji_exHosts(self)
	LSF_Batch_jobInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numExHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->exHosts[i],0)));	
	XSRETURN(self->numExHosts);

float
ji_cpuFactor(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->cpuFactor;
    OUTPUT:
	RETVAL

void
ji_loadSched(self)
	LSF_Batch_jobInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->nIdx; i++)
          XPUSHs(sv_2mortal(newSVnv(self->loadSched[i])));	
	XSRETURN(self->nIdx);

void
ji_loadStop(self)
	LSF_Batch_jobInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->nIdx; i++)
          XPUSHs(sv_2mortal(newSVnv(self->loadStop[i])));	
	XSRETURN(self->nIdx);

LSF_Batch_submit *
ji_submit(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = &self->submit;
    OUTPUT:
	RETVAL

int
ji_exitStatus(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->exitStatus;
    OUTPUT:
	RETVAL

int
ji_execUid(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->execUid;
    OUTPUT:
	RETVAL

char *
ji_execHome(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->execHome;
    OUTPUT:
	RETVAL

char *
ji_execCwd(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->execCwd;
    OUTPUT:
	RETVAL

char *
ji_execUsername(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->execUsername;
    OUTPUT:
	RETVAL

int
ji_jRusageUpdateTime(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->jRusageUpdateTime;
    OUTPUT:
	RETVAL

LSF_Batch_jRusage *
ji_runRusage(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = &self->runRusage;
    OUTPUT:
	RETVAL


int
ji_jType(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->jType;
    OUTPUT:
	RETVAL

char *
ji_parentGroup(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->parentGroup;
    OUTPUT:
	RETVAL

char *
ji_jName(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->jName;
    OUTPUT:
	RETVAL

void
ji_counter(self)
LSF_Batch_jobInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < NUM_JGRP_COUNTERS; i++)
          XPUSHs(sv_2mortal(newSVnv(self->counter[i])));	
	XSRETURN(NUM_JGRP_COUNTERS);

int
ji_jobPriority(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->jobPriority;
    OUTPUT:
	RETVAL

int
ji_numExternalMsg(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->numExternalMsg;
    OUTPUT:
	RETVAL

void
ji_externalMsg(self)
LSF_Batch_jobInfo *self
    PREINIT:
	SV *rv;
        LSF_Batch_jobExternalMsgReply **p;
	int i;
    PPCODE:
	for( i = 0, p = self->externalMsg; i < self->numExternalMsg; i++,p++ ){
	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::jobExternalMsgReplyPtr",(IV)p);
	    XPUSHs(sv_2mortal(rv));
	}
	XSRETURN(self->numExternalMsg);
	
#if LSF_VERSION >= 18

int
ji_port(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->port;
    OUTPUT:
	RETVAL

int
ji_clusterId(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->clusterId;
    OUTPUT:
	RETVAL

char *
ji_detailReason(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->detailReason;
    OUTPUT:
	RETVAL

float
ji_idleFactor(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->idleFactor;
    OUTPUT:
	RETVAL

int
ji_exceptMask(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->exceptMask;
    OUTPUT:
	RETVAL

char *
ji_additionalInfo(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->additionalInfo;
    OUTPUT:
	RETVAL

int
ji_exitInfo(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->exitInfo;
    OUTPUT:
	RETVAL

int
ji_warningTimePeriod(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->warningTimePeriod;
    OUTPUT:
	RETVAL

char *
ji_warningAction(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->warningAction;
    OUTPUT:
	RETVAL

char *
ji_chargedSAAP(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->chargedSAAP;
    OUTPUT:
	RETVAL

char *
ji_execRusage(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->execRusage;
    OUTPUT:
	RETVAL

time_t
ji_rsvInActive(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->rsvInActive;
    OUTPUT:
	RETVAL

int
ji_numLicense(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->numLicense;
    OUTPUT:
	RETVAL

void
ji_licenseNames(self)
	LSF_Batch_jobInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numLicense; i++ ){
      XPUSHs(sv_2mortal(newSVpv(self->licenseNames[i],0)));	
	}
	XSRETURN(self->numLicense);    

int
ji_numToHosts4Slots(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->numToHosts4Slots;
    OUTPUT:
	RETVAL

void
ji_toHosts4Slots(self)
	LSF_Batch_jobInfo *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numToHosts4Slots; i++ ){
      XPUSHs(sv_2mortal(newSVpv(self->toHosts4Slots[i],0)));	
	}
	XSRETURN(self->numToHosts4Slots);    


float
ji_aps(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->aps;
    OUTPUT:
	RETVAL

float
ji_adminAps(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->adminAps;
    OUTPUT:
	RETVAL

float
ji_adminFactorVal(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->adminFactorVal;
    OUTPUT:
	RETVAL

int
ji_runTime(self)
	LSF_Batch_jobInfo *self
    CODE:
	RETVAL = self->runTime;
    OUTPUT:
	RETVAL


#endif


MODULE = LSF::Batch	PACKAGE = LSF::Batch::submitPtr		PREFIX = sub_

int
sub_options(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->options;
    OUTPUT:
	RETVAL

int
sub_options2(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->options2;
    OUTPUT:
	RETVAL

char *
sub_jobName(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->jobName;
    OUTPUT:
	RETVAL

char *
sub_queue(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->queue;
    OUTPUT:
	RETVAL

void
sub_askedHosts(self)
	LSF_Batch_submit *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numAskedHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->askedHosts[i],0)));	
	XSRETURN(self->numAskedHosts);

char *
sub_resReq(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->resReq;
    OUTPUT:
	RETVAL

char *
sub_app(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->app;
    OUTPUT:
	RETVAL

void
sub_rLimits(self)
	LSF_Batch_submit *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < LSF_RLIM_NLIMITS; i++)
          XPUSHs(sv_2mortal(newSVnv(self->rLimits[i])));	
	XSRETURN(LSF_RLIM_NLIMITS);

char *
sub_hostSpec(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->hostSpec;
    OUTPUT:
	RETVAL

int
sub_numProcessors(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->numProcessors;
    OUTPUT:
	RETVAL

char *
sub_dependCond(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->dependCond;
    OUTPUT:
	RETVAL

int
sub_beginTime(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->beginTime;
    OUTPUT:
	RETVAL

int
sub_termTime(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->termTime;
    OUTPUT:
	RETVAL

int
sub_sigValue(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->sigValue;
    OUTPUT:
	RETVAL

char *
sub_inFile(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->inFile;
    OUTPUT:
	RETVAL

char *
sub_outFile(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->outFile;
    OUTPUT:
	RETVAL

char *
sub_errFile(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->errFile;
    OUTPUT:
	RETVAL

char *
sub_command(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->command;
    OUTPUT:
	RETVAL

int
sub_chkpntPeriod(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->chkpntPeriod;
    OUTPUT:
	RETVAL

char *
sub_chkpntDir(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->chkpntDir;
    OUTPUT:
	RETVAL

void
sub_xf(self)
	LSF_Batch_submit *self
    PREINIT:
	int i;
        SV *rv;
    PPCODE:
	for( i = 0; i < self->nxf; i++){
 	  rv = newRV_inc(&PL_sv_undef);
	  sv_setref_iv(rv, "LSF::Batch::xFilePtr",(IV)(self->xf + i));
	  XPUSHs(sv_2mortal(rv));
        }
	XSRETURN(self->nxf);

char *
sub_preExecCmd(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->preExecCmd;
    OUTPUT:
	RETVAL

char *
sub_mailUser(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->mailUser;
    OUTPUT:
	RETVAL

int
sub_delOptions(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->delOptions;
    OUTPUT:
	RETVAL

char *
sub_projectName(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->projectName;
    OUTPUT:
	RETVAL

int
sub_maxNumProcessors(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->maxNumProcessors;
    OUTPUT:
	RETVAL

char *
sub_loginShell(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->loginShell;
    OUTPUT:
	RETVAL

char *
sub_userGroup(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->userGroup;
    OUTPUT:
	RETVAL

char *
sub_exceptList(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->exceptList;
    OUTPUT:
	RETVAL

char *
sub_sla(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->sla;
    OUTPUT:
	RETVAL

int
sub_runtimeEstimation(self)
	LSF_Batch_submit *self
    CODE:
	RETVAL = self->runtimeEstimation;
    OUTPUT:
	RETVAL
	

MODULE = LSF::Batch       PACKAGE = LSF::Batch::jobPtr  PREFIX = job_

void
job_new(type, jobId, arrayIdx)
	char *type
	int jobId
	int arrayIdx
    PREINIT:
	LSF_Batch_job *j;
        SV *rv;
    PPCODE:
        j = (LSF_Batch_job *)safemalloc(sizeof(LSF_Batch_job));
        if( j == NULL ){
	   XSRETURN_UNDEF;
	}
	j->jobId = jobId;
        j->arrayIdx = arrayIdx;
	rv = newRV_inc(&PL_sv_undef);
	sv_setref_iv(rv, type,(IV)j);
	XPUSHs(sv_2mortal(rv));
	XSRETURN(1);

int
do_modify(self, sub)
	LSF_Batch_job *self
        HV*  sub;
    PREINIT:
        SV *rv;
        struct submit *s;
        struct submitReply reply;
        LSF_Batch_job *j;
        int error;
    CODE:
        memset(&reply, 0, sizeof(struct submitReply));
        s = (struct submit *)safemalloc(sizeof(struct submit));
        initialize_submit(s);
	if(format_submit(s, sub) < 0 ){
	  RETVAL = 0;
        }
	else{
           if (s->command == NULL) {
               s->command = (char *)calloc(64, sizeof(char));
               lsb_jobid2str_r(LSB_JOBID(self->jobId,self->arrayIdx), s->command);
           }
           s->options |= SUB_MODIFY;  
	   error = lsb_modify(s, &reply, LSB_JOBID(self->jobId,self->arrayIdx));
          if(error >= 0){
            if (NULL != reply.queue)
            {
                strncpy(self->queue, reply.queue, MAX_LSB_NAME_LEN);
            }
            RETVAL = 1;
          }
          else{
	    self->badJobId = reply.badJobId;
            self->badReqIndx = reply.badReqIndx;
            if (NULL != reply.badJobName)
                strncpy(self->badJobName, reply.badJobName, MAX_LSB_NAME_LEN);
            STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
            RETVAL = 0;
          }
        }
	free_submit(s);
    OUTPUT:
        RETVAL 
		
void
do_readjobmsg(self, r)
	LSF_Batch_job *self;
	HV *r;
    PREINIT:
    	SV *rv;
    	int port;
    	struct jobExternalMsgReply *reply;
    	struct jobExternalMsgReq *req;
		char * fileName = NULL;
    PPCODE:
    	req = (struct jobExternalMsgReq *)safemalloc(sizeof(struct jobExternalMsgReq));
    	bzero(req, sizeof(struct jobExternalMsgReq));
    	
	reply = (struct jobExternalMsgReply *)safemalloc(sizeof(struct jobExternalMsgReply));
    	bzero(reply, sizeof(struct jobExternalMsgReply));
    	
    	if (format_rjmreq(req, r, &fileName) < 0) {
            free_rjmreq(req);
            safefree(reply);
            XSRETURN_EMPTY;
    	}
    	req->jobId = self->jobId;
    	port = lsb_readjobmsg(req, reply);
        free_rjmreq(req); 	
	if (port > 0 && fileName != NULL && reply->dataSize > 0) {
	    if (readfile(port, fileName, reply->dataSize) < 0) {
	        STATUS_NATIVE_SET(lsberrno);
	        SET_LSB_ERRMSG;
	    }
	}
		
    	if(port < 0) {
	    STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
	    XSRETURN_EMPTY;
    	} else {
	    XPUSHs(sv_2mortal(newSViv(port)));
	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::jobExternalMsgReplyPtr",(IV)reply);
	    XPUSHs(sv_2mortal(rv));
    	}
    	XSRETURN(2);

int 
do_postjobmsg(self, msgReq)
	LSF_Batch_job *self
	HV*   msgReq
    PREINIT:
        struct jobExternalMsgReq *s;
        char *fileName = NULL;
	LS_LONG_INT jobId;
        int  err;
    CODE:
        s = (struct jobExternalMsgReq *)safemalloc(sizeof(struct jobExternalMsgReq));
        initialize_jobExternalMsgReq(s);
        s->jobId = self -> jobId;
        if(format_jobExternalMsgReq(s,msgReq,&fileName) < 0 ){
            RETVAL = 0;
        } else {
            err = lsb_postjobmsg(s,fileName);
	    if(err == -1){
	        STATUS_NATIVE_SET(lsberrno);
	        SET_LSF_ERRMSG;
	        RETVAL = 0;
	    }else {
	        RETVAL = 1;
	    }
	}
	safefree(s);
    OUTPUT:
        RETVAL

    	
int
job_jobId(self)
        LSF_Batch_job *self
    CODE:
        RETVAL = self->jobId;
    OUTPUT:
        RETVAL

int
job_arrayIdx(self)
        LSF_Batch_job *self
    CODE:
        RETVAL = self->arrayIdx;
    OUTPUT:
        RETVAL

char *
job_queue(self)
	LSF_Batch_job *self
    CODE:
	RETVAL = self->queue;
    OUTPUT:
	RETVAL

int
job_badJobId(self)
        LSF_Batch_job *self
    CODE:
        RETVAL = self->badJobId;
    OUTPUT:
        RETVAL

char *
job_badJobName(self)
	LSF_Batch_job *self
    CODE:
	RETVAL = self->badJobName;
    OUTPUT:
	RETVAL

int
job_badReqIndx(self)
	LSF_Batch_job *self
    CODE:
	RETVAL = self->badReqIndx;
    OUTPUT:
	RETVAL

int
job_chkpnt(self, period, options)
	LSF_Batch_job *self
	time_t period
	int options
    CODE:
	if( lsb_chkpntjob(LSB_JOBID(self->jobId,self->arrayIdx), period, options ) < 0){
	  STATUS_NATIVE_SET(lsberrno);
	  SET_LSB_ERRMSG;
	  RETVAL = 0;
	}
	else{
	  RETVAL = 1;
       }
    OUTPUT:
	RETVAL

int
job_mig(self, hosts, options)
	LSF_Batch_job *self
	char **hosts
	int options
    PREINIT:
	struct submig mig;
        char **c;
	int count = 0, idx;
    CODE:
	for(c = hosts; hosts && *c; c++ )count++;
	if( count == 0 ) hosts = NULL;
	mig.jobId = LSB_JOBID(self->jobId,self->arrayIdx);
	mig.options = options;
	mig.numAskedHosts = count;
	mig.askedHosts = hosts;
	if( lsb_mig(&mig, &idx) < 0 ){
	  STATUS_NATIVE_SET(lsberrno);
	  SET_LSB_ERRMSG;
	  RETVAL = 0;
	}
	else{
         RETVAL = 1;
	}
    OUTPUT:
	RETVAL

int
job_move(self, position, opcode)
	LSF_Batch_job *self
	int opcode
	int position
    CODE:
	if( lsb_movejob(LSB_JOBID(self->jobId,self->arrayIdx), &position, opcode ) < 0 ){
	  STATUS_NATIVE_SET(lsberrno);
	  SET_LSB_ERRMSG;
	  XSRETURN_UNDEF;
	}
	else{
	  RETVAL = position;
	}
    OUTPUT:
	RETVAL

char *
job_peek(self)
	LSF_Batch_job *self
    PREINIT:
        char *p = NULL;
    CODE:
	p = lsb_peekjob(LSB_JOBID(self->jobId,self->arrayIdx));
	if(p == NULL)
	{
           STATUS_NATIVE_SET(lsberrno);
	   SET_LSB_ERRMSG;
           XSRETURN_UNDEF;
	}
	else
	{
	  RETVAL = p;
	}
    OUTPUT:
	RETVAL


int
job_run(self, hosts, slots, options)
	LSF_Batch_job *self
	char **hosts
	int slots;
	int options
    PREINIT:
	char **h;
	int count = 0;
	struct runJobRequest r;
    CODE:
	for( h = hosts; hosts && *h; h++ ) count++;
 	r.jobId = LSB_JOBID(self->jobId,self->arrayIdx);
	r.numHosts = count;
	r.hostname = hosts;
	r.slots = &slots;
	r.options = options;
	if( lsb_runjob(&r) < 0 ){
	  STATUS_NATIVE_SET(lsberrno);
	  SET_LSB_ERRMSG;
	  RETVAL = 0;
        }
	else{
           RETVAL = 1;
        }
    OUTPUT:
	RETVAL

int
job_signal(self, signal)
        LSF_Batch_job *self
        char *signal
    PREINIT:
        int sigValue = 0;
    CODE:
        if ( (sigValue = getSignalValue(signal)) <= 0){
            char e[100];
            printf("Signal %s is not supported. \n", signal);
            SET_LSB_ERRMSG_TO(e);
            return -1;
        }

	if(lsb_signaljob(LSB_JOBID(self->jobId,self->arrayIdx), sigValue)<0){
	  STATUS_NATIVE_SET(lsberrno);
	  SET_LSB_ERRMSG;
	  RETVAL = 0;
	}
	else{
         RETVAL = 1;
        }
    OUTPUT:
	RETVAL

int
job_forcekill(self)
        LSF_Batch_job *self
    CODE:
        if(lsb_forcekilljob(LSB_JOBID(self->jobId,self->arrayIdx))<0){
          STATUS_NATIVE_SET(lsberrno);
          SET_LSB_ERRMSG;
          RETVAL = 0;
        }
        else{
         RETVAL = 1;
        }
    OUTPUT:
        RETVAL

int 
job_switch(self, queue)
	LSF_Batch_job *self
	char *queue
    CODE:
	if( lsb_switchjob(LSB_JOBID(self->jobId,self->arrayIdx), queue) < 0 ){
	  STATUS_NATIVE_SET(lsberrno);
	  SET_LSB_ERRMSG;
	  RETVAL = 0;
	}
	else{
	  RETVAL = 1;
        }
    OUTPUT:
	RETVAL

MODULE = LSF::Batch     PACKAGE = LSF::Batch    PREFIX = lsb_

char*
lsb_suspreason(self,reasons,subreasons,loadIndex)
	void *self
	int reasons
	int subreasons
	char **loadIndex
    PREINIT:
	char **h;
	int  count =0;
	struct loadIndexLog *s;
    CODE:
	for( h = loadIndex; loadIndex && *h; h++ ) count++;
	s = (struct loadIndexLog *)safemalloc (sizeof (struct loadIndexLog));
	s->nIdx = count;
	s->name = loadIndex;
	RETVAL = lsb_suspreason(reasons,subreasons,s);
	safefree(s);
    OUTPUT:	
	RETVAL

char *
lsb_pendreason(self,numReason,rsTb,jInfoH,loadIndex,clusterId)
	void     *self
	AV      *rsTb
	LSF_Batch_jobInfoHead *jInfoH
	char     **loadIndex
	int      clusterId
	int      numReason
    PREINIT:
	char **h;
	int  count =0;
	struct loadIndexLog *s;
	int *cc;
	I32   len;  
	int   *temp = NULL;
	int   i;
	SV    *element;
    CODE:
        len = av_len(rsTb);
        if(len < 0){
            STATUS_NATIVE_SET(errno);
            SET_LSB_ERRMSG_TO("Reason table is empty.");
            XSRETURN_UNDEF;
        }
        temp = (int *)safemalloc((len+1) * sizeof(int));
        if(temp == NULL){
	    STATUS_NATIVE_SET(errno);
	    SET_LSB_ERRMSG_TO("Unable to allocate memory for reason Table.");
	    XSRETURN_UNDEF;
        }
        for(i=0; i<=len; i++){
            element = av_shift(rsTb);
            if(!SvIOK(element)){
                break;
	    }
            else{
                    temp[i] = SvIV(element);
            }
        }   
        for( h = loadIndex; loadIndex && *h; h++ ) count++;
        s = (struct loadIndexLog *)safemalloc (sizeof (struct loadIndexLog));
        s->nIdx = count;
        s->name = loadIndex;
        RETVAL = lsb_pendreason(numReason, temp, jInfoH, s, clusterId);
        safefree(temp);
        safefree(s);
    OUTPUT:
        RETVAL


#if LSF_VERSION >= 34

char *
lsb_pendreason_ex(self, reasonLevel, jInfoE, jInfoH, clusterId)
	void                  * self
        int                     reasonLevel
        LSF_Batch_jobInfo     * jInfoE
 	LSF_Batch_jobInfoHead * jInfoH
 	int                     clusterId
 CODE:
     RETVAL = lsb_pendreason_ex(reasonLevel, jInfoE, jInfoH, clusterId);
 OUTPUT:
     RETVAL
 
char *
lsb_jobpendingsummary(hvreq)
       HV * hvreq
 PREINIT:
     struct jobInfoReq        * jreq    = NULL;
     struct jobPendingSummary * summary = NULL;
     char                     * retstr  = NULL;
 CODE:
     jreq = (struct jobInfoReq *)safemalloc(sizeof(struct jobInfoReq));
     bzero(jreq, sizeof(struct jobInfoReq));
     retstr = (char *)safemalloc(RETSTR_SIZE * sizeof(char));
     bzero(retstr, sizeof(RETSTR_SIZE * sizeof(char)));
 
     if (format_jobinforeq(jreq, hvreq, "bjobs_psum") < 0) {
         free_jobinforeq(jreq);
         safefree(retstr);
         SET_LSB_ERRMSG;
         XSRETURN_EMPTY;	
     }
 
     summary = lsb_jobpendingsummary(jreq);
     if (summary == NULL) {
         free_jobinforeq(jreq);
         safefree(retstr);
         STATUS_NATIVE_SET(lsberrno);
         SET_LSB_ERRMSG;
         XSRETURN_EMPTY;	
     }
     
     if ( getstr_jobpendingsummary(retstr, RETSTR_SIZE, summary, jreq->reasonLevel) < 0) {
         free_jobinforeq(jreq);
         safefree(retstr);
         SET_LSB_ERRMSG;
         XSRETURN_EMPTY;	
     }
 
     free_jobinforeq(jreq);
     RETVAL = retstr;
 OUTPUT:
     RETVAL

#endif
 
void
lsb_sharedresourceinfo(self, resources, hostName, option)
	void *self	
	char **resources
	char *hostName
	int option
    PREINIT:
	SV *rv;
	char **r;
	int i, count = 0, num;
	LSF_Batch_sharedResourceInfo *p, *si;
    PPCODE:
	for( r = resources; resources && *r; r++ ) count++;
	num = count;
	if( count == 0 ) resources = NULL;
	if(hostName && strlen(hostName)==0) hostName = NULL;
	si = lsb_sharedresourceinfo(resources, &num, hostName, option);
	if(si == NULL){
	    STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
	    XSRETURN_EMPTY;
 	}
	for( i = 0, p = si; i < num; i++,p++ ){
	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::sharedResourceInfoPtr",(IV)p);
	    XPUSHs(sv_2mortal(rv));
	}
	XSRETURN(num);



MODULE = LSF::Batch PACKAGE = LSF::Batch::sharedResourceInfoPtr PREFIX = sri_


char *
sri_resourceName(self)
	LSF_Batch_sharedResourceInfo *self;
    CODE:
	RETVAL = self->resourceName;
    OUTPUT:
	RETVAL

void 
sri_instances(self)
	LSF_Batch_sharedResourceInfo *self;
    PREINIT:
	int i;
        SV *rv;
    PPCODE:
	for( i = 0; i < self->nInstances; i++){
 	  rv = newRV_inc(&PL_sv_undef);
	  sv_setref_iv(rv, 
                       "LSF::Batch::sharedResourceInstancePtr",
                       (IV)(self->instances + i));
	  XPUSHs(sv_2mortal(rv));
        }
	XSRETURN(self->nInstances);

MODULE = LSF::Batch PACKAGE=LSF::Batch::sharedResourceInstancePtr PREFIX = ins_

char *
ins_totalValue(self)
	LSF_Batch_sharedResourceInstance *self;
    CODE:
	RETVAL = self->totalValue;
    OUTPUT:
	RETVAL

char *
ins_rsvValue(self)
	LSF_Batch_sharedResourceInstance *self;
    CODE:
	RETVAL = self->rsvValue;
    OUTPUT:
	RETVAL

void 
ins_hostList(self)
	LSF_Batch_sharedResourceInstance *self;
    PREINIT:
	int i;
        SV *rv;
    PPCODE:
	for( i = 0; i < self->nHosts; i++){
          XPUSHs(sv_2mortal(newSVpv(self->hostList[i],0)));	
        }
	XSRETURN(self->nHosts);

MODULE = LSF::Batch	PACKAGE = LSF::Batch	PREFIX = lsb_

void
lsb_hostpartinfo(self, hostParts)
	void *self
	char **hostParts
    PREINIT:
	SV *rv;
	int num, i, count;
	char **h;
	LSF_Batch_hostPartInfo *p, *pi;
    PPCODE:	
	for( h = hostParts; hostParts && *h; h++ ) count++;
	num = count;
	if( count == 0 ) hostParts = NULL;
	pi = lsb_hostpartinfo(hostParts, &num);
	if(pi == NULL){
	    STATUS_NATIVE_SET(lsberrno);
	    SET_LSB_ERRMSG;
	    XSRETURN_EMPTY;
 	}
	for( i = 0, p = pi; i < num; i++,p++ ){
	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::hostPartInfoPtr",(IV)p);
	    XPUSHs(sv_2mortal(rv));
	}
	XSRETURN(num);



MODULE = LSF::Batch	PACKAGE = LSF::Batch::hostPartInfoPtr	PREFIX = hpi_

char *
hpi_hostPart(self)
	LSF_Batch_hostPartInfo *self
    CODE:
	RETVAL = self->hostPart;
    OUTPUT:
	RETVAL

char *
hpi_hostList(self)
	LSF_Batch_hostPartInfo *self
    CODE:
	RETVAL = self->hostList;
    OUTPUT:
	RETVAL

void 
hpi_users(self)
	LSF_Batch_hostPartInfo *self;
    PREINIT:
	int i;
        SV *rv;
    PPCODE:
	for( i = 0; i < self->numUsers; i++){
          rv = newRV_inc(&PL_sv_undef);
	  sv_setref_iv(rv, 
                       "LSF::Batch::hostPartUserInfoPtr",
                        (IV)(self->users + i));
	  XPUSHs(sv_2mortal(rv));
        }
	XSRETURN(self->numUsers);


MODULE = LSF::Batch	PACKAGE = LSF::Batch::hostPartUserInfoPtr PREFIX = hpu_

char *
hpu_user(self)
	LSF_Batch_hostPartUserInfo *self
    CODE:
	RETVAL = self->user;
    OUTPUT:
	RETVAL
	
int
hpu_shares(self)
	LSF_Batch_hostPartUserInfo *self
    CODE:
	RETVAL = self->shares;
    OUTPUT:
	RETVAL
	
float
hpu_priority(self)
	LSF_Batch_hostPartUserInfo *self
    CODE:
	RETVAL = self->priority;
    OUTPUT:
	RETVAL

int	
hpu_numStartJobs(self)
	LSF_Batch_hostPartUserInfo *self
    CODE:
	RETVAL = self->numStartJobs;
    OUTPUT:
	RETVAL

int	
hpu_numReserveJobs(self)
	LSF_Batch_hostPartUserInfo *self
    CODE:
	RETVAL = self->numReserveJobs;
    OUTPUT:
	RETVAL
	
float
hpu_histCpuTime(self)
	LSF_Batch_hostPartUserInfo *self
    CODE:
	RETVAL = self->histCpuTime;
    OUTPUT:
	RETVAL

#if LSF_VERSION >= 18

int	
hpu_runTime(self)
	LSF_Batch_hostPartUserInfo *self
    CODE:
	RETVAL = self->runTime;
    OUTPUT:
	RETVAL

#endif
	
MODULE = LSF::Batch PACKAGE = LSF::Batch PREFIX = lsb_

LSF_Batch_eventRec *
lsb_geteventrecord(self, log_fp, lineNum)
	void  *self
	FILE* log_fp
	SV*   lineNum
   PREINIT:
	int ln;
   CODE:
	if( SvIOK(lineNum) ){
	   ln = (int)SvIV(lineNum);
	}
	else{
	   croak("geteventrecord: lineNum is not an integer");
	}
	if((RETVAL = lsb_geteventrecord(log_fp, &ln)) == NULL){
	  STATUS_NATIVE_SET(lsberrno);
	  SET_LSB_ERRMSG;
	  XSRETURN_UNDEF;
	}
	sv_setiv(lineNum, ln);
   OUTPUT:
	RETVAL
	 
MODULE = LSF::Batch PACKAGE = LSF::Batch::eventRecPtr PREFIX = er_

char *
er_version(self)
	LSF_Batch_eventRec *self
    CODE:
	RETVAL = self->version;
    OUTPUT:
	RETVAL

int 
er_type(self)
	LSF_Batch_eventRec *self
    CODE:
	RETVAL = self->type;
    OUTPUT:
	RETVAL

int
er_eventTime(self)
	LSF_Batch_eventRec *self
    CODE:
	RETVAL = self->eventTime;
    OUTPUT:
	RETVAL

void
er_eventLog(self)
	LSF_Batch_eventRec *self
    PREINIT:
	char *label;
	SV *rv = NULL;
    PPCODE:
	switch(self->type){
	   case EVENT_LOG_SWITCH:
	      label = "LSF::Batch::logSwitchLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.logSwitchLog);
	      break;
	   case EVENT_JGRP_ADD:
	      label = "LSF::Batch::jgrpNewLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jgrpNewLog);
	      break;
	   case EVENT_JGRP_MOD:
	      label = "LSF::Batch::jgrpNewLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jgrpNewLog);
	      break;
	   case EVENT_JGRP_CTRL:
	      label = "LSF::Batch::jgrpCtrlLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jgrpCtrlLog);
	      break;
	   case EVENT_JGRP_STATUS:
	      label = "LSF::Batch::jgrpStatusLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jgrpStatusLog);
	      break;
	   case EVENT_JOB_NEW:
	      label = "LSF::Batch::jobNewLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobNewLog);
	      break;
	   case EVENT_JOB_MODIFY:
	   case EVENT_JOB_MODIFY2:
	      label = "LSF::Batch::jobModLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobModLog);
	      break;
	   case EVENT_JOB_START:
	      label = "LSF::Batch::jobStartLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobStartLog);
	      break;
	   case EVENT_JOB_START_ACCEPT:
	      label = "LSF::Batch::jobStartAcceptLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobStartAcceptLog);
	      break;
	   case EVENT_JOB_EXECUTE:
	      label = "LSF::Batch::jobExecuteLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobExecuteLog);
	      break;
	   case EVENT_JOB_STATUS:
	      label = "LSF::Batch::jobStatusLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobStatusLog);
	      break;
	   case EVENT_SBD_JOB_STATUS:
	      label = "LSF::Batch::sbdJobStatusLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.sbdJobStatusLog);
	      break;
	   case EVENT_SBD_UNREPORTED_STATUS:
	      label = "LSF::Batch::sbdUnreportedStatusLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.sbdUnreportedStatusLog);
	      break;
	   case EVENT_JOB_SWITCH:
	      label = "LSF::Batch::jobSwitchLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobSwitchLog);
	      break;
	   case EVENT_JOB_MOVE:
	      label = "LSF::Batch::jobMoveLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobMoveLog);
	      break;
	   case EVENT_CHKPNT:
	      label = "LSF::Batch::chkpntLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.chkpntLog);
	      break;
	   case EVENT_JOB_REQUEUE:
	      label = "LSF::Batch::jobRequeueLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobRequeueLog);
	      break;
	   case EVENT_JOB_CLEAN:
	      label = "LSF::Batch::jobCleanLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobCleanLog);
	      break;
	   case EVENT_JOB_EXCEPTION:
	      label = "LSF::Batch::jobExceptionLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobExceptionLog);
	      break;
	   case EVENT_JOB_SIGACT:
	      label = "LSF::Batch::sigactLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.sigactLog);
	      break;
	   case EVENT_MIG:
	      label = "LSF::Batch::migLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.migLog);
	      break;
	   case EVENT_JOB_SIGNAL:
	      label = "LSF::Batch::signalLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.signalLog);
	      break;
	   case EVENT_QUEUE_CTRL:
	      label = "LSF::Batch::queueCtrlLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.queueCtrlLog);
	      break;
	   /*
	   case EVENT_NEW_DEBUG:
	      label = "LSF::Batch::newDebugLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.newDebugLog);
	      break;
	   */
	   case EVENT_HOST_CTRL:
	      label = "LSF::Batch::hostCtrlLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.hostCtrlLog);
	      break;
	   case EVENT_MBD_START:
	      label = "LSF::Batch::mbdStartLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.mbdStartLog);
	      break;
	   case EVENT_MBD_DIE:
	      label = "LSF::Batch::mbdDieLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.mbdDieLog);
	      break;
	   case EVENT_MBD_UNFULFILL:
	      label = "LSF::Batch::unfulfillLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.unfulfillLog);
	      break;
	   case EVENT_JOB_FINISH:
	      label = "LSF::Batch::jobFinishLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobFinishLog);
	      break;
	   case EVENT_LOAD_INDEX:
	      label = "LSF::Batch::loadIndexLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.loadIndexLog);
	      break;
	   case EVENT_CAL_NEW:
	   case EVENT_CAL_MODIFY:
	   case EVENT_CAL_DELETE:
	   case EVENT_CAL_UNDELETE:
	      label = "LSF::Batch::calendarLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.calendarLog);
	      break;
	   case EVENT_JOB_FORWARD:
	      label = "LSF::Batch::jobForwardLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobForwardLog);
	      break;
	   case EVENT_JOB_ACCEPT:
	      label = "LSF::Batch::jobAcceptLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobAcceptLog);
	      break;
	   case EVENT_STATUS_ACK:
	      label = "LSF::Batch::statusAckLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.statusAckLog);
	      break;
	   case EVENT_JOB_MSG:
	      label = "LSF::Batch::jobMsgLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobMsgLog);
	      break;
	   case EVENT_JOB_MSG_ACK:
	      label = "LSF::Batch::jobMsgAckLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobMsgAckLog);
	      break;
	   case EVENT_JOB_OCCUPY_REQ:
	      label = "LSF::Batch::jobOccupyReqLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobOccupyReqLog);
	      break;
	   case EVENT_JOB_VACATED:
	      label = "LSF::Batch::jobVacatedLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobVacatedLog);
	      break;
	   case EVENT_JOB_FORCE:
	      label = "LSF::Batch::jobForceRequestLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobForceRequestLog);
	      break;
	   case EVENT_JOB_CHUNK:
	      label = "LSF::Batch::jobChunkLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobChunkLog);
	      break;
	   case EVENT_JOB_EXT_MSG:
	      label = "LSF::Batch::jobExternalMsgLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobExternalMsgLog);
	      break;
           case EVENT_JOB_ATTR_SET:
              label = "LSF::Batch::jobAttrSetLogPtr";
              rv = newRV_inc(&PL_sv_undef);
              sv_setref_iv(rv, label, (IV)&self->eventLog.jobAttrSetLog);
              break;
	   case EVENT_ADRSV_FINISH:
	      label = "LSF::Batch::rsvFinishLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.rsvFinishLog);
	      break;
	   case EVENT_HGHOST_CTRL:
	      label = "LSF::Batch::hgCtrlLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.hgCtrlLog);
	      break;
	   case EVENT_CPUPROFILE_STATUS:
	      label = "LSF::Batch::cpuProfileLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.cpuProfileLog);
	      break;
	   case EVENT_DATA_LOGGING:
	      label = "LSF::Batch::dataLoggingLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.dataLoggingLog);
	      break;
	   case EVENT_JOB_RUN_RUSAGE:
	      label = "LSF::Batch::jobRunRusageLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobRunRusageLog);
	      break;
	   case EVENT_END_OF_STREAM:
	      label = "LSF::Batch::eventEOSLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.eventEOSLog);
	      break;
	   case EVENT_SLA_RECOMPUTE:
	      label = "LSF::Batch::slaLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.slaLog);
	      break;
	   case EVENT_METRIC_LOG:
	      label = "LSF::Batch::perfmonLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.perfmonLog);
	      break;
	   case EVENT_JOB_RESIZE_RELEASE:
	      label = "LSF::Batch::jobResizeReleaseLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobResizeReleaseLog);
	      break;
	   case EVENT_JOB_RESIZE_CANCEL:
	      label = "LSF::Batch::jobResizeCancelLogPtr";
	      rv = newRV_inc(&PL_sv_undef);
	      sv_setref_iv(rv, label, (IV)&self->eventLog.jobResizeCancelLog);
	      break;
	   default:
	      break;
	}
	if (rv) XPUSHs(sv_2mortal(rv));
	XSRETURN(1);

MODULE = LSF::Batch PACKAGE = LSF::Batch::logSwitchLogPtr PREFIX = lsl_

int
lsl_lastJobId(self)
	LSF_Batch_logSwitchLog *self
    CODE:
	RETVAL = self->lastJobId;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jgrpNewLogPtr PREFIX = jnl_

int
jnl_userId(self)
	LSF_Batch_jgrpNewLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

char *
jnl_timeEvent(self)
	LSF_Batch_jgrpNewLog *self
    CODE:
	RETVAL = self->timeEvent;
    OUTPUT:
	RETVAL

int
jnl_delOptions(self)
	LSF_Batch_jgrpNewLog *self
    CODE:
	RETVAL = self->delOptions;
    OUTPUT:
	RETVAL

int
jnl_fromPlatform(self)
	LSF_Batch_jgrpNewLog *self
    CODE:
	RETVAL = self->fromPlatform;
    OUTPUT:
	RETVAL

int
jnl_delOptions2(self)
	LSF_Batch_jgrpNewLog *self
    CODE:
	RETVAL = self->delOptions2;
    OUTPUT:
	RETVAL

char *
jnl_depCond(self)
	LSF_Batch_jgrpNewLog *self
    CODE:
	RETVAL = self->depCond;
    OUTPUT:
	RETVAL

char *
jnl_userName(self)
	LSF_Batch_jgrpNewLog *self
    CODE:
	RETVAL = self->userName;
    OUTPUT:
	RETVAL

time_t
jnl_submitTime(self)
	LSF_Batch_jgrpNewLog *self
    CODE:
	RETVAL = self->submitTime;
    OUTPUT:
	RETVAL

char *
jnl_destSpec(self)
	LSF_Batch_jgrpNewLog *self
    CODE:
	RETVAL = self->destSpec;
    OUTPUT:
	RETVAL

char *
jnl_groupSpec(self)
	LSF_Batch_jgrpNewLog *self
    CODE:
	RETVAL = self->groupSpec;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jgrpCtrlLogPtr PREFIX = jcl_

int
jcl_userId(self)
	LSF_Batch_jgrpCtrlLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

char *
jcl_userName(self)
	LSF_Batch_jgrpCtrlLog *self
    CODE:
	RETVAL = self->userName;
    OUTPUT:
	RETVAL

int
jcl_ctrlOp(self)
	LSF_Batch_jgrpCtrlLog *self
    CODE:
	RETVAL = self->ctrlOp;
    OUTPUT:
	RETVAL

char *
jcl_groupSpec(self)
	LSF_Batch_jgrpCtrlLog *self
    CODE:
	RETVAL = self->groupSpec;
    OUTPUT:
	RETVAL

int
jcl_options(self)
	LSF_Batch_jgrpCtrlLog *self
    CODE:
	RETVAL = self->options;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jgrpStatusLogPtr PREFIX = jsl_

int
jsl_status(self)
	LSF_Batch_jgrpStatusLog *self
    CODE:
	RETVAL = self->status;
    OUTPUT:
	RETVAL

int
jsl_oldStatus(self)
	LSF_Batch_jgrpStatusLog *self
    CODE:
	RETVAL = self->oldStatus;
    OUTPUT:
	RETVAL

char *
jsl_groupSpec(self)
	LSF_Batch_jgrpStatusLog *self
    CODE:
	RETVAL = self->groupSpec;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobNewLogPtr PREFIX = jnl2_

char *
jnl2_subHomeDir(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->subHomeDir;
    OUTPUT:
	RETVAL

int
jnl2_umask(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->umask;
    OUTPUT:
	RETVAL

char *
jnl2_hostSpec(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->hostSpec;
    OUTPUT:
	RETVAL

char *
jnl2_cwd(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->cwd;
    OUTPUT:
	RETVAL

int
jnl2_options(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->options;
    OUTPUT:
	RETVAL

char *
jnl2_jobSpoolDir(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->jobSpoolDir;
    OUTPUT:
	RETVAL

int
jnl2_niosPort(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->niosPort;
    OUTPUT:
	RETVAL

char *
jnl2_preExecCmd(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->preExecCmd;
    OUTPUT:
	RETVAL

int
jnl2_numProcessors(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->numProcessors;
    OUTPUT:
	RETVAL

char *
jnl2_fromHost(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->fromHost;
    OUTPUT:
	RETVAL

int
jnl2_numAskedHosts(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->numAskedHosts;
    OUTPUT:
	RETVAL

char *
jnl2_exceptList(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->exceptList;
    OUTPUT:
	RETVAL

char *
jnl2_jobFile(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->jobFile;
    OUTPUT:
	RETVAL

char *
jnl2_errFile(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->errFile;
    OUTPUT:
	RETVAL

char *
jnl2_projectName(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->projectName;
    OUTPUT:
	RETVAL

char *
jnl2_outFile(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->outFile;
    OUTPUT:
	RETVAL

char *
jnl2_schedHostType(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->schedHostType;
    OUTPUT:
	RETVAL

char *
jnl2_resReq(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->resReq;
    OUTPUT:
	RETVAL

char *
jnl2_queue(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->queue;
    OUTPUT:
	RETVAL

char *
jnl2_userName(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->userName;
    OUTPUT:
	RETVAL

int
jnl2_jobId(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

char *
jnl2_loginShell(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->loginShell;
    OUTPUT:
	RETVAL

LSF_Batch_xFile *
jnl2_xf(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->xf;
    OUTPUT:
	RETVAL

int
jnl2_restartPid(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->restartPid;
    OUTPUT:
	RETVAL

int
jnl2_sigValue(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->sigValue;
    OUTPUT:
	RETVAL

int
jnl2_maxNumProcessors(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->maxNumProcessors;
    OUTPUT:
	RETVAL

char *
jnl2_timeEvent(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->timeEvent;
    OUTPUT:
	RETVAL

char *
jnl2_mailUser(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->mailUser;
    OUTPUT:
	RETVAL

int
jnl2_options2(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->options2;
    OUTPUT:
	RETVAL

int
jnl2_idx(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
jnl2_nxf(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->nxf;
    OUTPUT:
	RETVAL

time_t
jnl2_submitTime(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->submitTime;
    OUTPUT:
	RETVAL

char *
jnl2_chkpntDir(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->chkpntDir;
    OUTPUT:
	RETVAL

int
jnl2_userPriority(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->userPriority;
    OUTPUT:
	RETVAL

time_t
jnl2_beginTime(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->beginTime;
    OUTPUT:
	RETVAL

int
jnl2_userId(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

void
jnl2_askedHosts(self)
	LSF_Batch_jobNewLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numAskedHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->askedHosts[i],0)));	
	XSRETURN(self->numAskedHosts);

char *
jnl2_userGroup(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->userGroup;
    OUTPUT:
	RETVAL

void
jnl2_rLimits(self)
	LSF_Batch_jobNewLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < LSF_RLIM_NLIMITS; i++)
          XPUSHs(sv_2mortal(newSViv(self->rLimits[i])));	
	XSRETURN(LSF_RLIM_NLIMITS);

time_t
jnl2_termTime(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->termTime;
    OUTPUT:
	RETVAL

char *
jnl2_inFileSpool(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->inFileSpool;
    OUTPUT:
	RETVAL

char *
jnl2_dependCond(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->dependCond;
    OUTPUT:
	RETVAL

char *
jnl2_jobName(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->jobName;
    OUTPUT:
	RETVAL

int
jnl2_chkpntPeriod(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->chkpntPeriod;
    OUTPUT:
	RETVAL

float
jnl2_hostFactor(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->hostFactor;
    OUTPUT:
	RETVAL

char *
jnl2_command(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->command;
    OUTPUT:
	RETVAL

char *
jnl2_inFile(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->inFile;
    OUTPUT:
	RETVAL

char *
jnl2_commandSpool(self)
	LSF_Batch_jobNewLog *self
    CODE:
	RETVAL = self->commandSpool;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobModLogPtr PREFIX = jml_

char *
jml_subHomeDir(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->subHomeDir;
    OUTPUT:
	RETVAL

char *
jml_hostSpec(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->hostSpec;
    OUTPUT:
	RETVAL

int
jml_umask(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->umask;
    OUTPUT:
	RETVAL

int
jml_delOptions(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->delOptions;
    OUTPUT:
	RETVAL

char *
jml_cwd(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->cwd;
    OUTPUT:
	RETVAL

int
jml_options(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->options;
    OUTPUT:
	RETVAL

int
jml_niosPort(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->niosPort;
    OUTPUT:
	RETVAL

char *
jml_preExecCmd(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->preExecCmd;
    OUTPUT:
	RETVAL

int
jml_numProcessors(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->numProcessors;
    OUTPUT:
	RETVAL

char *
jml_fromHost(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->fromHost;
    OUTPUT:
	RETVAL

int
jml_numAskedHosts(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->numAskedHosts;
    OUTPUT:
	RETVAL

char *
jml_jobIdStr(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->jobIdStr;
    OUTPUT:
	RETVAL

char *
jml_exceptList(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->exceptList;
    OUTPUT:
	RETVAL

char *
jml_jobFile(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->jobFile;
    OUTPUT:
	RETVAL

char *
jml_errFile(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->errFile;
    OUTPUT:
	RETVAL

char *
jml_projectName(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->projectName;
    OUTPUT:
	RETVAL

char *
jml_outFile(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->outFile;
    OUTPUT:
	RETVAL

char *
jml_schedHostType(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->schedHostType;
    OUTPUT:
	RETVAL

char *
jml_resReq(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->resReq;
    OUTPUT:
	RETVAL

int
jml_delOptions2(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->delOptions2;
    OUTPUT:
	RETVAL

char *
jml_queue(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->queue;
    OUTPUT:
	RETVAL

char *
jml_userName(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->userName;
    OUTPUT:
	RETVAL

char *
jml_loginShell(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->loginShell;
    OUTPUT:
	RETVAL

LSF_Batch_xFile *
jml_xf(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->xf;
    OUTPUT:
	RETVAL

int
jml_restartPid(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->restartPid;
    OUTPUT:
	RETVAL

int
jml_sigValue(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->sigValue;
    OUTPUT:
	RETVAL

int
jml_maxNumProcessors(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->maxNumProcessors;
    OUTPUT:
	RETVAL

char *
jml_timeEvent(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->timeEvent;
    OUTPUT:
	RETVAL

char *
jml_mailUser(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->mailUser;
    OUTPUT:
	RETVAL

int
jml_options2(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->options2;
    OUTPUT:
	RETVAL

int
jml_nxf(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->nxf;
    OUTPUT:
	RETVAL

char *
jml_chkpntDir(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->chkpntDir;
    OUTPUT:
	RETVAL

int
jml_submitTime(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->submitTime;
    OUTPUT:
	RETVAL

int
jml_userPriority(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->userPriority;
    OUTPUT:
	RETVAL

int
jml_beginTime(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->beginTime;
    OUTPUT:
	RETVAL

int
jml_userId(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

char *
jml_askedHosts(self)
	LSF_Batch_jobModLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numAskedHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->askedHosts[i],0)));	
	XSRETURN(self->numAskedHosts);

char *
jml_userGroup(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->userGroup;
    OUTPUT:
	RETVAL

int
jml_termTime(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->termTime;
    OUTPUT:
	RETVAL

void
jml_rLimits(self)
	LSF_Batch_jobModLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < LSF_RLIM_NLIMITS; i++)
          XPUSHs(sv_2mortal(newSViv(self->rLimits[i])));	
	XSRETURN(LSF_RLIM_NLIMITS);

char *
jml_dependCond(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->dependCond;
    OUTPUT:
	RETVAL

char *
jml_inFileSpool(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->inFileSpool;
    OUTPUT:
	RETVAL

char *
jml_jobName(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->jobName;
    OUTPUT:
	RETVAL

int
jml_chkpntPeriod(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->chkpntPeriod;
    OUTPUT:
	RETVAL

char *
jml_command(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->command;
    OUTPUT:
	RETVAL

char *
jml_inFile(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->inFile;
    OUTPUT:
	RETVAL

char *
jml_commandSpool(self)
	LSF_Batch_jobModLog *self
    CODE:
	RETVAL = self->commandSpool;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobStartLogPtr PREFIX = jsl2_

int
jsl2_jFlags(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->jFlags;
    OUTPUT:
	RETVAL

char *
jsl2_queuePostCmd(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->queuePostCmd;
    OUTPUT:
	RETVAL

int
jsl2_jStatus(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->jStatus;
    OUTPUT:
	RETVAL

int
jsl2_jobPGid(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->jobPGid;
    OUTPUT:
	RETVAL

int
jsl2_jobId(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

char *
jsl2_userGroup(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->userGroup;
    OUTPUT:
	RETVAL

int
jsl2_numExHosts(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->numExHosts;
    OUTPUT:
	RETVAL

float
jsl2_hostFactor(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->hostFactor;
    OUTPUT:
	RETVAL

int
jsl2_idx(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

char *
jsl2_queuePreCmd(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->queuePreCmd;
    OUTPUT:
	RETVAL

void
jsl2_execHosts(self)
	LSF_Batch_jobStartLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numExHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->execHosts[i],0)));	
	XSRETURN(self->numExHosts);

int
jsl2_jobPid(self)
	LSF_Batch_jobStartLog *self
    CODE:
	RETVAL = self->jobPid;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobStartAcceptLogPtr PREFIX = jsal_

int
jsal_jobPGid(self)
	LSF_Batch_jobStartAcceptLog *self
    CODE:
	RETVAL = self->jobPGid;
    OUTPUT:
	RETVAL

int
jsal_jobId(self)
	LSF_Batch_jobStartAcceptLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
jsal_idx(self)
	LSF_Batch_jobStartAcceptLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
jsal_jobPid(self)
	LSF_Batch_jobStartAcceptLog *self
    CODE:
	RETVAL = self->jobPid;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobExecuteLogPtr PREFIX = jel_

char *
jel_execHome(self)
	LSF_Batch_jobExecuteLog *self
    CODE:
	RETVAL = self->execHome;
    OUTPUT:
	RETVAL

int
jel_execUid(self)
	LSF_Batch_jobExecuteLog *self
    CODE:
	RETVAL = self->execUid;
    OUTPUT:
	RETVAL

int
jel_idx(self)
	LSF_Batch_jobExecuteLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
jel_jobPid(self)
	LSF_Batch_jobExecuteLog *self
    CODE:
	RETVAL = self->jobPid;
    OUTPUT:
	RETVAL

char *
jel_execUsername(self)
	LSF_Batch_jobExecuteLog *self
    CODE:
	RETVAL = self->execUsername;
    OUTPUT:
	RETVAL

int
jel_jobId(self)
	LSF_Batch_jobExecuteLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

char *
jel_execCwd(self)
	LSF_Batch_jobExecuteLog *self
    CODE:
	RETVAL = self->execCwd;
    OUTPUT:
	RETVAL

int
jel_jobPGid(self)
	LSF_Batch_jobExecuteLog *self
    CODE:
	RETVAL = self->jobPGid;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobStatusLogPtr PREFIX = jsl3_

int
jsl3_jFlags(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = self->jFlags;
    OUTPUT:
	RETVAL

int
jsl3_ru(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = self->ru;
    OUTPUT:
	RETVAL

int
jsl3_jStatus(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = self->jStatus;
    OUTPUT:
	RETVAL

int
jsl3_exitStatus(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = self->exitStatus;
    OUTPUT:
	RETVAL

LSF_Batch_lsfRusage *
jsl3_lsfRusage(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = &self->lsfRusage;
    OUTPUT:
	RETVAL

int
jsl3_reason(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = self->reason;
    OUTPUT:
	RETVAL

int
jsl3_idx(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
jsl3_subreasons(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = self->subreasons;
    OUTPUT:
	RETVAL

int
jsl3_jobId(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

time_t
jsl3_endTime(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = self->endTime;
    OUTPUT:
	RETVAL

float
jsl3_cpuTime(self)
	LSF_Batch_jobStatusLog *self
    CODE:
	RETVAL = self->cpuTime;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::sbdJobStatusLogPtr PREFIX = sjsl_

int
sjsl_actFlags(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->actFlags;
    OUTPUT:
	RETVAL

int
sjsl_reasons(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->reasons;
    OUTPUT:
	RETVAL

int
sjsl_jStatus(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->jStatus;
    OUTPUT:
	RETVAL

int
sjsl_actValue(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->actValue;
    OUTPUT:
	RETVAL

int
sjsl_idx(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
sjsl_subreasons(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->subreasons;
    OUTPUT:
	RETVAL

time_t
sjsl_actPeriod(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->actPeriod;
    OUTPUT:
	RETVAL

int
sjsl_jobId(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
sjsl_actSubReasons(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->actSubReasons;
    OUTPUT:
	RETVAL

int
sjsl_actPid(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->actPid;
    OUTPUT:
	RETVAL

int
sjsl_actStatus(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->actStatus;
    OUTPUT:
	RETVAL

int
sjsl_actReasons(self)
	LSF_Batch_sbdJobStatusLog *self
    CODE:
	RETVAL = self->actReasons;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::sbdUnreportedStatusLogPtr PREFIX = susl_

int
susl_sigValue(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->sigValue;
    OUTPUT:
	RETVAL

LSF_Batch_jRusage *
susl_runRusage(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = &self->runRusage;
    OUTPUT:
	RETVAL

char *
susl_execHome(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->execHome;
    OUTPUT:
	RETVAL

LSF_Batch_lsfRusage *
susl_lsfRusage(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = &self->lsfRusage;
    OUTPUT:
	RETVAL

int
susl_reason(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->reason;
    OUTPUT:
	RETVAL

int
susl_execUid(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->execUid;
    OUTPUT:
	RETVAL

int
susl_idx(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
susl_msgId(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->msgId;
    OUTPUT:
	RETVAL

int
susl_jobPid(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->jobPid;
    OUTPUT:
	RETVAL

char *
susl_execCwd(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->execCwd;
    OUTPUT:
	RETVAL

int
susl_jobPGid(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->jobPGid;
    OUTPUT:
	RETVAL

int
susl_exitStatus(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->exitStatus;
    OUTPUT:
	RETVAL

int
susl_subreasons(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->subreasons;
    OUTPUT:
	RETVAL

char *
susl_execUsername(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->execUsername;
    OUTPUT:
	RETVAL

int
susl_newStatus(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->newStatus;
    OUTPUT:
	RETVAL

int
susl_jobId(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
susl_actPid(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->actPid;
    OUTPUT:
	RETVAL

int
susl_actStatus(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->actStatus;
    OUTPUT:
	RETVAL

int
susl_seq(self)
	LSF_Batch_sbdUnreportedStatusLog *self
    CODE:
	RETVAL = self->seq;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobSwitchLogPtr PREFIX = jsl4_

char *
jsl4_queue(self)
	LSF_Batch_jobSwitchLog *self
    CODE:
	RETVAL = self->queue;
    OUTPUT:
	RETVAL

int
jsl4_userId(self)
	LSF_Batch_jobSwitchLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

int
jsl4_jobId(self)
	LSF_Batch_jobSwitchLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
jsl4_idx(self)
	LSF_Batch_jobSwitchLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobMoveLogPtr PREFIX = jml2_

int
jml2_userId(self)
	LSF_Batch_jobMoveLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

int
jml2_jobId(self)
	LSF_Batch_jobMoveLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
jml2_base(self)
	LSF_Batch_jobMoveLog *self
    CODE:
	RETVAL = self->base;
    OUTPUT:
	RETVAL

int
jml2_position(self)
	LSF_Batch_jobMoveLog *self
    CODE:
	RETVAL = self->position;
    OUTPUT:
	RETVAL

int
jml2_idx(self)
	LSF_Batch_jobMoveLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::chkpntLogPtr PREFIX = cl_

int
cl_jobId(self)
	LSF_Batch_chkpntLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
cl_flags(self)
	LSF_Batch_chkpntLog *self
    CODE:
	RETVAL = self->flags;
    OUTPUT:
	RETVAL

time_t
cl_period(self)
	LSF_Batch_chkpntLog *self
    CODE:
	RETVAL = self->period;
    OUTPUT:
	RETVAL

int
cl_idx(self)
	LSF_Batch_chkpntLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
cl_ok(self)
	LSF_Batch_chkpntLog *self
    CODE:
	RETVAL = self->ok;
    OUTPUT:
	RETVAL

int
cl_pid(self)
	LSF_Batch_chkpntLog *self
    CODE:
	RETVAL = self->pid;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobRequeueLogPtr PREFIX = jrl_

int
jrl_jobId(self)
	LSF_Batch_jobRequeueLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
jrl_idx(self)
	LSF_Batch_jobRequeueLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobCleanLogPtr PREFIX = jcl2_

int
jcl2_jobId(self)
	LSF_Batch_jobCleanLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
jcl2_idx(self)
	LSF_Batch_jobCleanLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobExceptionLogPtr PREFIX = jel2_

int
jel2_exceptMask(self)
	LSF_Batch_jobExceptionLog *self
    CODE:
	RETVAL = self->exceptMask;
    OUTPUT:
	RETVAL

int
jel2_jobId(self)
	LSF_Batch_jobExceptionLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
jel2_exceptInfo(self)
	LSF_Batch_jobExceptionLog *self
    CODE:
	RETVAL = self->exceptInfo;
    OUTPUT:
	RETVAL

time_t
jel2_timeEvent(self)
	LSF_Batch_jobExceptionLog *self
    CODE:
	RETVAL = self->timeEvent;
    OUTPUT:
	RETVAL

int
jel2_actMask(self)
	LSF_Batch_jobExceptionLog *self
    CODE:
	RETVAL = self->actMask;
    OUTPUT:
	RETVAL

int
jel2_idx(self)
	LSF_Batch_jobExceptionLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::sigactLogPtr PREFIX = sl_

int
sl_reasons(self)
	LSF_Batch_sigactLog *self
    CODE:
	RETVAL = self->reasons;
    OUTPUT:
	RETVAL

int
sl_jStatus(self)
	LSF_Batch_sigactLog *self
    CODE:
	RETVAL = self->jStatus;
    OUTPUT:
	RETVAL

char *
sl_signalSymbol(self)
	LSF_Batch_sigactLog *self
    CODE:
	RETVAL = self->signalSymbol;
    OUTPUT:
	RETVAL

int
sl_flags(self)
	LSF_Batch_sigactLog *self
    CODE:
	RETVAL = self->flags;
    OUTPUT:
	RETVAL

time_t
sl_period(self)
	LSF_Batch_sigactLog *self
    CODE:
	RETVAL = self->period;
    OUTPUT:
	RETVAL

int
sl_idx(self)
	LSF_Batch_sigactLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
sl_jobId(self)
	LSF_Batch_sigactLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
sl_actStatus(self)
	LSF_Batch_sigactLog *self
    CODE:
	RETVAL = self->actStatus;
    OUTPUT:
	RETVAL

int
sl_pid(self)
	LSF_Batch_sigactLog *self
    CODE:
	RETVAL = self->pid;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::migLogPtr PREFIX = ml_

int
ml_userId(self)
	LSF_Batch_migLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

char *
ml_askedHosts(self)
	LSF_Batch_migLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numAskedHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->askedHosts[i],0)));	
	XSRETURN(self->numAskedHosts);

int
ml_jobId(self)
	LSF_Batch_migLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
ml_numAskedHosts(self)
	LSF_Batch_migLog *self
    CODE:
	RETVAL = self->numAskedHosts;
    OUTPUT:
	RETVAL

int
ml_idx(self)
	LSF_Batch_migLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::signalLogPtr PREFIX = sl2_

int
sl2_userId(self)
	LSF_Batch_signalLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

char *
sl2_signalSymbol(self)
	LSF_Batch_signalLog *self
    CODE:
	RETVAL = self->signalSymbol;
    OUTPUT:
	RETVAL

int
sl2_jobId(self)
	LSF_Batch_signalLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
sl2_runCount(self)
	LSF_Batch_signalLog *self
    CODE:
	RETVAL = self->runCount;
    OUTPUT:
	RETVAL

int
sl2_idx(self)
	LSF_Batch_signalLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::queueCtrlLogPtr PREFIX = qcl_

int
qcl_userId(self)
	LSF_Batch_queueCtrlLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

char *
qcl_queue(self)
	LSF_Batch_queueCtrlLog *self
    CODE:
	RETVAL = self->queue;
    OUTPUT:
	RETVAL

int
qcl_opCode(self)
	LSF_Batch_queueCtrlLog *self
    CODE:
	RETVAL = self->opCode;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::newDebugLogPtr PREFIX = ndl_

int
ndl_userId(self)
	LSF_Batch_newDebugLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

int
ndl_logclass(self)
	LSF_Batch_newDebugLog *self
    CODE:
	RETVAL = self->_logclass;
    OUTPUT:
	RETVAL

int
ndl_level(self)
	LSF_Batch_newDebugLog *self
    CODE:
	RETVAL = self->level;
    OUTPUT:
	RETVAL

int
ndl_turnOff(self)
	LSF_Batch_newDebugLog *self
    CODE:
	RETVAL = self->turnOff;
    OUTPUT:
	RETVAL

int
ndl_opCode(self)
	LSF_Batch_newDebugLog *self
    CODE:
	RETVAL = self->opCode;
    OUTPUT:
	RETVAL

char *
ndl_logFileName(self)
	LSF_Batch_newDebugLog *self
    CODE:
	RETVAL = self->logFileName;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::hostCtrlLogPtr PREFIX = hcl_

int
hcl_userId(self)
	LSF_Batch_hostCtrlLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

int
hcl_opCode(self)
	LSF_Batch_hostCtrlLog *self
    CODE:
	RETVAL = self->opCode;
    OUTPUT:
	RETVAL

char *
hcl_host(self)
	LSF_Batch_hostCtrlLog *self
    CODE:
	RETVAL = self->host;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::mbdStartLogPtr PREFIX = msl_

char *
msl_cluster(self)
	LSF_Batch_mbdStartLog *self
    CODE:
	RETVAL = self->cluster;
    OUTPUT:
	RETVAL

char *
msl_master(self)
	LSF_Batch_mbdStartLog *self
    CODE:
	RETVAL = self->master;
    OUTPUT:
	RETVAL

int
msl_numHosts(self)
	LSF_Batch_mbdStartLog *self
    CODE:
	RETVAL = self->numHosts;
    OUTPUT:
	RETVAL

int
msl_numQueues(self)
	LSF_Batch_mbdStartLog *self
    CODE:
	RETVAL = self->numQueues;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::mbdDieLogPtr PREFIX = mdl_

int
mdl_exitCode(self)
	LSF_Batch_mbdDieLog *self
    CODE:
	RETVAL = self->exitCode;
    OUTPUT:
	RETVAL

char *
mdl_master(self)
	LSF_Batch_mbdDieLog *self
    CODE:
	RETVAL = self->master;
    OUTPUT:
	RETVAL

int
mdl_numRemoveJobs(self)
	LSF_Batch_mbdDieLog *self
    CODE:
	RETVAL = self->numRemoveJobs;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::unfulfillLogPtr PREFIX = ul_

int
ul_sig1(self)
	LSF_Batch_unfulfillLog *self
    CODE:
	RETVAL = self->sig1;
    OUTPUT:
	RETVAL

int
ul_jobId(self)
	LSF_Batch_unfulfillLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

time_t
ul_chkPeriod(self)
	LSF_Batch_unfulfillLog *self
    CODE:
	RETVAL = self->chkPeriod;
    OUTPUT:
	RETVAL

int
ul_sig(self)
	LSF_Batch_unfulfillLog *self
    CODE:
	RETVAL = self->sig;
    OUTPUT:
	RETVAL

int
ul_idx(self)
	LSF_Batch_unfulfillLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
ul_notSwitched(self)
	LSF_Batch_unfulfillLog *self
    CODE:
	RETVAL = self->notSwitched;
    OUTPUT:
	RETVAL

int
ul_sig1Flags(self)
	LSF_Batch_unfulfillLog *self
    CODE:
	RETVAL = self->sig1Flags;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobFinishLogPtr PREFIX = jfl_

char *
jfl_cwd(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->cwd;
    OUTPUT:
	RETVAL

int
jfl_options(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->options;
    OUTPUT:
	RETVAL

char *
jfl_preExecCmd(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->preExecCmd;
    OUTPUT:
	RETVAL

time_t
jfl_startTime(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->startTime;
    OUTPUT:
	RETVAL

int
jfl_numProcessors(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->numProcessors;
    OUTPUT:
	RETVAL

char *
jfl_fromHost(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->fromHost;
    OUTPUT:
	RETVAL

int
jfl_numAskedHosts(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->numAskedHosts;
    OUTPUT:
	RETVAL

time_t
jfl_endTime(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->endTime;
    OUTPUT:
	RETVAL

char *
jfl_jobFile(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->jobFile;
    OUTPUT:
	RETVAL

char *
jfl_errFile(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->errFile;
    OUTPUT:
	RETVAL

char *
jfl_projectName(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->projectName;
    OUTPUT:
	RETVAL

char *
jfl_outFile(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->outFile;
    OUTPUT:
	RETVAL

int
jfl_exitStatus(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->exitStatus;
    OUTPUT:
	RETVAL

int
jfl_maxRMem(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->maxRMem;
    OUTPUT:
	RETVAL

int
jfl_maxRSwap(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->maxRSwap;
    OUTPUT:
	RETVAL

char *
jfl_resReq(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->resReq;
    OUTPUT:
	RETVAL

char *
jfl_queue(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->queue;
    OUTPUT:
	RETVAL

char *
jfl_userName(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->userName;
    OUTPUT:
	RETVAL

int
jfl_jobId(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

char *
jfl_loginShell(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->loginShell;
    OUTPUT:
	RETVAL

void
jfl_execHosts(self)
	LSF_Batch_jobFinishLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numExHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->execHosts[i],0)));	
	XSRETURN(self->numExHosts);

float
jfl_cpuTime(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->cpuTime;
    OUTPUT:
	RETVAL

int
jfl_maxNumProcessors(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->maxNumProcessors;
    OUTPUT:
	RETVAL

LSF_Batch_lsfRusage *
jfl_lsfRusage(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = &self->lsfRusage;
    OUTPUT:
	RETVAL

char *
jfl_timeEvent(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->timeEvent;
    OUTPUT:
	RETVAL

char *
jfl_mailUser(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->mailUser;
    OUTPUT:
	RETVAL

int
jfl_idx(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

time_t
jfl_submitTime(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->submitTime;
    OUTPUT:
	RETVAL

time_t
jfl_beginTime(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->beginTime;
    OUTPUT:
	RETVAL

int
jfl_jStatus(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->jStatus;
    OUTPUT:
	RETVAL

int
jfl_userId(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

char *
jfl_askedHosts(self)
	LSF_Batch_jobFinishLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numAskedHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->askedHosts[i],0)));	
	XSRETURN(self->numAskedHosts);

time_t
jfl_termTime(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->termTime;
    OUTPUT:
	RETVAL

char *
jfl_inFileSpool(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->inFileSpool;
    OUTPUT:
	RETVAL

char *
jfl_dependCond(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->dependCond;
    OUTPUT:
	RETVAL

char *
jfl_jobName(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->jobName;
    OUTPUT:
	RETVAL

float
jfl_hostFactor(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->hostFactor;
    OUTPUT:
	RETVAL

int
jfl_numExHosts(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->numExHosts;
    OUTPUT:
	RETVAL

char *
jfl_command(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->command;
    OUTPUT:
	RETVAL

char *
jfl_inFile(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->inFile;
    OUTPUT:
	RETVAL

char *
jfl_commandSpool(self)
	LSF_Batch_jobFinishLog *self
    CODE:
	RETVAL = self->commandSpool;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::loadIndexLogPtr PREFIX = lil_

void
lil_name(self)
	LSF_Batch_loadIndexLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->nIdx; i++)
          XPUSHs(sv_2mortal(newSVpv(self->name[i],0)));	
	XSRETURN(self->nIdx);

int
lil_nIdx(self)
	LSF_Batch_loadIndexLog *self
    CODE:
	RETVAL = self->nIdx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::calendarLogPtr PREFIX = cl2_

int
cl2_userId(self)
	LSF_Batch_calendarLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

char *
cl2_calExpr(self)
	LSF_Batch_calendarLog *self
    CODE:
	RETVAL = self->calExpr;
    OUTPUT:
	RETVAL

char *
cl2_desc(self)
	LSF_Batch_calendarLog *self
    CODE:
	RETVAL = self->desc;
    OUTPUT:
	RETVAL

int
cl2_options(self)
	LSF_Batch_calendarLog *self
    CODE:
	RETVAL = self->options;
    OUTPUT:
	RETVAL

char *
cl2_name(self)
	LSF_Batch_calendarLog *self
    CODE:
	RETVAL = self->name;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobForwardLogPtr PREFIX = jfl2_

void
jfl2_reserHosts(self)
	LSF_Batch_jobForwardLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numReserHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->reserHosts[i],0)));	
	XSRETURN(self->numReserHosts);

int
jfl2_jobId(self)
	LSF_Batch_jobForwardLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

char *
jfl2_cluster(self)
	LSF_Batch_jobForwardLog *self
    CODE:
	RETVAL = self->cluster;
    OUTPUT:
	RETVAL

int
jfl2_numReserHosts(self)
	LSF_Batch_jobForwardLog *self
    CODE:
	RETVAL = self->numReserHosts;
    OUTPUT:
	RETVAL

int
jfl2_idx(self)
	LSF_Batch_jobForwardLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobAcceptLogPtr PREFIX = jal_

LSF_Batch_job *
jal_remoteJid(self)
	LSF_Batch_jobAcceptLog *self
    CODE:
	RETVAL = (LSF_Batch_job *)safemalloc(sizeof(LSF_Batch_job));
	RETVAL->jobId = LSB_ARRAY_JOBID(self->remoteJid);
	RETVAL->arrayIdx = LSB_ARRAY_IDX(self->remoteJid);
    OUTPUT:
	RETVAL

int
jal_jobId(self)
	LSF_Batch_jobAcceptLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

char *
jal_cluster(self)
	LSF_Batch_jobAcceptLog *self
    CODE:
	RETVAL = self->cluster;
    OUTPUT:
	RETVAL

int
jal_idx(self)
	LSF_Batch_jobAcceptLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::statusAckLogPtr PREFIX = sal_

int
sal_jobId(self)
	LSF_Batch_statusAckLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
sal_idx(self)
	LSF_Batch_statusAckLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
sal_statusNum(self)
	LSF_Batch_statusAckLog *self
    CODE:
	RETVAL = self->statusNum;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobMsgLogPtr PREFIX = jml3_

int
jml3_usrId(self)
	LSF_Batch_jobMsgLog *self
    CODE:
	RETVAL = self->usrId;
    OUTPUT:
	RETVAL

int
jml3_idx(self)
	LSF_Batch_jobMsgLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

char *
jml3_dest(self)
	LSF_Batch_jobMsgLog *self
    CODE:
	RETVAL = self->dest;
    OUTPUT:
	RETVAL

int
jml3_msgId(self)
	LSF_Batch_jobMsgLog *self
    CODE:
	RETVAL = self->msgId;
    OUTPUT:
	RETVAL

int
jml3_jobId(self)
	LSF_Batch_jobMsgLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

char *
jml3_src(self)
	LSF_Batch_jobMsgLog *self
    CODE:
	RETVAL = self->src;
    OUTPUT:
	RETVAL

int
jml3_type(self)
	LSF_Batch_jobMsgLog *self
    CODE:
	RETVAL = self->type;
    OUTPUT:
	RETVAL

char *
jml3_msg(self)
	LSF_Batch_jobMsgLog *self
    CODE:
	RETVAL = self->msg;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobMsgAckLogPtr PREFIX = jmal_

int
jmal_usrId(self)
	LSF_Batch_jobMsgAckLog *self
    CODE:
	RETVAL = self->usrId;
    OUTPUT:
	RETVAL

int
jmal_idx(self)
	LSF_Batch_jobMsgAckLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

char *
jmal_dest(self)
	LSF_Batch_jobMsgAckLog *self
    CODE:
	RETVAL = self->dest;
    OUTPUT:
	RETVAL

int
jmal_msgId(self)
	LSF_Batch_jobMsgAckLog *self
    CODE:
	RETVAL = self->msgId;
    OUTPUT:
	RETVAL

int
jmal_jobId(self)
	LSF_Batch_jobMsgAckLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

char *
jmal_src(self)
	LSF_Batch_jobMsgAckLog *self
    CODE:
	RETVAL = self->src;
    OUTPUT:
	RETVAL

int
jmal_type(self)
	LSF_Batch_jobMsgAckLog *self
    CODE:
	RETVAL = self->type;
    OUTPUT:
	RETVAL

char *
jmal_msg(self)
	LSF_Batch_jobMsgAckLog *self
    CODE:
	RETVAL = self->msg;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobOccupyReqLogPtr PREFIX = jorl_

int
jorl_numOccupyRequests(self)
	LSF_Batch_jobOccupyReqLog *self
    CODE:
	RETVAL = self->numOccupyRequests;
    OUTPUT:
	RETVAL

int
jorl_userId(self)
	LSF_Batch_jobOccupyReqLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

int
jorl_jobId(self)
	LSF_Batch_jobOccupyReqLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

void *
jorl_occupyReqList(self)
	LSF_Batch_jobOccupyReqLog *self
    CODE:
	RETVAL = self->occupyReqList;
    OUTPUT:
	RETVAL

int
jorl_idx(self)
	LSF_Batch_jobOccupyReqLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobVacatedLogPtr PREFIX = jvl_

int
jvl_userId(self)
	LSF_Batch_jobVacatedLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

int
jvl_jobId(self)
	LSF_Batch_jobVacatedLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
jvl_idx(self)
	LSF_Batch_jobVacatedLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobForceRequestLogPtr PREFIX = jfrl_

int
jfrl_userId(self)
	LSF_Batch_jobForceRequestLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

int
jfrl_jobId(self)
	LSF_Batch_jobForceRequestLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

int
jfrl_numExecHosts(self)
	LSF_Batch_jobForceRequestLog *self
    CODE:
	RETVAL = self->numExecHosts;
    OUTPUT:
	RETVAL

int
jfrl_options(self)
	LSF_Batch_jobForceRequestLog *self
    CODE:
	RETVAL = self->options;
    OUTPUT:
	RETVAL

int
jfrl_idx(self)
	LSF_Batch_jobForceRequestLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

char**
jfrl_execHosts(self)
	LSF_Batch_jobForceRequestLog *self
    CODE:
	RETVAL = self->execHosts;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobChunkLogPtr PREFIX = jcl3_

void
jcl3_membJobId(self)
	LSF_Batch_jobChunkLog *self
    PREINIT:
	LS_LONG_INT id;
	int i;
	LSF_Batch_job *j;
	SV *rv;
    PPCODE:
	for( i = 0; i < self->membSize; i++){
	   j = (LSF_Batch_job *)safemalloc(sizeof(LSF_Batch_job));
	   j->jobId = LSB_ARRAY_JOBID(id);
	   j->arrayIdx = LSB_ARRAY_IDX(id);
	   rv = newRV_inc(&PL_sv_undef);
	   sv_setref_iv(rv, "LSF::Batch::jobPtr", (IV)&j);
	   XPUSHs(sv_2mortal(rv));
	}
	XSRETURN(self->membSize);

long
jcl3_numExHosts(self)
	LSF_Batch_jobChunkLog *self
    CODE:
	RETVAL = self->numExHosts;
    OUTPUT:
	RETVAL

long
jcl3_membSize(self)
	LSF_Batch_jobChunkLog *self
    CODE:
	RETVAL = self->membSize;
    OUTPUT:
	RETVAL

void
jcl3_execHosts(self)
	LSF_Batch_jobChunkLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numExHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->execHosts[i],0)));	
	XSRETURN(self->numExHosts);

MODULE = LSF::Batch PACKAGE = LSF::Batch::jobExternalMsgLogPtr PREFIX = jeml_

int
jeml_userId(self)
	LSF_Batch_jobExternalMsgLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

int
jeml_jobId(self)
	LSF_Batch_jobExternalMsgLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

char *
jeml_fileName(self)
	LSF_Batch_jobExternalMsgLog *self
    CODE:
	RETVAL = self->fileName;
    OUTPUT:
	RETVAL

int
jeml_dataStatus(self)
	LSF_Batch_jobExternalMsgLog *self
    CODE:
	RETVAL = self->dataStatus;
    OUTPUT:
	RETVAL

time_t
jeml_postTime(self)
	LSF_Batch_jobExternalMsgLog *self
    CODE:
	RETVAL = self->postTime;
    OUTPUT:
	RETVAL

char *
jeml_desc(self)
	LSF_Batch_jobExternalMsgLog *self
    CODE:
	RETVAL = self->desc;
    OUTPUT:
	RETVAL

long
jeml_dataSize(self)
	LSF_Batch_jobExternalMsgLog *self
    CODE:
	RETVAL = self->dataSize;
    OUTPUT:
	RETVAL

int
jeml_idx(self)
	LSF_Batch_jobExternalMsgLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
jeml_msgIdx(self)
	LSF_Batch_jobExternalMsgLog *self
    CODE:
	RETVAL = self->msgIdx;
    OUTPUT:
	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobAttrSetLogPtr PREFIX = jasl_

int
jasl_jobId(self)
	LSF_Batch_jobAttrSetLog *self
    CODE:
	RETVAL = self->jobId;
    OUTPUT:
	RETVAL

char *
jasl_hostname(self)
	LSF_Batch_jobAttrSetLog *self
    CODE:
	RETVAL = self->hostname;
    OUTPUT:
	RETVAL

int
jasl_port(self)
	LSF_Batch_jobAttrSetLog *self
    CODE:
	RETVAL = self->port;
    OUTPUT:
	RETVAL

int
jasl_idx(self)
	LSF_Batch_jobAttrSetLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

int
jasl_uid(self)
	LSF_Batch_jobAttrSetLog *self
    CODE:
	RETVAL = self->uid;
    OUTPUT:
	RETVAL
	
MODULE = LSF::Batch PACKAGE = LSF::Batch::rsvFinishLogPtr PREFIX = rsvf_

time_t
rsvf_rsvReqTime(self)
	LSF_Batch_rsvFinishLog *self
    CODE:
	RETVAL = self->rsvReqTime;
    OUTPUT:
	RETVAL

int
rsvf_uid(self)
	LSF_Batch_rsvFinishLog *self
    CODE:
	RETVAL = self->uid;
    OUTPUT:
	RETVAL
	
char *
rsvf_rsvId(self)
	LSF_Batch_rsvFinishLog *self
    CODE:
	RETVAL = self->rsvId;
    OUTPUT:
	RETVAL
	
char *
rsvf_name(self)
	LSF_Batch_rsvFinishLog *self
    CODE:
	RETVAL = self->name;
    OUTPUT:
	RETVAL

int
rsvf_numReses(self)
	LSF_Batch_rsvFinishLog *self
    CODE:
	RETVAL = self->numReses;
    OUTPUT:
	RETVAL
	
LSF_Batch_rsvRes *
rsvf_alloc(self)
	LSF_Batch_rsvFinishLog *self
    CODE:
	RETVAL = self->alloc;
    OUTPUT:
	RETVAL
	
char *
rsvf_timeWindow(self)
	LSF_Batch_rsvFinishLog *self
    CODE:
	RETVAL = self->timeWindow;
    OUTPUT:
	RETVAL
	
time_t
rsvf_duration(self)
	LSF_Batch_rsvFinishLog *self
    CODE:
	RETVAL = self->duration;
    OUTPUT:
	RETVAL

char *
rsvf_creator(self)
	LSF_Batch_rsvFinishLog *self
    CODE:
	RETVAL = self->creator;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::hgCtrlLogPtr PREFIX = hgctrl_

char *
hgctrl_host(self)
	LSF_Batch_hgCtrlLog *self
    CODE:
	RETVAL = self->host;
    OUTPUT:
	RETVAL

char *
hgctrl_grpname(self)
	LSF_Batch_hgCtrlLog *self
    CODE:
	RETVAL = self->grpname;
    OUTPUT:
	RETVAL

int
hgctrl_userId(self)
	LSF_Batch_hgCtrlLog *self
    CODE:
	RETVAL = self->userId;
    OUTPUT:
	RETVAL

char *
hgctrl_userName(self)
	LSF_Batch_hgCtrlLog *self
    CODE:
	RETVAL = self->userName;
    OUTPUT:
	RETVAL

char *
hgctrl_message(self)
	LSF_Batch_hgCtrlLog *self
    CODE:
	RETVAL = self->message;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::cpuProfileLogPtr PREFIX = cpupro_

char *
cpupro_servicePartition(self)
	LSF_Batch_cpuProfileLog *self
    CODE:
	RETVAL = self->servicePartition;
    OUTPUT:
	RETVAL

int
cpupro_slotsRequired(self)
	LSF_Batch_cpuProfileLog *self
    CODE:
	RETVAL = self->slotsRequired;
    OUTPUT:
	RETVAL

int
cpupro_slotsAllocated(self)
	LSF_Batch_cpuProfileLog *self
    CODE:
	RETVAL = self->slotsAllocated;
    OUTPUT:
	RETVAL

int
cpupro_slotsBorrowed(self)
	LSF_Batch_cpuProfileLog *self
    CODE:
	RETVAL = self->slotsBorrowed;
    OUTPUT:
	RETVAL

int
cpupro_slotsLent(self)
	LSF_Batch_cpuProfileLog *self
    CODE:
	RETVAL = self->slotsLent;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::dataLoggingLogPtr PREFIX = dtlogin_

time_t
dtlogin_loggingTime(self)
	LSF_Batch_dataLoggingLog *self
    CODE:
	RETVAL = self->loggingTime;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::jobRunRusageLogPtr PREFIX = jrr_

int
jrr_jobid(self)
	LSF_Batch_jobRunRusageLog *self
    CODE:
	RETVAL = self->jobid;
    OUTPUT:
	RETVAL

int
jrr_idx(self)
	LSF_Batch_jobRunRusageLog *self
    CODE:
	RETVAL = self->idx;
    OUTPUT:
	RETVAL

LSF_Batch_jRusage * 
jrr_jrusage(self)
	LSF_Batch_jobRunRusageLog *self
    CODE:
	RETVAL = &(self->jrusage);
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::eventEOSLogPtr PREFIX = eeos_

int
eeos_eos(self)
	LSF_Batch_eventEOSLog *self
    CODE:
	RETVAL = self->eos;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::slaLogPtr PREFIX = sla_

char *
sla_name(self)
	LSF_Batch_slaLog *self
    CODE:
	RETVAL = self->name;
    OUTPUT:
	RETVAL

char *
sla_consumer(self)
	LSF_Batch_slaLog *self
    CODE:
	RETVAL = self->consumer;
    OUTPUT:
	RETVAL

int
sla_goaltype(self)
	LSF_Batch_slaLog *self
    CODE:
	RETVAL = self->goaltype;
    OUTPUT:
	RETVAL

int
sla_state(self)
	LSF_Batch_slaLog *self
    CODE:
	RETVAL = self->state;
    OUTPUT:
	RETVAL

int
sla_optimum(self)
	LSF_Batch_slaLog *self
    CODE:
	RETVAL = self->optimum;
    OUTPUT:
	RETVAL

int *
sla_counters(self)
	LSF_Batch_slaLog *self
    CODE:
	RETVAL = self->counters;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::perfmonLogPtr PREFIX = perf_

int
perf_samplePeriod(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->samplePeriod;
    OUTPUT:
	RETVAL

int 
perf_totalQueries(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->totalQueries;
    OUTPUT:
	RETVAL

int 
perf_jobQuries(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->jobQuries;
    OUTPUT:
	RETVAL

int 
perf_queueQuries(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->queueQuries;
    OUTPUT:
	RETVAL

int 
perf_hostQuries(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->hostQuries;
    OUTPUT:
	RETVAL

int 
perf_submissionRequest(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->submissionRequest;
    OUTPUT:
	RETVAL

int 
perf_jobSubmitted(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->jobSubmitted;
    OUTPUT:
	RETVAL

int 
perf_dispatchedjobs(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->dispatchedjobs;
    OUTPUT:
	RETVAL

int 
perf_jobcompleted(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->jobcompleted;
    OUTPUT:
	RETVAL

int 
perf_jobMCSend(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->jobMCSend;
    OUTPUT:
	RETVAL

int 
perf_jobMCReceive(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->jobMCReceive;
    OUTPUT:
	RETVAL

time_t
perf_startTime(self)
	LSF_Batch_perfmonLog *self
    CODE:
	RETVAL = self->startTime;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::lsfRusagePtr PREFIX = lr_

double
lr_ru_utime(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_utime;
    OUTPUT:
	RETVAL

double
lr_ru_stime(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_stime;
    OUTPUT:
	RETVAL

double
lr_ru_maxrss(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_maxrss;
    OUTPUT:
	RETVAL

double
lr_ru_ixrss(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_ixrss;
    OUTPUT:
	RETVAL

double
lr_ru_ismrss(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_ismrss;
    OUTPUT:
	RETVAL

double
lr_ru_idrss(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_idrss;
    OUTPUT:
	RETVAL

double
lr_ru_isrss(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_isrss;
    OUTPUT:
	RETVAL

double
lr_ru_minflt(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_minflt;
    OUTPUT:
	RETVAL

double
lr_ru_majflt(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_majflt;
    OUTPUT:
	RETVAL

double
lr_ru_nswap(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_nswap;
    OUTPUT:
	RETVAL

double
lr_ru_inblock(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_inblock;
    OUTPUT:
	RETVAL

double
lr_ru_oublock(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_oublock;
    OUTPUT:
	RETVAL

double
lr_ru_ioch(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_ioch;
    OUTPUT:
	RETVAL

double
lr_ru_msgsnd(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_msgsnd;
    OUTPUT:
	RETVAL

double
lr_ru_msgrcv(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_msgrcv;
    OUTPUT:
	RETVAL

double
lr_ru_nsignals(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_nsignals;
    OUTPUT:
	RETVAL

double
lr_ru_nvcsw(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_nvcsw;
    OUTPUT:
	RETVAL

double
lr_ru_nivcsw(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_nivcsw;
    OUTPUT:
	RETVAL

double
lr_ru_exutime(self)
	LSF_Batch_lsfRusage *self
    CODE:
        RETVAL = self->ru_exutime;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::rsvResPtr PREFIX = rsvr_

char *
rsvr_resName(self)
	LSF_Batch_rsvRes *self
    CODE:
        RETVAL = self->resName;
    OUTPUT:
	RETVAL

int
rsvr_count(self)
	LSF_Batch_rsvRes *self
    CODE:
        RETVAL = self->count;
    OUTPUT:
	RETVAL
	
int
rsvr_usedAmt(self)
	LSF_Batch_rsvRes *self
    CODE:
        RETVAL = self->usedAmt;
    OUTPUT:
	RETVAL
	
MODULE = LSF::Batch PACKAGE = LSF::Batch::apsFactorInfoPtr PREFIX = apsf_

char *
apsf_name(self)
	LSF_Batch_apsFactorInfo *self
    CODE:
        RETVAL = self->name;
    OUTPUT:
	RETVAL

float
apsf_weight(self)
	LSF_Batch_apsFactorInfo *self
    CODE:
        RETVAL = self->weight;
    OUTPUT:
	RETVAL

float
apsf_limit(self)
	LSF_Batch_apsFactorInfo *self
    CODE:
        RETVAL = self->limit;
    OUTPUT:
	RETVAL

int
apsf_gracePeriod(self)
	LSF_Batch_apsFactorInfo *self
    CODE:
        RETVAL = self->gracePeriod;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::apsFactorMapPtr PREFIX = apsm_

char *
apsm_factorName(self)
	LSF_Batch_apsFactorMap *self
    CODE:
        RETVAL = self->factorName;
    OUTPUT:
	RETVAL

char *
apsm_subFactorNames(self)
	LSF_Batch_apsFactorMap *self
    CODE:
        RETVAL = self->subFactorNames;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::apsLongNameMapPtr PREFIX = apsl_

char *
apsl_shortName(self)
	LSF_Batch_apsLongNameMap *self
    CODE:
        RETVAL = self->shortName;
    OUTPUT:
	RETVAL

char *
apsl_longName(self)
	LSF_Batch_apsLongNameMap *self
    CODE:
        RETVAL = self->longName;
    OUTPUT:
	RETVAL

MODULE = LSF::Batch PACKAGE = LSF::Batch::jobExternalMsgReplyPtr PREFIX = jemr_

int 
jemr_jobId(self)
	LSF_Batch_jobExternalMsgReply *self
    CODE:
    	RETVAL = LSB_ARRAY_JOBID(self->jobId);
    OUTPUT:
	RETVAL

int
jemr_msgIdx(self)
	LSF_Batch_jobExternalMsgReply *self
    CODE:
    	RETVAL = self->msgIdx;
    OUTPUT:
	RETVAL

char *
jemr_desc(self)
	LSF_Batch_jobExternalMsgReply *self
    CODE:
    	RETVAL = self->desc;
    OUTPUT:
	RETVAL
	
int
jemr_dataSize(self)
	LSF_Batch_jobExternalMsgReply *self
    CODE:
    	RETVAL = self->dataSize;
    OUTPUT:
	RETVAL
	
time_t 
jemr_postTime(self)
	LSF_Batch_jobExternalMsgReply *self
    CODE:
    	RETVAL = self->postTime;
    OUTPUT:
	RETVAL
	
int 
jemr_dataStatus(self)
	LSF_Batch_jobExternalMsgReply *self
    CODE:
    	RETVAL = self->dataStatus;
    OUTPUT:
	RETVAL
	
char *
jemr_userName(self)
    	LSF_Batch_jobExternalMsgReply *self
    CODE:
    	RETVAL = self->userName;
    OUTPUT:
	RETVAL	

MODULE = LSF::Batch PACKAGE = LSF::Batch::jRusagePtr PREFIX = jru_

int
jru_mem(self)
	LSF_Batch_jRusage *self
    CODE:
    	RETVAL = self->mem;
    OUTPUT:
    	RETVAL

int
jru_swap(self)
	LSF_Batch_jRusage *self
    CODE:
    	RETVAL = self->swap;
    OUTPUT:
    	RETVAL

int
jru_utime(self)
	LSF_Batch_jRusage *self
    CODE:
    	RETVAL = self->utime;
    OUTPUT:
    	RETVAL

int
jru_stime(self)
	LSF_Batch_jRusage *self
    CODE:
    	RETVAL = self->stime;
    OUTPUT:
    	RETVAL

int
jru_npids(self)
	LSF_Batch_jRusage *self
    CODE:
    	RETVAL = self->npids;
    OUTPUT:
    	RETVAL

void
jru_pidInfo(self)
	LSF_Batch_jRusage *self
    PREINIT:
    	int num = 0;
    	SV *rv;
	LSF_Batch_pidInfo *p;
    PPCODE:
    	for (num = 0, p = self->pidInfo; num < self->npids; num ++, p ++) {
    	    rv = newRV_inc(&PL_sv_undef);
	    sv_setref_iv(rv, "LSF::Batch::pidInfoPtr",(IV)p);
	    XPUSHs(sv_2mortal(rv));
    	}
	XSRETURN(self->npids);

void
jru_pgids(self)
	LSF_Batch_jRusage *self
    PREINIT:
    	int num = 0;
    PPCODE:
    	for (num = 0; num < self->npgids; num ++) {
	    XPUSHs(sv_2mortal(newSVnv(self->pgid[num])));
    	}
	XSRETURN(self->npgids);

int
jru_nthreads(self)
	LSF_Batch_jRusage *self
    CODE:
    	RETVAL = self->nthreads;
    OUTPUT:
    	RETVAL
    	
MODULE = LSF::Batch PACKAGE = LSF::Batch::pidInfoPtr PREFIX = pi_

int
pi_pid(self)
	LSF_Batch_pidInfo *self
    CODE:
    	RETVAL = self->pid;
    OUTPUT:
    	RETVAL

int
pi_ppid(self)
	LSF_Batch_pidInfo *self
    CODE:
    	RETVAL = self->ppid;
    OUTPUT:
    	RETVAL
    
int
pi_pgid(self)
	LSF_Batch_pidInfo *self
    CODE:
    	RETVAL = self->pgid;
    OUTPUT:
    	RETVAL
    	
int
pi_jobid(self)
	LSF_Batch_pidInfo *self
    CODE:
    	RETVAL = self->jobid;
    OUTPUT:
    	RETVAL


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobResizeReleaseLogPtr PREFIX = jrszrlease_

int
jrszrlease_jobid(self)
	LSF_Batch_jobResizeReleaseLog *self
    CODE:
    	RETVAL = self->jobId;
    OUTPUT:
    	RETVAL

int
jrszrlease_idx(self)
	LSF_Batch_jobResizeReleaseLog *self
    CODE:
    	RETVAL = self->idx;
    OUTPUT:
    	RETVAL

int
jrszrlease_reqid(self)
	LSF_Batch_jobResizeReleaseLog *self
    CODE:
    	RETVAL = self->reqId;
    OUTPUT:
    	RETVAL

int
jrszrlease_options(self)
	LSF_Batch_jobResizeReleaseLog *self
    CODE:
    	RETVAL = self->options;
    OUTPUT:
    	RETVAL

int
jrszrlease_userid(self)
	LSF_Batch_jobResizeReleaseLog *self
    CODE:
    	RETVAL = self->userId;
    OUTPUT:
    	RETVAL

char *
jrszrlease_username(self)
	LSF_Batch_jobResizeReleaseLog *self
    CODE:
    	RETVAL = self->userName;
    OUTPUT:
    	RETVAL

char *
jrszrlease_resizenotifycmd(self)
	LSF_Batch_jobResizeReleaseLog *self
    CODE:
    	RETVAL = self->resizeNotifyCmd;
    OUTPUT:
    	RETVAL

int
jrszrlease_numresizehosts(self)
	LSF_Batch_jobResizeReleaseLog *self
    CODE:
    	RETVAL = self->numResizeHosts;
    OUTPUT:
    	RETVAL

void
jrszrlease_resizehosts(self)
	LSF_Batch_jobResizeReleaseLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numResizeHosts; i++)
          XPUSHs(sv_2mortal(newSVpv(self->resizeHosts[i],0)));	
	XSRETURN(self->numResizeHosts);

int
jrszrlease_nextstatusno(self)
	LSF_Batch_jobResizeReleaseLog *self
    CODE:
    	RETVAL = self->nextStatusNo;
    OUTPUT:
    	RETVAL

int
jrszrlease_numresizehosts4slots(self)
	LSF_Batch_jobResizeReleaseLog *self
    CODE:
    	RETVAL = self->numResizeHosts4Slots;
    OUTPUT:
    	RETVAL

void
jrszrlease_resizehosts4slots(self)
	LSF_Batch_jobResizeReleaseLog *self
    PREINIT:
	int i;
    PPCODE:
	for( i = 0; i < self->numResizeHosts4Slots; i++)
          XPUSHs(sv_2mortal(newSVpv(self->resizeHosts4Slots[i],0)));	
	XSRETURN(self->numResizeHosts4Slots);


MODULE = LSF::Batch PACKAGE = LSF::Batch::jobResizeCancelLogPtr PREFIX = jrszcancel_

int
jrszcancel_jobid(self)
	LSF_Batch_jobResizeCancelLog *self
    CODE:
    	RETVAL = self->jobId;
    OUTPUT:
    	RETVAL

int
jrszcancel_idx(self)
	LSF_Batch_jobResizeCancelLog *self
    CODE:
    	RETVAL = self->idx;
    OUTPUT:
    	RETVAL

int
jrszcancel_userid(self)
	LSF_Batch_jobResizeCancelLog *self
    CODE:
    	RETVAL = self->userId;
    OUTPUT:
    	RETVAL

char *
jrszcancel_username(self)
	LSF_Batch_jobResizeCancelLog *self
    CODE:
    	RETVAL = self->userName;
    OUTPUT:
    	RETVAL

int
jrszcancel_nextstatusno(self)
	LSF_Batch_jobResizeCancelLog *self
    CODE:
    	RETVAL = self->nextStatusNo;
    OUTPUT:
    	RETVAL



