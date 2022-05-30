#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
use Statistics::Descriptive;

open(IN0,"$ARGV[0]") || die "Can't open IN0!\n";
open(IN1,"$ARGV[1]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[2]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[3]") || die "Can't open OUT!\n";

my $total;
while(<IN0>){
	chomp;
	$total=$_;
}

my %Chrom;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Chrom{$tmp[0]}=$tmp[1];
}

print OUT "chr1\tchr2\tscore\n";
my %hash;
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	my $score=($tmp[2])/((($Chrom{$tmp[0]}/$total)*($Chrom{$tmp[1]}/($total-$Chrom{$tmp[0]}))+(($Chrom{$tmp[1]}/$total)*($Chrom{$tmp[0]}/($total-$Chrom{$tmp[1]}))))*($total/2)) if($total!=0 && ($total-$Chrom{$tmp[0]})!=0 && ($total-$Chrom{$tmp[1]})!=0 && ((($Chrom{$tmp[0]}/$total)*($Chrom{$tmp[1]}/($total-$Chrom{$tmp[0]}))+(($Chrom{$tmp[1]}/$total)*($Chrom{$tmp[0]}/($total-$Chrom{$tmp[1]}))))*($total/2))!=0);
	$score=log2($score);
	$hash{$tmp[0]}{$tmp[1]}=$score;
	$hash{$tmp[1]}{$tmp[0]}=$score;
}

foreach my $chr1(sort {$a cmp $b} keys %hash){
	print OUT "$chr1\t$chr1\tNA\n";
	foreach my $chr2(sort {$a cmp $b} keys %{$hash{$chr1}}){
		print OUT "$chr1\t$chr2\t$hash{$chr1}{$chr2}\n";
	}
}

sub log2{
	my $n = shift;
	return log($n) / log(2); 
}
