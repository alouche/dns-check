#-*- encoding: utf-8 -*-

require 'forwardable'

module DNSCheck
  class DB

    extend Forwardable

    include Enumerable

    def_delegators :@Records

    def initialize
      super
      @Records = Hash.new { |hash, key|
        hash[key] = []
      }
    end

    def self.[](*args)
      db = new
      db.instance_variable_set(:@Records, Hash[*args])
      db
    end

    def [](key)
      @Records[key]
    end

    def update k
      @Records[k] = yield(@Records[k])
    end

    def add(k, v)
      update(k) do |hash|
        hash << v
      end
    end
    alias_method :[]=, :add

    # Can't marshal hash with default proc
    def dump_all
      return @Records unless @Records.default_proc
      records = @Records.clone
      records.default = nil
      records
    end

    def keys
      @Records.keys
    end

    def values
      @Records.values
    end

    def has_key? k
      @Records[k] ? true : false
    end

    def rand_keys
      self.keys.sort_by{rand}
    end
  end
end
