# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)

require 'dns-check/version'

Gem::Specification.new do |gem|
  gem.name          = "dns-check"
  gem.version       = DNSCheck::VERSION
  gem.authors       = "Ali Abbas"
  gem.email         = "ali@alouche.net"
  gem.description   = "CLI based DNS propagation check tool"
  gem.summary       = "Allows you to query a bunch of random nameservers, filter per countries, cities to check the propagation of your domain or simply make sure that your geo load balancing is working"
  gem.homepage      = "https://github.com/alouche/dns-check"
  gem.add_dependency  'ipaddress', '~> 0.8.0'
  gem.add_dependency 'public_suffix', '~> 1.2.0'
  gem.add_dependency 'eventmachine', '~> 1.0.1'
  gem.add_dependency 'em-resolv-replace', '~> 1.1.3'
  gem.add_dependency 'json', '~> 1.8.0' if RUBY_VERSION < '1.9'
  gem.add_development_dependency 'rspec', '~> 2.13.0'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec)/})
  gem.require_paths = ["lib"]

  gem.license       = 'GPLv3'
end
