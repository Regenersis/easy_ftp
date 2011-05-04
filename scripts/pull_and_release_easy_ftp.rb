# This file sits in the root of Tupac.
# It uses the Ronseal naming convention

`cd gem_staging/easy_ftp;git pull origin master`

version_line = `more gem_staging/easy_ftp/easy_ftp.gemspec | grep 'version'`
version_number = version_line.split( '"' )[1]

`cd gem_staging/easy_ftp;gem build easy_ftp.gemspec`

file_to_copy = "~/gem_staging/easy_ftp/easy_ftp-#{version_number}.gem"
puts "Copying #{file_to_copy}"
`cp #{file_to_copy} ~/www/gems/gems`
`cd ~/www/gems;gem generate index`
puts "easy-ftp verion: #{version_number} has been released successfully"
