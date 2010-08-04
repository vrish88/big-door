require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "big-door"
    gem.summary = %Q{Big Door Media gem}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "mlavrisha@trada.com"
    gem.homepage = "http://github.com/vrish88/big-door"
    gem.authors = ["Michael Lavrisha"]
    gem.add_development_dependency "rspec", "~> 2.0.0.beta.19"
    gem.add_development_dependency "cucumber", "~> 0.8.5"
    gem.add_runtime_dependency "httparty", "~>0.6.0"
    gem.add_runtime_dependency "json", "~>1.4.3"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

#require 'spec/rake/spectask'
#Spec::Rake::SpecTask.new(:spec) do |spec|
#  spec.libs << 'lib' << 'spec'
#  spec.spec_files = FileList['spec/**/*_spec.rb']
#end
#
#Spec::Rake::SpecTask.new(:rcov) do |spec|
#  spec.libs << 'lib' << 'spec'
#  spec.pattern = 'spec/**/*_spec.rb'
#  spec.rcov = true
#end
#
#task :spec => :check_dependencies

# begin
#   require 'cucumber/rake/task'
#   Cucumber::Rake::Task.new(:features)
# 
#   task :features => :check_dependencies
# rescue LoadError
#   task :features do
#     abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
#   end
# end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "big-door #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
