use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  PREREQ_PM => {
    'Mojolicious'              => 0,
    'Modern::Perl'             => 0,
    'DBIx::Class'              => 0,
    'DateTime'                 => 0,
    'DateTime::Format::SQLite' => 0,
    'Time::Duration'           => 0,
    'File::Slurp'              => 0,
    'SQL::Translator'          => 0
  },
  test => {TESTS => 't/*.t'}
);
