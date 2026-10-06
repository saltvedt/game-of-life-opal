# Project workflow

- Use Ruby 3.4.4 (`.ruby-version`) and Bundler 2.6.7 (`Gemfile.lock`).
- Install with `bundle install`; compile the static site with `bundle exec rake build`.
- Preview with `bundle exec rackup --host 127.0.0.1`. It builds on startup and serves only `build/` on port 9292. Run `bundle exec guard` separately for rebuilds on source changes.
- Verification: `bundle check`, `bundle exec rake build`, and `git diff HEAD --check`. No automated test suite is configured. Browser smoke checks should cover the automatically running glider, Start/Pause labels, Clear stopping and emptying the grid, Step advancing once while paused, click/double-click, editing paused/running cells, and edge clicks after resizing.
- The compiler uses Opal::Builder with JavaScript backticks enabled. The generated bundle starts the app itself; do not add a second `Opal.load` call to the HTML.
- `.github/workflows/static.yml` builds and deploys `build/` to GitHub Pages on pushes to `master` and manual workflow runs. Pages must use the "GitHub Actions" source; do not manually publish to `gh-pages`. Preserve the introduction and shared HTTPS stylesheet when updating the template.
- Typography and links use saltvedt.net's shared `portfolio`/`reading-page` styles and article markup, with the same Bootstrap and font stylesheets. Keep local `style.css` limited to game layout; do not duplicate text or link styling locally.
