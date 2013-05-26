#!/usr/bin/env ruby

require 'rubygems'
require 'trello'

include Trello
include Trello::Authorization

########################################################################
# Begin Configuration
########################################################################

# You can get you Trello public and secret keys by going to:
#     https://trello.com/1/appKey/generate
#
publicKey = ""
secretKey = ""

# Use the following URL to generate your OAuth token
#  https://trello.com/1/connect?key=__YOUR_PUBLIC_KEY__&name=RSTrelloStatusBoard&response_type=token&scope=read&expiration=never
#
oAuthToken = ""

# The boards array allows you to generate JSON files for multiple Trello boards. Each item is a hash with the key/value pairs below:
#
# boardID:
#     You can find the ID of each of your boards by using the find_board_ids method
# graphTitle:
#     The title of the graph. It will be displayed as: "YOUR TITLE - Trello"
# graphColor:
#     Color values can be: yellow, green, red, purple, blue, mediumGray, pink, aqua, orange, or lightGray.
# outputFile:
#     File path to save the JSON data to. Using Dropbox is the simplest way to create a shareable URL.
#
boards = [
      {
         :boardID    => "",
         :graphTitle => "",
         :graphColor => "green",
         :outputFile => "#{Dir.home}/Dropbox/Status\ Board/trello.json"
      }
   ]

########################################################################
# END Configuration
########################################################################

def find_board_ids()
   me = Member.find("me")
   me.boards.each do |b|
      puts "#{b.id} - #{b.name}"
   end
end

########################################################################

Trello::Authorization.const_set :AuthPolicy, OAuthPolicy

OAuthPolicy.consumer_credential = OAuthCredential.new(publicKey, secretKey)
OAuthPolicy.token = OAuthCredential.new(oAuthToken, nil)

boards.each do |boardInfo|
   board = Board.find(boardInfo[:boardID])

   dataPoints = []

   board.lists.each do |list|
      dataPoints << { :title => list.name, :value => list.cards.count }
   end

   graph = {
      :graph => {
         :title => "Trello",
         :type => "bar",
         :xAxis => {
            :showEveryLabel => "true"
         },
         :yAxis => {
            :hide => boardInfo[:hideYAxisTotals],
         },
         :datasequences => [
            {
               :title => boardInfo[:graphTitle],
               :color => boardInfo[:graphColor],
               :datapoints => dataPoints
            }
         ]
      }
   }

   File.open(boardInfo[:outputFile], "w") do |f|
      f.write(graph.to_json)
   end
end
