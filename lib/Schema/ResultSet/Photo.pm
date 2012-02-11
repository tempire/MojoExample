package Schema::ResultSet::Photo;

use Modern::Perl;
use base 'DBIx::Class::ResultSet';

sub latest {
    my $self  = shift;
    my $count = shift;

    return $self->search( undef,
        { order_by => { -desc => 'taken' }, page => 1, rows => $count } );
}

1;

=head1 NAME

Schema::ResultSet::Photoset

=head1 METHODS

=head2 latest

Return latest photos by count

=cut
