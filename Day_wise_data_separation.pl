#!/usr/bin/perl -w


$input = 'july15_tower.csv';
open(INFILE, $input) or die "Database $input not available\n";

$outf= '>july15_tower_perl.csv';
open(OUTFILE, $outf) or die "Output file could not be opened\n";



my $a=1;
my $g=0;
my $b = "bb";
my $line = "shdoie";
$newline = <INFILE>;
         
	while(<INFILE>)
	{
		$newline = $_;
		if ( $line eq $newline)
		{
		}
		else
		{
		$line = $newline;
		$g+=1;
    			 chomp($newline);
				 
				my @linelist = split(/,/, $newline);

				
				if ($b eq ($linelist[0]))
				{
				print OUTFILE "$a	$linelist[1]	$linelist[2]	$linelist[3] \n";
				$b = $linelist[0];
				}
				else {$a += 1; $b = $linelist[0];
				print OUTFILE "$a	$linelist[1]	$linelist[2]	$linelist[3] \n";
				}
		}		
    	}    
printf $a;
printf "\n";
printf $g;	

close(INFILE);
close(OUTFILE);
