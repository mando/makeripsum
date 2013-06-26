class Ipsum
  # class info

  # instance info
  # has paragraphs

  def paragraphs(n)
    # generate n paragraphs
    paragraphs = Array.new(n) { |index|
      Paragraph.new.sentences( rand(15..20) )
    }
  end

end

class Paragraph
  # class info

  # instance info
  # has sentences
  def sentences(n)
    # generate n sentences
    sentences = Array.new(n) { |index|
      Sentence.new.words( rand(10..15) )
    }
    sentences.join(' ')
  end

end

class Sentence
  # class info

  # instance info
  # has words

  def words(n)
    # generate n sentences
    words = Array.new(n) { |index|
      Word.new
    }
    words[0].capitalize!               # capitalize first word
    words[-1] += %w{. ? !}[rand(0..2)] # add ending punctuation
    2.times {
      # add middle punctuation
      words[rand(0..words.count-2)] += %w{, ; : \ - ...}[rand(0..4)]
    }
    words
  end
end

class Word
  # class info
  @@words = []
  f = File.new('ipsumrandomwords.txt', 'r')
  while line = f.gets
    @@words += line.split(/\s+/)
  end
  f.close

  def self.new
    @@words[ rand( 0..@@words.count-1 ) ]
  end

  # instance info
  # is an array of random words

  def to_s
    @word
  end
end


# --------- Main ---------- #

# Ipsum.new.paragraphs(n) => array of n paragraphs
paragraphs = Ipsum.new.paragraphs(2)

# render to console
paragraphs.each { |p| puts p; puts }

# to render in rails, iterate over array of paragraphs
