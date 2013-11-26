# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { 
  $| = 1; print "1..25\n";
  $nolsfbase = 1 unless eval "require LSF::Base";
}

END {print "not ok 1\n" unless $loaded;}
use LSF::Batch;
$loaded = 1;
print "ok 1\n";

$base = new LSF::Base;
######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):
$ok2 = 1;
$ok2 = 0 unless $b = new LSF::Batch "myTestApplication";
$conf = "/etc";
$conf = $ENV{LSF_ENVDIR} if $ENV{LSF_ENVDIR};


open CONF, "<$conf/lsf.conf" or $ok2 = 0;

#Read in LSF environment variables;
if($ok2){
  while(<CONF>){
    next if /^\#|^\s*$/;
    $ENV{$1} = $2 if /(.+)=(.+)/;
  }
  
  close CONF;
}
print "not " unless $ok2;
print "ok 2\n";

#********************************************
$ok3 = 1;

@user = ( );   
defined(@user) or warn "no user names are given.           \t";

@userinfo = $b->userinfo(\@user) or $ok3 = 0;
foreach $user (@userinfo){
  $ok3 = 0 if $user->maxJobs == 0;
}

@queues = ("normal","owners","priority","night","chkpnt_rerun_queue","short","license","idle");
$host = undef;
$user = undef;
$queueoption = 0;
defined($user) or warn "no user name is given.             \t";
defined($host) or warn "no host name is given.             \t" ;
@qinfo = $b->queueinfo(\@queues,$host,$user,$queueoption) or $ok3 = 0;

$nq = @info;

foreach $queue (@qinfo){
  if( $queue->queue eq "" ){
    $ok3 = 0;
  }
}

$ok3 = 0 unless $nq;

@resource = ( );
$resourceopt = 0;
@resinfo = $b->sharedresourceinfo(\@resource,$host,$resourceopt);

unless( @resinfo ){
  $ok3 = 0 unless $@ eq "No resource defined";
}

@hostparts = ( );
defined(@hostparts) or warn "no hostparts given.               \t" ;
@partinfo = $b->hostpartinfo(\@hostparts);
$ok3 = 0 unless @partinfo;

print "not " unless $ok3;
print "ok 3\n";

#**************************************************

$ok4 = 1;

$command = <<EOF;
#!/bin/ksh
for i in 1 2 3 4 5 6
do
  date
 sleep 10
done
EOF

$jobname = "testjob1.$$";

$ENV{BSUB_QUIET} = 1;

$job = $b->submit(  -JobName => $jobname, 
		    -command => $command,
		    -output => "/dev/null"
		 );

$ok4 = 0 unless $job;

$myjobid = $job->jobId;
$index = $job->arrayIdx;

if( $myjobid != -1){
  sleep 10;
  $job->signal(SIGSTOP) or $ok4 = 0;
  $rec = 0;
  $rec = $b->openjobinfo($job,undef,undef,undef,undef,0) or $ok4 = 0;
  $j = $b->readjobinfo or $ok4 = 0;
  $cmd = $j->submit->command;
  $myqueue = $j->submit->queue;
  $cmd =~ s/;/\n/g;
  $cmd .= "\n";
  if( $rec != 1 or
      $j->submit->jobName ne $jobname or
      $j->submit->outFile ne "/dev/null" or
      $cmd ne $command or
      $j->jobId != $myjobid or
      $index != 0 
    ){
    $ok4 = 0;
  }
  $b->closejobinfo;
  $job->signal(SIGCONT) or $b->perror("signal");
}
else{
  $ok4 = 0;
}

print "not " unless $ok4;
print "ok 4\n";

#***************************************

if( $nolsfbase ){
  use ExtUtils::MakeMaker;
  $clustername = prompt("please enter your LSF cluster name");
}
else{
  $base = new LSF::Base;
  $clustername = $base->getclustername;
}

$events = $ENV{LSB_SHAREDIR}."/$clustername/logdir/lsb.events";

unless( -r $events ){
  $events = prompt("Events file is unreadable.\nPlease enter path to a readable events file.",$events);
}

open LOG, $events;

$ok5 = 1;
$line = 1;
while($er = $b->geteventrecord( LOG, $line)){
  $el = $er->eventLog;
  $lt = localtime $er->eventTime;
  if( $er->type == EVENT_JOB_NEW ){
    $job = $el->jobId;
    $user = $el->userName;
    $res = $el->resReq;
    $q = $el->queue;
    #print "New job $job submitted to queue $q by $user\n";
    $ok5 = 0 if $job == $myjobid and $q != $myqueue;
  }
  elsif( $er->type == EVENT_JOB_START ){
    $job = $el->jobId;
    $idx = $el->idx; 
    #print "Started job ${job}[${idx}]\n";
  }
  elsif( $er->type == EVENT_JOB_START_ACCEPT ){
    $job = $el->jobId;
    $idx = $el->idx; 
    $pid = $el->jobPid;
    #print "SBD accepted job ${job}[${idx}]: pid $pid\n";
  }
  elsif( $er->type == EVENT_JOB_EXECUTE ){
    $job = $el->jobId;
    $idx = $el->idx; 
    $pid = $el->jobPid;
    $home = $el->execHome;
    $cwd = $el->execCwd;
    $user = $el->execUsername;
    #print "job ${job}[${idx}] started execution with home=$home and cwd=$cwd as $user\n";
  }
  elsif( $er->type == EVENT_JOB_STATUS ){
    $job = $el->jobId;
    $idx = $el->idx;
    $status = $el->jStatus;
    #print "Job ${job}[${idx}] status changed to $status\n";
  }
  elsif( $er->type == EVENT_JOB_FINISH ){
    $job = $el->jobId;
    $idx = $el->idx;
    @hosts = $el->execHosts;
    $cpu = $el->cpuTime;
    #print "job ${job}[${idx}] finished on @hosts using $cpu\n";
  }
  elsif( $er->type == EVENT_JOB_CLEAN ){
    $job = $el->jobId;
    $idx = $el->idx;
    #print "job ${job}[${idx}] cleaned up\n";
  }
  elsif( $er->type == EVENT_LOG_SWITCH ){
    $lastid = $el->lastJobId;
    #print "Log switched at job $lastid\n";
  }
  elsif( $er->type == EVENT_MBD_START ){
    $master = $el->master;
    $cluster = $el->cluster;
    $numhosts = $el->numHosts;
    $numqueues = $el->numQueues;
    #print "Master batch daemon started on $master for cluster $cluster.\n";
    #print "Hosts = $numhosts, queues = $numqueues\n";
    $ok5 = 0 if $cluster != $clustername;
  }
  else{
    #print "Got event type ",$er->type,"\n";
  }
}

print "not " unless $ok5;
print "ok 5\n";

#********************************************

#$job->run(\@hosts, RUNJOB_OPT_NORMAL) or $b->perror("running job");


$ok6 = 1;
$mysysmsg = $b->sysmsg();
$ok6 = 0 unless $mysysmsg eq "End of file";
print "not " unless $ok6;
print "ok 6\n";

#*********************************************

$ok7 = 1;
$myappname = undef;
$myinit= $b->init($myappname);
$ok7 = 0 unless $myinit;
print "not " unless $ok7;
print "ok 7\t";
if(! $ok7)
{
  $msg = $b->sysmsg();
  print "$msg";
}
print "\n";

#**************************************************

$ok8 = 1;
$rcfgopt = MBD_CKCONFIG; #This value should be MBD_RESTART, MBD_RECONFIG,MBD_CKCONFIG
$myreconfig= $b->reconfig($rcfgopt);
$ok8 = 0 unless $myreconfig;
print "not " unless $ok8;
print "ok 8\t";
if(! $ok8)
{
  $msg = $b->sysmsg();
  print "$msg";
}
print "\n";

#****************************************************

$ok9 = 1;
$host = undef;
$hostctrlopt = HOST_OPEN; #This value should be HOST_OPEN, HOST_CLOSE, HOST_REBOOT
                          #HOST_SHUTDOWN, HOST_CLOSE_REMOTE
defined($host) or warn "no host name is given.           \t" ;
$myhostcontrol= $b->hostcontrol($host,$hostctrlopt);
$ok9 = 0 unless $myhostcontrol;
print "not " unless $ok9;
print "ok 9      ";
if(! $ok9)
{
  $msg = $b->sysmsg();
  print "$msg";
}
print "\n";

#***************************************************

$ok10 = 1; 
$host = undef;
@hostinfo = $b->hostinfo($host)or $ok10 = 0;
foreach $host (@hostinfo){
  $ok10 = 0 if length($host->host) == 0;
}
print "not " unless $ok10;
print "ok 10\t";
if(! $ok10)
{
  $msg = $b->sysmsg();
  print "$msg";
}
print "\n";

#*****************************************************

$ok11 = 1;
@hosts = ();
$resreq = undef;
$options =  0;
@hostinfo_ex = $b->hostinfo_ex(\@hosts, $resreq, $options)or $ok11 = 0;
foreach $host (@hostinfo_ex){
  $ok11 = 0 if $host->maxJobs == 0;
}
print "not " unless $ok11;
print "ok 11\t";
if(! $ok11)
{
  $msg = $b->sysmsg();
  print "$msg";
}
print "\n";

#*****************************************************

$ok12 = 1;
@groups = ( );
$options = GRP_ALL;
@usergrpinfo = $b->usergrpinfo(\@groups,$options)or $ok12 = 0;
foreach $usegrp (@usergrpinfo){
  $ok12 = 0 if length($usegrp) == 0;
}
print "not " unless $ok12;
print "ok 12\t";
if(! $ok12)
{
  $msg = $b->sysmsg();
  print "$msg";
}
print "\n";

#*****************************************************

$ok13 = 1;
@groups = ();
$options = GRP_ALL;
@hostgrpinfo = $b->hostgrpinfo(\@groups, $options) or $ok13 = 0;
foreach $hostgrp (@hostgrpinfo){
  $ok13 = 0 if length($hostgrp) == 0;
}
print "not " unless $ok13;
print "ok 13\t";
if(! $ok13)
{
  $msg = $b->sysmsg();
  print "$msg";
}
print "\n";

#******************************************************

$ok14 = 1;
$queue ="normal";
$options = QUEUE_ACTIVATE;
$myqueuectrl= $b->queuecontrol($queue,$options);
$ok14 = 0 unless $myqueuectrl;
print "not " unless $ok14;
print "ok 14\t";
if(! $ok14)
{
  $msg = $b->sysmsg();
  print "$msg";
}
print "\n";

#*******************************************************

$ok15 = 1;
$myparainfo = $b->parameterinfo();
$ok15 = 0 unless defined($myparainfo);
$pidefaultQueues = $myparainfo->defaultQueues;
$ok15 = 0 unless length($pidefaultQueues) > 0;
print "not " unless $ok15;
print "ok 15\t";
if(! $ok15)
{
  $msg = $b->sysmsg();
  print "$msg";
}
print "\n";

#*******************************************************

$ok16 = 1;
$jobId = undef;
$jobname = undef;
$user = undef;
$queue = undef;
$host = undef;
$options = 1;
defined($jobId) or warn "no jobId is given.                 \t" ;

$job = new LSF::Batch::jobPtr ($jobId, 0); 
$rec = $b->openjobinfo($job,$jobname,$user,$queue,$host,$options);

$j = $b->readjobinfo;
$myjob = $j->job or $err1 = 1; 
$myjob->modify() or $err2 = 1;
$err2 = 1 unless length($@) == 0;

$period =10 ;
$options = LSB_CHKPNT_KILL;  #LSB_CHKPNT_KILL = 1;
$mychkpnt = $myjob->chkpnt($period, $options);
$err3 = 1 unless $mychkpnt;

$hosts = ();
$option = 0;
defined($hosts) or warn "no host names are given.          \t";
$mymig = $myjob->mig(\@hosts , $option);
$err4 = 1 unless $mymig;

$position =1;
$opcode = TO_TOP; # TO_TOP =1 TO_BOTTOM=2;
defined($position) or warn "position is not setted.           \t";
$mymove = $myjob->move($position ,$opcode);
$err5 = 1 unless defined($mymove);

$mypeek = $myjob->peek();
$err6 = 1 unless length($mypeek) != 0;

@hosts = ();
$slots = 1;
$options = RUNJOB_OPT_NORMAL;  # RUNJOB_OPT_NORMAL = 1;
defined(@hosts) or warn "no host names are given.          \t" ;
$myrun = $myjob->run(\@hosts, $slots, $options);
$err7 = 1 unless $myrun;

$signal = 9;
$mysignal = $myjob->signal($signal);
$err7 = 1 unless $mysignal;

$queue = "normal";
$myswitch = $myjob->switch($queue);
$err8 = 1 unless $myswitch;

$ok16 = 0 if $err1 or $err2 or $err3 or $err4 or $err5 or $err6 or $err7 or $err8;
print "not " unless $ok16;
print "ok 16\n";

#********************************************
$ok17 = 1;
$err = 0;
$jobname = "launch";
$command = "perl -I $ENV{'PWD'}/blib/lib/ -I $ENV{'PWD'}/blib/arch/ $ENV{'PWD'}/test_launch.pl";
$host = "hostname";

$job = $b->submit( -JobName    => $jobname,
                   -command    => $command,
                   -m          => $host
                ); 
$myjobid = $job->jobId;
$status = 0;
if ($myjobid != -1) {
    while (!(($status & JOB_STAT_DONE) || ($status & JOB_STAT_EXIT))) {
        sleep 3;
        $rec = $b->openjobinfo($job, undef, undef, undef, undef, ALL_JOB);
        $j = $b->readjobinfo;
        $status = $j->status;
    }
    $err = 1 unless $status & JOB_STAT_DONE;
}
$ok17 = 0 if $err;

print "not " unless $ok17;
print "ok 17\n";

#***************************************************
$ok18 = 1;
$jobId = undef;
defined($jobId) or warn "no job Id is given.               \t";
$job = new LSF::Batch::jobPtr ($jobId, 0);
$rec = $b->openjobinfo($job,undef,undef,undef,undef,1);
$j = $b->readjobinfo;

$err1 = $err2 = 0;
$myjob = $j->job or $err1 = 1;
$aa=$myjob->postjobmsg( -d      => "test postjobmsg",
                        -i      => 4,
                        -a      => "c.txt"
                       ) or $err2 = 1;
$ok18 = 0 if $err2 or $err1;

print "not " unless $ok18;
print "ok 18     ";
if (!$ok18) {
    print $base->sysmsg;
}
print "\n";
#**************************************************
$ok19 = 1;
$err = 0;
($port,$reply) = $myjob->readjobmsg(-i   => 4, 
                                    -a   => "b.txt"
				   );
$err = 1 unless $port;
$ok19 = 0 if $err;

print "not " unless $ok19;
print "ok 19     ";
if (!$ok19) {
    print $b->sysmsg;
}

print "\n";
#**************************************************

$ok20 = 1;
$err = 0;
$rsvId = $b->brsvadd(-n  =>  1,
                     -m  => "egodev07",
                     -t  => "8:00-9:00",
                     -u  => "qlnie") ;
$err = 1 unless $rsvId;
$ok20 = 0 if $err;

print "not " unless $ok20;
print "ok 20     ";
if (!$ok20) {
    print $b->sysmsg();
}
print "\n";
#**************************************************

$ok21 = 1;
$err = 0;
@rsvent = $b->reservationinfo($rsvId) or $err = 1;
$ok21 = 0 if $err;
print "not " unless $ok21;
print "ok 21     ";
if (!$ok21) {
    print $b->sysmsg;
}
print "\n";
#***************************************************

$ok22 = 1;
$err = 0;
$res = $b->removereservation($rsvId) or $err = 1;
$ok22 = 0 if $err;

print "not " unless $ok22;
print "ok 22     ";
if (!$ok22) {
    print $b->sysmsg;
}
print "\n";
#*************************************************
$ok23 =1;
$jobId = undef;
#defined($jobId) or warn "no job Id is given.              \t";
$job = new LSF::Batch::jobPtr ($jobId, 0);

$rec = $b->openjobinfo($job,undef,undef,undef,undef,1);
$j = $b->readjobinfo;

$numReasons = $j -> numReasons;
@reasonTb  =  $j -> reasonTb;
$clusterId = $j -> clusterId;

$info=$b->openjobinfo_a($job,undef,undef,undef,undef,$options) or $ok23=0 ;

if(!$ok23){
    print "not ";
}
print "ok 23     ";

if(!$ok23){
    $msg = $b ->sysmsg();
    print "$msg \n";
    $ok23 = 0;
}
print "\n";
#*****************************************************
$ok24 =1;

@loadIndex = $j ->initLoadIndex;

$pedmsg = $b ->pendreason($numReasons ,\@reasonTb,$info,\@loadIndex,$clusterId) or $ok24=0;
#print "pendmsg = $pedmsg \n";

if(!$ok24){
    print "not ";
}
print "ok 24     ";

if(!$ok24){
    #$msg = $b ->sysmsg();
    #print "$msg \n";
    print "$@";
}
print "\n";
#********************************************************
$ok25 =1;
$reasons = $j ->reasons;
$subreason = $j -> subreasons;

$susmsg = $b->suspreason($reasons,$subreason,\@loadIndex) or $ok25=0;
#print "suspreason = $msg \n ";

if(!$ok25){
    print "not ";
}
print "ok 25     ";
if(!$ok25){
    $msg = $base ->sysmsg();
    print "$msg \n";
}
print "\n";

