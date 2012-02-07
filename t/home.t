use Modern::Perl +2012;
use Test::More;
use Test::Mojo;
use Schema;
use Test::Database;

my $schema = Test::Database->new->create(Schema => 'test.db');
my $t = Test::Mojo->new('MojoFull')->app(schema => $schema);

$t->get_ok('/')->status_is(200)->element_exists('div.home');

# Primary photo
$t->get_ok('/')->status_is(200)
  ->element_exists(
  'div.photos.mini-thumbnails.home > a[href^="/photos/"] > img[src^="http://farm"]'
  );

# Smaller photo
$t->get_ok('/')->status_is(200)
  ->element_exists(
  'div.photos.mini-thumbnails.home > a[href^="/photos/"] > img[src^="http://farm"]'
  );

done_testing;
