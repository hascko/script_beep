#!/usr/bin/perl
use strict;
use Tie::File;


my $size = scalar(@ARGV);
my $arg = $ARGV[0];
my $res = 0;
#my @records;
#tie @records, 'Tie::File', "/etc/asterisk/meetme.conf";
#my $records = @records;
my @exten;
tie @exten, 'Tie::File', "/var/dialplan/conference.conf";
my $exten = @exten;
for(my $i = 0; $i <= $exten; $i++){
        if($exten[$i] =~  m/exten => $arg[\s,]/){
                $res = 1;
        }
}
if($size == 1) {

        if($ARGV[0] =~ m/^\d+$/){
                if($res == 0){
                        for(my $x=0; $x <= $exten; $x++){
                                if($exten[$x] =~ m/\; Conference/){
                                        $exten[$x] = "; Conference\nexten => $ARGV[0],1,MeetMe($ARGV[0])\n";
                                }
                        }
                        if(open (FD, ">>/etc/asterisk/meetme.conf")){
                                print (FD "conf => $ARGV[0] \n");
                        }
                        else {
                                exit(1);
                        }

                        print "Numero de conference $ARGV[0] a bien ete cree \n";
                }
                elsif($res == 1) {
                        print "Ce numero n'est pas disponible\n";
                }
        }
        else {
                        print "Veuillez entrez un chiffre numérique";
}

}
elsif($size == 2){
        if($ARGV[0] =~ m/^\d+$/ && $ARGV[1] =~ m/^\d+$/){
                if($res == 0){
                        for(my $x=0; $x <= $exten; $x++){
                                if($exten[$x] =~ m/\; Conference/){
                                        $exten[$x] = "; Conference\nexten => $ARGV[0],1,MeetMe($ARGV[0])\n";
                                }
                        }
                        if(open (FD, ">>/etc/asterisk/meetme.conf")){
                                print (FD "conf => $ARGV[0],$ARGV[1]\n");
                        }
                        else {
                                exit(1);
                        }

                        print "Numero de conference $ARGV[0] a bien ete cree \n";
                }
                elsif($res == 1) {
                        print "Ce numero n'est pas disponible\n";
                }
        }
        else {
                print "Veuillez entrez un chiffre numérique";
        }
}
else{
        print "Indiquez le numéro de conférence et/ou le mot de passe\n";
}

system 'asterisk -rx "dialplan reload"'