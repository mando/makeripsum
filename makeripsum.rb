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
  def generate (min, max)
    s = []
    s.push(Word.generate.capitalize)
    rand(min-1..max-1).times { s.push(Word.generate) }
    s.join(" ") + "." 
  end
end

class Paragraph
end

#We need to prompt the user for x number of paragraphs.
#Generate paragraphs.


# a = ['zero', one','two','three','four']
# a[2] => 'two'

10.times { puts Sentence.new.generate(6,10) }

