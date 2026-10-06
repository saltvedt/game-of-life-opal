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

## Build and deploy

`bundle exec rake build` compiles the app with Opal into `build/`, producing `index.html`, `game-of-life.js`, and `style.css`. The page continues to use the shared stylesheet at https://saltvedt.net/style.css.

Pushes to `master` run `.github/workflows/static.yml`, which builds and deploys `build/` to GitHub Pages. Set Pages source to "GitHub Actions" in repository settings. The workflow can also be run manually from the Actions tab; copying files to `gh-pages` is no longer required.
