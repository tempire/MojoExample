use Modern::Perl;
use Nempire::Schema;
use Devel::Dwarn;

use Test::Most;
use Test::Database;

my $blog_id = '1';
my $tag_id  = '1';

my $schema = Test::Database->new_test->schema;
my $tag    = $schema->resultset('BlogTag')->find($tag_id);

is $tag->blog->id => $blog_id, 'related blog';

done_testing;
