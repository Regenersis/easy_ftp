require 'net/ftp'
require 'date'

module EasyFTP
  def self.put( local_path_to_file, connection_details )
    connect(connection_details) do |ftp|
      ftp.puttextfile(local_path_to_file)
    end
  end

  def self.get( file_name_to_get, local_path_to_file, connection_details )
    connect(connection_details) do |ftp|
      if (File.directory?(local_path_to_file))
        ftp.get(file_name_to_get, local_path_to_file + "/" + file_name_to_get)
      else
        ftp.get(file_name_to_get, local_path_to_file)
      end
    end
  end

  def self.list(connection_details)
    connect(connection_details) do |ftp|
      response = ftp.list('*')
      files = []
      response.each do |s|
        strings = s.split(" ")
        file_name = strings[strings.length-1]
        unless file_name == "." || file_name == ".."
          files << {:file_name => file_name}
        end
      end
      return files
    end
  end

  def self.delete(file_name, connection_details)
    connect(connection_details) do |ftp|
      ftp.delete(file_name)
    end
  end

  def self.move(source, destination, connection_details)
    connect(connection_details) do |ftp|
      ftp.sendcmd("RNFR #{source}")
      ftp.sendcmd("RNTO #{destination}")
    end
  end


  def self.connect(connection_details, &block)
    ftp=Net::FTP.new
    ftp.passive = true
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
