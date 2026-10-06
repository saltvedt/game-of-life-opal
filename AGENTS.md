# Project workflow

- Use Ruby 3.4.4 (`.ruby-version`) and Bundler 2.6.7 (`Gemfile.lock`).
- Install with `bundle install`; compile the static site with `bundle exec rake build`.
- Preview with `bundle exec rackup --host 127.0.0.1`. It builds on startup and serves only `build/` on port 9292. Run `bundle exec guard` separately for rebuilds on source changes.
- Verification: `bundle check`, `bundle exec rake build`, and `git diff HEAD --check`. No automated test suite is configured. Browser smoke checks should cover click/double-click, editing paused/running cells, partial edge clicks, and Start/Stop.
- The compiler uses Opal::Builder with JavaScript backticks enabled. The generated bundle starts the app itself; do not add a second `Opal.load` call to the HTML.
- GitHub Pages publishes the root of the separate `gh-pages` branch. Building on `master` does not publish anything. Preserve the introduction and shared HTTPS stylesheet when updating the template.
