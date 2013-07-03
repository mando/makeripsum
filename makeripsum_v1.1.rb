require 'twitter'

class Ipsum
  # class info

  # instance info
  attr_reader :paragraphs

  def initialize(n_paragraphs)
    Dictionary.from_file('ipsumrandomwords.txt')

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
    @text = Sentence.new(5).text
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

  def self.words
    @@words
  end

  def self.n_words
    @@words.count
  end

  # instance info
end

#------------ Main -------------#

# puts Ipsum.new(3).paragraphs
puts Ipsum.new(3).paragraphs

