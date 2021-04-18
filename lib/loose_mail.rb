require_relative 'loose_mail/version'
require 'mail'
require 'mail/parser_tools'

module LooseMail
  ENCODED_VALUE = /\A=\?([^?]+)\?([QB])\?([^?]*)\?=\z/i

  def self.decode_words(words)
    results = []
    while (word = words.shift)
      if (m = word.match(ENCODED_VALUE))
        charset = m[1].downcase
        word = decode_data(m[2], m[3])
        while (m = words.first&.match(ENCODED_VALUE)) && m[1].downcase == charset
          word.concat decode_data(m[2], m[3])
          words.shift
        end
        word = Mail::Ruby19.charset_encoder.encode(word, charset).encode(Encoding::UTF_8, undef: :replace, invalid: :replace)
      end
      results.push word
    end
    results.join
  end

  def self.decode_data(type, data)
    case type
    when 'q', 'Q' then data.gsub(/_/, ' ').unpack1('M')
    when 'b', 'B' then data.unpack1('m')
    end
  end
end

module Mail
  module Encodings
    def self.value_decode(str)
      return str unless str.match? ENCODED_VALUE
      words = collapse_adjacent_encodings(str)
      LooseMail.decode_words(words)
    end
  end

  module ParserTools
    def chars(data, from_bytes, to_bytes)
      s = data.slice(from_bytes..to_bytes)
      if from_bytes != 0 && data[from_bytes - 1] == '"' && data[to_bytes + 1] == '"' # quoted string
        s.gsub!(/\\(.)/) { $1 }
      end
      s.force_encoding(Encoding::UTF_8)
    end
  end

  class Ruby19
    class << self
      alias orig_pick_encoding pick_encoding
      def pick_encoding(charset)
        charset = 'cp50221' if charset =~ /\Aiso-2022-jp/i
        orig_pick_encoding(charset)
      end
    end
  end
end
