use Test::Database;
use Modern::Perl +2012;
use Test::Most;
use Schema;
use Test::Mojo;
use Test::Database;

my $t = Test::Mojo->new('MojoFull');
my $schema =
  Test::Database->new_test(Schema => ':memory:', home_path => $t->app->home)
  ->schema;

my $blog_id = '1';
my $tag_id  = '1';

my $tag    = $schema->resultset('BlogTag')->find($tag_id);

is $tag->blog->id => $blog_id, 'related blog';

done_testing;
