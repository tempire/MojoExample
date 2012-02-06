use utf8;
package Schema::Result::BlogTag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("blog_tags");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "char", is_nullable => 0, size => 50 },
  "blog",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to(
  "blog",
  "Schema::Result::Blog",
  { id => "blog" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07015 @ 2012-02-05 21:35:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dkmcVpL+N1FV5CoZ+jiEjQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
