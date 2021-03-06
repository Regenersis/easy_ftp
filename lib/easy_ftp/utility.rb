module EasyFTP
  module Utility
    def self.download_files(destination, settings)
      ftp_authorisation_details =  settings[:ftp_authorisation_details]
      files = EasySFTP.list(settings[:directory], ftp_authorisation_details)
      files.uniq.each do |file|
        remote_file_path = "#{settings[:directory]}/#{file}"
        local_file_path = File.join(destination, file)
        unless File.exists?(destination)
          Dir.mkdir(destination)
        end
        EasySFTP.get(remote_file_path, local_file_path, ftp_authorisation_details)
        yield(local_file_path) if block_given?
        if settings[:delete_file]
          remote_file_path = "#{settings[:directory]}/#{file}"
          EasySFTP.delete(remote_file_path, ftp_authorisation_details)
        end
      end
    end
  end
end
