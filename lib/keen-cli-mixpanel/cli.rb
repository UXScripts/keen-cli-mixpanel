require 'thor'
require 'keen'

require 'keen-cli-mixpanel/utils'

require 'keen-cli-mixpanel/shared'

module KeenCli
  
  class Mixpanel < Thor
    
    @@mixpanel_api_key = ENV['MIXPANEL_API_KEY']
    @@mixpanel_api_secret = ENV['MIXPANEL_API_SECRET']
    
    def self.params(options)
      {
        :api_key => @@mixpanel_api_key,
        :event => options[:event],
        :expire => (Time.now.to_i + 240),
        :from_date => options[:"from-date"],
        :to_date => options[:"to-date"]
      }
    end
    
    # overwrite the api-key with the value specified in the options if present
    if !@@mixpanel_api_key.nil? && !options[:"api-key"].nil?
      if @@mixpanel_api_key != options[:"api-key"]
        @@mixpanel_api_key = options[:"api-key"]
      end
    end
    
    # overwrite the api-key with the value specified in the options if present
    if !@@mixpanel_api_secret.nil? && !options[:"api-secret"].nil?
      if @@mixpanel_api_secret != options[:"api-secret"]
        @@mixpanel_api_secret = options[:"api-secret"]
      end
    end
    
    require 'keen-cli-mixpanel/plugin'
    
    desc 'version', 'Print the keen-cli-mixpanel version'
    map %w(-v --version) => :version
    def version
      "keen-cli-mixpanel version #{VERSION}".tap do |s|
        puts s
      end
    end
  
  end
    
end