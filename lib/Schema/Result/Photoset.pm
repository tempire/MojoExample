use utf8;
package Schema::Result::Photoset;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("photosets");
__PACKAGE__->add_columns(
  "id",
  { data_type => "char", is_nullable => 0, size => 20 },
  "title",
  { data_type => "char", is_nullable => 0, size => 255 },
  "server",
  { data_type => "char", is_nullable => 0, size => 10 },
  "farm",
  { data_type => "integer", is_nullable => 0 },
  "photos",
  { data_type => "integer", is_nullable => 1 },
  "videos",
  { data_type => "integer", is_nullable => 1 },
  "secret",
  { data_type => "char", is_nullable => 0, size => 20 },
  "primary_photo",
  { data_type => "char", is_foreign_key => 1, is_nullable => 1, size => 20 },
  "idx",
  { data_type => "integer", is_nullable => 0 },
  "description",
  { data_type => "char", is_nullable => 0, size => 255 },
  "timestamp",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "date_create",
  { data_type => "integer", is_nullable => 1 },
  "date_update",
  { data_type => "integer", is_nullable => 1 },
  "can_comment",
  { data_type => "integer", is_nullable => 1 },
  "count_comments",
  { data_type => "integer", is_nullable => 1 },
  "count_views",
  { data_type => "integer", is_nullable => 1 },
  "needs_interstitial",
  { data_type => "integer", is_nullable => 1 },
  "visibility_can_see_set",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many(
  "photos",
  "Schema::Result::Photo",
  { "foreign.photoset" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "primary_photo",
  "Schema::Result::Photo",
  { id => "primary_photo" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-02-05 21:35:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:A75CmBVd9ombVH4YCAs9eg


use Time::Duration;
use Encode;

__PACKAGE__->belongs_to(
  "primary",
  "Schema::Result::Photo",
  { id => "primary_photo" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


sub date   { shift->primary_photo->taken }
sub region { shift->primary_photo->region }

sub decoded_title { return decode_utf8 shift->title }

sub url_title {
  my $self = shift;

  my $title = $self->decoded_title;
  $title =~ s/[^a-zA-Z0-9]+/_/g;

  warn $title if $self->id eq '72157621680562327';
  # Other languages don't translate to url naming Scheme
  return $self->id if $title eq '_';
  warn $title if $self->id eq '72157621680562327';

  return lc $title;
}

sub previous {
    my $self = shift;
    return $self->result_source->resultset->search({idx => $self->idx - 1})
      ->first;
}

sub next {
    my $self = shift;

    return $self->result_source->resultset->search({idx => $self->idx + 1})
      ->first;
}

sub location {
    return shift->primary_photo->location;
}

sub time_since {
    return shift->primary_photo->time_since;
}

1;

=head1 RELATIONSHIPS

=head2 primary

Type: belongs_to

Related object: L<Schema::Result::Photo>

Alias for L<Schema::Result::Photo/primary_photo>

=head1 METHODS

=head2 date

Datetime object from set's primary photo

=head2 decoded_title

Title decoded from utf8

=head2 url_title

Title for use in readable URLs - uses id for incompatible titles

=head2 region

Region from set's primary photo

=head2 previous

Previous set, ordered by idx field

=head2 next

Next set, ordered by idx field

=head2 location

Location from set's primary photo

=head2 time_since

Time since photo was taken
