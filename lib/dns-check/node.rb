#-*- encoding: utf-8 -*-

require 'eventmachine'
require 'dns-check/output'
require 'dns-check/dns'
require 'dns-check/core'

module DNSCheck
  module Node extend Core

    def start
      @records = __init(DNSCheck.config)
      resolv_all
    end

    def resolv
      DNSCheck
    end

    def hostname
      DNSCheck.config[:hostname]
    end

    def timeout
      DNSCheck.config[:timeout]
    end

    def output
      output ||= Output.new
    end

    def resolv_all
      resolv.timeout = timeout

      EM.run do
        Fiber.new do
          @records.each do |e, ns, c|
            resolv.nameservers = ns

            resolved_ip = resolv.lookup(hostname)

            output_msg = [e, resolved_ip, ns.sample, c]

            output.insert do
              output.print_msg output_msg
            end
          end
          EM.stop
        end.resume
      end
    end

    extend self
  end
end
