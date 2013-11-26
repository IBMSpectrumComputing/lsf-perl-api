#!/apps/grid/bin/perl

#This will read through a list of structures and generate:
# 1: a list of typedefs
# typedef struct jobChunkLog  LSF_Batch_jobChunkLog;
# 2: Module line for each
# MODULE = LSF::Batch PACKAGE = LSF::Batch:jobChunkLogPtr PREFIX = jcl_
# 3: List of methods based on type.
#
# 
while(<ARGV>){
  next unless /^struct\s+(.*)\s*\{/;
  $struct = $1;
  $struct =~ s/\s+//g;
  print "Got a struct of type $struct \n";
  push @structures, $struct;
  while(($_ = <ARGV>) !~ /\};/){
    next if /^\s*$/;
    ($type, $field, $more) = split;
    $field=~ s/^\*//;
    $field =~ s/;$//;
    $field =~ s/\[.+\]//;
    if( $type eq "struct" ){
      $type = "LSF_Batch_$field *";
      $field = $more;
      $field=~ s/^\*//;
      $field =~ s/;$//;
    }
    #print "   Field $field of type $type\n";
    $package{$struct}{$field} = $type;
  }
} 
print "/* typemap entries */\n";
foreach $struct (@structures){
  print "LSF_Batch_$struct * T_PTROBJ_SPECIAL\n";
}
print "/* typedefs */\n";
foreach $struct (@structures){
  print "typedef struct $struct LSF_Batch_$struct;\n";
}
print "/* XS Code.... */\n";
print "MODULE = LSF::Batch PACKAGE = LSF::Batch::eventRecPtr PREFIX = er_\n";
print "\n";
print "void\n";
print "er_eventLog(self)\n";
print "\tLSF_Batch_eventRec *self\n";
print "    PREINIT:\n";
print "\tchar *label;\n";
print "\tSV *rv;\n";
print "    PPCODE:\n";
print "\tswitch(self->type){\n";

foreach $struct (@structures){
  $label = $struct;
  $label =~ s/Log$//;
  $label =~ s/([A-Z]{1})/_\1/g;
  $label = "EVENT_" . uc $label;
  print "\t   case $label:\n";
  print "\t      label = \"LSF::Batch::${struct}Ptr\";\n";
  print "\t      rv = newRV_inc(&PL_sv_undef);\n";
  print "\t      sv_setref_iv(rv, label, (IV)&self->eventLog.$struct);\n";
  print "\t      break;\n";
}
print "\t   default:\n";
print "\t}\n";
print "\tXPUSHs(sv_2mortal(rv));\n";
print "\tXSRETURN(1);\n";

foreach $struct (@structures){
  $prefix =  ucfirst $struct;
  $prefix =~ s/[^A-Z]//g;
  $prefix .= $used{$prefix} if ++$used{$prefix} > 1;
  $prefix = lc $prefix . "_";
  
  print "\nMODULE = LSF::Batch PACKAGE = LSF::Batch::${struct}Ptr PREFIX = $prefix\n";
  print "\n";

  foreach $field (keys %{$package{$struct}}){
    $type = $package{$struct}{$field};
    if( $type eq "char" ){
      print "char *\n";
    }
    else{
      print "$type\n";
    }
    print "$prefix$field(self)\n";
    print "\tLSF_Batch_$struct *self\n";
    print "    CODE:\n";
    print "\tRETVAL = self->$field;\n";
    print "    OUTPUT:\n\tRETVAL\n";
    print "\n";
  }
}

