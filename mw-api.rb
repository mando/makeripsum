require 'http_request'

puts HttpRequest.get('https://github.com').body

puts HttpRequest.get('http://www.dictionaryapi.com/api/v1/references/collegiate/xml/test?key=0c1eddc2-cb46-4433-a396-b7ae96e18e4c').body
