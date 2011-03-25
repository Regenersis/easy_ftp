# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "easy_ftp/version"

Gem::Specification.new do |s|
  s.name        = "easy_ftp"
  s.version     = EasyFtp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Peter Atkin", "Kenny Primrose", "Colin Gemmell", "Matthew Lang"]
  s.email       = ["jiggypete@gmail.com", "kprimrose@regenersis.com", "pythonandchips@gmail.com", "matthew@matthewlang.com"]
  s.homepage    = "http://www.jiggypete.com"
  s.summary     = "Wrapper round Net:FTP"
  s.description = "Wrapper round Net:FTP"

  s.rubyforge_project = "easy_ftp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.has_rdoc = false
end
