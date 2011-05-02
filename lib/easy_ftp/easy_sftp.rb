require 'net/sftp'

module EasySFTP
  def self.put( local_path_to_file, remote_directory, connection_details )
    connect( connection_details ) do |sftp|
      filename = local_path_to_file.split( '/' ).last
      remote_filepath = "#{remote_directory}/#{filename}"
      sftp.upload local_path_to_file, remote_filepath       
    end
  end

  def self.get( remote_path_to_file, local_path_to_file, connection_details )
    connect( connection_details ) do |sftp|
      sftp.download remote_path_to_file, local_path_to_file
    end
  end

  def self.delete( remote_path_to_file, connection_details )
    connect( connection_details ) do |sftp|
      sftp.remove( remote_path_to_file )
    end
  end

  def self.list(directory, connection_details)
    connect(connection_details) do |sftp|
      files = []

      sftp.dir.foreach(directory) do |entry|
        files << entry.name
      end

      return files - ['.', '..']
    end
  end

  private

  def self.connect( connection_details )
    Net::SFTP.start(connection_details['hostname'], connection_details['user'], connection_details['password']) do |sftp|
      yield sftp
    end
  end
end
