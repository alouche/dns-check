#-*- encoding: utf-8 -*-

require 'rubygems' if RUBY_VERSION < '1.9'
require 'uri'
require 'json'
require 'time'

require 'dns-check/ext'
require 'dns-check/version'
require 'dns-check/errors'
require 'dns-check/util'
require 'dns-check/cli'

module DNSCheck extend self
  def config
    @config ||={
      :timeout          => 1,
      :indice_location  => URI.parse('http://public-dns.tk/nameservers.json'),
      :indice_store     => "#{$PROG_PATH}/db/indice",
      :show_ns          => false,
      :size             => 10
    }
  end

  def config=(opts)
    @config = opts
  end
end
