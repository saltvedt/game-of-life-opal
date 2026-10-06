require 'rack'
require 'rake'

Rake.application.init
Rake.application.load_rakefile
Rake::Task[:build].invoke

use Rack::Static, urls: ['/'], root: 'build', index: 'index.html'
run ->(_env) { [404, { 'content-type' => 'text/plain' }, ['Not found']] }
