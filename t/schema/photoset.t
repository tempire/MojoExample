use Modern::Perl;
use Nempire::Schema;
use Devel::Dwarn;

use Test::Most;
use Test::Database;

my $photoset_id      = '72157618164628634';
my $photoset_title   = 'houston_correlation';
my $prev_photoset_id = '72157624605719910';
my $next_photoset_id = '72157624492991403';

my $schema = Test::Database->new_test->schema;
is $schema->resultset('Photoset')->by_id_or_title($photoset_id)->id =>
  $photoset_id;
is $schema->resultset('Photoset')->by_id_or_title($photoset_title)->id =>
  $photoset_id;

my $set = $schema->resultset('Photoset')->find($photoset_id);

is ref $set->date         => 'DateTime';
is $set->date->month_abbr => 'Jul';
is $set->date->year       => 2010;

is $set->primary->id => $set->primary_photo->id, 'primary photo alias';
is $set->region      => 'Texas';
is $set->url_title   => $photoset_title;
is $set->location    => 'League City, Texas';
like $set->time_since => qr/\d+ \w+ and \d+ \w+ ago/;

is $set->previous->id => $prev_photoset_id, 'previous photoset';
is $set->next->id     => $next_photoset_id, 'next photoset';

like $set->time_since => qr/\d+ \w+ and \d+ \w+ ago/, 'time since';

done_testing;
