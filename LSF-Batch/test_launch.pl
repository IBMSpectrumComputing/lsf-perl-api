BEGIN { 
  $| = 1; 
  $nolsfbase = 1 unless eval "require LSF::Base";
}

END {print "not ok 1\n" unless $loaded;}
use LSF::Batch;
$loaded = 1;

print "Failed to new\n" unless my $b = new LSF::Batch "test";

@hosts = $b->gethostlist() or $err = 1;
if($err) {
  print $b->sysmsg;
  exit -1;
}

#$hosts = "egodev07";
$argv = "sleep 1";
$options = LSF_DJOB_NOWAIT;
$ret = $b->launch(undef,$argv, $options) or $err = 1;
if ($err) {
  print $b->sysmsg;
  exit -2;
}
print "\n";
exit;  
