require File.dirname(__FILE__) + '/dynftp_server'
require 'logger'

Thread.abort_on_exception = true

class FSProvider
  attr_reader :ftp_name, :ftp_size, :ftp_dir, :ftp_date

  def ftp_parent
    path = @path.split('/')
    return nil unless path.pop
    return nil if path.size <= 1
    return FSProvider.new(path.join('/'))
  end

  def ftp_list
    output = Array.new
    Dir.entries(@path).sort.each do |file|          
      output << FSProvider.new(@path + (@path == '/'? '': '/') + file)
    end
    return output
  end
  
  def ftp_create(name, dir = false)
    if dir
      begin
        Dir.mkdir(@path + '/' + name)
        return FSProvider.new(@path + '/' + name)
      rescue
        return false
      end
    else
      FSProvider.new(@path + '/' + name)
    end
    
  end
  
  def ftp_retrieve(output)
    output << File.new(@path, 'r').read
  end
  
  def ftp_store(input)
    return false unless File.open(@path, 'w') do |f|
      f.write input.read
    end
    @ftp_size = File.size?(@path)
    @ftp_date = File.mtime(@path) if File.exists?(@path)
  end
  
  def ftp_delete(file_name)
    File.delete(@path)
    return true
  end
  
  def initialize(path)
    @path = path
    @ftp_name = path.split('/').last
    @ftp_name = '/' unless @ftp_name
    @ftp_dir = File.directory?(path)    
    @ftp_size = File.size?(path)
    @ftp_size = 0 unless @ftp_size
    @ftp_date = Time.now
    @ftp_date = File.mtime(path) if File.exists?(path)
  end
  
end


