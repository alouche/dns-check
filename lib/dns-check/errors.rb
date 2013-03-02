#-*- encoding: utf-8 -*-

module DNSCheck
  class Error < StandardError; end

  class NotFoundError < RuntimeError; end

  class IndiceMissing < Error; end

  class IndiceLoading < Error; end

  class DomainError < Error; end

  class LocationError < Error; end

  class UpdateError < Error; end
end
