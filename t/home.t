use Modern::Perl;
use Test::More;
use Test::Mojo;
use Schema;
use Test::Database;

my $schema = Test::Database->new->create(Schema => 'test.db');
my $t = Test::Mojo->new('MojoFull')->app(schema => $schema);

$t->get_ok('/')->status_is(200)->text_is(h1 => 'Purpose');

done_testing;
