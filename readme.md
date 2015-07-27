Look for same file recursively starting from script path

```bash
$ bundle install

$ ruby same_file.rb
ruby same_file.rb setup               -- Setup database, need to be run once
ruby same_file.rb start               -- Find duplicate file
ruby same_file.rb duplicate           -- Display duplicate file
ruby same_file.rb all_files           -- Display all tested file
ruby same_file.rb remove_dead_entries -- Remove dead entries from database

$ ruby same_file.rb setup
$ ruby same_file.rb start
$ ruby same_file.rb duplicate
```
