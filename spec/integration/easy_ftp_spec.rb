require 'spec_helper'

describe EasyFTP do
  def create_test_folders
    @local_folder = File.join(File.dirname(__FILE__), '../test_files')
    @remote_folder = File.join(File.dirname(__FILE__), '../../cucumber_ftp_server_dir')
    [@local_folder, @remote_folder].each do |folder|
      unless File.exists?(folder)
        Dir.mkdir(folder)
      end
    end
    
  end

  def delete_test_folders
    [@local_folder, @remote_folder].each do |folder|
      if File.exists?(folder)
        Dir.rmdir(folder)
      end
    end
  end

  before(:all) do
    create_test_folders
    @config_hash = {"hostname" => "127.0.0.1", "port" => "2000", "user" => "a_user", "password" => "password" }
    pid = EasyFTP::FTPServer.start_ftp_server(@config_hash)
    sleep(4)
  end

  after(:all) do
    EasyFTP::FTPServer.kill_ftp_server
    delete_test_folders
  end

  after(:each) do
    [@local_folder, @remote_folder].each do |folder|
      if File.exists?(folder)
        Dir.glob(File.join(folder, '**/*')).each{|f| File.delete(f)}
      end
    end
  end

  def create_test_file
    local_file = File.join(@local_folder, 'test.txt')
    File.open(local_file, 'w') do |f|
      f.write("readme")
    end
    local_file
  end

  def create_remote_file file_name
    local_file = File.join(@remote_folder, file_name)
    File.open(local_file, 'w') do |f|
      f.write("readme")
    end
    local_file
  end

  it "should be able to connect to server" do
    EasyFTP.connect(@config_hash) do |ftp|
    end
  end

  it "should put file to server" do
    local_file = create_test_file
    EasyFTP.put(local_file, @config_hash)
    remote_file = File.join(@remote_folder, 'test.txt')
    File.exists?(remote_file).should eql true
  end

  it "should pull file from server" do
    remote_file = create_remote_file 'test.txt'
    local_file = File.join(@local_folder, "test.txt")
    EasyFTP.get('test.txt', local_file,  @config_hash)
    File.exists?(local_file).should eql true
  end

  it "should list remote folder content" do
    remote_file = create_remote_file 'test.txt'
    list = EasyFTP.list(@config_hash)
    list.should eql([{:file_name => 'test.txt'}])
  end

  it "should delete file from server" do
    remote_file = create_remote_file "test.txt"
    EasyFTP.delete("test.txt", @config_hash)
    File.exists?(remote_file).should eql false
  end

#  it "should move file from server to new directory" do
#    remote_file = create_remote_file "test.txt"
#    Dir.mkdir(File.join(@remote_folder, "alt" ))
#    EasyFTP.move("test.txt", "/alt/test.txt", @config_hash)
#    File.exists?(File.join(@remote_folder, "alt/test.txt")).should eql false
#  end
end

