package MojoFull;
use Mojo::Base 'Mojolicious';
use Schema;

has schema => sub {
  return Schema->connect('dbi:SQLite:' . ($ENV{TEST_DB} || 'test.db'));
};

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->plugin('Config');
  $self->helper(db => sub { $self->app->schema });

  # Routes
  my $r = $self->routes;

  $r->add_condition(

    # Requested id is a photoset?
    photoset => sub {
      my ($r, $c, $captures, $pattern) = @_;

      my $id = $captures->{id};
      return 1 if $id !~ /^\d+$/ or $id =~ /^\d+$/ and length $id == 17;
    }
  );

  $r->get('/')->to('home#index');

  $r->get('/photos')->to('photos#index');
  $r->get('/photos/:id')->over('photoset')->to('photos#show_set');
  $r->get('/photos/:id')->to('photos#show');

  $r->get('/blogs')->to('blogs#index');
  $r->get('/blogs/(:name)')->to('blogs#show');
  $r->get('/blogs/tag/(*tags)')->to('blogs#index');
}

1;
