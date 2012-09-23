#!/usr/bin/perl

sub SYS { system($_[0]); }

SYS("rm -rf build");
SYS("mkdir build");

for my $langfile (<lang-*.txt>) {
    $langfile =~ /-([^.]+)/;
    my $f = uc($1);
    my $fl = lc($1);
    SYS("nmake clean");
    SYS("nmake D=LDLANG_$f");
    SYS("copy ldmicro.exe build\\ldmicro-$fl.exe");
}

SYS("nmake clean");
SYS("nmake D=LDLANG_EN");
SYS("copy ldmicro.exe build\\ldmicro.exe");
