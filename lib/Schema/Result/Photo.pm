use utf8;
package Schema::Result::Photo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("photos");
__PACKAGE__->add_columns(
  "id",
  { data_type => "char", default_value => "", is_nullable => 0, size => 20 },
  "description",
  { data_type => "char", is_nullable => 1, size => 255 },
  "lat",
  { data_type => "char", is_nullable => 1, size => 10 },
  "lon",
  { data_type => "char", is_nullable => 1, size => 10 },
  "region",
  { data_type => "char", is_nullable => 1, size => 20 },
  "locality",
  { data_type => "char", is_nullable => 1, size => 20 },
  "country",
  { data_type => "char", is_nullable => 1, size => 20 },
  "square",
  { data_type => "tinytext", is_nullable => 1 },
  "original_url",
  { data_type => "tinytext", is_nullable => 1 },
  "taken",
  { data_type => "datetime", is_nullable => 1 },
  "isprimary",
  { data_type => "char", is_nullable => 1, size => 1 },
  "small",
  { data_type => "tinytext", is_nullable => 1 },
  "medium",
  { data_type => "tinytext", is_nullable => 1 },
  "original",
  { data_type => "tinytext", is_nullable => 1 },
  "thumbnail",
  { data_type => "tinytext", is_nullable => 1 },
  "large",
  { data_type => "tinytext", is_nullable => 1 },
  "is_glen",
  { data_type => "char", is_nullable => 1, size => 1 },
  "idx",
  { data_type => "integer", is_nullable => 1 },
  "photoset",
  { data_type => "char", is_foreign_key => 1, is_nullable => 1, size => 20 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to(
  "photoset",
  "Schema::Result::Photoset",
  { id => "photoset" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);
__PACKAGE__->has_many(
  "photosets",
  "Schema::Result::Photoset",
  { "foreign.primary_photo" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-02-05 21:35:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hBwyD8s8bHZ6aae1bl2a3Q


use Time::Duration;

__PACKAGE__->belongs_to(
  "set",
  "Schema::Result::Photoset",
  { id => "photoset" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

sub location {
  return join ', ' => grep {defined} map {$_->locality, $_->region} shift;
}

sub next {
  return $_->result_source->resultset->find(
    { photoset => $_->set->id,
      idx      => $_->idx + 1
    }
  ) for grep $_->idx => shift;
}

sub previous {
    my $self = shift;

    return if !$self->idx;

    return $self->result_source->resultset->find(
        {   photoset => $self->set->id,
            idx      => $self->idx - 1
        }
    );
}

sub time_since {
    return Time::Duration::ago(time - $_->taken->epoch) for grep $_->taken => shift;
}

=head1 RELATIONSHIPS

=head2 set

Type: belongs_to

Related object: L<Schema::Result::Photoset>

Alias for L<Schema::Result::Photo/photoset>

=head1 METHODS

=head2 location

City, State

=head2 previous

Previous photo in set according to idx

=head2 next

Next photo in set according to idx

=head2 time_since

Time since photo was taken

=cut

1;
