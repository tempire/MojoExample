use Test::Database;
use Modern::Perl + 2012;
use Test::Most;
use Schema;
use Test::Mojo;
use Test::Database;

my $t = Test::Mojo->new('MojoFull');
my $schema =
  Test::Database->new_test(Schema => ':memory:', home_path => $t->app->home)
  ->schema;

my $photoset_id      = '72157624222825789';
my $photoset_title   = 'robot_arms_apts_';
my $prev_photoset_id = '72157624222820921';
my $next_photoset_id = '72157624347519408';

is $schema->resultset('Photoset')->by_id_or_title($photoset_id)->id =>
  $photoset_id;
is $schema->resultset('Photoset')->by_id_or_title($photoset_title)->id =>
  $photoset_id;

my $set = $schema->resultset('Photoset')->find($photoset_id);

is ref $set->date         => 'DateTime';
is $set->date->month_abbr => 'Jun';
is $set->date->year       => 2010;

is $set->primary->id => $set->primary_photo->id, 'primary photo alias';
is $set->region      => 'California';
is $set->url_title   => $photoset_title;
is $set->location    => 'Chico, California';
like $set->time_since => qr/\d+ \w+ and \d+ \w+ ago/;

is $set->previous->id => $prev_photoset_id, 'previous photoset';
is $set->next->id     => $next_photoset_id, 'next photoset';

like $set->time_since => qr/\d+ \w+ and \d+ \w+ ago/, 'time since';

done_testing;
