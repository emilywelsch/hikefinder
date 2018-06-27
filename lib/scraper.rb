require "hikefinder/version"
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/trail.rb'


class Scraper

  def self.scrape_trails
    trails = [{:name=>"Inca Trail", :location=>"Peru", :distance=>"26 miles", :best_time=>"May to September", :description=>"One of the most popular hikes in the world, the Inca Trail takes you through 26 miles of grueling inclines and declines. You get a chance to explore ruins, jungle, and beautiful mountain scenery, and of course, end the hike at Machu Picchu.", :url=>"https://localadventurer.com/25-best-hikes-in-the-world-bucket-list/", :tips=>"Have fun!"}]
    # trails = []
    # doc = Nokogiri::HTML(open("https://localadventurer.com/25-best-hikes-in-the-world-bucket-list/"))
    #   doc.css('div._e296pg').each do |heading|
    #     # binding.pry
    #     trail_info = {}
    #     trail_info[:name] = heading.css('div._18nb9p').text
    #     trail_info[:location] = heading.css('div._1uel1v2').text
    #     trail_info[:distance] = heading.css('div._vpdeeg').text
    #     trail_info[:time] = heading.css('span._q27mtmr').text
    #     trail_info[:best_time] = heading.css('span._1m8bb6v').text
    #     trail_info[:description] = heading.css('span._1m8bb6v').text
    #     trail_info[:url] = heading.css('a').attr("href").value
    #     trails << trail_info # Can I use sort_by on trail_info to alphabetize hashes?
    #   end
    trails
  end

  def self.scrape_trail_details(profile_url)
    trail_profile = "https://localadventurer.com/25-best-hikes-in-the-world-bucket-list/" + profile_url
    trail_profile_page = Nokogiri::HTML(open(trail_profile))

        trail_profile_details = []
        trails_page.css("").each do |attribute|
            tips = attribute.css('div._n5wk6ic').text
            trail_profile_details << {tips: tips}
          end
        trail_profile_details
  end


end
