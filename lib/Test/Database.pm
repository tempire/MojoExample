package Test::Database;

use Modern::Perl;
use lib 'lib';
use Carp;
use File::Spec;
use Data::Dumper;
use Cwd qw/ abs_path getcwd /;
use File::Basename 'dirname';
use File::Copy 'cp';
use File::Slurp qw/ slurp write_file /;
use Mojo::Home;

use constant DEBUG => $ENV{DEBUG};

our $schema;

use Mojo::Base -base;
has [qw/ schema file home_path /];
has db_name => 'test.db';

sub import {
  my $self = shift;
  my $type = shift;

  # Runtime configuration
  return if !$type;

  # Compile time, verify args
  croak "Accepts either 'test' or 'production' arguments'"
    if $type ne 'test' and $type ne 'production';

  $type   = "new_$type";
  $schema = $self->$type->schema;

  # No schema export
  return if "@_" ne 'schema';

  no strict 'refs';
  my $caller = caller;
  *{"$caller\::schema"} = \$schema;
}

sub new_production {
  my $self = bless {} => shift;
  my ($schema_name, $dbname) = @_;

  $self->file($dbname || dirname(abs_path($0)) . '/../' . $self->db_name);

  my $schema = $self->_new($schema_name => $self->file);
  $self->schema($schema);

  return $self;
}

sub new_test {
  my $self = shift->SUPER::new(@_);
  my ($schema_name, $dbname) = @_;

  # In-memory sqlite db is quite zippy
  # dbname parameter is for controller testing - cannot use in-memory db
  $self->file($ENV{TEST_DB} || $dbname || ':memory:');

  my $schema = $self->_new($schema_name => $self->file);
  $self->schema($schema);

  return $self;
}

sub _new {
  my $self = shift;
  my $schema_name = shift;
  my $file = shift;

  # Database cannot be reset without disconnection
  $self->disconnect if $schema;

  $schema = $self->_create($schema_name, $file);
  $self->insert_fixtures($file, $schema);

  #$self->restore_photos;

  # Assign dsn for out-of-band use
  $ENV{DEBUG_DSN} = $schema->storage->connect_info->[0];

  return $schema;
}

sub _create {
  my $self        = shift;
  my $schema_name = shift;
  my $file        = shift;

  # Remove previous
  unlink $file if -e $file;

  # New
  my $dsn = "dbi:SQLite:dbname=$file";
  my $schema =
    $schema_name->connect($dsn, '', '', {quote_char => '`', name_sep => '.'});
  $schema->deploy({quote_table_names => 1, quote_field_names => 1});

  return $schema;
}

sub fixture_path {
  my $self = shift;

  return $self->home_path . '/t/fixtures';
}

sub insert_fixtures {
  my $self   = shift;
  my $file   = shift;
  my $schema = shift;

  # Store working dir
  my $cwd = getcwd;

  my $dir = $self->fixture_path;
  chdir $dir;

  foreach my $fixture (<*>) {

    warn "$dir/$fixture" if DEBUG;

    my $info = eval slurp "$dir/$fixture";
    chdir $cwd, croak "Cloud not insert fixture $dir/$fixture: $@" if $@;

    # Arrayrefs of rows, (dbic syntax) table defined by fixture filename
    if (ref $info->[0] eq 'HASH') {
      my $rs_name = (split /\./, $fixture)[0];
      $rs_name =~ s/s$//;

      # wantarray context, so that populate uses dbic ->insert overrides
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
  return $schema->storage->dbh->disconnect;
}

#sub _import_sql {
#    my $self   = shift;
#    my $schema = shift;
#    my @dsl    = @_;
#
#    # SQL statements in @dsl array
#    foreach my $sql (@dsl) {
#        $schema->storage->dbh_do(
#            sub {
#                my ( $storage, $dbh, @cols ) = @_;
#                $dbh->do($sql) || die $dbh->errstr;
#            }
#        );
#    }
#}
#
#sub _export_mysql {
#    my $self = shift;
#
#    my $dsl;
#
#    # Tquestions
#    my $output =
#      `mysqldump --compact --compatible=ansi --default-character-set=binary echem tquestions | grep INSERT`;
#    $output =~ s/^(.+?\()/INSERT INTO tquestions VALUES\(/;
#    $output =~ s/\\'\''/'\'\''/g;
#    $output =~ s/\\'/''/g;
#    $output =~ s/\\n/\n/g;
#    $output =~ s/\),\(/\);\nINSERT INTO tquestions VALUES(/g;
#    open my $file, '>', '/tmp/tquestions.txt';
#
#    #print $file $output;
#    $dsl .= $output;
#
#    # Toptions
#    $output =
#      `mysqldump --compact --compatible=ansi --default-character-set=binary echem toptions | grep INSERT`;
#    $output =~ s/^(.+?\()/INSERT INTO toptions VALUES\(/;
#    $output =~ s/\\'\''/'\'\''/g;
#    $output =~ s/\\'/''/g;
#    $output =~ s/\\n/\n/g;
#    $output =~ s/\),\(/\);\nINSERT INTO toptions VALUES(/g;
#    open $file, '>', '/tmp/toptions.txt';
#
#    #print $file $output;
#    $dsl .= $output;
#
#    return split /\n/, $dsl;
#}

#sub restore_photos {
#    my $self = shift;
#
#    # Store working dir
#    my $cwd = getcwd;
#
#    my $dir        = $self->fixture_path;
#    my $photos_dir = $self->home_path . '/public/photos';
#
#    chdir $dir;
#
#    foreach my $photo (<*>) {
#
#        # Only images (binary files)
#        next unless -B $photo;
#
#        # b4080d40736cbbd8108508edf2475823422814cd.jpg | jpeg | png | etc
#        next unless $photo =~ /^\w{40}\.\w{3,4}$/;
#
#        my $to_dir = $photos_dir . '/' . substr $photo, 0, 2;
#
#        # Photo already exists
#        next if -B "$to_dir/$photo";
#
#        mkdir $to_dir;
#        cp( "$dir/$photo", "$to_dir/$photo" );
#
#    }
#
#    # Restore working dir
#    chdir $cwd;
#}

1;

=head1 NAME

Test::Database

=head1 DESCRIPTION

Deploy schema & load fixtures

=head1 USAGE

    # Creates a production sqlite3 database
    my $d = Test::Database->new_production;
    print $d->file;

    # Creates a database with all fixtures, defaults to in-memory sqlite3
    my $d = Test::Database->new_test;

    # Creates a test database in file.db
    my $d = Test::Database->new_test('file.db');

    # Creates a test database using file in TEST_DB
    $ENV{TEST_DB} = 'file.db';
    my $d = Test::Database->new_test;

=head1 ATTRIBUTES

=head2 schema

DBIC schema

=head2 file

Deployed-to file

=head1 METHODS

=head2 import

Allows for compile time generation of database:

    use Test::Database 'test';

or 

    use Test::Database 'production';

Export the $schema into the current namespace:

    use Test::Database test => 'schema';
    print $schema->sources;

=head2 schema

Returns the schema instantiated during compile-time usage

=cut

=head2 new_production

New production database, generates file location

=head2 new_test

New test database, uses in-memory sqlite database by default, or accepts 
file in $ENV{TEST_DB} environment variable

otherwise

=head2 _new

New database with specified file, handles database setup

=head2 _create

Create new sqlite3 database from DBIC schema

=head2 fixture_path

Relative fixture path changes according to location of t

Clunky.

=head2 insert_fixtures

Insert fixtures into sqlite3 database

=head2 _export_mysql

Exports tquestions & toptions tables from mysql, returns list of sqlite3-
compatible sql

=head2 _import

Executes sql statements in schema (generally used with _export_mysql)

=head2 restore_photos

Copy photos to original locations, as specified in user fixtures 

(Profile photos for man, woman, alone)

=head2 disconnect

Disconnect from database handle

=cut
