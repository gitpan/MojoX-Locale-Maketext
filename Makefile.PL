use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'MojoX::Locale::Maketext',
    AUTHOR        => 'Viacheslav Tikhanovskii <vti@cpan.org>',
    VERSION_FROM  => 'lib/MojoX/Locale/Maketext.pm',
    ABSTRACT_FROM => 'lib/MojoX/Locale/Maketext.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ('LICENSE' => 'perl')
        : ()),
    PL_FILES  => {},
    PREREQ_PM => {
        'Test::More'       => 0,
        'Mojo'             => 0,
        'Locale::Maketext' => 0
    },
    dist  => {COMPRESS => 'gzip -9f', SUFFIX => 'gz'},
    clean => {FILES    => 'MojoX-Locale-Maketext-*'}
);
