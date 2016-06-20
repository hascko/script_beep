#!/usr/bin/perl
use strict;
use Tie::File;
# 1 - Pour Activer Musique Pour conference
# 2 - Pour Activer Que TalkOnly Pour conference
# 3 - Pour Activer Musique et TalkOnly Pour conference
my @records;
tie @records, 'Tie::File',"/var/dialplan/conference.conf";
my $records = @records;
my @meetme;
tie @meetme, 'Tie::File',"/etc/asterisk/meetme.conf";
my $meetme = @meetme;
my $argv = @ARGV;
my $arg = $ARGV[0];
my $arg2 = $ARGV[1];

if($argv == 2){

        for(my $i = 0; $i <= $records; $i++){
                if($records[$i] =~ m/exten => $arg[\s,]/){
                        $records[$i] = "exten => $arg2,1,MeetMe($arg2,M)";
                        print "Changer\n";
                }
        }
}
else{
        print "c pas bon";
}

