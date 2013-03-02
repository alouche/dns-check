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
  gem.add_dependency('ipaddress')
  gem.add_dependency('public_suffix')
  gem.add_dependency('eventmachine')
  gem.add_dependency('em-resolv-replace')
  gem.add_development_dependency('rspec')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec)/})
  gem.require_paths = ["lib"]
end
