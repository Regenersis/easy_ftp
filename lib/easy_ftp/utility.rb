module EasyFTP
  module Utility
    def self.download_files(destination, settings)
      ftp_authorisation_details =  settings[:ftp_authorisation_details]
      claim_files = EasyFTP.list(ftp_authorisation_details)
      claim_files.uniq.each do |file|
        unless File.exists?(destination)
          Dir.mkdir(destination)
        end
        EasyFTP.get(file[:file_name], destination, ftp_authorisation_details)
        yield(File.join(destination, file[:file_name])) if block_given?
      end
    end
  end
end
