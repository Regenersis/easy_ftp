require 'lib/easy_ftp'
require 'lib/start_ftp_server'
require 'spec/app_config'

describe EasyFTP do
  describe "integration test" do
    it "should upload file to server" do
     hash_config = AppConfig.ftp
     start_ftp_server ( hash_config )
     sleep 3
     file_path = File.join(File.dirname(__FILE__), '../test_files', "blah.txt")
     File.open(file_path, 'w') do |f|
       f.write("blah")
     end

     EasyFTP.put(file_path, hash_config)
     ftp_path = File.join(File.dirname(__FILE__), '../../cucumber_ftp_server_dir', "blah.txt")
     File.exists?(ftp_path).should eql true
    end
  end
end

# todo : start integration test
# # start the ftp server
# # chuck some files on it 
# # assert our list function works
# # delete ftp folder
# # close ftp
# # make a cup of tea
