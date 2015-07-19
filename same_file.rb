require 'digest/md5'
require_relative "database"

db = Database.new

if ARGV.first == "setup"
  db.setup
end

Dir.glob("**/*").each do |fa|
  print "."

  f = File.new(fa)
  unless File.directory?(fa)
    md5   = Digest::MD5.hexdigest(f.read)
    path  = File.absolute_path(f)
    bytes = f.size

    db.save_if_not_exist(md5, path, bytes)
  end
end

db.all.each do |a|
  p a
end
