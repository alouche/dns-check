#-*- encoding: utf-8 -*-

class String

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

  def colorize_to(color_name)
    case color_name
    when 'red'
      color_code = 31
    when 'green'
      color_code = 32
    else
      color_code = 33
    end

    "\e[#{color_code}m#{self}\e[0m"
  end
end
