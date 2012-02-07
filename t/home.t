use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use Schema;
use Test::Database;

$ENV{TEST_DB} = 'test.db';
my $t = Test::Mojo->new('MojoFull');
Test::Database->new_test(Schema => $ENV{TEST_DB}, home_path => $t->app->home);

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
