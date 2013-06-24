class Word
  #Class info
  @@words = ['zero', 'one','two','three','four']

  #Instance info
  def self.generate
    i=rand(@@words.count-1)
    @@words[i]
  end
end

class Sentence
  #Class info

  #Instance info
  def generate (n)
    s = []
    n.times { s.push(Word.generate) }
    s.join(" ")
  end
end

class Paragraph
end

#We need to prompt the user for x number of paragraphs.
#Generate paragraphs.


# a = ['zero', one','two','three','four']
# a[2] => 'two'

puts Sentence.new.generate(5)