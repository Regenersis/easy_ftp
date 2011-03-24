require 'net/ftp'
require 'date'

class EasyFTP
  def self.put( local_path_to_file, connection_details )
    connect(connection_details) do |ftp|
      ftp.puttextfile(local_path_to_file)
    end
  end

  def self.get( file_name_to_get, local_path_to_file, connection_details )
    connect(connection_details) do |ftp|
      ftp.get(file_name_to_get, local_path_to_file)
    end
  end

  def self.list(connection_details)
    connect(connection_details) do |ftp|
      response = ftp.list('*')
      files = []
      response.each do |s|
        strings = s.split(" ")
        files << {:file_name => strings[strings.length-1]}
      end 
      return files
    end
  end

  def self.connect(connection_details, &block)
    ftp=Net::FTP.new
    begin
      ftp.connect connection_details['hostname'], connection_details['port']
      ftp.login connection_details['user'], connection_details['password']
      if !(connection_details['upload_directory'].nil? || connection_details['upload_directory'] == '')
        ftp.chdir connection_details['upload_directory']
      end
      return block.call(ftp) unless block.nil?
    ensure
      ftp.close
    end
  end
end
