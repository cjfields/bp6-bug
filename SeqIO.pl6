use v6;

use lib './lib';

use Test;

# Pluggable module
use Bio::SeqIO;

# passes
lives-ok {Bio::SeqIO.new(format  => 'fasta')};

# These next two fail w/ 'No such symbol' errors
lives-ok {Bio::SeqIO.new(format  => 'Bio::fasta')};
lives-ok {Bio::SeqIO.new(format  => 'Bio::SeqIO::fasta')};
