use Modern::Perl +2012;
use Test::More;
use Schema;
use Test::Database;

my $schema = Test::Database->new->create(Schema => ':memory:');

my $blog_id = '1';
my $tag_id  = '1';

my $tag = $schema->resultset('BlogTag')->find($tag_id);

is $tag->blog->id => $blog_id, 'related blog';

done_testing;
