# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..24\n"; }
END {print "not ok 1\n" unless $loaded;}
use LSF::Base;
$SIG{USR1} = 'IGNORE';
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 26"
# (correspondingly "not ok 33") depending on the success of chunk 13
# of the test code):
my $base;

print "not " unless $base = new LSF::Base;
print "ok 2\n";

my $myhost = $base->getmyhostname;
#print "$myhost\n";
my $master = $base->getmastername;
#print "$master\n";
my $cluster = $base->getclustername;
#print $cluster,"\n";
my $hostType = $base->gethosttype($master);
#print $hostType,"\n";
my $hostModel = $base->gethostmodel($master);
#print "$hostModel\n";
my $factor = $base->getmodelfactor($hostModel);
#print "$factor\n";
my $hostFactor = $base->gethostfactor($master);
#print "$hostFactor\n";
my $lsinfo = $base->info();
my @resTable = $lsinfo->resTable;
my @types = $lsinfo->hostTypes;
my @models = $lsinfo->hostModels;
my @factors = $lsinfo->cpuFactor;
#print scalar(@resTable)," ",scalar(@models),"\n";
#print scalar(@types)," ", scalar(@factors),"\n";
#print @resTable[MEM]->name,"\n";
#print @resTable[MEM]->des,"\n";
#print @resTable[MEM]->orderType == DECR,"\n";
#print @resTable[MEM]->valueType == NUMERIC,"\n";
#print @resTable[MEM]->flags == (RESF_BUILTIN|RESF_DYNAMIC|RESF_GLOBAL),"\n";
#print @resTable[MEM]->interval,"\n";
unless( @resTable > 0                    and
    @resTable[MEM]->name eq "mem"        and
    @resTable[MEM]->des =~ /^Available/  and
    @resTable[MEM]->orderType == DECR    and
    @resTable[MEM]->valueType == NUMERIC and
    @resTable[MEM]->flags == RESF_BUILTIN|RESF_DYNAMIC|RESF_GLOBAL
	                                 and
    @resTable[MEM]->interval == 15      and
    @models > 0                          and
    @types > 0                           and
    @factors > 0                         and
    $cluster                             and
    $myhost                              and
    $factor == $hostFactor               and
    grep $factor == $_, @factors         and
    grep $hostModel eq $_, @models       and
    grep $hostType eq $_, @types
  ){
  print "not ";
}
print "ok 3\n";
  
##########################################

@hostinfo = $base->gethostinfo("r15m<2.0",NULL,EFFECTIVE);
if( @hostinfo ){
  foreach (@hostinfo){
    if( $master eq $_->hostName ){
      if( $_->cpuFactor eq $hostFactor and
	  $_->hostModel eq $hostModel  and
	  $_->hostType  eq $hostType   and
	  $_->isServer                 and
          $_->licensed
	){
	print "ok 4\n"
      }
      else{
	print "not ok 4\n";
      }
      last;
    }
  }
}
else{
  print "not ok 4\n";
}
#############################################
my @h, @load;
my $load_ok = 1;
@load = $base->load("r15m<2.0 && status==ok", 0, EFFECTIVE, undef);
$load_ok = 0 if $?;
foreach $hl (@load){
  @st = $hl->status;
  push @h , $hl->hostName;
  @li = $hl->li;
  if( $li[R15M] > 2.0 and ISOK(\@st) ){
    $load_ok = 0;
    last;
  }
}

@load = $base->loadofhosts("r15m<2.0", 0, EFFECTIVE, $h[0], \@h);
$load_ok = 0 if $?;
foreach $hl (@load){
  @li = $hl->li;
  if( $li[R15M] > 2.0 ){
    $load_ok = 0;
    last;
  }
}

if($load_ok){
  print "ok 5\n";
}
else{
  print "not ok 5\n";
}
#################################################
my @h1, %pl;
($place) = $base->placereq("r15m<2.0", 1, 0, undef);
$err = $?;
#print "place = $place\n";
push @h1,$place;
($place2) = $base->placeofhosts("r15m<2.0", 1, 0, undef, \@h1);
$err2 = $?;
$pl{$place} = 1;
$err3 = !$base->loadadj("r1m",\%pl);
#print "$@, $err, $err2, $err3, $place, $place2\n";
print "not " unless  !$err and !$err2 and $place eq $place2;
print "ok 6";
if($err or $err2 or $err3 or ($place ne $place2))
{
    $errno = $base->errno();
    print "\terrno = $errno";
}
print "\n";
#################################################
$ok7 = 1;

$rtask = "testremote123";
$req = "r1m<1.0";
$ltask = "testlocal123";
$base->insertrtask("$rtask/$req") or $ok6 = 0;
$base->insertltask($ltask) or $ok6 = 0;

($ok, $resreq) = $base->eligible($rtask, LSF_LOCAL_MODE);
$ok7 = 0 unless $ok;
$ok7 = 0 unless $resreq eq $req;

$resreq = $base->resreq($rtask);
$ok7 = 0 unless $req eq $resreq;

($ok, $resreq) = $base->eligible($ltask, LSF_LOCAL_MODE);
$ok7 = 0 if $ok;

@rtasks = $base->listrtask(1);
@ltasks = $base->listltask(1);
$ok7 = 0 unless grep /^$rtask/, @rtasks;
$ok7 = 0 unless grep /^$ltask/, @ltasks;

$ok7 = 0 unless $base->deletertask($rtask);
$ok7 = 0 unless $base->deleteltask($ltask);

print "not " unless $ok7;
print "ok 7\n";


#################################################
$p = $base->initrex(0,0);
$err1 = !defined $p;

if( $pid = open(CHILD,"-|") ){
  #parent
  $data = <CHILD>;
  $err3 = $data !~ /^this is a test/;
  $child = wait;
  $err2 = !defined $child;
}
elsif( defined $pid ){
  #child
  @arg = ("echo", "this is a test");
  $base->rexecv($place, \@arg, 0) or die $@;
  $base->rexecve($place, \@arg, 0,NULL) or die $@;
  #should never get here
  $err2 = 1;
  exit;
}
else{
  #error
  $err2 = 1;
}

@arg = ("/dev/null");
$tid = $base->rtask($place, \@arg, REXF_TASKPORT);
$onoff = 0;
$errstdinmode = $base->stdinmode($onoff);
$err4 = 1 unless $errstdinmode;
$on = NIO_TASK_STDINON;
@tidlist = ($tid);
$errsetstdin = $base->setstdin($on,\@tidlist);
$err5 = 1 unless $errsetstdin;
my $on = 0;
my $max = 100;
$errgetstdin = $base->getstdin($on,$max);
if(!$errgetstdin)
{
    $err6 = 1;
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno \n";
}

$err7 = !($ru = $base->rwaittid($tid,0));

$tid = $base->rtaske($place, \@arg, REXF_TASKPORT,NULL);
$err8 = !($ru = $base->rwaittid($tid,0));
#print "$err1,$err2,$err3,$err4,$err5,$err6,$err7,$err8\n";
print "not " if $err1 or $err2 or $err3 or $err4 or $err5 or $err6 or $err7 or $err8;
print "ok 8\n";

#################################################
use Fcntl;

$fname = "./lsfbase.test";
$rfd = $base->ropen($place, $fname ,O_CREAT|O_WRONLY, 0777);
$buf = "1234567890";
$size = $base->rwrite($rfd, $buf, 10);
$err1 = $size != 10;
$err2 = !$base->rclose($rfd);

$rfd = $base->ropen($place, $fname, O_RDONLY, 0777);
$ret = $base->rlseek($rfd, 5, 0);
$ret2 = $base->rread($rfd, $buf2, 5);

$err3 = $buf2 ne "67890";

@stat1 = $base->rstat($place, $fname);
@stat2 = $base->rfstat($rfd);

$err4 = 0;
foreach(0..7){
  $err4 = 1 if $stat1[$_] != $stat2[$_];
}

$err5 = $stat1[7] ne 10;

my $filepoint;
my $tid = 3;
$filepoint = $base->conntaskport($tid);
$err6 = 1 unless defined($filepoint);
if(!defined($filepoint))
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno\n";
}

$base->rclose($rfd);
#$base->stoprex();
$base->donerex;

unlink $fname;

print "not " if $err1 or $err2 or $err3 or $err4 or $err5 or $err6;
print "ok 9\n";

#################################################

my @env = ("LSF_MANDIR");
my $path = "$ENV{LSF_ENVDIR}"; 
(@confenv) = $base->readconfenv(\@env,$path);
foreach $conf (@confenv){
  #print "$conf\n";
}
print "not " unless scalar(@confenv) == 2;
print "ok 10";
if($err)
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";

#################################################

$base->initrex(0,0);
my $host = undef;
$err1 = $base->connect($host) or warn $@;
$err2 = $base->isconnected($host);
my @connections = $base->findmyconnections();
$err3 = 1 unless scalar(@connections) != 1;
print "not " unless $err1 and $err2 and $err3;
print "ok 11";
if(!($err1 and $err2 and $err3))
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";

#################################################

my $waitopt = WNOHANG; #This option should be "WNOHANG" and "WUNTRACED"
@list = $ru = $base->rwait($waitopt);
print "not " unless scalar(@list) != 0;
print "ok 12";
if(scalar(@list) == 0)
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";

#################################################


my $rkillsig = SIGINT; #Refer sig_map in Libsig.c for the value.
$err = $base->rkill($tid,$rkillsig);
print "not " unless $err;
print "ok 13";
if(!$err)
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";

#################################################

my $host = undef;
my @envp = ("");
$errrsetenv = $base->rsetenv($host,\@envp);
print "not " unless $errrsetenv;
print "ok 14";
if(!$err)
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";


#################################################

my $host = undef;
my $clntdir = undef; # For example,"//hostlinux1/test/";
$errchdir = $base->chdir($host,$clntdir);
print "not " unless $errchdir;
print "ok 15";
if(!$errchdir)
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";

#################################################

my $command = RF_CMD_RXFLAGS; #This value should be: RF_CMD_RXFLAGS,RF_CMD_MAXHOSTS
my @arg = ("REXF_USEPTY"); #This value should be: REXF_USEPTY, REXF_CLNTDIR, REXF_TASKPORT, REXF_SHMODE,                       # REXF_TASKINFO, REXF_REQVCL, REXF_SYNCNIOS, REXF_TTYASYNC, REXF_STDERR
$errrfcontrol = $base->rfcontrol($command, @arg);
print "not " unless defined($errrfcontrol);
print "ok 16";
if(!defined($errrfcontrol))
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";    
    print "errno = $errno";
}
print "\n";

#################################################

my $hostname = undef;
$errrfterminate = $base->rfterminate($hostname);
print "not " unless defined($errrfterminate);
print "ok 17";
if(!defined($errrfterminate))
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";

#################################################

my $duration = 100;
$err1 = $base->lockhost($duration);
$err2 = $base->unlockhost();
print "not " unless $err1 and $err2 == 0;
print "ok 18";
if(!$err1 or ($err2 < 0))
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";

#################################################

my $hostname = undef;
my $optcode = LIM_CMD_REMOVEHOST; 
                 #This value should be LIM_CMD_REBOOT, LIM_CMD_SHUTDOWN, LIM_CMD_REMOVEHOST, 
                 #                     LIM_CMD_ACTIVATE, LIM_CMD_DEACTIVATE, LIM_CMD_ELIM_ENV
$errlimcontrol = $base->limcontrol($hostname,$optcode);
print "not " unless $errlimcontrol;
print "ok 19";
if(!$errlimcontrol)
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";


#################################################

my $hostname = undef;
my $optcode = RES_CMD_REBOOT; #This value should be RES_CMD_REBOOT, RES_CMD_SHUTDOWN, 
                 #RES_CMD_LOGON, RES_CMD_LOGOFF
my $data = 1;
$errrescontrol = $base->rescontrol($hostname,$optcode,$data);
print "not " unless $errrescontrol;
print "ok 20";
if(!$errrescontrol)
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";

#################################################

my $usrMsg = "Hello,world!";
$base->perror($usrMsg);
print "ok 21\n"; #Here, the content of $usrMsg should be print on user screen crectly.  

#################################################

my $msg = "Hello,world";
open FP,">>./aaa.txt" or die "Can't open aaa.txt";
$errno = $base->fdbusy(FP);
if( $errno )
{
	  #Here, the file must be not busy. Otherwise, there will be some errors.
    print "not ";
}
else
{
    $base->errlog(FP,$msg);
}
close(FP);
open FP,"./aaa.txt" or die "Can't open aaa.txt";
$line = <FP>;
my $exist = index($line,$msg,0);
close(FP);
unlink("./aaa.txt");
print "not " unless $exist != -1;
print "ok 22\n"; #In pwd, check the file aaa.txt; If the file is exsit and it contais the content of $msg, the API is correctly.

#################################################

my $file = "./aaa1.txt";
open FP,">>$file";
close(FP);
$errgetmnthost = $base->getmnthost($file);
print "not " unless defined($errgetmnthost);
print "ok 23";
if(!defined($errgetmnthost))
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";
unlink $file;

#################################################

my $file =  "./aaa2.txt";
open FP,">>$file";
close(FP);
my $hostname = undef; 
$errrgetmnthost = $base->rgetmnthost($hostname,$file);
print "not " unless defined($errrgetmnthost);
print "ok 24";
if(!defined($errrgetmnthost))
{
    $errno = $base->errno();
    $usrMsg = $base->sysmsg();
    print "\t$usrMsg,";
    print "errno = $errno";
}
print "\n";
unlink $file;

#################################################


exit;
