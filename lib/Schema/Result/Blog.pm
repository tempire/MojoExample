use utf8;
package Schema::Result::Blog;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("blogs");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "char", is_nullable => 0, size => 100 },
  "subtitle",
  { data_type => "tinytext", is_nullable => 1 },
  "content",
  { data_type => "text", is_nullable => 0 },
  "created_time",
  { data_type => "char", is_nullable => 0, size => 20 },
  "timestamp",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "location",
  { data_type => "char", is_nullable => 1, size => 100 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many(
  "blog_tags",
  "Schema::Result::BlogTag",
  { "foreign.blog" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-02-05 21:35:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Pu8So1Y80nFfvuHrqLpqag


use Time::Duration;
use DateTime;
use Lingua::EN::Summarize 'summarize';

# Convert date strings to datetime objects, and vice versa
__PACKAGE__->inflate_column( "created_time", {
   inflate => sub { DateTime->from_epoch( epoch => shift ); }, 
   deflate => sub { shift->epoch; }, 
} );

__PACKAGE__->has_many(
  "tags",
  "Schema::Result::BlogTag",
  { "foreign.blog" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

sub url_title {
    my $self  = shift;
    my $title = $self->title;

    $title =~ s/\W/_/g;

    return lc $title;
}

sub time_since {
    return Time::Duration::ago(time - shift->created_time->epoch);
}

sub created_time_string {
    return shift->created_time->strftime("%A, %B %e, %Y at %l:%M%p");
}

sub snippet {
    return summarize(
        shift->content,
        maxlength => 200,
        filter    => 'html'
    );
}

1;

=head1 RELATIONSHIPS

=head2 tags

Type: has_many

Related object: L<Nempire::Schema::Result::BlogTag>

Alias for: L<blog_tags/Nempire::Schema::Result::BlogTag>

=head1 METHODS

=head2 url_title

Title for readable URLs

=head2 time_since

Time since blog was entered

=head2 created_time_string

pretty created time string

=cut
