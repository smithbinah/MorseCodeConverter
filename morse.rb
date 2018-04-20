class Morse
  def self.initialize(encode_or_decode, file_prefix)
    file_name = file_prefix + ".txt"
    file_location = File.join(File.dirname(__FILE__), "#{file_name}")
    controller = Controller.new()
    if encode_or_decode.downcase == "encode"
      is_encoding = true
    elsif encode_or_decode.downcase == "decode"
      is_encoding = false
    end
    if is_encoding
      self.encode(is_encoding, controller, file_location,file_name)
    else
      self.decode(is_encoding, file_location, controller,file_name)
    end
  end

  def self.encode(encoding, controller, file_location,file_name)
    file_contents = read_file(encoding, file_location,file_name)
    puts "str value: #{file_contents.to_s}"
    result = controller.translate_encode(file_contents)
    self.write_file(result, encoding)
    puts "Translated Message: #{result}"
  end

  def self.decode(encoding, file_location, controller,file_name)
    file_contents = read_file(encoding, file_location,file_name)
    puts "str value: #{file_contents.to_s}"
    result = controller.translate_decode(file_contents)
    puts "Translated Message: #{result}"
    self.write_file(result, encoding)
  end

  def self.read_file(encoding, file_location,file_name)
    case encoding
    when true
      temp_str = ""
      file_contents = File.open(file_name, "r")
      file_contents.each_line { |x|
        temp_str << x
      }
      file_contents = temp_str
    when false
      puts "not encoding"
      temp_str = ""
      file_contents = File.open("preamble_encode.txt", "r")
      file_contents.each_line { |x|
        temp_str << x
      }
      file_contents = temp_str
    else
      puts "wrong input"
    end
    file_contents
  end

  def self.write_file(input, encoding)
    File.open( encoding ? "preamble_encode.txt" : "preamble_decode.txt", "w") { |x|
      x.puts input
    }
  end
end

class Controller
  attr_accessor :dictionary, :morseString

  def initialize()
    @dictionary = Dictionary.new()
    @morseString = String.new()
  end

  def translate_encode(message)
    message = convertToString(message)
    message.each_char { |x|
      convertCharToMorse(x)
    }
    @morseString
  end

  def translate_decode(message)
    word_arr = split_into_words(message.chomp)
    temp_holder = " "
    word_arr.each { |x|
      char_array = x.split(" ").to_a
      @morseString << convert_char_to_plain_text(char_array)
    }
    @morseString
  end

  def split_into_words(message)
    message.split("  ").to_a
  end

  def split_into_characters(message)
    message.split(" ").to_a
  end

  def convertCharToMorse(character)
    if character =~ /\s/
      @morseString << "  "
    else
      @morseString << " #{dictionary.accessDictionary(character)}"
    end
  end

  def convert_char_to_plain_text(character)
    encoding = false
    character_new = dictionary.accessDictionary(character, encoding)
    character_new
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
  attr_accessor :morseAlphabet, :testHash

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

  def accessDictionary(args, encoding = true)
    results = " "
    if encoding
      results = @morseAlphabet[args]
    else
      args.each { |x|
        results << "#{@morseAlphabet.key(x)}"
      }
    end
    if !encoding
      results + " "
    end
    results
  end

  def test
    testHash[1]
  end

  def to_s
    "Dictionary stuff Here"
  end
end

encode_or_decode, file_prefix = ARGV
Morse.initialize(encode_or_decode, file_prefix)
# puts "Press enter to continue"
 