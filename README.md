# Bug report

Instead of packaging this up, I'm posting this here so the repo can be easily cloned and tested.

I'm seeing a bug that appeared after lexical module loading was introduced, which is tied to
the name of the class and how deep it is in the path.  

```
[cjfields@Chriss-MacBook-Air lex-bp6]$ tree .
.
├── SeqIO.pl6
└── lib
    ├── Bio
    │   ├── SeqIO
    │   │   └── fasta.pm6
    │   ├── SeqIO.pm6
    │   └── fasta.pm6
    └── fasta.pm6

3 directories, 5 files
```

In the script and the directory structure, note that three modules are named similarly, e.g. `fasta`, `Bio::fasta`, and `Bio::SeqIO::fasta`.  The pluggable `Bio::SeqIO` dynamically loads the module passed.  

The test script:

```perl6
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
```

Note the commented `use` statements; these should be loaded dynamically.  When running this, the last two tests fail:

```
[cjfields@Chriss-MacBook-Air lex-bp6]$ perl6 SeqIO.pl6

ok 1 -
not ok 2 -

# Failed test at SeqIO.pl6 line 14
# Can't load Bio::fasta: No such symbol 'Bio::fasta'
not ok 3 -

# Failed test at SeqIO.pl6 line 15
# Can't load Bio::SeqIO::fasta: No such symbol 'Bio::SeqIO::fasta'
```

If you uncomment the line, they pass:

```
[cjfields@Chriss-MacBook-Air lex-bp6 (master)]$ cat SeqIO.pl6
use v6;

use lib './lib';

use Test;

# Pluggable module
use Bio::SeqIO;

# Uncomment these lines and the tests pass
use Bio::fasta;
use Bio::SeqIO::fasta;

# passes
lives-ok {Bio::SeqIO.new(format  => 'fasta')}, 'simple path';

# These next two fail w/ 'No such symbol' errors
lives-ok {Bio::SeqIO.new(format  => 'Bio::fasta')}, 'one level deep';
lives-ok {Bio::SeqIO.new(format  => 'Bio::SeqIO::fasta')}, 'two levels deep';
[cjfields@Chriss-MacBook-Air lex-bp6 (master)]$ perl6 SeqIO.pl6
ok 1 - simple path
ok 2 - one level deep
ok 3 - two levels deep
[cjfields@Chriss-MacBook-Air lex-bp6 (master)]$
```
