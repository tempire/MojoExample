use Mojo::Base -strict;

use Test::More tests => 4;
use Test::Mojo;

use_ok 'MojoFull';

my $t = Test::Mojo->new('MojoFull');
$t->get_ok('/')->status_is(200)->content_like(qr/Mojolicious/i);
