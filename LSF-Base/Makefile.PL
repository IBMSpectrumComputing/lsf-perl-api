use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

unless ($ENV{'LSF_ENVDIR'}) {
	$ENV{'LSF_ENVDIR'} = prompt("Directory containing lsf.conf file for this machine:","/etc/");
}

my $lsfConf = "$ENV{LSF_ENVDIR}/lsf.conf";

die "Cannot find lsf.conf file in $ENV{LSF_ENVDIR}\n" unless (-r $lsfConf);

# Get LSF_LIBDIR(if not found in the environment veriables) and LSF_INCLUDEDIR from config file
my $lsfLib = $ENV{'LSF_LIBDIR'};
unless($lsfLib)
{
    chomp(my $lsfLib = `grep ^LSF_LIBDIR $lsfConf`);
}
$lsfLib =~ s/^[^=]+=//;
die "Invalid LSF_LIBDIR ($lsfLib)\n" unless ((-d $lsfLib) && (-r $lsfLib));
warn "Found LSF_LIBDIR: $lsfLib\n";

chomp(my $lsfInc = `grep ^LSF_INCLUDEDIR $lsfConf`);
$lsfInc =~ s/^[^=]+=//;
die "Invalid LSF_INCLUDEDIR ($lsfInc)\n" unless ((-d $lsfInc) && (-r $lsfInc));
warn "Found LSF_INCLUDEDIR: $lsfInc\n";

$os = `uname`;
warn "Found OS: $os\n";

OS: for($os){
  /OSF1/ && do{$libs = "-L$lsfLib -llsf -lmach -lmld"; last OS};
  /AIX/ && do{$libs = "-L$lsfLib -llsf -lbsd";last OS};
  /SunOS/ && do{$libs = "-L$lsfLib -llsf -lnsl -lelf -lresolv -lsocket -lrpcsvc -lgen -ldl"; last OS};
  /Linux/ && do{$libs = "-L$lsfLib -llsf"; last OS};
  print "$os is not supported at this time. Modify Makefile.PL with\n";
  print "proper compilation options for you OS and please forward them\n";
  print "to paul\@capita.com\n";
  exit;
}

WriteMakefile(
    'NAME'	=> 'LSF::Base',
    'VERSION_FROM' => 'Base.pm',
    'LIBS'	=> [$libs ],
    'DEFINE'	=> '-DPERL_POLLUTE',
    'OBJECT'	=> '$(O_FILES)',
    'INC'	=> "-I$lsfInc"
);


