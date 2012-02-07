package Schema::ResultSet::Photoset;

use Modern::Perl +2012;
use base 'DBIx::Class::ResultSet';

sub by_id {
  return shift->find({id => pop});
}

sub by_name {
  return shift->find({title => {LIKE => pop}});
}

sub by_id_or_name {
  my ($self, $param) = @_;
  return $param =~ /^\d+$/ ? $self->by_id($param) : $self->by_name($param);
}

sub faces {
  return shift->by_id_or_title('Faces of Glen');
}

1;

=head1 NAME

Schema::ResultSet::Photoset

=head1 METHODS

=head2 id_or_title

Find photoset by either id or title;

=head2 faces

Faces of Glen Photoset

=cut
