require 'erb'
require 'opal'
require 'opal-jquery'

desc "Build our app to game-of-life.js"
task :build do
  builder = Opal::Builder.new
  builder.append_paths 'app'
  javascript = builder.build('game-of-life', backtick_javascript: true).to_s
  index = ERB.new(File.read('index.erb'))

  def javascript_include_tag name
    %{<script src="./#{name}.js"></script>}
  end

  Dir.mkdir 'build' unless Dir.exist? 'build'
  File.write 'build/game-of-life.js', javascript
  File.write 'build/index.html', index.result(binding)
  File.write 'build/style.css', File.read('style.css')
end

task default: :build
