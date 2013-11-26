use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

unless ($ENV{'LSF_ENVDIR'}) {
  $ENV{'LSF_ENVDIR'} = prompt("Directory containing lsf.conf file for this machine:","/etc/");
}

my $lsfConf = $ENV{LSF_ENVDIR}."/lsf.conf";

die "Cannot find lsf.conf file in $ENV{LSF_ENVDIR}\n" unless (-r $lsfConf);

# Get LSF_LIBDIR(if not found in the environment veriables) and LSF_INCLUDEDIR from config file
my $lsfLib = $ENV{'LSF_LIBDIR'};
unless ($lsfLib)
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
warn "Found OS=$os\n";

for($os){
  /OSF1/ && do{$libs = "-L$lsfLib -llsf -lbat -lmach -lmld";};
  /AIX/ && do{$libs = "-L$lsfLib -llsf -lbat -lbsd";};
  /SunOS/ && do{$libs = "-L$lsfLib -lbat -llsf -lnsl -lsocket -lrpcsvc -lgen -ldl -lresolv";};
  /Linux/ && do{$libs = "-L$lsfLib -lbat -llsf";};
}

WriteMakefile(
    'NAME'	=> 'LSF::Batch',
    'VERSION_FROM' => 'Batch.pm',
    'LIBS'	=> [$libs],
    'DEFINE'	=> '-DPERL_POLLUTE',
    'OBJECT'	=> '$(O_FILES)',
    'INC'	=> "-I$lsfInc"
);

