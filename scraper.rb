require 'rest-client'
require 'scraperwiki'

def web_archive(url)
  archive_request_response = RestClient.get("https://web.archive.org/save/#{url}")
  archive_request_response.headers[:link].split(", ")[2][/\<.*\>/].gsub(/<|>/, "")
end

url = "https://tenders.nsw.gov.au/?event=public.api.contract.search"
record = {
  scraped_date: Date.today.to_s,
  web_archive_url: web_archive(url)
}

ScraperWiki.save_sqlite([:scraped_date], record)
