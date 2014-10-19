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

    def get_cname_record hostname
      @query.getresource(hostname, Resolv::DNS::Resource::IN::CNAME).name.to_s
    rescue
      hostname
    end

    def lookup hostname
      Timeout::timeout(@timeout) do
        record = get_cname_record hostname
        if DNSCheck.config[:no_recursion] && (record != hostname)
          return record.colorize_to(:green)
        end

        resolved_ip = @query.getresource(record, Resolv::DNS::Resource::IN::A).address.to_s
        resolved_ip.to_s.colorize_to(:green)
      end
    rescue Timeout::Error
      "Nameserver Timeout".colorize_to(:red)
    rescue => e
      e.message.colorize_to(:red)
    end
  end

  extend DNS
end
