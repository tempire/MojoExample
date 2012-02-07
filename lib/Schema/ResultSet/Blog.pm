package Schema::ResultSet::Blog;

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

sub by_tags {
  my ($self, @tags) = @_;

  return if !@tags;

  my $tags = $self->search_related(tags => {name => [@tags]});

  return map $_->blog => $tags->all;
}

sub latest {
  return
    shift->not_hidden->search({},
    {order_by => {-desc => 'created_time'}, rows => 1})->single;
}

sub hidden {
  return shift->search(
    {},
    { join     => 'tags',
      group_by => 'me.id',
      where    => {'tags.name' => 'hidden'}
    }
  );
}

sub not_hidden {
  return shift->search(
    {},
    { join     => 'tags',
      group_by => 'me.id',
      where    => {'tags.name' => {'!=' => 'hidden'}}
    }
  );
}

1;

=head1 NAME

Schema::ResultSet::Blog

=head1 METHODS

=head2 by_id

Find one blog entry by id

=head2 by_name

Find one blog entry by title

=head2 by_tags

Search blogs by related tags

=head2 latest

Most recently posted entry, chained from L<not_hidden>

=head2 hidden

Hidden entries (by 'hidden' tag)

=head2 not_hidden

Available entries

=cut
