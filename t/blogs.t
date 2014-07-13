use Modern::Perl;
use Test::More;
use Test::Mojo;
use Schema;
use Test::Database;

my $schema = Test::Database->new->create(Schema => 'test.db');

my $t = Test::Mojo->new('MojoFull');
$t->app->schema($schema);

# Blog not found
$t->get_ok('/blogs/bad_title')->status_is(302)
  ->header_like(Location => qr|/blogs$|);

# List
$t->get_ok('/blogs')->status_is(200)->element_exists('ul#blogs')
  ->element_exists('#blogs > .blog.snippet')
  ->text_is('li#hello_ h2 > a' => 'Hello!');

# One blog entry
$t->get_ok('/blogs/hello_')->status_is(200)->element_exists('ul#blogs')
  ->text_is('h2 > a' => 'Hello!');

# Entries by tag
$t->get_ok('/blogs/tag/personal')->status_is(200)->element_exists('ul#blogs')
  ->text_is('li#hello_ h2 > a'     => 'Hello!')
  ->text_is('li#non_tech_2 h2 > a' => 'non-tech 2')
  ->element_exists_not('li#tech');

# Entries by tag
$t->get_ok('/blogs/tag/tech')->status_is(200)
  ->element_exists_not('li#non-tech_2')
  ->text_is('li#tech h2 > a' => 'Tech');

$t->get_ok('/blogs/tag/tech/tag/personal')->status_is(200)
  ->element_exists('ul#blogs')->text_is('li#hello_ h2 > a' => 'Hello!')
  ->text_is('li#non_tech_2 h2 > a' => 'non-tech 2')
  ->text_is('li#tech h2 > a'       => 'Tech');

done_testing;
