use v6;

use lib './lib';

use Test;

# Pluggable module
use Bio::SeqIO;

# Uncomment these lines and the tests pass
#use Bio::fasta;
#use Bio::SeqIO::fasta;

# passes
lives-ok {Bio::SeqIO.new(format  => 'fasta')}, 'simple path';

# These next two fail w/ 'No such symbol' errors
lives-ok {Bio::SeqIO.new(format  => 'Bio::fasta')}, 'one level deep';
lives-ok {Bio::SeqIO.new(format  => 'Bio::SeqIO::fasta')}, 'two levels deep';
