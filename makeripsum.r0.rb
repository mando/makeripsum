

class Word
  #Class info
  @@words = []

  def self.populate
    f = File.new('ipsumrandomwords.txt', 'r')
    while line = f.gets
      # puts "line class = #{line.class}"
      @@words += line.split(/\s+/)
    end
    f.close
  end

  def self.get
    puts @@words.class
    puts @@words.inspect
  end

  #Instance info
  def self.generate
    i=rand(@@words.count-1)
    @@words[i]
  end
end

class Sentence
  #Class info

  # Instance info
  # attr_accessor :min, :max

  def initialize(min,max)
    @min = min
    @max = max
  end

  def generate
    s = []
    s.push(Word.generate.capitalize, ' ')
    rand(@min-1..@max-1).times { s.push(Word.generate, ' ') }
    s.pop
    1.times {
      p = rand(15..25)
      s[p] += %w(, ; \ - :)[rand(0..3)] unless s[p] == ' '
    }
    s[-1] += %w(. ? !)[rand(0..2)]
    s.push(' ')
    s
  end

end

class Paragraph
  # Class info

  # Instance info
  def initialize(min,max)
    @min = min
    @max = max
    @words =[]
  end

  def generate
    @words = []
    rand(@min..@max).times { @words += Sentence.new(15,20).generate }
    self
  end

  def write
    while @words.count > 0
      if @words.count == 1
        break
      end
      print @words.shift
    end
    print "\n"

  end

end

# --------- MAIN ------------


Word.populate
# Word.get


puts "Welcome to MakerIpsum."
puts "How many paragraphs would you like?"
n_paragraphs = gets.chomp.to_i

n_paragraphs.times {
  n_paragraphs -= 1
  p = Paragraph.new(13,16).generate
  p.write
  print "\n" if n_paragraphs > 0
}
# puts p.class
# puts p.inspect

# s = Sentence.new(15,20).generate
# puts s.class
# puts s.inspect


#We need to prompt the user for x number of paragraphs.
#Generate paragraphs.


# a = ['zero', one','two','three','four']
# a[2] => 'two'

# n = 0
# s = 0
# # Let's figure out how to set x amount of words per line then break
# #it. :)
# num_of_lines = rand (4..6)
# while n < num_of_lines
#   while s >= rand 
#     n += 1
#     rand(4..6).times { puts Sentence.new.generate(6,10) }
#     puts 
 
#   end
# end

