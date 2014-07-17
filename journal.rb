require 'rubygems'
require 'bundler'
Bundler.require(:default)

class Journal
  attr_accessor :user, :password, :output

  def initialize(user, password, url, output)
    @user       = user
    @password   = password
    @output     = output
    fetch(url)
  end

  def fetch(url)
    page = get(url)
    download_links(page).each_with_index do |link, idx|
      puts "<> Downloading article #{idx.next}"
      raw_pdf = link.click.body
      File.open(pdf_file_path(idx), 'wb') { |f| f.write(raw_pdf)}
      sleep(3)
    end
    combine_articles
  end

  def pdf_file_path(idx)
    File.join(dest_dir,"#{idx.next}.pdf")
  end

  def dest_dir
    @tmpdir ||= Dir.mktmpdir
  end

  def agent
    @agent ||= Mechanize.new
  end

  def download_links(page)
    page.links.map{|l| l if l.text =~ /Download/i }.compact
  end

  def combine_articles
    articles = Dir.glob(File.join(dest_dir, "*")).sort_by do |file|
      File.basename(file)[/\d+/].to_i
    end.join(" ")
    %x{
      gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite  \
      -sOutputFile=#{output_dir} \
      -dFirstPage=2 \
      #{articles}
    }
  end

  def output_dir
    File.join(output, "output.pdf")
  end

  def get(url)
    login = agent.get(url)
    form = login.forms.first
    form.username = user
    form.password = password
    form.submit
  end
end

# url =  "http://muse.jhu.edu.proxy.lib.pdx.edu/journals/computer_music_journal/toc/cmj.38.2.html"
# Journal.new(user, pass, url, '/Users/ereth/Desktop/')
