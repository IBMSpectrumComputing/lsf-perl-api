package LSF::Base;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

use Exporter;
use DynaLoader;

@ISA = qw(Exporter AutoLoader DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw( BOOLEAN NUMERIC STRING INCR DECR NA RESF_BUILTIN
RESF_DYNAMIC RESF_GLOBAL RESF_SHARED RESF_LIC RESF_EXTERNAL RESF_RELEASE
EXACT OK_ONLY NORMALIZE LOCALITY IGNORE_RES LOCAL_ONLY DFT_FROMTYPE 
ALL_CLUSTERS EFFECTIVE RECV_FROM_CLUSTERS NEED_MY_CLUSTER_NAME
LIM_UNAVAIL LIM_LOCKEDU LIM_LOCKEDW LIM_BUSY LIM_RESDOWN LIM_UNLICENSED
LIM_OK_MASK LIM_SBDDOWN INTEGER_BITS ISUNAVAIL ISBUSY ISBUSYON ISLOCKEDU
ISLOCKEDW ISLOCKED ISRESDOWN ISSBDDOWN ISUNLICENSED ISOK ISOKNRES 
R15S R1M R15M UT PG IO LS IT TMP SWP MEM USR1 USR2 LSF_BASE_LIC
LSF_BATCH_LIC LSF_JS_SCHEDULER_LIC LSF_JS_LIC LSF_CLIENT_LIC LSF_MC_LIC
LSF_ANALYZER_LIC LSF_ANALYZER_SERVER_LIC LSF_MAKE_LIC LSF_PARALLEL_LIC
LSF_NUM_LIC_TYPE LSF_LOCAL_MODE LSF_REMOTE_MODE KEEPUID REXF_USEPTY
REXF_CLNTDIR REXF_TASKPORT REXF_SHMODE REXF_TASKINFO REXF_REQVCL
REXF_SYNCNIOS REXF_TTYASYNC STATUS_TIMEOUT STATUS_IOERR STATUS_EXCESS 
STATUS_REX_NOMEM STATUS_REX_FATAL STATUS_REX_CWD STATUS_REX_PTY 
STATUS_REX_SP STATUS_REX_FORK STATUS_REX_AFS STATUS_REX_UNKNOWN
STATUS_REX_NOVCL STATUS_REX_NOSYM STATUS_REX_VCL_INIT STATUS_REX_VCL_SPAWN
STATUS_REX_EXEC RF_MAXHOSTS RF_CMD_MAXHOSTS RF_CMD_TERMINATE 
RF_CMD_RXFLAGS RES_CMD_REBOOT RES_CMD_SHUTDOWN RES_CMD_LOGON 
RES_CMD_LOGOFF LIM_CMD_REBOOT LIM_CMD_SHUTDOWN
);

@EXPORT_OK = qw(
);

#%EXPORT_TAGS = (
#   Configuration => 
#   [qw(getclustername getmastername gethosttype gethostmodel)],
#   LoadInfoPlacement => 
#   [],
#   TaskList =>
#   [],
#   RexecTaskControl =>
#   [],
#   RemoteFile =>
#   [],
#   Administration =>
#   [],
#   ErrorHandling =>
#   [],
#   Miscellaneous =>
#   []
#);

$VERSION = '1.01';

bootstrap LSF::Base $VERSION;

# Preloaded methods go here.

sub new{
  my $type = shift;
  my $self;

  return eval{
    if( -e "/etc/lsf.conf" or $ENV{LSF_ENVDIR} ){
      bless \$self, $type;
    }
    else{
      die "Can't access lsf.conf file or LSF_ENVDIR not set";
    }
  }
}

sub BOOLEAN{0}
sub NUMERIC{1}
sub STRING{2}

sub INCR{0}
sub DECR{1}
sub NA{2}

sub RESF_BUILTIN{0x01}  # builtin vs configured resource
sub RESF_DYNAMIC{0x02}  # dynamic vs static value
sub RESF_GLOBAL{0x04}   # resource defined in all clusters
sub RESF_SHARED{0x08}   # shared resource for some hosts
sub RESF_LIC{0x10}      # license static value
sub RESF_EXTERNAL{0x20} # external resource defined
sub RESF_RELEASE{0x40}  # Resource can be released when job is suspended

#flags for placement decision
sub EXACT{0x01}
sub OK_ONLY{0x02}
sub NORMALIZE{0x04}
sub LOCALITY{0x08}
sub IGNORE_RES{0x10}
sub LOCAL_ONLY{0x20}
sub DFT_FROMTYPE{0x40}
sub ALL_CLUSTERS{0x80}
sub EFFECTIVE{0x100}
sub RECV_FROM_CLUSTERS{0x200}
sub NEED_MY_CLUSTER_NAME{0x400}

# Host status from the LIM
sub LIM_UNAVAIL{0x00010000}
sub LIM_LOCKEDU{0x00020000}
sub LIM_LOCKEDW{0x00040000}
sub LIM_BUSY{0x00080000}
sub LIM_RESDOWN{0x00100000}
sub LIM_UNLICENSED{0x00200000}
sub LIM_OK_MASK{0x003f0000}
sub LIM_SBDDOWN{0x00400000}
sub INTEGER_BITS{32}

sub ISUNAVAIL{ my ($st) = @_; ($$st[0] & LIM_UNAVAIL) != 0;}
sub ISBUSY{my ($st) = @_; ($$st[0] & LIM_BUSY) != 0;}
sub ISBUSYON{ my ($st,$in) = @_; 
	      ($$st[1 + $in/INTEGER_BITS] & (1 << $in % INTEGER_BITS)) != 0;}
sub ISLOCKEDU{ my ($st) = @_; ($$st[0] & LIM_LOCKEDU) != 0;}
sub ISLOCKEDW{ my ($st) = @_; ($$st[0] & LIM_LOCKEDW) != 0;}
sub ISLOCKED{ my ($st) = @_; ($$st[0] & (LIM_LOCKEDU|LIM_LOCKEDW)) != 0;}
sub ISRESDOWN{ my ($st) = @_; ($$st[0] & LIM_RESDOWN) != 0;}
sub ISSBDDOWN{ my ($st) = @_; ($$st[0] & LIM_SBDDOWN) != 0;}
sub ISUNLICENSED{ my ($st) = @_; ($$st[0] & LIM_UNLICENSED) != 0;}
sub ISOK{ my ($st) = @_; ($$st[0] & LIM_OK_MASK) == 0;}
sub ISOKNRES{ my ($st) = @_; ($$st[0] & ~(LIM_RESDOWN | LIM_SBDDOWN)) == 0;}

# Index into load vector and resource table
sub R15S{0}
sub R1M{1}
sub R15M{2}
sub UT{3}
sub PG{4}
sub IO{5}
sub LS{6}
sub IT{7}
sub TMP{8}
sub SWP{9}
sub MEM{10}
sub USR1{11}
sub USR2{12}

sub LSF_BASE_LIC{0}
sub LSF_BATCH_LIC{1}
sub LSF_JS_SCHEDULER_LIC{2} 
sub LSF_JS_LIC{3}
sub LSF_CLIENT_LIC{4}
sub LSF_MC_LIC{5}
sub LSF_ANALYZER_LIC{6}
sub LSF_ANALYZER_SERVER_LIC{7}
sub LSF_MAKE_LIC{8}
sub LSF_PARALLEL_LIC{9}
sub LSF_NUM_LIC_TYPE{10}

sub LSF_LOCAL_MODE{1}
sub LSF_REMOTE_MODE{2}

sub KEEPUID{1}

sub REXF_USEPTY{0x00000001}
sub REXF_CLNTDIR{0x00000002}
sub REXF_TASKPORT{0x00000004}
sub REXF_SHMODE{0x00000008} 
sub REXF_TASKINFO{0x00000010}
sub REXF_REQVCL{0x00000020}
sub REXF_SYNCNIOS{0x00000040}
sub REXF_TTYASYNC{0x00000080}

sub STATUS_TIMEOUT{125}
sub STATUS_IOERR{124}
sub STATUS_EXCESS{123}   
sub STATUS_REX_NOMEM{122}
sub STATUS_REX_FATAL{121}
sub STATUS_REX_CWD{120}
sub STATUS_REX_PTY{119}
sub STATUS_REX_SP{118}
sub STATUS_REX_FORK{117}
sub STATUS_REX_AFS{116}
sub STATUS_REX_UNKNOWN{115}
sub STATUS_REX_NOVCL{114}
sub STATUS_REX_NOSYM{113}
sub STATUS_REX_VCL_INIT{112}
sub STATUS_REX_VCL_SPAWN{111}
sub STATUS_REX_EXEC{110}

sub RF_MAXHOSTS{5}
# ls_rfcontrol() commands
sub RF_CMD_MAXHOSTS{0}
sub RF_CMD_TERMINATE{1}
sub RF_CMD_RXFLAGS{2}

sub RES_CMD_REBOOT{1}
sub RES_CMD_SHUTDOWN{2}
sub RES_CMD_LOGON{3}
sub RES_CMD_LOGOFF{4}

sub LIM_CMD_REBOOT{1}
sub LIM_CMD_SHUTDOWN{2}

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

LSF::Base - Object oriented Perl extension for use with the Platform
Computing Corporation's LSF.

=head1 SYNOPSIS

  use LSF::Base;
  
  $base = new LSF::Base;
  
  #Cluster configuration

  $info = $base->info or die $@;
  
  @resources = $info->resTable;
  $res = $resources[0];

  $name  = $res->name;
  $desc  = $res->des;
  $vt    = $res->valueType; # 0,1,2 (BOOLEAN, NUMERIC, STRING)
  $ot    = $res->orderType; # 0,1,2 (INCR, DECR, NA)
  $flags = $res->flags; # RESF_BUILTIN | RESF_*
  $int   = $res->interval; #seconds

  $nRes    = $info->nRes;
  @resTable= $info->resTable;
  @types   = $info->hostTypes;
  @models  = $info->hostModels;
  @archs   = $info->hostArchs;
  @narch   = $info->modelRefs;
  @factors = $info->cpuFactor;
  $n_index = $info->numIndx;
  $n_usr   = $info->numUsrIndx;

  $myhost = $base->getmyhostname;

  $cluster = $base->getclustername;
  
  $master  = $base->getmastername;
  
  $type    = $base->gethosttype($host);

  $model   = $base->gethostmodel($host);
  
  $factor  = $base->gethostfactor($host);
  
  $factor  = $base->getmodelfactor($model);

  @hosts = qw(skynet alpha60 wopr ghostwheel);
  # passing in @hosts restricts the results to the listed
  # hosts. 
  
  @hostinfo = $base->gethostinfo($resreq, \@hosts, $options);
  
  #return information on all hosts.
  @hostinfo = $base->gethostinfo($resreq, NULL, $options);
  
  $hi = $hostinfo[0];

  $name      = $hi->hostName;
  $type      = $hi->hostType;
  $model     = $hi->hostModel;
  $factor    = $hi->cpuFactor;
  $max_cpus  = $hi->maxCpus;
  $max_mem   = $hi->maxMem;
  $max_swap  = $hi->maxSwap;
  $max_tmp   = $hi->maxTmp;
  $ndisks    = $hi->nDisks;
  @resources = $hi->resources;
  $windows   = $hi->windows;
  @threshold = $hi->busyThreshold;
  $is_server = $hi->isServer;
  $licensed  = $hi->licensed;
  $rex_pri   = $hi->rexPriority;
  $lic_feat  = $hi->licFeaturesNeeded;

  @params = qw( LSF_SERVERDIR LSF_CONFDIR LSF_SERVER_HOSTS LSF_MANDIR); 
  %env = $base->readconfenv(\@params, $ENV{LSF_ENVDIR});
  
  #load information and placement functions

  @hostload = $base->load($resreq, $numhosts, $options, $fromhost );
  
  @hostload = $base->loadofhosts( $resreq, $numhosts, $options, $fromhost, \@hosts);
  
  $hl = $hostload[0];

  $name = $hl->hostName;
  @status = $hl->status

  $bool = ISUNAVAIL(\@status);
  $bool = ISBUSY(\@status);
  $bool = ISBUSYON(\@status,$index);
  $bool = ISLOCKEDU(\@status);
  $bool = ISLOCKEDW(\@status);
  $bool = ISLOCKED(\@status);
  $bool = ISRESDOWN(\@status);
  $bool = ISSBDDOWN(\@status);
  $bool = ISUNLICENSED(\@status);
  $bool = ISOK(\@status);
  $bool = ISOKNRES(\@status);
 
  @where = $base->placereq( $resreq, $number, $options, $fromhost);
  
  @where = $base->placeofhosts( $resreq, $number, $options, $fromhost, \@hosts);
  
  $place{alpha60} = 3;
  $place{skynet} = 2;

  $base->loadadj($resreq, \%place) or die $@;
   
  #Task list manipulation

  $resreq = $base->resreq($task);
 
  ($bool, $resreq) = $base->eligible($task, $mode);
  
  $base->insertrtask($task);
  
  $base->insertltask($task);

  $base->deletertask($task);
   
  $base->deleteltask($task);
  
  @remote = $base->listrtask($sortflag);
   
  @local = $base->listltask($sortflag);
    
  # Remote Execution and task control functions

  $ports = $base->initrex($numports, $options); # or KEEPUID
   
  $base->connect($hostname) or die $@;
  
  $bool = base->isconnected($hostname);
    
  @connections = $base->findmyconnections;
 
  $base->rexecv($host, \@argv, $options) or die $@;
    
  $base->rexecve($host, \@argv, $options, \@envp) or die $@;
    
  $tid = $base->rtask($host, \@argv, $options);
  
  $tid = $base->rtaske($host, \@argv, $options, \@env);
  
  ($tid, $ru) = $base->rwait($options);
  $status = $?;
  
  $ru = $base->rwaittid($tid, $options);
  $status = $?;
    
  $u_sec = $ru->utime_sec;
  $u_usec = $ru->utime_usec;
  $s_sec = $ru->stime_sec;
  $s_usec = $ru->stime_usec;
  $maxrss = $ru->maxrss;
  $ixrss = $ru->ixrss;
  $idrss = $ru->idrss;
  $minflt = $ru->minflt;
  $majflt = $ru->majflt;
  $nswap = $ru->nswap;
  $inblock = $ru->inblock;
  $outblock = $ru->outblock;
  $msgsnd = $ru->msgsnd;
  $msgrcv = $ru->msgrcv;
  $nsignals = $ru->nsignals;
  $nvcsw = $ru->nvcsw;
  $nivcsw = $ru->nivcsw;

  $base->rkill($tid, $signal) or die $@;
    
  $base->rsetenv($host, \@env) or die $@;
    
  $base->chdir($host, $path) or die $@;
    
  $base->stdinmode($remote) or die $@;
    
  @tids = $base->getstdin($on, $max);
    
  $base->setstdin($on, \@tids) or die $@;
    
  $base->stoprex or die $@;
  
  $base->donerex or die $@;
  
  $socket = $base->conntaskport($tid);
  
  # Remote file operations

  $rfd = $base->ropen($host, $filename, $flags, $mode) or die $@;
   
  $base->rclose($rfd) or die $@;
  
  $bytes = $base->rwrite($rfd, $buf, $len);
    
  $bytes = $base->rread($rfd, $buf, $len );
  
  $offset = $base->rlseek($rfd, $offset, $whence );
  
  @stat = $base->rfstat($rfd);
 
  @stat = $base->rstat($host, $path);
    
  $host = $base->getmnthost($file);
    
  $host = $base->rgetmnthost($host, $file);
  
  #if LSF_VERSION < 9
  
  $base->rfcontrol($option, \@arg);
  #Controls the behavior of remote file operations. $option is either 
  #RF_CMD_MAXHOSTS or RF_CMD_TERMINATE. @arg should be one or more of the
  #following: REXF_USEPTY,REXF_CLNTDIR, REXF_TASKPORT, REXF_SHMODE, 
  #REXF_TASKINFO, REXF_REQVCL, REXF_SYNCNIOS, REXF_TTYASYNC, REXF_STDERR.
  
  #else 
  $base->rfcontrol($option, \@arg) or die $@;
  #Controls the behavior of remote file operations.$option is either 
  #RF_CMD_RXFLAGS or RF_CMD_MAXHOSTS. @arg is the same with that of above.
  
  #endif
  
  $base->lockhost($duration) or die $@;
    
  $base->unlockhost() or die $@;
    
  $base->limcontrol($hostname, $opcode) or die $@;
    
  $base->rescontrol($hostname, $opcode, $data) or die $@;
  
  $base->perror($message);
   
  $base->sysmsg;
    
  $base->errno;
    
  $base->errlog(FILE, $msg);
  
  $base->fdbusy($fd);
  
=head1 DESCRIPTION

LSF provides basic load sharing functionality consisting of the
following services: cluster configuration information, load
information and placement advice, task list manipulation, remote
execution and task control, remote file operations, administration,
and error handling.

This library is designed to be used with LSF version 7.0 Update 2. Please see 
the "LSF Programmer's Guide" and the LSF man pages for
detailed documentation of this API.

The data structures used in the API have been wrapped in Perl objects
for ease of use. The functions set $@ and $? where appropriate, or you
can use the lserrno, sysmsg, and perror functions if you want. 

The Perl version of this API has been modified to some extent to act
more "Perlish" than the straightforward C API. For instance, return
values have been changed to more closely match what a Perl programmer
expects from a function. Other deviations from the original are noted
in the documentation.

=over

=item $info = $base->info;

This routine returns a pointer to an lsInfo structure, which contains
complete load sharing configuration information. This information includes
the name of the cluster, the name of the current cluster master host, the 
set of defined resources, the set of defined host types and models, the CPU 
factors of the host models, and all load indices (resTable[0] through 
resTable[numIndx - 1]), including the site defined external load indices 
(resTable[MAX + 1] through resTable[MAX + numUsrIndx]).

=item $myhost = $base->getmyhostname;

This routine returns the name used throughout LSF to represent the 
local host.

=item $cluster = $base->getclustername;

This routine returns the name of the local load sharing cluster.

=item $master  = $base->getmastername;

This routine returns the name of the host running the local load 
sharing cluster's master LIM.

=item $type = $base->gethosttype(host);

This routine returns the type of the specified C<host>.

=item $model = $base->gethostmodel(host);

This routine returns the model of the specified C<host>.
        
=item $factor = $base->gethostfactor(host); 
     
This routine returns a pointer to a floating point number that contains 
the CPU factor of the specified C<host>. 

=item $factor = $base->getmodelfactor(model);

This routine returns the CPU normalization factor of the specified host 
model. C<model> can be obtained by calling $base->gethostmodel.

=item @hostinfo = $base->gethostinfo(resreq, hosts, options);

This routine returns an array of hostInfo data structures. C<resreq> 
specifies resource requirements that a host must satisfy; C<hosts> is the 
reference of array and gives a list of hosts or clusters whose information is 
returned if they satisfy the requirements in resreq. if C<hosts> is undefined, all 
hosts known to LSF that satisfy the requirements in C<resreq> are returned. 
C<options> should be zero or one or more of the following:
EXACT, OK_LOLY, NORMALIZE, LOCALITY, LGNORE_RES, DFT_FROMTYPE, EFFECTIVE.
Each entry contains information about one host, including the host 
type, the host model, its CPU normalization factor, the number of CPUs, 
its maximum memory, swap and tmp space, number of disks, the resources 
available on the host, the run windows during which the host is available
for load sharing, the busy thresholds for the host, whether the host is a 
LSF server, and the default priority used by the RES for remote tasks 
executing on that host. The windows field will be set to "-" if the host is
always open. The busyThreshold field is an array of floating point numbers
specifying the load index thresholds that LIM uses to consider a host as 
busy. The size of the array is indicated by the numIndx field. 
    
=item %env = $base->readconfenv(paramList, confPath);

This routine reads the LSF configuration parameters from the 
C<confPath>/lsf.conf. If C<confPath> is NULL, the LSF configurable parameters 
are read from the ${LSF_ENVDIR-/etc}/lsf.conf file. The input C<paramList> is 
a reference of array of (LSF_SERVERDIR LSF_CONFDIR LSF_SERVER_HOSTS 
LSF_MANDIR).
    
=item @hostload = $base->load(resreq, numhosts, options, fromhost);

This routine returns an array of hostLoad data structures. C<resreq> is a
character string describing resource requirements. C<numhosts> initially 
contains the number of hosts requested. C<options> is the same as that of 
$base->gethostinfo(). C<fromhost> is the name of the host from which a task 
might be transferred. This parameter affects the host selection in such a 
way as to give preference to C<fromhost> if the load on other hosts is not much
better. If C<fromhost> is undefined, the local host is assumed.

=item @hostload = $base->loadofhosts(resreq, numhosts, options, fromhost, hosts);

This routine returns the dynamic load information of qualified hosts. 
The parameters are the same as that of $base->load(). C<hosts> is an array of 
listsize host or cluster names. If undefined, only load information about 
hosts in this list will be returned.

=item @where = $base->placereq(resreq, number, options, fromhost);

This routine returns the most suitable host() for the task() with 
regards to current load conditions and the task's resource 
requirements. C<resreq> is a resource requirement expression that characterizes
the resource needs of a single task. C<number> is the number of hosts requested.
options is the same as $base->load(); C<fromhost> is the host from which the
task originates when LIM makes the placement decision. If C<fromhost> is undefined,
the local host is assumed.

=item @where = $base->placeofhosts(resreq, number, options, fromhost, hosts);

This routine returns the most suitable host() for the task() from a set
of candidate hosts with regards to current load conditions and the task's 
resource requirements. The first four parameters are the same as that of 
$base->placereq, hosts specifies a list of candidate hosts from which 
$base->placeofhosts() can choose suitable hosts.
        
=item $base->loadadj(resreq, place);

This routine sends a load adjustment request to LIM after the execution
host or hosts have been selected outside the LIM by the calling application.
C<resreq> is a resource requirement expression (that can be NULL) that 
describes the resource requirements for which the load must be adjusted. 
C<place> is a hash variable. The key is a hostname and the value is the number
of tasks on the host.
    
=item $resreq = $base->resreq(task);

This routine searches a remote task list and returns the resource 
requirements. C<task> is the name of the task being sought.  

=item ($bool, $resreq) = $base->eligible(task, mode);

This routine checks to see if a task is eligible for remote execution. 
C<task> is being checked to see if it can be remotely executed. C<mode> is
LSF_LOCAL_MODE or LSF_REMOTE_MODE. If C<mode> is LSF_LOCAL_MODE, the routine
searches through the remote task lists to see if the name of task is on a 
list. If found, the task is considered eligible for remote execution, 
otherwise the task is considered ineligible. if C<mode> is LSF_REMOTE_MODE,
the routine searches through the local task lists to see if taskname is on
a list. If found, the task is considered ineligible for remote execution, 
otherwise the task is considered eligible.
  
=item $base->insertrtask(task);

This routine adds a specified task to the remote task list. C<task> is a 
character string containing the name of the task to be inserted .

=item $base->insertltask(task);

This routine adds the specified task to the local task list. C<task> is a 
character string containing the name of the task to be inserted.
    
=item $base->deletertask(task);

This routine deletes a specified task from the remote task list. C<task>
is a character string containing the name of the task to be deleted.

=item $base->deleteltask(task);

This routine deletes a specified task from the local task list. C<task> 
is a character string containing the name of the task to be deleted.

=item @remote = $base->listrtask(sortflag);

This routine returns the contents of the user's remote task list. 
If C<sortflag> is non-zero, then the returned task list is sorted 
alphabetically. Usually, C<sortflag> is set to 1.

=item @local = $base->listltask(sortflag);

This routine retruns the contents of the user's local task list. C<sortflag>
is the same as the one of $base->listrtask.
    
=item $ports = $base->initrex(numports, options); 

This routine initializes the LSF library for remote execution. C<options> is 
usually set to 0.

=item $base->connect(hostname);

This routine sets up an initial connection with the Remote Execution 
Server (RES) on a specified remote host. C<hostname> that is set up with
a Remote Execution Server.

=item $bool = base->isconnected(hostname);

This routine tests whether the specified host is currently connected
with the application. C<hostname> is the name of target host. When it returns 1, 
it means function was successful, 0 means the function failed.

=item @connections = $base->findmyconnections;

This routine finds established connections to hosts.

=item $base->rexecv(host, argv, options);

This routine executes a program on a specified remote host. C<host> is
the remote host where the program is executed. C<argv> is the program being
used. C<options> is constructed by ORing flags from the following list:
REXF_USEPTY, REXF_CLNTDIR, REXF_TASKPORT, REXF_SHMODE.

=item $base->rexecve(host, argv, options, envp);

This routine is the same as $base->rexecv() except that it provides the
support of setting up a new environment specified by the string array C<envp>.
When C<envp> is undefined, it means using the remote RES server's cached 
environment. Otherwise it uses the new one. C<argv> and C<options> are the same
as the ones of $base->rexecv().

=item $tid = $base->rtask(host, argv, options);

This routine starts a remote task on a specified host. C<host> is the 
remote host where the program is executed. C<argv> is the program being used. 
C<options> should be one or more of the following: REXF_USEPTY, REXF_CLNTDIR,
REXF_TASKPORT, REXF_SHMODE, REXF_TASKINFO, REXF_REQVCL, REXF_SYNCNIOS, 
REXF_TTYASYNC, REXF_STDERR.

=item $tid = $base->rtaske(host, argv, options, env);

This routine is the same as $base->rtask() except that it provides the
support of setting up a new environment specified by the string array C<envp>.
When C<envp> is undef, it means using the remote RES server's cached
environment. Otherwise it uses the new one. Other arguments are the same as
the ones of $base->rtask().

=item ($tid, $ru) = $base->rwait(options);

This routine collects the status of a remote task started by 
$base->rtask() or $base->rtaske().
C<options> should be WNOHANG or WUNTRACED, if it specified as 0, and there
is at least one remote child, then the calling host is blocked until a remote
child exits. If C<options> is specified to be WNOHANG, the routine checks 
for any exited (remote) child and returns immediately. $ru is a pointer to 
the struct of rusage. $tid returns the remote task ID, if $tid was -1, the
function failed.

=item $ru = $base->rwaittid(tid, options);

This routine provides support for collecting the status of a specified 
remote task. C<tid> is the ID of the remote task being accessed. if C<options>
is set to 0, and there is at least one remote task, the calling host is blocked 
until the specific task exits. If C<options> is WNOHANG (non-blocking), it 
reads the child's status if the child is dead, otherwise it returns immediately
with 0. If the status of the child is successfully read, the remote task ID is
returned. $ru is the structure where the resource usage information of the 
exited child is stored.
   
=item $base->rkill(tid, signal);

This routine sends the C<signal> to the remote task $tid and all 
its children that belong to the same UNIX process group. C<tid> is the 
remote task ID returned by $base->rtask() or $base->rtaske(). 

=item $base->rsetenv(host, env);

This routine sets up environment variables on a remote host. C<host> is
the remote host upon which the environment is being set. C<env> is a pointer
to an array of strings of the form C<variable=value>.

=item $base->chdir(host, path);

This routine sets the application's working directory on the remote host
to the directory specified by C<path>. C<host> is the remote host containing
the client directory. C<path> is the full pathname of a valid directory on
the remote host.

=item $base->stdinmode(remote);

This routine allows an application program to query and specify how 
stdin is assigned to remote tasks on a local application. If C<remote> is 
non-zero, then the application will not read subsequent standard input,
and the remote children will read standard input. This mode of operation is
called the remote stdin mode. Remote stdin mode is the default. In remote 
stdin mode, standard input is read by the Network I/O Server (NIOS) and 
forwarded to the appropriate remote tasks. If C<remote> is zero, then the
application reads the subsequent standard input, and it is not forwarded to
remote children. This mode of operation is called the local stdin mode.

=item @tids = $base->getstdin(on, max);

This routine allows an application program to query and specify how stdin
is assigned to remote tasks. If C<on> is non-zero, the task IDs of the remote
tasks that are enabled to receive standard input are stored in tidlist. If it
is zero, then the IDs of remote tasks whose standard input is disabled are 
returned. The ID of a task is assigned by the LSLIB when $base->rtask() is 
called. C<max> is the size of the remote IDs list; these remote tasks are 
enable to receive standard input.

=item $base->setstdin(on, tids);

This routine allows an application program to query and specify how stdin
is assigned to a specific subset of remote tasks. If C<on> is non-zero and
the current stdin mode is remote, then the tasks given by tidlist receive 
the standard input. If it is zero, the tasks will not receive standard input.
C<tids> gives the list of task IDs of the remote tasks to be operated upon.

=item $base->stoprex;

This routine stops the Networks I/O Server and restores the local tty
environment.

=item $base->donerex;

This routine kills the Network I/O server (NIOS) and restores the tty 
environment before a remote execution connection is closed.
  
=item $socket = $base->conntaskport(tid);

This routine connects a socket to the task port that was created by the
remote RES for the remote task C<tid>, C<tid> is returned by an 
$base->rtask() or $base->rtaske().

=item $rfd = $base->ropen(host, filename, flags, mode);

This routine opens a file on a remote host. C<host> is the host where 
the file to be opened is located. C<filename> is the file to be opened. 
C<flags> is one or more of the following: O_CREAT, O_WRONLY, O_RDONLY.

=item $base->rclose(rfd);

This routine performs a close operation on a file on a remote host. C<rfd>
is the references of the file that is to be closed, returned by $base->ropen().

=item $bytes = $base->rwrite(rfd, buf, len);

This routine performs a write operation on a file on a remote host.

=item $bytes = $base->rread(rfd, buf, len );

This routine performs a read operation on a file on a remote host.

=item $offset = $base->rlseek(rfd, offset, whence );

This routine performs a seek operation on a file on a remote host.

=item @stat = $base->rfstat(rfd);

This routine obtains information about a file located on a remote host.

=item @stat = $base->rstat(host, path);

This routine obtains information about a file located on a remote host.
C<host> is the remote host containing the file to be analyzed. C<path> is
the path of the file.

=item $host = $base->getmnthost(file);

This routine returns the name of the file server containing a specific
C<file>. C<file> is the relative or absolute path name for the file server.

=item $host = $base->rgetmnthost(host, file);

This routine obtains the name of the file server that exports a 
specified file system. C<host> is the host containing the file. C<file> is 
the file to be accessed.

=item $base->rfcontrol(option, arg);

This routine controls the behavior of remote file operations. C<option>
is either RF_CMD_MAXHOSTS or RF_CMD_TERMINATE. C<arg> should be one or more
of the following: REXF_USEPTY,REXF_CLNTDIR, REXF_TASKPORT, REXF_SHMODE,
REXF_TASKINFO, REXF_REQVCL, REXF_SYNCNIOS, REXF_TTYASYNC, REXF_STDERR.   
    
=item $base->lockhost(duration);

This routine locks the local host for a specified number of seconds.
C<duration> is the number of seconds the local host is locked. 0 seconds 
locks a host indefinitely.

=item $base->unlockhost();

This routine unlocks a locked local host.

=item $base->limcontrol(hostname, opcode);

This routine shuts down or reboots a host's LIM. C<hostname> specifies
the host to be controlled. C<opcode> is either LIM_CMD_SHUTDOWN or 
LIM_CMD_REBOOT.

=item $base->rescontrol(hostname, opcode, data);

This routine controls and maintains the Remote Execution Server. 
C<hostname> is the host to be controlled. The support C<opcode> value
are: RES_CMD_REBOOT, RES_CMD_SHUTDOWN, RES_CMD_LOGOFF and RES_CMD_LOGON.
C<data> is optionally used with RES_CMD_LOGON to specify a CPU time threshold
in msec, so that RES will log resource information only for tasks that
consumed more than the specified CPU time.

=item $base->perror(message);

This routine prints LSF error messages. C<message> is standard output
error string.

=item $base->sysmsg;

This routine obtains LSF error messages.

=item $base->errno;

This routine returns lsberrno correctly.

=item $base->errlog(FILE, msg);

This routine logs error messages. C<FILE> is a file handle. C<msg> is
error message.

=item $base->fdbusy($fd);

This routine tests if a specified file descriptor is in use or reserved
by LSF. C<fd> is the file descriptor to test.
    
=back
                 
=head1 AUTHOR

Paul Franceus, Capita Technologies, Inc., paul@capita.com

=head1 MODIFIER

ISV Team, Platform Computing Corporation, support@platform.com

=head1 SEE ALSO

C<perl(1)>, 
C<LSF::Batch>, 
C<LSF Programmer's guide>, 
C<lslib(3)>, 
C<LSF man pages for each function>

=cut

