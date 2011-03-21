require File.dirname(__FILE__) + '/../test_server/ftpserv'
require File.dirname(__FILE__) + '/../spawn/lib/spawn'
require File.dirname(__FILE__) + '/../spawn/init'
include Spawn

def start_ftp_server( config_hash )
  host = config_hash["hostname"]
  port = config_hash["port"]
  username = config_hash["user"]
  serve_dir = "cucumber_ftp_server_dir"

  spawn(:method => :fork, :kill => true) do
    root = FSProvider.new(serve_dir)
    auth =
      lambda do |user,pass|
        return user == username
      end

    s = DynFTPServer.new(:host => host, :port => port, :root => root, :authentication => auth)
    s.mainloop
   end
end