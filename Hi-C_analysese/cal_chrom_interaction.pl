#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT1,">$ARGV[1]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[2]") || die "Can't open OUT2!\n";

my $total_interaction;
my (%Interaction1,%Interaction2);

while(<IN>){
	chomp;
	#next if(/chrW/);
	my @tmp=split /\s+/,$_;
	if($tmp[0]=~ /W/){
		$tmp[0]=(split /\-/,$tmp[0])[0];
	}
	if($tmp[3]=~ /W/){
		$tmp[3]=(split /\-/,$tmp[3])[0];
	}
	next if($tmp[0] eq $tmp[3]);
	$total_interaction+=$tmp[-1];
	$Interaction1{$tmp[0]}{$tmp[3]}+=$tmp[-1];
	$Interaction2{$tmp[0]}+=$tmp[-1];
	$Interaction2{$tmp[3]}+=$tmp[-1];
}

foreach my $chr1(sort {$a cmp $b} keys %Interaction1){
	foreach my $chr2(sort {$a cmp $b} keys %{$Interaction1{$chr1}}){
		print OUT1 "$chr1\t$chr2\t$Interaction1{$chr1}{$chr2}\n";
	}
}
foreach my $chr(sort {$a cmp $b} keys %Interaction2){
	print OUT2 "$chr\t$Interaction2{$chr}\n";
}
print "$total_interaction\n";
