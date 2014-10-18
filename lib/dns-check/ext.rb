#-*- encoding: utf-8 -*-
#

class String

  COLORS = {
    :red      => 31,
    :green    => 32,
    :yellow   => 33,
  }

  def capitalize_all
    self.split(' ').map do |word|
      word.capitalize
    end.join(' ')
  end

  def resolve_country_code
    DNSCheck::COUNTRY_CODES[self] || self
  end

  def resolve_country_name
    DNSCheck::COUNTRY_CODES.invert[self]
  end

  def colorize(color_name)
    self.scan(REGEXP_PATTERN).inject("") do |str, match|

    end
  end

  def colorize_to(color_name)
    "\e[#{COLORS[color_name]}m#{self}\e[0m"
  end
end
