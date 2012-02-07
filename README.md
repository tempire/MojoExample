▾ lib/
    MojoFull.pm       - Mojolicious Application
  ▾ MojoFull/         - Mojolicious Controllers
      Blogs.pm
      Home.pm
      Photos.pm
    Schema.pm         - DBIx::Class model 
  ▾ Schema/
    ▾ Result/         - Result classes
        Blog.pm
        BlogTag.pm
        Photo.pm
        Photoset.pm
    ▾ ResultSet/      - ResultSet classes
        Blog.pm
        Photo.pm
        Photoset.pm
  ▾ Test/
      Database.pm     - Utility class for populating test fixtures
▾ public/             - Static files
  ▾ css/
      main.css
  ▾ images/
      background.gif
      bender_promo.png
      box-bottom.png
      box-middle.gif
      box-top.png
      profile_top.png
▾ script/             - Utilities
    generate_schema   - Generates DBIx::Class schema from database file
    mojo_full*
    new_db            - Generates database file from DBIx::Class and fixtures
▾ t/                  - Tests
  ▾ fixtures/         - Fixtures (placeholder data) for tests
      Blog.pl
      Photoset.pl
  ▾ schema/           - DBIx::Class model tests
      blog.t
      blog_tag.t
      photo.t
      photoset.t
    home.t            - Home.pm controller tests
    blogs.t           - Blogs.pm controller tests
    photos.t          - Photos.pm controller tests
▾ templates/
  ▾ blogs/
      index.html.ep
      show.html.ep
  ▾ home/
      index.html.ep
  ▾ layouts/
      default.html.ep
  ▾ photos/
      index.html.ep
      show.html.ep
      show_set.html.ep
  mojolite*           - Mojolicious::Lite app, with all the above files embedded
  README.md           - This file
