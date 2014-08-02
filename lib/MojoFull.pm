package MojoFull;
use Mojo::Base 'Mojolicious';
use Schema;

# Connects once for entire application. For real apps, consider using a helper
# that can reconnect on each request if necessary.
has schema => sub {
  return Schema->connect('dbi:SQLite:' . ($ENV{TEST_DB} || 'test.db'));
};

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->helper(db => sub { $self->app->schema });

  # Routes
  my $r = $self->routes;

  # Requested id is a photoset?
  $r->add_condition(
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
