require 'digest/md5'
require_relative "database"

db = Database.new

if ARGV.first == "setup"
  db.setup

elsif ARGV.first == "start"
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

  puts ""

elsif ARGV.first == "duplicate"
  db.duplicate.each do |a|
    p a
  end

elsif ARGV.first == "all_files"
  db.all.each do |a|
    p a
  end

elsif ARGV.first == "remove_dead_entries"
  db.all.each do |a|
    unless File.file?(a[1])
      puts "delete in database : #{a.inspect}"
      db.remove_entries(a[1])
    end
  end

else

  puts "ruby same_file.rb setup               -- Setup database, need to be run once"
  puts "ruby same_file.rb start               -- Find duplicate file"
  puts "ruby same_file.rb duplicate           -- Display duplicate file"
  puts "ruby same_file.rb all_files           -- Display all tested file"
  puts "ruby same_file.rb remove_dead_entries -- Remove dead entries from database"
end
