require File.dirname(__FILE__) + '/../../test_server/ftpserv'

module EasyFTP
  module FTPServer
    def self.pid
      @@pid
    end

    def self.pid= pid
      @@pid = pid
    end

    def self.start_ftp_server( config_hash )
      host = config_hash["hostname"]
      port = config_hash["port"]
      username = config_hash["user"]
      serve_dir = "cucumber_ftp_server_dir"

      @@pid = fork do
        Signal.trap("HUP") do 
          puts
          puts
          puts("killing ftp server")
          exit
        end
        puts
        puts
        puts "starting ftp server"
        root = FSProvider.new(serve_dir)
        auth =
          lambda do |user,pass|
            return user == username
          end

        s = DynFTPServer.new(:host => host, :port => port, :root => root, :authentication => auth)
        s.mainloop
        Process.wait
      end
    end

    def self.kill_ftp_server
      Process.kill("HUP", pid)
    end

  end
end
