#!/usr/bin/perl
use strict;
use Tie::File;

my @records;
tie @records, 'Tie::File', "/var/dialplan/conference.conf";
my $records = @records;
my @chaine;
my @meet;
tie @meet, 'Tie::File', "/etc/asterisk/meetme.conf";
my $meet = @meet;

my $size = scalar(@ARGV);
my $arg = $ARGV[0];
my $res = 0;
my $chaine = 0;
for(my $i = 0; $i <= $meet; $i++){
        if($meet[$i] =~  m/conf => $arg[\s,]/){
                @chaine = split (/[\,,\s]/, $meet[$i]);
                $chaine = @chaine;
                if($size > 2){
                        $res = 3;
                }
                elsif($chaine == 3 && $size == 1 || $chaine == 4 && $size == 2 && $ARGV[1] == $chaine[3]){
                        $res = 1;
                }
                elsif($chaine == 4 && $size == 2 && $ARGV[1] != $chaine[3]){
                        $res = 4;
                }
                elsif(($chaine == 4) && ($size == 1)){
                        $res = 2;
                }
#               elsif(3 <= $size){
#                       $res = 3;
#               }
        }
}

if($res == 0){
        print "Le numero de conference demandé n'existe pas\n";
}
elsif($res == 1){
        for(my $i = 0; $i <= $records; $i++){
                if($records[$i] =~ m/exten => $arg[\s,]/){
                        splice @records, $i, 1;
                        print "Supprimer dans le fichier extensions.conf\n";
                }
        }

        for(my $i = 0; $i <= $meet; $i++){
                if($meet[$i] =~  m/conf => $arg[\s,]/){
                        splice @meet, $i, 1;
                        print "Supprimer dans le fichier meetme.conf \n";
                }
        }
}
elsif($res == 2){
        print "Veuillez rentez le mot de passe de la conference\n";
}
elsif($res == 3){
        print "Veuillez indiquez le numéro de conférence et/ou le mot de passe\n";
}
elsif($res == 4){
        print "Mot de passe incorrect\n";
}

system 'asterisk -rx "dialplan reload"'