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

n = 0
s = 0
# Let's figure out how to set x amount of words per line then break
#it. :)
num_of_lines = rand (4..6)
while n < num_of_lines
  while s >= rand 
    n += 1
    rand(4..6).times { puts Sentence.new.generate(6,10) }
    puts 
 
  end
end

