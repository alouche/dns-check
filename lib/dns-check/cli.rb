#-*- encoding: utf-8 -*-

require 'optparse'
require 'singleton'

require 'dns-check/db'
require 'dns-check/update'
require 'dns-check/node'

module DNSCheck
  class CLI
    include Singleton

    attr_reader :args

    def initialize
      super
      @args = ARGV
    end

    def run
      config.merge!(parse_options)
      DNSCheck::Node.start
    end

    private

    def config
      DNSCheck.config
    end

    def update!
      DNSCheck.indice_location = config[:indice_location]
      DNSCheck.indice_store    = config[:indice_store]
      DNSCheck.update!
      exit 0
    end

    def parse_options
      opts = {}

      parser = OptionParser.new do |o|
        o.separator ''
        o.separator 'Options:'

        o.on '-l', '--location   [name]', String, 'Location can either be a country or city' do |loc|
          opts[:location]  = loc
        end

        o.on '-t', '--timeout    [sec]', Integer, 'DNS Query timeout (Default: 5s)' do |sec|
          opts[:timeout] = sec
        end

        o.on '--records    [size]', Integer, 'Number of nameservers to select (default: 10)' do |size|
          opts[:size]     = size
        end

        o.on '--show-ns', 'Show nameservers' do
          opts[:show_ns] = true
        end

        o.on '--update', 'Perform indice update' do
          update!
        end
        
        o.on '--debug' do
          $DEBUG = true
        end

        o.on_tail '-v', '--version', 'Show version' do
          puts DNSCheck::VERSION
          exit 0
        end
      end

      parser.banner = 'Usage: dns-check [options] [domain]'
      parser.on_tail '-h', '-?', '--help', 'Show this message' do
        puts parser
        exit 0
      end

      parser.parse!(@args)

      if @args.empty?
        puts parser
        exit 0
      end

      opts[:hostname] = @args[0]
      opts
    end
  end

  trap("SIGINT") {
    EM.stop if EM.reactor_running?

    exit 0
  }
end
