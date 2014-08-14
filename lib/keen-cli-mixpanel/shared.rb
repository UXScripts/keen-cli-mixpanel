module KeenCli
  
  class Mixpanel < Thor
    
    # only require the credential options if env values haven't been specified
    def self.credentials
      if @@mixpanel_api_key.nil?
        option :"api-key", :required => true
      end

      if @@mixpanel_api_secret.nil?
        option :"api-secret", :required => true
      end
    end

    def self.shared_options
      option :"from-date", :required => true
      option :"to-date", :required => true
      option :event, :required => true
      option :where
      option :bucket
    end

    def self.file_options
      option :file, :required => true
    end
    
  end
end