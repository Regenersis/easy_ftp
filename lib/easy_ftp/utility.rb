module EasyFTP
  module Utility
    def self.download_files(destination, settings)
      ftp_authorisation_details =  settings[:ftp_authorisation_details]
      files = EasySFTP.list(settings[:directory], ftp_authorisation_details)
      files.uniq.each do |file|
        unless File.exists?(destination)
          Dir.mkdir(destination)
        end
        EasySFTP.get(file, destination, ftp_authorisation_details)
        yield(File.join(destination, file[:file_name])) if block_given?
      end
    end
  end
end
