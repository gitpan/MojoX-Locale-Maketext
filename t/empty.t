#!/usr/bin/perl

package MyTest;

package main;

use strict;
use warnings;

use Test::More tests => 5;

use_ok('MojoX::Locale::Maketext');

my $i18n = MojoX::Locale::Maketext->new;

$i18n->setup(namespace => 'MyTest', subclass => 'I18N');

$i18n->languages(['de']);
is($i18n->language,     'en');
is($i18n->language_tag, 'en');
is($i18n->loc('Hello', ' there'), 'Hello there');
is($i18n->localize('Hello'), 'Hello');
