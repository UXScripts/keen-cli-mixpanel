require 'digest/md5'
require 'json'
require 'open-uri'

module KeenCli
  
  class Utils
    
    class Mixpanel
    
      class << self
      
        # Builds the Data API url path per Mixpanel API requirements
        #
        # @return [String] url
        def build_path(options)
          URI::encode(options[:path] + '?' +  Utils::Mixpanel.sign_request({ :api_secret => options[:api_secret], :params => options[:params] })).gsub("[","%5B").gsub("]","%5D")
        end
      
        # Export the data from Mixpanel
        #
        # @return [String] json
        def export(options)
          path = Utils::Mixpanel.build_path(options)
          response = Keen::HTTP::Sync.new(CONFIG[:data_api_url],nil).get(:path => path,:headers => nil)
          response.body
        end
        
        # Compiles an MD5 signature per Mixpanel Data API requirements
        #
        # @return [String] md5 hash signature
        def sign_request(options)
          args = Hash[options[:params].sort_by{|k,v| k}].map{|k,v| "#{k}=#{v}"}.join
          options[:params][:sig] = Digest::MD5.hexdigest(args + options[:api_secret])
          Hash[options[:params].sort_by{|k,v| k}].map{|k,v| "#{k}=#{v}"}.join('&')
        end
        
        # Transform a JSON string from Mixpanel format to Keen IO format (e.g. flatten it)
        #
        # @return [String] json
        def transform(options)
          json = JSON.parse(options[:data])
          
          properties = json['properties']
          properties['event'] = json['event']
          properties['keen'] = { :timestamp => Time.at(properties['time'].to_i).to_time.utc.iso8601 }
          properties.delete('time')
        
          properties.to_json
        end
        
        # Write data to a file
        def write(options)
          data = options[:data].gsub(/\{\"\$/,'{"').gsub(/\,\"\$/,',"') # regex cleans up properties names that begin with $  
            
          File.open(options[:file],'w') do |f|
            f.write(data)  
          end
          
          # do we need to transform the data?
          if options.has_key?(:transform)
            if options[:transform]
              # open the raw export and parse it line by line
              File.open(options[:file],'r').each do |line|
                # append to a separate transformed file
                File.open(options[:file] + '.transformed','a') { |f|
                  f.puts transform(:data => line)
                }
              end
            end
          end
        end
        
      end
    
    end
    
  end
  
end