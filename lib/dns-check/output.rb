#-*- encoding: utf-8 -*-

require 'stringio'

module DNSCheck
  class Output
    def initialize; end

    def print_msg msg
      pretty_print msg
    end

    def insert(*msg)
      $stdout = StringIO.new

      yield

      unless $stdout.string.empty?
        STDOUT.print $stdout.string
        STDOUT.flush
      end
    ensure
      $stdout = STDOUT
    end

    def pretty_print msg
      msg[0] = "NN" if msg[0].empty?

      #FIXME redundant, catch nil instead of has_key
      if msg[3] && COUNTRY_CODES.has_key?(msg[3])
        #FIXME cheap workaround around frozen string
        msg[0] = msg[0].dup
        msg[0].prepend(msg[3].resolve_country_code + '/')
      end

      print msg[0] + "|" + msg[1]

      print "|" + msg[2] if DNSCheck.config[:show_ns]

      print "\n"
    end
  end
end
