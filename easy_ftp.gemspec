# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "easy_ftp"
  s.version     = "0.0.4"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Peter AitkEn", "Kenny Primrose", "Colin Gemmell", "Matthew Lang","Chris Wright", "Charlie Quinn"]
  s.email       = ["jiggypete@gmail.com", "kprimrose@regenersis.com", "pythonandchips@gmail.com", "matthew@matthewlang.co.uk","cjwright83y@gmail.com","charlesquinn1984@gmail.com"]
  s.homepage    = "http://www.jiggypete.com"
  s.summary     = "Wrapper round Net:FTP and SFTP"
  s.description = "Wrapper round Net:FTP"
  s.add_dependency( 'net-sftp', '=2.0.5')

  s.rubyforge_project = "easy_ftp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.has_rdoc = false
end
