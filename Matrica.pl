#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Time::HiRes qw(gettimeofday tv_interval);
$| = 1;

print "Enter 3 digits: \n";
my @array;

for (my $increment = 0; $increment < 3; $increment++) {
    $array[$increment] = <STDIN>;
}

my $N = $array[0];
my $a = $array[1];
my $b = $array[2];
my @arrayA;
my @arrayB;
my @arrayC;
my $startTime;
my $runTime = 0;
my $rounded;

for (my $x = 0; $x < $N; $x++) {
    for (my $y = 0; $y < $N; $y++) {
        $arrayA[$x][$y] = $a +  0.0000001*($y + $N * $x);
        $arrayB[$x][$y] = $b - 0.0000001*($y + $N * $x);
    }
}


$startTime = gettimeofday;
for (my $x = 0; $x < $N; $x++) {
    for (my $y = 0; $y < $N; $y++) {
        for (my $c = 0; $c < $N; ($c)++) {
            $arrayC[$x][$y] += $arrayA[$x][$c] * $arrayB[$c][$y];
        }
    }
}
$runTime += (gettimeofday -$startTime);
$rounded = sprintf("%.7f",$runTime);
print "$arrayC[0][0]\n";
print "$arrayC[$N - 1][$N - 1]\n";
print "Time of program execution: $rounded seconds\n";

my $mid;
my $left = 300;
my $right = 1000;
$runTime = 0;
$rounded = 0;
my $stop = 1;


while ($stop){
   $runTime = 0;
   $mid = $left + int(($right - $left)/2);
    for (my $x = 0; $x < $mid; $x++) {
        for (my $y = 0; $y < $mid; $y++) {
            $arrayA[$x][$y] = $a + 0.0000001 * ($x + $N * $y);
            $arrayB[$x][$y] = $b - 0.0000001 * ($x + $N * $y);
        }
    }

    $startTime = gettimeofday;
    for (my $x = 0; $x < $mid; $x++) {
        for (my $y = 0; $y < $mid; $y++) {
            for (my $c = 0; $c < $mid; ($c)++) {
                $arrayC[$x][$y] = $arrayA[$x][$c] * $arrayB[$c][$y];
            }
        }
    }
    $runTime += (gettimeofday -$startTime);
    $rounded = sprintf("%.7f",$runTime);

    if (($rounded >= 59) && ($rounded <=61)){
        print "\n";
        $stop = 0;
    } else {
        if ($rounded > 60){
            $right = $mid;
        } else {
            $left = $mid;
        }
    }
}

print "Maximal size of array: $mid \n";

$runTime = 0;
$startTime = gettimeofday;
for (my $x = 0; $x < $mid; $x++) {
    for (my $y = 0; $y < $mid; $y++) {
       for (my $c = 0; $c < $mid; $c++) {
          $arrayC[$x][$y] = $arrayA[$x][$c] * $arrayB[$c][$y];
    }
}
}
$runTime += (gettimeofday -$startTime);
print "\n";

$rounded = sprintf("%.7f", $runTime);


$runTime = 0;
for (my $i = 0; $i < 10; $i++) {
    $startTime = gettimeofday;
    for (my $x = 0; $x < $mid; $x++) {
        for (my $y = 0; $y < $mid; $y++) {
            for (my $c = 0; $c < $mid; $c++) {
                $arrayC[$x][$y] = $arrayA[$x][$c] * $arrayB[$c][$y];
            }
        }
    }
    $runTime += (gettimeofday -$startTime);
}
print "\n";
$rounded = sprintf("%.7f",$runTime);
$rounded /= 10;
print "Middle time of program execution: $rounded \n";
my $share = abs(100 - ($rounded * 100)/60);
print "Deviation: $share ";