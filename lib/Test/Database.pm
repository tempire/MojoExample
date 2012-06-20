package Test::Database;

use Modern::Perl;
use lib 'lib';
use Carp;
use Cwd qw/ abs_path getcwd /;
use File::Slurp 'slurp';
use constant DEBUG => $ENV{DEBUG};

our $schema;

use Mojo::Base -base;
has fixture_path => 't/fixtures';

sub import {
  my ($self, $schema_name, $file) = @_;

  return if @_ < 3;

  # Export connected schema to $schema
  no strict 'refs';
  my $caller = caller;
  *{"$caller\::schema"} = $self->create($schema_name => $file);
}

sub create {
  my $self        = shift;
  my $schema_name = shift;
  my $file        = shift || $ENV{TEST_DB} || ':memory:';

  # Remove previous
  unlink $file if -e $file;

  # New db
  my $dsn = "dbi:SQLite:dbname=$file";
  my $schema =
    $schema_name->connect($dsn, '', '', {quote_char => '`', name_sep => '.'});
  $schema->deploy({quote_table_names => 1, quote_field_names => 1});

  # Fixtures
  $self->insert_fixtures($file, $schema);

  return $schema;
}

sub insert_fixtures {
  my $self   = shift;
  my $file   = shift;
  my $schema = shift;

  # Store working dir
  my $cwd = getcwd;

  chdir $self->fixture_path;

  foreach my $fixture (<*>) {

    warn "$fixture" if DEBUG;

    my $info = eval slurp $fixture;
    chdir $cwd, croak "Could not insert fixture $fixture: $@" if $@;

    # Arrayrefs of rows, (dbic syntax) table defined by fixture filename
    if (ref $info->[0] eq 'HASH') {
      my $rs_name = (split /\./, $fixture)[0];
      $rs_name =~ s/s$//;

      # list context, so that populate uses dbic ->insert overrides
      my @noop = $schema->resultset(ucfirst $rs_name)->populate($info);

      next;
    }

    # Arrayref of hashrefs, multiple tables per file
    for (my $i = 0; $i < @$info; $i++) {
      $schema->resultset($info->[$i])->create($info->[++$i]);
    }
  }

  # Restore working dir
  chdir $cwd;
}

sub disconnect {
  return shift->storage->dbh->disconnect;
}

1;

=head1 NAME

Test::Database

=head1 DESCRIPTION

Deploy schema & load fixtures

=head1 USAGE

    # Creates an sqlite3 test.db database from DBIC Schema
    my $schema = Test::Database->new->create(Schema => 'test.db');

    # Creates an in-memory sqlite3 database from DBIC Schema
    my $schema = Test::Database->new->create(Schema => ':memory:');

=head1 METHODS

=head2 import

Allows for compile time generation of database.
Exports the $schema into the current namespace:

    use Test::Database Schema => 'test.db';
    print $schema->sources;

=head2 create ($schema_name, $file_name)

Create new sqlite3 database from DBIC schema

=head2 insert_fixtures

Insert fixtures into sqlite3 database

=head2 disconnect ($schema)

Disconnect from database handle

=cut
