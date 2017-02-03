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
[cjfields@Chriss-MacBook-Air lex-bp6]$ perl6 SeqIO.pl6

ok 1 -
not ok 2 -

# Failed test at SeqIO.pl6 line 14
# Can't load Bio::fasta: No such symbol 'Bio::fasta'
not ok 3 -

# Failed test at SeqIO.pl6 line 15
# Can't load Bio::SeqIO::fasta: No such symbol 'Bio::SeqIO::fasta'
```

