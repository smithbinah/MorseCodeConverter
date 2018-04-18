class Morse
  attr_accessor :controller, :test_str
  def initialize()
    @test_str = "We the People of the United States, in Order to form a more perfect Union, establish Justice, insure domestic Tranquility, provide for the common defence, promote the general Welfare, and secure the Blessings of Liberty to ourselves and our Posterity, do ordain and establish this Constitution for the United States of America."
    @controller = Controller.new()
  end

  def encode
    result = @controller.translate_encode(@test_str)
    write_file(result)
  end

  def decode
  end

  def read_file
  end

  def write_file(input)
    open('preamble_decode.txt')
  end
end

class Controller
  attr_accessor :dictionary
  attr_accessor :morseString

  def initialize()
    @dictionary = Dictionary.new()
    @morseString = String.new()
    run
  end

  def run
    loop do
      userinput = promptForInput()
      @morseString = ""
      puts "Translated Message: #{translate_encode(userinput)}"
    end
  end

  def translate_encode(message)
    message = convertToString(message)
    message.each_char { |x|
      convertCharToMorse(x)
    }
    @morseString
  end

  def convertCharToMorse(character)
    if character =~ /\s/
      @morseString << "  "
    else
      @morseString << " #{dictionary.accessDictionary(character)}"
    end
  end

  def convertToString(message)
    stringInput = convertToUsable(message.chomp.to_s)
  end

  def convertToUsable(message)
    stringInput = message.upcase
  end

  def promptForInput()
    puts "Enter text to be translate_encoded into Morse Code."
    input = gets
  end

  def to_s
    "Input stuff Here"
  end
end

class Dictionary
  attr_accessor :morseAlphabet
  attr_accessor :testHash

  @testHash = {1 => "one"}

  def initialize()
    @morseAlphabet = Hash[
      "A" => ".-",
      "B" => "-...",
      "C" => "-.-.",
      "D" => "-..",
      "E" => ".",
      "F" => "..-.",
      "G" => "--.",
      "H" => "....",
      "I" => "..",
      "J" => ".---",
      "K" => "-.-",
      "L" => ".-..",
      "M" => "--",
      "N" => "-.",
      "O" => "---",
      "P" => ".--.",
      "Q" => "--.-",
      "R" => ".-.",
      "S" => "...",
      "T" => "-",
      "U" => "..-",
      "V" => "...-",
      "W" => ".--",
      "X" => "-..-",
      "Y" => "-.--",
      "Z" => "--..",
      "1" => ".----",
      "2" => "..---",
      "3" => "...--",
      "4" => "....-",
      "5" => ".....",
      "6" => "-....",
      "7" => "--...",
      "8" => "---..",
      "9" => "----.", "0" => "-----"
    ]
  end

  #   def accessDictionary(.args)
  #     case args.size
  #     when 1
  #       placeholder = morseAlphabet[args[0]]
  #     when 2
  #     end
  #     output = placeholder
  #   end
  def accessDictionary(args)
    @morseAlphabet[args]
  end

  def test
    testHash[1]
  end

  def to_s
    "Dictionary stuff Here"
  end
end

controller = Controller.new()
