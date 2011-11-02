require 'cucumber'

module Cucumber
  module Integration
    Before(:all) do
      begin
        options = {"hostname" => "127.0.0.1", "port" => "2000", "user" => "a_user", "password" => "password" }
        options.merge(ftp_options) if defined?(:ftp_options)
        EasyFTP::FTPServer.start_ftp_server(options)
        sleep(4)
      rescue
      end
    end

    After(:all) do
      EasyFTP::FTPServer.kill_ftp_server
    end
  end
end
