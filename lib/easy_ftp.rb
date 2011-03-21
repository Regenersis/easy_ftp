require 'net/ftp'

class EasyFTP
   def self.put( local_path_to_file, connection_details )
     ftp=Net::FTP.new
     begin
       ftp.connect connection_details['hostname'], connection_details['port']
       ftp.login connection_details['user'], connection_details['password']
       if !(connection_details['upload_directory'].nil? || connection_details['upload_directory'] == '')
         ftp.chdir connection_details['upload_directory']
       end
       ftp.puttextfile(local_path_to_file)
     ensure
      ftp.close
     end
   end
end
