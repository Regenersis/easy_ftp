require 'spec_helper'

class StubSFTPPlaceholder
  class << self
    attr_accessor :stub_sftp
  end
end

module Net::SFTP

  def self.start(hostname, user, options )
    @@hostname = hostname
    @@user = user
    @@options = options
    yield StubSFTPPlaceholder.stub_sftp
  end

  def self.hostname
    return @@hostname
  end

  def self.user
    return @@user
  end

  def self.options
    return @@options
  end
end

def initialise_sftp_stub
  result = stub("sftp");
  result.stub( :upload )
  return result
end

describe EasySFTP do

  before(:each) do
    @config_hash = {'hostname' => "www.google.com", 'user' => "Flash Gordon", 'password' => "Gordons Alive", 'port' => 21}
    StubSFTPPlaceholder.stub_sftp = initialise_sftp_stub
  end

  describe "connection details" do

    before( :each ) do
      EasySFTP.put("expected/route/to/file.txt", "temp", @config_hash)
    end

    it "should supply the hostname" do
      Net::SFTP.hostname.should == "www.google.com"
    end

    it "should supply the user" do
      Net::SFTP.user.should == "Flash Gordon"
    end

    it "should supply the password in the options" do
      Net::SFTP.options.should == {:password => "Gordons Alive"}
    end
  end

  describe "put file to server" do

    it "should send the configured file" do
      file_path = "expected/route/to/file.txt"
      StubSFTPPlaceholder.stub_sftp.should_receive(:upload).with(file_path, "temp/file.txt").once

      EasySFTP.put(file_path, "temp", @config_hash)
    end

  end

  describe "get a file from the server" do
    it "should retrieve a file from the ftp server" do
      remote_file_path = '/remote/bookstore.xml'
      local_file_path = '/local/bookstore.xml'
      StubSFTPPlaceholder.stub_sftp.should_receive( :download ).with(remote_file_path, local_file_path)
      EasySFTP.get(remote_file_path, local_file_path, @config_hash)
    end
  end

  describe "delete file from server" do
    it "should remove file from remote server" do
      file_path = "temp/file.txt"
      StubSFTPPlaceholder.stub_sftp.should_receive(:remove).with(file_path).once
      EasySFTP.delete(file_path, @config_hash)
    end
  end

end
