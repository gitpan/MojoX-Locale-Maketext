package MojoX::Locale::Maketext;

use strict;
use warnings;

use base 'Mojo::Base';

require Carp;
require Locale::Maketext;

our $VERSION = '0.03';

__PACKAGE__->attr('_class');
__PACKAGE__->attr('language');
__PACKAGE__->attr('language_tag');
__PACKAGE__->attr('_handle');

sub setup {
    my $self = shift;
    my %options = @_;

    Carp::croak(qq/Namespace is undefined/) unless $options{namespace};

    my $namespace = $options{namespace};
    my $subclass = $options{subclass} || 'I18N';

    my $class = $self->_class($namespace . '::' . $subclass);
    eval <<"";
        package $class;
        use base 'Locale::Maketext';
        1;

    if ($@) {
        Carp::croak(qq/Couldn't initialize i18n "$class", "$@"/);
    }
}

sub languages {
    my $self = shift;

    my $class = $self->_class;
    my $handle = $self->_handle($class->get_handle(@{$_[0]}));

    my $lang = ref $handle;
    $lang =~ s/^.*::// if $lang;

    $self->language($lang);
    $self->language_tag($handle->language_tag);

    return $self;
}

*loc = \&localize;

sub localize {
    my $self = shift;

    my $handle = $self->_handle;

    return $handle->maketext(@_) if $handle;

    return @_;
}

1;
__END__

=head1 NAME

MojoX::Locale::Maketext - Locale::Maketext implementation

=head1 SYNOPSIS

    use MojoX::Locale::Maketext;

    my $i18n =
      MojoX::Locale::Maketext->new(namespace => 'MyApp', subclass => 'I18N');

=head1 DESCRIPTION

L<MojoX::Locale::Maketext> is Locale::Maketext for L<Mojo>.

Standart usage:

    __PACKAGE__->attr('i18n', default => sub { MojoX::Locale::Maketext->new });

    sub startup {
        my $self = shift;

        $self->i18n->setup(namespace => ref $self);
    }

=head1 METHODS

L<MojoX::Locale::Maketext> inherits all methods from L<Mojo::Base> and
implements the following ones.

=head2 C<setup>

    Setup Locale::Maketext module.

    $i18n->setup(namespace => ref $self, subclass => 'I18N');

=head2 C<languages>

    $i18n->languages([qw/ en en-us /]);

=head2 C<language>

    Current selected language.

    $i18n->language;

=head2 C<language_tag>

    Current selected language tag.

    $i18n->language_tag;

=head2 C<localize>
    
    $i18n->localize('Hello, [_1]', 'world');

=head2 C<loc>

    Alias to B<localize>.

=cut
