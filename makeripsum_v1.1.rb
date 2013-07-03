require 'twitter'

N_SENTENCES_PER_PARAGRAPH = 10
N_WORDS_PER_SENTENCE      = 10

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
Ipsum.new(2).paragraphs.each do |p|
  puts p
  puts
end

