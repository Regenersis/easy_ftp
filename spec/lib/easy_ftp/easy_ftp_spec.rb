require 'spec_helper'

describe EasyFTP do
  before ( :each ) do
    @config_hash = {'hostname' => "www.google.com", 'upload_directory' => "temp", 'user' => "Flash Gordon", 'password' => "Gordons Alive", 'port' => 21}
    @stub_ftp = initialise_ftp_stub
    Net::FTP.stub!(:new).and_return( @stub_ftp )
    @stub_ftp.should_receive(:passive=).with(true).once
  end

  describe "put file to server" do

    it "should send the configured file" do
      file_path = "expected/route/to/file.txt"
      @stub_ftp.should_receive( :puttextfile ).with( file_path )
      EasyFTP.put( file_path, @config_hash )
    end

  end

  describe "delete file from server" do
    it "should remove file from remote server" do
      file_name = "file.txt"
      @stub_ftp.should_receive(:delete).with(file_name)
      EasyFTP.delete(file_name, @config_hash)
    end
  end

  describe "list file to server" do
    before( :each ) do
      files = "-r--r--r-- 1 ftp ftp           1471 Jun 25  2007 .\n"
      files << "-r--r--r-- 1 ftp ftp           1471 Jun 25  2007 ..\n"
      files << "-r--r--r-- 1 ftp ftp           1471 Jun 25  2007 bookstore.xml\n"
      files << "-r--r--r-- 1 ftp ftp         279658 Jun 25  2007 hamlet.xml\n"
      files << "-r--r--r-- 1 ftp ftp          80641 Jun 25  2007 hamlet.zip\n"
      files << "-r--r--r-- 1 ftp ftp           2164 Jun 25  2007 japanese.xml\n"
    
      @stub_ftp.should_receive( :list ).with('*').and_return files
      @lines = EasyFTP.list(@config_hash )
    end


    it "should contain hash with file details" do
      @lines.should eql [{:file_name => "bookstore.xml"},
                        {:file_name => "hamlet.xml"},
                        {:file_name => "hamlet.zip"},
                        {:file_name => "japanese.xml"}]
    end
  end

  describe "get a file from the server" do
    context "when a path and filename is given" do
      it "should retrieve a file from the ftp server" do
        File.stub!(:directory?).and_return(false)
        @stub_ftp.should_receive( :get ).with('bookstore.xml', '/public/bookstore.xml')
        EasyFTP.get('bookstore.xml','/public/bookstore.xml', @config_hash)
      end
    end
    context "when just a path is given" do
      it "should retrieve a file from the ftp server" do
        File.stub!(:directory?).and_return(true)
        @stub_ftp.should_receive( :get ).with('bookstore.xml', '/public/bookstore.xml')
        EasyFTP.get('bookstore.xml','/public', @config_hash)
      end
    end
  end

  describe "connect to server" do
    
    it "should connect to the configured url and port" do
      @stub_ftp.should_receive( :connect ).with( @config_hash['hostname'], @config_hash['port'] )
      EasyFTP.connect(@config_hash )
    end

    it "should login with the configured user and password" do
      @stub_ftp.should_receive( :login ).with( @config_hash['user'], @config_hash['password'] )
      EasyFTP.connect(@config_hash )
    end

    it "should move to the configured remote upload_directory" do
      @stub_ftp.should_receive( :chdir ).with( @config_hash['upload_directory'] )
      EasyFTP.connect(@config_hash )
    end

    it "should not move directory when no remote upload_directory is configured " do
      @config_hash['upload_directory'] = nil
      @stub_ftp.should_not_receive( :chdir )
      EasyFTP.connect(@config_hash )
    end

    it "should not move directory when empty remote upload_directory is configured " do
      @config_hash['upload_directory'] = ''
      @stub_ftp.should_not_receive( :chdir )
      EasyFTP.connect(@config_hash )
    end

    it "should close the ftp connection" do
      @stub_ftp.should_receive( :close )
      EasyFTP.connect(@config_hash )
    end

    it "should close connection on error" do
      begin
        @stub_ftp.should_receive( :connect ).and_raise( Exception.new )
        @stub_ftp.should_receive( :close )
        EasyFTP.connect(@config_hash )
      rescue Exception => e
      end
    end
  end


  private

  def initialise_ftp_stub
    result = stub( "ftp" );
    result.stub!( :connect )
    result.stub!( :login )
    result.stub!( :chdir )
    result.stub!( :puttextfile )
    result.stub!( :close )
    result.stub!( :list )
    result.stub!( :get )
    result.stub!( :delete )
    return result
  end

end
