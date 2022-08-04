#!/usr/bin/perl -w

use strict;
use warnings ;

my $usage ="Usage: $0 <genomes list file>";

### Read list of genomes to be included
my $genomes_list_file = shift or die "$usage\n";
my %genomes_list;
open(GENOMES_LIST, "<$genomes_list_file") or die $!;
while (my $line = <GENOMES_LIST>) {
    chomp $line;
    unless ($line=~m/^\#/) {
	if ($line =~ m/^(\S+)\s+(.*)/) {
	    my ($filename, $genome) = ($1, $2);
	    $filename =~ s/\.fna$|\.contig$//;

	    if (-s "$filename.contig") {
		$filename = "$filename.contig";
		$genome .= '.contig';
	    } elsif ( -s "$filename.fna") {
		$filename = "$filename.fna";
		$genome .= '.fna';
	    } else {
		warn "Can't find a file matching $filename";
	    }
	    
	    $genome =~ s/\s+/_/g;
	    $genomes_list{$filename} = $genome;
	}
    }
}
close GENOMES_LIST;

foreach my $filename (keys %genomes_list) {
    my $genome = $genomes_list{$filename};
    my $cmd = "cp $filename \"$genome\"";
    warn "$cmd\n";
    system($cmd);
}
