# RESTful API for implementing page configurator


Developed using Ruby 2.2.3


Installing dependencies:

Make sure you have ruby installed (go here for installation information for your specific system: https://www.ruby-lang.org/en/documentation/installation/)

Bundler is a a useful Ruby package manager that I recommend you install. To install bundler, in a terminal window run:

	$ gem install bundler

To install the required Gems, from the root project directory run:

	$ bundle install


Running the program:

From the root project directory run:

	$ rackup config.ru

You can then navigate to localhost:9292/ and other available pages of the webapp to test the API's usage.


Running the tests:

From the root project directory run:

	$ rspec --format doc


Overview:

The API implements all of the required web services that should be needed.

The unit tests can all be ran using rspec as described above.

A basic authorization has been implemented to protect all available routes provided by the API. I would have liked to implement a more complex solution to this and only protect the methods which could modify the contents (i.e. the put and delete requests).