#!/usr/bin/perl
use strict;
use Tie::File;
# 1 - Pour Activer Musique Pour conference
# 2 - Pour Activer Que TalkOnly Pour conference
# 3 - Pour Activer Musique et TalkOnly Pour conference
# 4 - Pour Activer RIEN Pour conference
my @records;
tie @records, 'Tie::File',"/var/dialplan/conference.conf";
my $records = @records;
my $argv = @ARGV;
my $arg = $ARGV[0];

if($argv == 2){
        if($ARGV[1] == 1){

                for(my $i = 0; $i <= $records; $i++){
                        if($records[$i] =~ m/exten => $arg[\s,]/){
                                $records[$i] = "exten => $arg,1,MeetMe($arg,M)";
                                print "Changer\n";
                        }
                }

        }
        elsif($ARGV[1] == 2){

                for(my $i = 0; $i <= $records; $i++){
                        if($records[$i] =~ m/exten => $arg[\s,]/){
                                $records[$i] = "exten => $arg,1,MeetMe($arg,t)";
                                print "Changer\n";
                        }
                }

        }
        elsif($ARGV[1] == 3){

                for(my $i = 0; $i <= $records; $i++){
                        if($records[$i] =~ m/exten => $arg[\s,]/){
                                $records[$i] = "exten => $arg,1,MeetMe($arg,Mt)";
                                print "Changer\n";
                      }
                }
        }
		elsif($ARGV[1] == 4){

			for(my $i = 0; $i <= $records; $i++){
					if($records[$i] =~ m/exten => $arg[\s,]/){
							$records[$i] = "exten => $arg,1,MeetMe($arg)";
							print "Changer\n";
				  }
			}
		}
}
else{
        print "c pas bon";
}

system 'asterisk -rx "dialplan reload"'