
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'restclient'

puts "Accessing NJT's server...this may take a moment...."

page = "https://dv.njtransit.com/webdisplay/tid-mobile.aspx?sid=HI"
page_getter = Nokogiri::HTML(open(page))

puts "Train data is up-to-date!"

local_page = "NJT Highland Avenue Departures.html"

# @get_local = Nokogiri::HTML(open(local_page))
@get_real = Nokogiri::HTML(open(page))

  def next_train

    tr = @get_real.css('tr')[3].text.split("\r\n").select {|x| x.length>0 && x!=" " }
    sta = @get_real.css('div')[0].text.split(" ")

    if tr[2] == 3
      dir = "west"
    else
      dir = "east"
    end

    binding.pry

    message = "The next train arriving at #{sta[0]} #{sta[1]} is the #{tr[0]} heading #{dir} and arriving on track #{tr[2]}."

    if tr.length == 6
      message = message+" The train will arrive #{tr[5]}."
    end

    puts message

  end

next_train

#---------NOTHING TO SEE HERE!---------#
# much love to http://ruby.bastardsbook.com/chapters/html-parsing/
