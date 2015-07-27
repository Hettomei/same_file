require 'sqlite3'

class Database

  def save_if_not_exist(md5, path, bytes)
    unless exist?(md5, path, bytes)
      db.execute("INSERT INTO same_files values (?, ?, ?)", md5, path, bytes)
    end
  end

  def exist?(md5, path, bytes)
    db.execute(
      "select count(*) from same_files where md5 = ? and path = ? and bytes = ?;",
      md5,
      path,
      bytes
    ).flatten.first > 0
  end

  def all
    db.execute("select md5, path, bytes from same_files order by path;")
  end

  def duplicate
    db.execute("select md5, group_concat(path, ', '), count(md5) as count_md5 from same_files group by(md5) having count_md5 > 1; ")
  end

  def setup
    puts "Creating table same_files"
    db.execute_batch(
      "create table if not exists same_files(md5 CHAR(32),path TEXT, bytes INTEGER);"
    )
    puts "Creating table ok"
  end

  def remove_entries(path)
    db.execute("delete from same_files where path = ?;", path)
  end

  private

  def db
    @db ||= SQLite3::Database.new(file)
  end

  def file
    @file ||= File.expand_path("../same_file_bdd", __FILE__)
  end

end
