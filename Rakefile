require 'opal'
require 'opal-jquery'

desc "Build our app to game-of-life.js"
task :build do
  environment = Sprockets::Environment.new
  Opal.append_path 'app'
	Opal.paths.each do |path|
	  environment.append_path path
	end

  index = ERB.new(File.read('index.erb'))

  def javascript_include_tag name
    %{<script src="./#{name}.js"></script>}+
    %{<script>Opal.load(#{name.inspect})</script>}
  end

  Dir.mkdir 'build' unless Dir.exist? 'build'
  File.write 'build/game-of-life.js', environment["game-of-life"].to_s
  File.write 'build/index.html', index.result(binding)
  File.write 'build/style.css', File.read('style.css')
end

task default: :build
