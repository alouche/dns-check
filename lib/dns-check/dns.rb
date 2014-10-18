#-*- encoding: utf-8 -*-

require 'timeout'
require 'em-resolv-replace'

module DNSCheck
  module DNS

    def timeout= sec
      @timeout = sec
    end

    def nameservers= ns
      @query = Resolv::DNS.new(
        :nameserver => ns,
        :ndots => 1
      )
    end

    def lookup hostname
      Timeout::timeout(@timeout) do
        @query.getaddress(hostname).to_s.colorize_to(:green)
      end
    rescue Timeout::Error
      "Nameserver Timeout".colorize_to(:red)
    rescue => e
      e.message.colorize_to(:red)
    end
  end

  extend DNS
end
