use v6;

class Bio::SeqIO {

    has $.plugin;

    submethod BUILD(:$format!) {

        try {
            require ::($format);
        };

        if MY::{$format} ~~ Failure {
            die "Can't load $format: $!";
        } else {
            $!plugin = MY::{$format}.new();
            dd $!plugin;
            dd MY::{$format};
        }
    }
}
