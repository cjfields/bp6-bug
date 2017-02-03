use v6;

class Bio::SeqIO {

    has $.plugin;

    submethod BUILD(:$format!) {

        try {
            require ::($format);
        };

        if ::($format) ~~ Failure {
            die "Can't load $format: $!";
        } else {
            $!plugin = ::($format).new();
        }
    }
}
