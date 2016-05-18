#!/usr/bin/perl
use strict;
use Tie::File;
# 1 - Pour Activer Musique et TalkOnly Pour conference MDP
# 2 - Pour Activer Que TalkOnly Pour conference MDP
# 3 - Pour Activer Que Musique Pour conference MDP
# 4 - Pour Activer Musique et TalkOnly Pour conference SMDP
# 5 - Pour Activer Que TalkOnly Pour conference MDP
# 6 - Pour Activer Que Musique Pour conference MDP
my @records;
tie @records, 'Tie::File',"conference.conf";
my $records = @records;
my $argv = @ARGV;

if($argv != 1){
        print "Veuillez rentrer un argument\n";
}
else{
        if($ARGV[0] == 1){
                for(my $i = 0; $i < $records; $i++){
                        if($records[$i] =~ m/\[macro-conference_mdpt\]/){
                                my $x = $i + 2;
                                $records[$x] = "exten => s,n,MeetMe(770,cMIt)";
                                print "Les options Musique et Talk Only viens d'etre active pour conference mot de passe\n";
                        }
                }
        }
        elsif($ARGV[0] == 2){
                for(my $i = 0; $i < $records; $i++){
                        if($records[$i] =~ m/\[macro-conference_mdpt\]/){
                                my $x = $i + 2;
                                $records[$x] = "exten => s,n,MeetMe(770,cIt)";
                                print "Seule l'option Talk Only viens d'etre active pour conference mot de passe\n";
                        }
                }
        }
        elsif($ARGV[0] == 3){
                for(my $i = 0; $i < $records; $i++){
                        if($records[$i] =~ m/\[macro-conference_mdpt\]/){
                                my $x = $i + 2;
                                $records[$x] = "exten => s,n,MeetMe(770,cMI)";
                                print "Seule l'option musique viens d'etre active pour conference mot de passe\n";
                        }
                }
        }
        elsif($ARGV[0] == 4){
                for(my $i = 0; $i < $records; $i++){
                        if($records[$i] =~ m/\[macro-conference_smdpt\]/){
                                my $x = $i + 2;
                                $records[$x] = "exten => s,n,MeetMe(790,cMIt)";
                                print "Les options Musique et Talk Only viens d'etre active pour conference sans mot de passe\n";
                        }
                }
        }
        elsif($ARGV[0] == 5){
                for(my $i = 0; $i < $records; $i++){
                        if($records[$i] =~ m/\[macro-conference_smdpt\]/){
                                my $x = $i + 2;
                                $records[$x] = "exten => s,n,MeetMe(790,cIt)";
                                print "Seule l'option Talk Only viens d'etre active pour conference sans mot de passe\n";
                        }
                }
        }
        elsif($ARGV[0] == 6){
                for(my $i = 0; $i < $records; $i++){
                        if($records[$i] =~ m/\[macro-conference_smdpt\]/){
                                my $x = $i + 2;
                                $records[$x] = "exten => s,n,MeetMe(790,cMI)";
                                print "Seule l'option musique viens d'etre active pour conference sans mot de passe\n";
                        }
                }
        }
        else{
                print "Cette option n'existe pas\n";
        }
}
