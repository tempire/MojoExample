<img src="http://empireenterprises.com/skitch//localhost_3000_photos-20120207-120707.png" />

# Purpose

- Compare a full Mojolicious app to a lite app with the same functionality.
- See an example of DBIx::Class usage with Mojolicious
- See an example of tests for a Mojolicious app

## Notes

- Both apps make use of the DBIx::Class schema.
- The schema is in lib/Schema.pm, lib/Schema/*
- The DBIx::Class schema connects to a provided sqlite3 database, test.db
- The controller tests create a new test.db, populated using fixtures from t/fixtures/*
- The schema tests use an in-memory sqlite3 database, populated using fixtures
  from t/fixtures
- Test::Database is a utility for populating the sqlite3 databases with
  fixtures from t/fixtures/*


## Requirements

Perl 5.10+, Mojolicious, Modern::Perl, DBIx::Class, DateTime, Time::Duration

Easy, one-step installation of modules:
<br />
`curl -L cpanmin.us | perl - Mojolicious Modern::Perl DBIx::Class DateTime Time::Duration`

If your Perl is too old, <a href="http://perlbrew.pl/">Perlbrew</a> is über easy to install!

# Usage

To run the full app:
`morbo script/mojo_full`

To run the lite app:
`morbo mojolite`

(Both the Full and Lite apps are identical in functionality)

# Index

* lib/
  * MojoFull.pm       - Mojolicious Application
  * MojoFull/         - Mojolicious Controllers
      * Blogs.pm
      * Home.pm
      * Photos.pm
  * Schema.pm         - DBIx::Class model 
  * Schema/
      * Result/         - DBIx::Class Result classes
          * Blog.pm
          * BlogTag.pm
          * Photo.pm
          * Photoset.pm
      * ResultSet/      - DBIx::Class ResultSet classes
          * Blog.pm
          * Photo.pm
          * Photoset.pm
    * Test/
        * Database.pm     - Utility class for populating test fixtures
* public/             - Static files
    * css/
        * main.css
    * images/
        * background.gif
        * bender_promo.png
        * box-bottom.png
        * box-middle.gif
        * box-top.png
        * profile_top.png
    * script/             - Utilities
        * generate_schema   - Generates DBIx::Class schema from database file
        * mojo_full*
        * new_db            - Generates database file from DBIx::Class and fixtures
* t/                  - Tests
    * fixtures/         - Fixtures (placeholder data) for tests
        * Blog.pl
        * Photoset.pl
    * schema/           - DBIx::Class model tests
        * blog.t
        * blog_tag.t
        * photo.t
        * photoset.t
    * home.t            - Home.pm controller tests
    * blogs.t           - Blogs.pm controller tests
    * photos.t          - Photos.pm controller tests
* templates/
    * blogs/ - Blogs.pm templates
        * index.html.ep
        * show.html.ep
    * home/ - Home.pm templates
        * index.html.ep
    * photos/ - Photos.pm templates
        * index.html.ep
        * show.html.ep
        * show_set.html.ep
    * layouts/
        * default.html.ep
* *mojolite*          - Mojolicious::Lite app, with all the application files listed above embedded
* README.md           - This file
