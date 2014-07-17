Muse
====
Muse is a tool that uses Mechanize to download and combine PDF Journal articles from Project Muse via your PSU Library account.  Each Muse download header page is removed and all articles are concatenated into a single PDF.

### Requirements 
1. bundler
2. ghostscript
3. PSU library access/credentials

### Installation
```
bundle install
```

### Usage
1. Copy the URL link for the journal issue on Project Muse
2. Supply the Library username, password, the journal issue URL and the local destination directory for the combined output.pdf
```
url = "http://muse.jhu.edu.proxy.lib.pdx.edu/journals/computer_music_journal/toc/cmj.36.1.html"
dest_dir = "/Users/ereth/Desktop/"
Journal.new(username, password, url, dest_dir)
```

### Notes
1.  This was written to make it a little easier to access and archive a single Journal of interest.  This shouldn't be altered to abuse and mass download Journals from the Muse service.




