package MojoFull::Home;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  shift->render('home/index');
}

1;
