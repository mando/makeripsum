require 'twitter'

N_SENTENCES_PER_PARAGRAPH = 10
N_WORDS_PER_SENTENCE      = 10

class Ipsum
  # class info

  # instance info
  attr_reader :paragraphs

  def initialize(n_paragraphs)
    Dictionary.from_file('ipsumrandomwords.txt')
    Dictionary.from_twitter

    @paragraphs = []
    n_paragraphs.times {
      paragraphs.push(Paragraph.new.text)
    }
  end
end

class Paragraph
  # class info

  # instance info
  attr_reader :text

  def initialize
    @paragraph_array = []
    N_SENTENCES_PER_PARAGRAPH.times {
      @paragraph_array.push(Sentence.new(N_WORDS_PER_SENTENCE).text)
    }
  end

  def text
    @paragraph_array.join(' ')
  end
end

class Sentence
  # class info

  # instance info
  attr_reader :text

  def initialize(n_words)
    @sentence_array = []
    n_words.times {
      @sentence_array.push(Dictionary.words[ rand( 0..Dictionary.n_words-1 ) ])
    }
    normalize
  end

  def normalize
    @sentence_array[0].capitalize!
    @sentence_array[-1] += %w{. ? !}[rand(0..2)]
    2.times {
      i = rand(0..@sentence_array.count-2)
      @sentence_array[i] += %w{, ; : \ - ...}[rand(0..4)] unless @sentence_array[i].match(/[,;:\-.]$/)
      # unless => prevent multiple punctuation, e.g. ;,
    }    
  end

  def text
    @sentence_array.join(' ')
  end
end

class Dictionary
  # class info
  def self.from_file(file)
    @@words = []
    f = File.new(file, 'r')
    while line = f.gets
      @@words += line.split(/\s+/)
    end
    f.close
    @@words
  end

  def self.from_twitter
    Twitter.configure do |config|
      config.consumer_key = ENV['YOUR_CONSUMER_KEY']
      config.consumer_secret = ENV['YOUR_CONSUMER_SECRET']
      config.oauth_token = ENV['YOUR_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['YOUR_OAUTH_TOKEN_SECRET']
    end

    Twitter.search("@MakerSquare -rt").results.map do |status|
      # clean up the tweets a bit
      tweet = status.text.gsub!(/[@#]\S+/,'') # remove @s and #s
      tweet.gsub!(/\s+/,' ')
      tweet.gsub!(/http\S+/,'')
      tweet.gsub!(/RT/,'')
      tweet.gsub!(/\&\S+/,'')
      tweet.gsub!(/^\s+/,'')  # remove leading spaces
      tweet.gsub!(/\s+$/,'')  # remove trailing spaces
      @@words.push(tweet)     # add normalized tweet to our dictionary
    end
  end


  def self.words
    @@words
  end

  def self.n_words
    @@words.count
  end

  # instance info
end

#------------ Main -------------#

puts "Welcome to TheMakerIpsum"
puts "How many paragraphs of MakerIpsum would you like?"
n = gets.chomp.to_i

Ipsum.new(n).paragraphs.each do |p|
  puts p
  puts
end

#---- How to port to Rails -----#
# to render in rails, iterate over array of paragraphs
# <% Ipsum.new(n).paragraphs.each do |p| %>
#   <p><%= p %></p>
# <% end %>