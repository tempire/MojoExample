package MojoFull::Blogs;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;

  # Specified tags to search for
  my @tags = grep $_ ne 'tag' => split '/' => $self->param('tags')
    || qw/personal/;

  my @blogs = $self->db->resultset('Blog')->by_tags(@tags)
    or return $self->redirect_to('blogs');

  $self->render('blogs/index', blogs => [@blogs],);
}

sub show {
  my $self  = shift;
  my $param = $self->stash('name');

  my $blog = $self->db->resultset('Blog')->by_id_or_name($param)
    or return $self->redirect_to('blogs');

  $self->render('blogs/show', blog => $blog);
}

1;
