#!/usr/bin/perl
use strict;
use Tie::File;

my @records;
tie @records, 'Tie::File',"conference.conf";
my $records = @records;
my @split;
my $mdp;
my $smdp;
my $mus;
my $iqe;
my $x;
my $y;
my $choix;

do{
# Verification des options MUSIQUE ET TALK ONLY
for(my $i = 0; $i <= $records; $i++){
        if($records[$i] =~ m/\[macro-conference_mdpt\]/){
                 $y = $i + 2;
                @split = split (/\,/, $records[$y]);
                if ($split[3] =~ m/t\)/){
                        $mdp = 1;
                }
                #elsif($split[3] =~ m/cMI\)/){
                else{
                        $mdp = 0;
                }
                if($split[3] =~ m/M/){
                        $mus = 1;
                }
                else{
                        $mus = 0;
                }
        }
        if($records[$i] =~ m/\[macro-conference_smdpt\]/){
                $x = $i + 2;
                @split = split (/\,/, $records[$x]);
                if ($split[3] =~ m/t\)/){
                        $smdp = 1;
                }
                else{
                        $smdp = 0;
                }
                if($split[3] =~ m/M/){
                        $iqe = 1;
                }
                else{
                        $iqe = 0;
                }
        }
}
#AFFICHAGE DES OPTIONS AVEC LEUR ETAT DE FONCTIONNEMENT
print "\n";
if($mdp == 0){
        print "1 - ACTIVER L'OPTION TALK ONLY POUR CONFERENCE MOT DE PASSE\n";
}
elsif($mdp == 1){
        print "1 - DESACTIVER L'OPTION TALK ONLY POUR CONFERENCE MOT DE PASSE\n";
}


if($smdp == 0){
        print "2 - ACTIVER L'OPTION TALK ONLY POUR CONFERENCE SANS MOT DE PASSE\n";
}
elsif($smdp == 1){
        print "2 - DESACTIVER L'OPTION TALK ONLY POUR CONFERENCE SANS MOT DE PASSE\n";
}

if($mus == 0){
        print "3 - ACTIVER L'OPTION MUSIQUE POUR CONFERENCE MOT DE PASSE\n";
}
elsif($mus == 1){
        print "3 - DESACTIVER L'OPTION MUSIQUE POUR CONFERENCE MOT DE PASSE\n";
}
if($iqe == 0){
        print "4 - ACTIVER L'OPTION MUSIQUE POUR CONFERENCE SANS MOT DE PASSE\n";
}
elsif($iqe == 1){
        print "4 - DESACTIVER L'OPTION MUSIQUE POUR CONFERENCE SANS MOT DE PASSE\n";
}
print ("Appuyez q pour quitter\n");

#ON RECUPERE LE CHOIX D'UTILISATEUR
$choix = <>;
until(($choix == 1)||($choix == 2)||($choix == 3)||($choix == 4)||($choix == "q")){
        print "Veuillez choisir une option\n";
        $choix = <>;
}
#MODIFIER OPTION TALK ONLY CONFERENCE MOT DE PASSE
if($choix == 1){
        if($mdp == 0 && $mus == 0){
                $records[$y] = "exten => s,n,MeetMe(770,cIt)";
                print "L'option Talk Only a était ACTIVER pour conference mot de passe\n";
        }
        elsif($mdp == 0 && $mus == 1){
                $records[$y] = "exten => s,n,MeetMe(770,cMIt)";
                print "L'option Talk Only a était ACTIVER pour conference mot de passe\n";
        }

        elsif($mdp == 1 && $mus == 0){
                $records[$y] = "exten => s,n,MeetMe(770,cI)";
                print "L'option Talk Only a était DESACTIVER pour conference mot de passe\n";
        }
        elsif($mdp == 1 && $mus == 1){
                $records[$y] = "exten => s,n,MeetMe(770,cMI)";
                print "L'option Talk Only a était DESACTIVER pour conference mot de passe\n";
        }
}
#MODIFIER OPTION TALK ONLY CONFERENCE SANS MOT DE PASSE
elsif($choix == 2){
        if($smdp == 0 && $iqe == 0){
                $records[$x] = "exten => s,n,MeetMe(790,cIt)";
                print "L'option Talk Only a était ACTIVER pour conference sans mot de passe\n";
        }
        elsif($smdp == 0 && $iqe == 1){
                $records[$x] = "exten => s,n,MeetMe(790,cMIt)";
                print "L'option Talk Only a était ACTIVER pour conference sans mot de passe\n";
        }
        elsif($smdp == 1 && $iqe == 0){
                $records[$x] = "exten => s,n,MeetMe(790,cI)";
                print "L'option Talk Only a était DESACTIVER pour conference sans mot de passe\n";
        }
        elsif($smdp == 1 && $iqe == 1){
                $records[$x] = "exten => s,n,MeetMe(790,cMI)";
                print "L'option Talk Only a était DESACTIVER pour conference sans mot de passe\n";
        }
}
#MDOFIER OPTION MUSIQUE CONFERENCE MOT DE PASSE
elsif($choix == 3){
        if($mus == 0 && $mdp == 0){
                $records[$y] = "exten => s,n,MeetMe(770,cMI)";
                print "L'option Musique a était ACTIVER pour conference mot de passe\n";
        }
        elsif($mus == 0 && $mdp == 1){
                $records[$y] = "exten => s,n,MeetMe(770,cMIt)";
                print "L'option Musique a était ACTIVER pour conference mot de passe\n";
        }
        elsif($mus == 1 && $mdp == 0){
                $records[$y] = "exten => s,n,MeetMe(770,cI)";
                print "L'option Musique a était DESACTIVER pour conference mot de passe\n";
        }
        elsif($mus == 1 && $mdp == 1){
                $records[$y] = "exten => s,n,MeetMe(770,cIt)";
                print "L'option Musique a était DESACTIVER pour conference mot de passe\n";
        }
}
#MODIFER OPTION MUSIQUE CONFERENCE SANS MOT DE PASSE
elsif($choix == 4){
        if($iqe == 0 && $smdp == 0){
                $records[$x] = "exten => s,n,MeetMe(790,cMI)";
                print "L'option Musique a était ACTIVER pour conference sans mot de passe\n";
        }
        elsif($iqe == 0 && $smdp == 1){
                $records[$x] = "exten => s,n,MeetMe(790,cMIt)";
                print "L'option Musique a était ACTIVER pour conference sans mot de passe\n";
        }
        elsif($iqe == 1 && $smdp == 0){
                $records[$x] = "exten => s,n,MeetMe(790,cI)";
                print "L'option Musique a était DESACTIVER pour conference sans mot de passe\n";
        }
        elsif($iqe == 1 && $smdp == 1){
                $records[$x] = "exten => s,n,MeetMe(790,cIt)";
                print "L'option Musique a était DESACTIVER pour conference sans mot de passe\n";
        }
}
}while($choix != "q"); 