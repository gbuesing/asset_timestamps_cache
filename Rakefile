require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end
task :default => :test

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "asset_timestamps_cache"
    gemspec.summary = "A simple asset timestamping solution."
    gemspec.description = "Adapted from asset timestamping functionality in ActionPack."
    gemspec.email = "gbuesing@gmail.com"
    gemspec.homepage = "http://github.com/gbuesing/asset_timestamps_cache"
    gemspec.authors = ["Geoff Buesing"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end