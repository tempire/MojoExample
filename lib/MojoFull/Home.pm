package MojoFull::Home;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;

  $self->render(
    'home/index',
    blog   => $self->db->resultset('Blog')->latest,
    photos => [
      $self->db->resultset('Photoset')->first->photos->latest(2)
    ]
  );
}

1;
