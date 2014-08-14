module KeenCli
  
  class Mixpanel < Thor
    
    desc "export","Export data from Mixpanel to a file"
    credentials
    shared_options
    file_options
    def export
      puts "Exporting data from Mixpanel..."
      data = Utils::Mixpanel.export({ :api_secret => @@mixpanel_api_secret, :path => CONFIG[:export_path], :params => Mixpanel.params(options) })
  
      puts "Writing exported data to '#{options[:file]}'..."
      Utils::Mixpanel.write({ :file => options[:file], :data => data })
  
      rows = File.open(options[:file],'r').readlines.size
      puts "Exported #{rows} events from Mixpanel."
  
      puts "Done."
      true
    end

    desc "import","Import data from Mixpanel into Keen IO"
    option :collection, :aliases => ['-c'], :required => true
    credentials
    shared_options
    def import
      puts "Exporting data from Mixpanel..."
      data = Utils::Mixpanel.export({ :api_secret => @@mixpanel_api_secret, :path => CONFIG[:export_path], :params => Mixpanel.params(options) })
      
      file = 'mixpanel_export_' + Time.now.utc.iso8601.gsub('-','').gsub(':','') + '.json'
      puts "Writing exported data to '#{file}'..."
      Utils::Mixpanel.write({ :file => file, :data => data, :transform => true })
  
      rows = File.open(file,'r').readlines.size
      puts "Exported #{rows} events from Mixpanel."

      if rows > 0
        puts "Importing data to Keen IO..."
        system("cat " + file + '.transformed' + " | keen events:add -c #{options[:collection]}") # pipe events via the keen-cli
      else
        puts "Nothing to import to Keen IO."
      end
      
      # cleanup
      File.delete(file)
      File.delete(file + '.transformed')
  
      puts "Done."
      true
    end
    
  end

end