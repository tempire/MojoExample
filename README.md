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
  from t/fixtures/*
- Test::Database is a utility for populating the sqlite3 databases with
  fixtures from t/fixtures/*


# Usage

# Live

<a href="http://mojoexample.herokuapp.com/">Running on Heroku</a>

Heroku is running Hypnotoad, the *full featured UNIX optimized preforking 
non-blocking I/O HTTP 1.1 and WebSocket server built around the very well 
tested and reliable Mojo::Server::Daemon with IPv6, TLS, Bonjour, libev 
and hot deployment support that just works*.

# Locally

To run the full app:
`morbo script/mojo_full`

To run the lite app:
`morbo mojolite`

(Both the Full and Lite apps are identical in functionality)

## Requirements for running locally

Easy, one-step installation of modules:
<br />
`curl -L cpanmin.us | perl - Mojolicious Modern::Perl DBIx::Class DateTime DateTime::Format::SQLite Time::Duration`

A minimum of Perl 5.10 is required.  If your Perl is too old, <a href="http://perlbrew.pl/">Perlbrew</a> is über easy to install!


# Index

* [lib/](https://github.com/tempire/MojoExample/blob/master/lib)
  * [MojoFull.pm](https://github.com/tempire/MojoExample/blob/master/lib/MojoFull.pm)       - Mojolicious Application
  * [MojoFull/](https://github.com/tempire/MojoExample/blob/master/lib/MojoFull)         - Mojolicious Controllers
      * [Blogs.pm](https://github.com/tempire/MojoExample/blob/master/lib/MojoFull/Blogs.pm)
      * [Home.pm](https://github.com/tempire/MojoExample/blob/master/lib/MojoFull/Home.pm)
      * [Photos.pm](https://github.com/tempire/MojoExample/blob/master/lib/MojoFull/Photos.pm)
  * [Schema.pm](https://github.com/tempire/MojoExample/blob/master/lib/Schema.pm)         - DBIx::Class model 
  * [Schema/](https://github.com/tempire/MojoExample/blob/master/lib/Schema)
      * [Result/](https://github.com/tempire/MojoExample/blob/master/lib/Schema/Result)         - DBIx::Class Result classes
          * [Blog.pm](https://github.com/tempire/MojoExample/blob/master/lib/Schema/Result/Blog.pm)
          * [BlogTag.pm](https://github.com/tempire/MojoExample/blob/master/lib/Schema/Result/BlogTag.pm)
          * [Photo.pm](https://github.com/tempire/MojoExample/blob/master/lib/Schema/Result/Photo.pm)
          * [Photoset.pm](https://github.com/tempire/MojoExample/blob/master/lib/Schema/Result/Photoset.pm)
      * [ResultSet/]https://github.com/tempire/MojoExample/blob/master/lib/Schema/ResultSet/)      - DBIx::Class ResultSet classes
          * [Blog.p](https://github.com/tempire/MojoExample/blob/master/lib/Blog.p)m
          * [Photo.p](https://github.com/tempire/MojoExample/blob/master/lib/Photo.p)m
          * [Photoset.p](https://github.com/tempire/MojoExample/blob/master/lib/Photoset.p)m
    * [Test](https://github.com/tempire/MojoExample/blob/master/lib/Test)/
        * [Database.pm](https://github.com/tempire/MojoExample/blob/master/lib/Database.pm)     - Utility class for populating test fixtures
* [public/](https://github.com/tempire/MojoExample/blob/master/lib/public/)             - Static files
    * [css](https://github.com/tempire/MojoExample/blob/master/lib/css)/
        * [main.cs](https://github.com/tempire/MojoExample/blob/master/lib/main.cs)s
    * [images](https://github.com/tempire/MojoExample/blob/master/lib/images)/
        * [background.gi](https://github.com/tempire/MojoExample/blob/master/lib/background.gi)f
        * [bender_promo.pn](https://github.com/tempire/MojoExample/blob/master/lib/bender_promo.pn)g
        * [box-bottom.pn](https://github.com/tempire/MojoExample/blob/master/lib/box-bottom.pn)g
        * [box-middle.gi](https://github.com/tempire/MojoExample/blob/master/lib/box-middle.gi)f
        * [box-top.pn](https://github.com/tempire/MojoExample/blob/master/lib/box-top.pn)g
        * [profile_top.pn](https://github.com/tempire/MojoExample/blob/master/lib/profile_top.pn)g
    * [script/](https://github.com/tempire/MojoExample/blob/master/lib/script/)             - Utilities
        * [generate_schema](https://github.com/tempire/MojoExample/blob/master/lib/generate_schema)   - Generates DBIx::Class schema from database file
        * [mojo_full](https://github.com/tempire/MojoExample/blob/master/lib/mojo_full)*
        * [new_db](https://github.com/tempire/MojoExample/blob/master/lib/new_db)            - Generates database file from DBIx::Class and fixtures
* [t/](https://github.com/tempire/MojoExample/blob/master/lib/t/)                  - Tests
    * [fixtures/](https://github.com/tempire/MojoExample/blob/master/lib/fixtures/)         - Fixtures (placeholder data) for tests
        * [Blog.p](https://github.com/tempire/MojoExample/blob/master/lib/Blog.p)l
        * [Photoset.p](https://github.com/tempire/MojoExample/blob/master/lib/Photoset.p)l
    * [schema/](https://github.com/tempire/MojoExample/blob/master/lib/schema/)           - DBIx::Class model tests
        * [blog.](https://github.com/tempire/MojoExample/blob/master/lib/blog.)t
        * [blog_tag.](https://github.com/tempire/MojoExample/blob/master/lib/blog_tag.)t
        * [photo.](https://github.com/tempire/MojoExample/blob/master/lib/photo.)t
        * [photoset.](https://github.com/tempire/MojoExample/blob/master/lib/photoset.)t
    * [home.t](https://github.com/tempire/MojoExample/blob/master/lib/home.t)            - Home.pm controller tests
    * [blogs.t](https://github.com/tempire/MojoExample/blob/master/lib/blogs.t)           - Blogs.pm controller tests
    * [photos.t](https://github.com/tempire/MojoExample/blob/master/lib/photos.t)          - Photos.pm controller tests
* [templates](https://github.com/tempire/MojoExample/blob/master/lib/templates)/
    * [blogs/](https://github.com/tempire/MojoExample/blob/master/lib/blogs/) - Blogs.pm templates
        * [index.html.e](https://github.com/tempire/MojoExample/blob/master/lib/index.html.e)p
        * [show.html.e](https://github.com/tempire/MojoExample/blob/master/lib/show.html.e)p
    * [home/](https://github.com/tempire/MojoExample/blob/master/lib/home/) - Home.pm templates
        * [index.html.e](https://github.com/tempire/MojoExample/blob/master/lib/index.html.e)p
    * [photos/](https://github.com/tempire/MojoExample/blob/master/lib/photos/) - Photos.pm templates
        * [index.html.e](https://github.com/tempire/MojoExample/blob/master/lib/index.html.e)p
        * [show.html.e](https://github.com/tempire/MojoExample/blob/master/lib/show.html.e)p
        * [show_set.html.e](https://github.com/tempire/MojoExample/blob/master/lib/show_set.html.e)p
    * [layouts](https://github.com/tempire/MojoExample/blob/master/lib/layouts)/
        * [default.html.e](https://github.com/tempire/MojoExample/blob/master/lib/default.html.e)p
* [README.md](https://github.com/tempire/MojoExample/blob/master/lib/README.md)           - This file
