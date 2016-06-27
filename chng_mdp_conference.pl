#!/usr/bin/perl
use strict;
use Tie::File;
my @meetme;
tie @meetme, 'Tie::File',"/etc/asterisk/meetme.conf";
my $meetme = @meetme;
my $argv = @ARGV;
my $arg = $ARGV[0];
my $arg2 = $ARGV[1];

if($argv == 2){
        for(my $i = 0; $i <= $meetme; $i++){
                if($meetme[$i] =~ m/conf => $arg[\s,]/){
                        $meetme[$i] = "conf => $arg,$arg2\n";
                        print "Changer\n";
                }
        }
}
else{
        print "c pas bon";
}

system 'asterisk -rx "dialplan reload"'