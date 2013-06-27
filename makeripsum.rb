require 'twitter'

# general description

class Ipsum
  #----- Ipsum class info ------#

  # define ipsum dictionary as Ipsum class variable
  # we can seed once and keep accessing it rather
  # than loading it multiple times in our app
  @@ipsum = []

  # dictionary accessor
  def self.dictionary
    @@ipsum
  end

  # seed dictionary from text file
  def self.from_file(file)
    f = File.new(file, 'r')
    while line = f.gets
      @@ipsum += line.split(/\s+/)
    end
    f.close    
  end

  # add to dictionary from twitter
  # search from TheModernSonnyG account for
  # #makeripsim and @MakerSquare
  def self.from_twitter
    Twitter.configure do |config|
      config.consumer_key = ENV['YOUR_CONSUMER_KEY']
      config.consumer_secret = ENV['YOUR_CONSUMER_SECRET']
      config.oauth_token = ENV['YOUR_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['YOUR_OAUTH_TOKEN_SECRET']
    end

    Twitter.search("#makeripsum @MakerSquare").results.map do |status|
        # clean up the tweets a bit
        tweet = status.text.gsub(/[@#]\S+/,'') # remove @s and #s
        tweet.gsub!(/^\s+/,'')  # remove leading spaces
        tweet.gsub!(/\s+$/,'')  # remove trailing spaces
        @@ipsum.push(tweet)     # add normalized tweet to our dictionary
    end
  end

  #------ Ipsum instance info ------#
  def initialize
    # populate dictionary at Ipsum object creation
    Ipsum.from_file('ipsumrandomwords.txt')
    Ipsum.from_twitter
  end

  # Ipsum has paragraphs
  # generate n paragraphs/ipsum
  def paragraphs(n)
    paragraphs = Array.new(n) { |index|
      # var paragraphs is an array of strings (paragraphs)
      # where number of sentences/paragraph is selected randomly
      # in the range [10,12]
      Paragraph.new.sentences( rand(10..12) )
    }
    # return an array of strings (paragraphs)
  end
end

class Paragraph
  #-------- class info ----------#
  # N/A

  #------- instance info --------#
  # Paragraph has sentences
  # generate n sentences/paragraph
  def sentences(n)
    sentences = Array.new(n) { |index|
      # var sentences is an array of strings (sentences)
      # where words/sentence is selected randomly
      # in the range [10,15]
      Sentence.new.words( rand(10..15) )
    }
    sentences.join(' ') # return a string of sentences
  end
end


class Sentence
  #-------- class info ----------#
  # N/A

  #-------- instance info ----------#
  # Sentence has words
  # generate n words/sentence
  def words(n)
    words = Array.new(n) { |index|
      # var words is an array of strings (words)
      # select a word randomly from the ipsum dictionary
      Word.new
    }
    words[0].capitalize!               # capitalize first word of sentence
    words[-1] += %w{. ? !}[rand(0..2)] # add ending punctuation
    2.times {
      # add middle punctuation
      i = rand(0..words.count-2)
      words[i] += %w{, ; : \ - ...}[rand(0..4)] unless words[i].match(/[,;:\-.]$/)
      # unless => prevent multiple punctuation, e.g. ;,
    }
    words # return an array of strings (words)
  end
end

class Word
  #-------- class info ----------#
  def self.new
    Ipsum.dictionary[ rand( 0..Ipsum.dictionary.count-1 ) ]
    # return random word from the dictionary as a string
  end

  #-------- instance info ----------#
  # N/A
end


# --------- Main ---------- #

# promp user from CLI
puts "Welcome to TheMakerIpsum"
puts "How many paragraphs of MakerIpsum would you like?"
n = gets.chomp.to_i

# Ipsum.new.paragraphs(n) => array of n paragraphs
paragraphs = Ipsum.new.paragraphs(n)

# render to CLI
paragraphs.each { |p| puts p; puts }


#---- How to port to Rails -----#
# to render in rails, iterate over array of paragraphs
# <% Ipsum.new.paragraphs(n).each do |p| %>
#   <p><%= p %></p>
# <% end %>
