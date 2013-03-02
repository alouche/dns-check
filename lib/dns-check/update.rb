#-*- encoding: utf-8 -*-

require 'net/http'

module DNSCheck
  module Update
    attr_accessor :indice_location, :indice_store

    def update!
      print "-> downloading... (please wait)"

      http do |conn|
        request = Net::HTTP::Get.new(indice_location.request_uri, {})

        buffer = ''

        conn.request request do |res|
          case res
          when Net::HTTPNotModified
            puts "No new content available"
          when Net::HTTPRedirection
            # Do not expect a redirect...
            puts "Redirecting to #{res['Location']}... aborting! open a github issue"
          when Net::HTTPOK
            begin
              res.read_body do |buf|
                buffer << buf
              end
              save buffer
            rescue Exception => e
              raise e
            ensure
              #TODO clean exit?
            end
          when Net::HTTPNotFound
            raise DNSCheck::NotFoundError, "http code 404 - open a github issue"
          else
            raise RuntimeError, "Update failed... #{res.message}"
          end
        end
      end
    rescue => e
      raise DNSCheck::UpdateError, "the indice update failed... #{e.message}"
    end

    private

    def save buffer
      object = sanetize_indice buffer
      DNSCheck.store object, indice_store
    end

    def http
      yield Net::HTTP.new(indice_location.hostname, 80)
    end
  
    def sanetize_indice buffer
      indice_records = JSON.parse(buffer)
      # Create new array, faster than calling Array#delete on indice_records
      new_indice_records = DNSCheck::DB.new

      indice_records.each do |record|
        if record['state'] == "valid" and !record['country_id'].nil?
          new_indice_records[record['country_id']] = {
            record['city'] => [
              record['ip'],
              record['name']
            ]
          }
        end
      end
      print " - done\n";
      return new_indice_records
    rescue => e
      #TODO raise exception, i.e: upstream key format changed!
    end
  end

  extend Update
end
