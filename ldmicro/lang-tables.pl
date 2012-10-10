#!/usr/bin/perl

use strict;

my $t;

for my $file (sort <lang-*.txt>) {

    my $name = $file;
    $name =~ s#lang-##;
    $name =~ s#(.)#uc($1)#e;
    $name =~ s#\.txt##;
    $nameUc = uc($name);
    
    print "#ifdef LDLANG_$nameUc\n";
    print "static LangTable Lang${name}Table[] = {\n";

    my $engl = 1;
    local $. = 0;
    open(my $in, '<', $file) or die "couldn't open $file";
    while(<$in>) {
        chomp;

        if (/^\s*$/) {
            if ($engl) {
                next;
            }
            die "blank line mid-translation at $file, $.\n";
        }

        if ($engl) {
            $toTranslate = $_;
            $engl = 0;
        } else {
            $translated = $_;

            print "    { $toTranslate, $translated },\n";
            $engl = 1;
        }
    }

    print "};\n";

    print <<EOT;
static Lang Lang$name = {
    Lang${name}Table, sizeof(Lang${name}Table)/sizeof(Lang${name}Table[0])
};
#endif
EOT

    close FILE;
}

