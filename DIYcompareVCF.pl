#!/usr/bin/env perl

use Modern::Perl '2015';
use autodie;
use experimental qw/signatures postderef/;
#use Data::Dumper;

die "$0 file1.vcf file2.vcf\n" unless $#ARGV == 1;

my %ref;
readFile($_) foreach ($ARGV[0], $ARGV[1]);

say join "\t",qw/CHROM POS ID REF ALT QUAL FILTER INFO FORMAT Mtb/; #HEADER

for my $key (sort {$a <=> $b} keys %ref){
   say join("\t",   $ref{$key}->{chrom},
                    $ref{$key}->{id},
                    $ref{$key}->{ref},
                    join('||', $ref{$key}->{alt}->@*)."||",
                    $ref{$key}->{qual},
                    $ref{$key}->{filter},
                    $ref{$key}->{info},
                    $ref{$key}->{format},
                    join('||', $ref{$key}->{mtb}->@*))."||",
}

sub readFile($fileName)
{
    open my $file, "<", $fileName;
    while(my $line = <$file>)
    {
        if($line =~ m/^[^#]/){
            chomp $line;
            my ($chrom, $pos, $id, $ref, $alt, $qual, $filter, $info, $format, $mtb) = split(/\t/, $line);
            if(!exists $ref{$pos})
            {
                $ref{$pos} = {
                                chrom  => $chrom,
                                ref    => $ref,
                                qual   => $qual,
                                filter => $filter,
                                info   => $info,
                                format => $format,
                             };

                push @{$ref{$pos}->{alt}}, $alt;
                push @{$ref{$pos}->{mtb}}, $mtb;
            }else{
                push @{$ref{$pos}->{alt}}, $alt;
                push @{$ref{$pos}->{mtb}}, $mtb;
            }
        }
    }
#say Dumper %ref;
}

__DATA__
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	Mtb
gi|448814763|ref|NC_000962.3|	1849	.	C	A	222	.	DP=38;VDB=3.066695e-01;AF1=1;AC1=2;DP4=0,0,17,20;MQ=46;FQ=-138	GT:PL:GQ	1/1:255,111,0:99
gi|448814763|ref|NC_000962.3|	1977	.	A	G	222	.	DP=26;VDB=2.470958e-01;AF1=1;AC1=2;DP4=0,0,5,19;MQ=45;FQ=-99	GT:PL:GQ	1/1:255,72,0:99
gi|448814763|ref|NC_000962.3|	4013	.	T	C	222	.	DP=54;VDB=3.171747e-01;AF1=1;AC1=2;DP4=0,0,27,25;MQ=47;FQ=-184	GT:PL:GQ	1/1:255,157,0:99
gi|448814763|ref|NC_000962.3|	7362	.	G	C	222	.	DP=77;VDB=2.243493e-01;AF1=1;AC1=2;DP4=0,0,42,34;MQ=45;FQ=-256	GT:PL:GQ	1/1:255,229,0:99
gi|448814763|ref|NC_000962.3|	7581	.	G	A	222	.	DP=77;VDB=3.868569e-01;AF1=1;AC1=2;DP4=0,0,34,40;MQ=42;FQ=-250	GT:PL:GQ	1/1:255,223,0:99
gi|448814763|ref|NC_000962.3|	7585	.	G	C	222	.	DP=78;VDB=2.912741e-01;AF1=1;AC1=2;DP4=0,0,35,43;MQ=42;FQ=-262	GT:PL:GQ	1/1:255,235,0:99
gi|448814763|ref|NC_000962.3|	9304	.	G	A	222	.	DP=70;VDB=4.160671e-01;AF1=1;AC1=2;DP4=0,0,32,33;MQ=47;FQ=-223	GT:PL:GQ	1/1:255,196,0:99
gi|448814763|ref|NC_000962.3|	11820	.	C	G	222	.	DP=64;VDB=2.530749e-01;AF1=1;AC1=2;DP4=0,0,35,25;MQ=43;FQ=-208	GT:PL:GQ	1/1:255,181,0:99
gi|448814763|ref|NC_000962.3|	11879	.	A	G	222	.	DP=65;VDB=3.882483e-01;AF1=1;AC1=2;DP4=0,0,38,26;MQ=44;FQ=-220	GT:PL:GQ	1/1:255,193,0:99
gi|448814763|ref|NC_000962.3|	14785	.	T	C	222	.	DP=87;VDB=2.333809e-01;AF1=1;AC1=2;DP4=0,0,48,39;MQ=44;FQ=-282	GT:PL:GQ	1/1:255,255,0:99
gi|448814763|ref|NC_000962.3|	14861	.	G	T	222	.	DP=82;VDB=1.995208e-01;AF1=1;AC1=2;DP4=0,0,39,40;MQ=43;FQ=-265	GT:PL:GQ	1/1:255,238,0:99
gi|448814763|ref|NC_000962.3|	15117	.	C	G	222	.	DP=65;VDB=9.069146e-02;AF1=1;AC1=2;DP4=0,0,30,33;MQ=47;FQ=-217	GT:PL:GQ	1/1:255,190,0:99
gi|448814763|ref|NC_000962.3|	16119	.	C	A	222	.	DP=40;VDB=2.140469e-01;AF1=1;AC1=2;DP4=0,0,16,20;MQ=47;FQ=-135	GT:PL:GQ	1/1:255,108,0:99

$VAR9 = '3336359';
$VAR10 = {
           'chrom' => 'gi|448814763|ref|NC_000962.3|',
           'mtb' => [
                      '1/1:255,138,0:99'
                    ],
           'format' => 'GT:PL:GQ',
           'alt' => [
                      'A'
                    ],
           'qual' => '222',
           'ref' => 'C',
           'filter' => '.',
           'info' => 'DP=47;VDB=2.227686e-01;AF1=1;AC1=2;DP4=0,0,17,29;MQ=47;FQ=-165'
         };
