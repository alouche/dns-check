#-*- encoding: utf-8 -*-

require 'ipaddress'
require 'public_suffix'

module DNSCheck
  module Core
    def __init options, filter={}
      is_hostname_sane?   options[:hostname]
      indice_file_exist?  options[:indice_store]

      indice_records = load_indice(options[:indice_store], options[:location])

      select_random_records(options[:size], indice_records)
    end

    private

    def is_hostname_sane? hostname
      raise DNSCheck::DomainError, "Specify a correct domain name format!"\
        if IPAddress.valid? hostname\
          or (Float(hostname) != nil rescue false)\
          or !PublicSuffix.valid? hostname
    end

    def indice_file_exist? indice_file
      raise DNSCheck::IndiceMissing, "Download the indice by issuing dns-check --update"\
        unless File.exist?(indice_file)
    end

    def is_location_city? location_filter
      return location_filter.resolve_country_name if location_filter.size > 2

      #FIXME String#capitalize_all needs to be fixed
      #to not allow FR to become Fr
      return location_filter.upcase
    end

    def load_indice indice_file, location_filter=nil
      records = DNSCheck.load indice_file

      unless location_filter.nil?
        location_filter = location_filter.capitalize_all

        location = is_location_city? location_filter

        filtered_records = []

        #FIXME clean up procedure (duplicate push call)
        unless location.nil?
          # This will also catch unexisting cities, return general error
          raise DNSCheck::LocationError, "This location could not be found"\
            unless records.has_key?(location)

          records = records[location]
          records.each do |record|
            filtered_records.push([record])
          end
        else
          records.values.each do |record|
            record.each do |k|
              if k.include?(location_filter)
                filtered_records.push([k])
              end
            end
          end
        end

        return DNSCheck::DB[filtered_records]
      end

      records
    rescue => e
      raise DNSCheck::IndiceLoading, e.message
    end

    #FIXME break method
    def select_random_records(max_records, indice_records)
      records = []

      sliced_records = indice_records.rand_keys.slice(0..max_records-1)

      sliced_records.each do |k|
        if k.class == String
          v = indice_records[k].sample.flatten
          v.push(k)
        else
          v = k.flatten
        end

        v[1].delete_if {|x|
          x == nil || x == ""
        }

        records.push(v)
      end

      records
    end
  end
end
