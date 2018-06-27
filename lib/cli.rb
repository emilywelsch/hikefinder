require "hikefinder/version"
require 'nokogiri'
require 'colorize'
require_relative '../lib/scraper.rb'
require_relative '../lib/trail.rb'

class CLI
  # index_url = "https://localadventurer.com/25-best-hikes-in-the-world-bucket-list/"

  def call
    puts "                "
    puts "·÷±‡± Welcome to HikeFinder! ±‡±÷·".colorize(:blue)
    puts "                "
    list
  end

  def list
    puts "Available hiking trails around the world (in alphabetical order by location):".colorize(:cyan)
    make_trails
    # add_attributes_to_trails
    display_trails
  end

  def make_trails
    trails_array = Scraper.scrape_trails
    Trail.create_trail(trails_array)
  end

  def add_attributes_to_trails
    Trail.all.each do |trail|
      attributes = Scraper.scrape_trail_details(trail.url)
      trail.add_trail_attributes(attributes_hash)
    end
  end

  def display_trails
    Trail.all.each.with_index(1) do |trail, i|
      puts "#{i}. #{trail.name} - #{trail.location} - #{trail.distance} - Takes approximately #{trail.time} to complete"
      end
    puts "                "
    trail_selector
  end

  def trail_selector
    puts "Which hiking trail would you like to learn more about? (Enter a number or exit)".colorize(:cyan)
    user_input = gets.chomp
    if user_input == "exit"
      puts "See you on the mountain!".colorize(:blue)
      exit
    elsif
      !user_input.to_i.between?(0, Trail.all.count)
      puts "Invalid entry. Please try again.".colorize(:red)
      trail_selector
    end
    display_details(user_input)
  end

  def display_details(user_input)
    trail = Trail.all[user_input.to_i-1]
    puts "                     "
    puts "Okay, let's check out the hiking trail you picked in #{trail.location}.".colorize(:blue)
    puts "                     "
    puts "·÷±‡± #{trail.name} ±‡±÷·"
    puts "-----------------------------------"
    puts "Distance: " + "#{trail.distance}"
    puts "Time: " + "Approximately #{trail.time} to complete"
    puts "Best Time to Hike: " + "#{trail.best_time}"
    puts "Before the Hike Tips: " + "#{trail.tips}"
    puts "                     "
    puts "For more information on this hiking trail, visit www.localadventurer.com#{trail.url}."
    puts "                     "
    list_again?
  end

  def list_again?
    puts "Would you like to return to the list of hiking trails? (Please enter yes or no)".colorize(:cyan)
    user_input = gets.chomp
    if user_input == "yes"
      puts "                     "
      list
    elsif user_input == "no"
      exit
    else
      puts "Sorry, I didn't understand that entry.".colorize(:red)
      list_again?
    end
  end

end
