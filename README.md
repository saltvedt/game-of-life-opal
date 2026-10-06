## Game of Life

This is an implementation of Game of Life, loosely based on [this Sitepoint tutorial](https://www.sitepoint.com/opal-ruby-browser-game-life/)

Use Ruby 3.4.4 (selected by `.ruby-version`) and Bundler 2.6.7.

```sh
bundle install
bundle exec rackup --host 127.0.0.1
```

Open http://127.0.0.1:9292. The server builds the app on startup and serves only `build/`.

To rebuild after editing:

```sh
bundle exec rake build
```

Alternatively, run `bundle exec guard` in another terminal to rebuild when Ruby, HTML template, or CSS files change. Refresh the browser after rebuilding.

Click a cell to make it alive; double-click to clear it. Cells can be edited before starting, while paused, or while running. Start/Stop pauses and resumes the simulation, which advances every 100 ms.

The static build consists of `build/index.html`, `build/game-of-life.js`, and `build/style.css`. GitHub Pages publishes the root of the separate `gh-pages` branch, not `master` or `build/`. Publishing requires copying the built files to that branch, committing, and pushing. The page continues to use the shared stylesheet at https://saltvedt.net/style.css.
