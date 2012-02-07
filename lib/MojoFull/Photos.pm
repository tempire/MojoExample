package MojoFull::Photos;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;

  $self->render(
    'photos/index',
    sets        => [$self->db->resultset('Photoset')->search],
    photo_count => $self->db->resultset('Photo')->count
  );
}

sub show {
  my $self = shift;
  my $id   = $self->param('id');

  my $photo = $self->db->resultset('Photo')->find($id)
    or $self->redirect_to("/photos"), return;

  $self->render(template => 'photos/show', photo => $photo);
}

sub show_set {
  my $self = shift;
  my $id   = $self->param('id');

  my $set = $self->db->resultset('Photoset')->by_id_or_name($id)
    or $self->redirect_to("/photos"), return;

  $self->render(template => 'photos/show_set', set => $set);
}

1;

=head1 NAME

MojoFull::Photos

=head1 DESCRIPTION

/photos controller

=head1 ACTIONS

=head2 index

GET /photos

=head2 show

GET /photos/:photo_id

=head2 show_set

GET /photos/:set_id

=cut
