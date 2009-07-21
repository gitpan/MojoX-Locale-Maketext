#!/usr/bin/perl

package MyTest;

package MyTest::I18N::de;
use base 'MyTest::I18N';

our %Lexicon = ('Hello' => 'Hallo');

package MyTest::I18N::en;
use base 'MyTest::I18N';

our %Lexicon = (_AUTO => 1);

package main;

use strict;
use warnings;

use Test::More tests => 8;

use_ok('MojoX::Locale::Maketext');

my $i18n = MojoX::Locale::Maketext->new();

$i18n->setup(namespace => 'MyTest', subclass => 'I18N');

$i18n->languages(['de']);
is($i18n->language,          'de');
is($i18n->language_tag,      'de');
is($i18n->loc('Hello'),      'Hallo');
is($i18n->localize('Hello'), 'Hallo');

$i18n->languages(['en']);
is($i18n->language,     'en');
is($i18n->language_tag, 'en');
is($i18n->loc('Hello'), 'Hello');
