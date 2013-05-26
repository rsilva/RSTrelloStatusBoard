# Trello Status Board

This script generates a bar graph for the number of cards in each list of a Trello board. The generated JSON file is to be used with Panic's [Status Board](http://panic.com/statusboard/).

## Installation

1. Clone this `RSTrelloStatusBoard` repo somewhere.
2. Open Terminal and navigate to the location chosen in step 1.
3. Install the required gems via Bundler (`bundle install`) or individually (`gem install ruby-trello`)
4. Open `trello_status_board.rb` and adjust the values inside the configuration block.
5. Open `trello_status_board.sh` and update the path to the `trello_status_board.rb` script to match where you've installed it. Optionally, uncomment the `export` line if you use `rbenv`
6. Open `com.rickjsilva.rstrellostatusboard.plist` and update its `ProgramArguments` value to match where you are storing the `trello_status_board.sh` file you updated in step 5.
7. Copy `com.rickjsilva.rstrellostatusboard.plist` to `~/Library/LaunchAgents/`
8. Open Termimal and run `launchctl load ~/Library/LaunchAgents/com.rickjsilva.rstrellostatusboard.plist`. This should generate the first version of your JSON file.
9. Go to Dropbox, get a shareable link for the JSON file and add it to Status Board on your iPad.

## Contact

[Rick Silva](http://rickjsilva.com) ([@rjsmsu](https://twitter.com/rjsmsu))

## License

This project is licensed under the terms of the MIT License.
