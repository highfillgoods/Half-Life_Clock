#!/usr/bin/perl

use strict;

# Define the base directory for audio files
## change to your /wavs directory
my $base = "/home/jona/wavs";



## collect the system time using the date binary

 ## 12 hour time 
  #my $hour=`date +%I`; chop($hour);
 ## 24 hour time 
  my $hour=`date +%H`; chop($hour);

## get min
my $minute = `date +%M`; chop($minute);

# "the time is" wav
my @audio = ("$base/time_is.wav");

# Handle special cases for hours 21 and 22
if ($hour == 21) {
    push(@audio, "$base/20.wav");
    push(@audio, "$base/01.wav");
} elsif ($hour == 22) {
    push(@audio, "$base/20.wav");
    push(@audio, "$base/02.wav");
} elsif ($hour == 23) {
    push(@audio, "$base/20.wav");
    push(@audio, "$base/03.wav");
} else {
    # For other hours, play the hour's corresponding audio file
    push(@audio, "$base/$hour.wav");
}

# The minute wav. Check for minutes which are less than 20
if ($minute > 20) {
    my $min1 = eval($minute - ($minute % 10));
    my $min2 = eval($minute % 10);
    push(@audio, "$base/$min1.wav");
    unless ($min2 == 0) {
        push(@audio, "$base/$min2.wav");
    }
} else {
    if ($minute != 0) {
        push(@audio, "$base/$minute.wav");
    }
}

# Announce the time
system("play -q @audio");
