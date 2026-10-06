## Game of Life

This is an implementation of Game of Life, loosely based on [this Sitepoint tutorial](https://www.sitepoint.com/opal-ruby-browser-game-life/)

```
bundle install
bundle exec rackup
```

## Build and deploy

`bundle exec rake build` compiles the app with Opal into `build/`.
Pushes to `master` run `.github/workflows/static.yml`, which builds and deploys `build/` to GitHub Pages
(set Pages source to "GitHub Actions" in repository settings).
