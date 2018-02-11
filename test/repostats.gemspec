# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','repostats','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'repostats'
  s.version = Repostats::VERSION
  s.author = 'Krystalenia Tatsi'
  s.email = 'krystalenia.tatsi@gmail.com'
  s.homepage = ''
  s.platform = Gem::Platform::RUBY
  s.summary = 'repostat command line tool'
  s.files = `git ls-files -z`.split("\x0")
  s.require_paths = ['lib']
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','repostats.rdoc']
  s.rdoc_options << '--title' << 'repostats' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'repostats'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('ffi')
  s.add_development_dependency('aruba')
  s.add_development_dependency('rspec')
  s.add_runtime_dependency('gli','2.17.1')
  s.add_runtime_dependency('faraday-http-cache', '2.0.0')
  s.add_runtime_dependency('activesupport')
end
