require 'lib/easy_ftp'

describe EasyFTP do

  before( :each ) do
    @config_hash = {'hostname' => "www.google.com", 'upload_directory' => "temp", 'user' => "Flash Gordon", 'password' => "Gordons Alive", 'port' => 21}
    @stub_ftp = initialise_ftp_stub

    Net::FTP.stub!(:new).and_return( @stub_ftp )
  end

  it "should connect to the configured url and port" do
    @stub_ftp.should_receive( :connect ).with( @config_hash['hostname'], @config_hash['port'] )
    EasyFTP.put( "thefile", @config_hash )
  end

  it "should login with the configured user and password" do
    @stub_ftp.should_receive( :login ).with( @config_hash['user'], @config_hash['password'] )
    EasyFTP.put( "thefile", @config_hash )
  end

  it "should move to the configured remote upload_directory" do
    @stub_ftp.should_receive( :chdir ).with( @config_hash['upload_directory'] )
    EasyFTP.put( "thefile", @config_hash )
  end

  it "should not move directory when no remote upload_directory is configured " do
    @config_hash['upload_directory'] = nil
    @stub_ftp.should_not_receive( :chdir )    
    EasyFTP.put( "thefile", @config_hash )
  end

  it "should not move directory when empty remote upload_directory is configured " do
    @config_hash['upload_directory'] = ''
    @stub_ftp.should_not_receive( :chdir )
    EasyFTP.put( "thefile", @config_hash )
  end

  it "should send the configured file" do
    file_path = "expected/route/to/file.txt"
    @stub_ftp.should_receive( :puttextfile ).with( file_path )
    EasyFTP.put( file_path, @config_hash )
  end

  it "should close the ftp connection" do
    @stub_ftp.should_receive( :close )    
    EasyFTP.put( "thefile", @config_hash )
  end

  it "should close connection on error" do
    begin
      @stub_ftp.should_receive( :connect ).and_raise( Exception.new )
      @stub_ftp.should_receive( :close )
      EasyFTP.put( "thefile", @config_hash )
    rescue Exception => e
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

    return result
  end

end
