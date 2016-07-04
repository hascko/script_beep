#!/usr/bin/perl
use strict;use warnings;
use File::Find;

my $n;

sub recherche {
 if (-f){++$n if $File::Find::name =~ /\.wav/;}
}

find(\&recherche,"/var/www/site_beep/voicemail/voicemail/$ARGV[0]/INBOX");
open(FD, ">count_vocale.txt");

print (FD "$n\n");
