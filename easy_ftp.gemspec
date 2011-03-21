spec = Gem::Specification.new do |s|
  s.name = 'easy_ftp'
  s.version = '0.0.1'
  s.summary = 'Easily FTP'
  s.author = 'Peter & Kenny'
  s.email = 'jiggypete@gmail.com'
  s.homepage = 'http://www.jiggypete.com'
  s.description = 'Easily FTP'
  s.rubyforge_project = ''
  s.files = [
          "README",
          
          "lib/easy_ftp.rb",
          "lib/start_ftp_server.rb",

          "test_server/dynftp_server.rb",
          "test_server/ftpserv.rb",

          "spawn/init.rb",
          "spawn/lib/patches.rb",
          "spawn/lib/spawn.rb",

          "spec/easy_ftp_spec.rb"
  ]
  s.has_rdoc = false
end

