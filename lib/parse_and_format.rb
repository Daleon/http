require 'socket'

module ParseAndFormat
  def debugger(lines)
    info = assign_to_debugger(lines)
    format_output(info)
  end

  def assign_to_debugger(lines)
    output = {}
    lines.each do |line|
      if line.include?('HTTP')
        output[:Verb] = line[0...line.index('/')].strip
        output[:Path] = line[line.index('/')...line.index('HTTP')].strip
        output[:Protocol] = line[-8..-1]
      elsif line.include?('Host')
        output[:Host] = line.split(':')[1].strip
        output[:Port] = line.split(':')[2]
        output[:Origin] = `ipconfig getifaddr en0`.chomp.to_s
      end
      if line.include?('Accept:')
        output[:Accept] = line.split(':')[1].strip
      end
      if line.include?('Content-Length')
        output[:Content_Length] = line.split(':')[1].strip
      end
    end
    output
  end

  def format_output(output)
    output.to_a.map do |key, value|
      "#{key}: #{value}"
    end.join("\n")
  end

  def requested_path(lines)
    info = assign_to_debugger(lines)
    info[:Path]
  end

  def check_type_of_request(lines)
    info = assign_to_debugger(lines)
    info[:Verb]
  end

  def find_content_length(lines)
    info = assign_to_debugger(lines)
    info[:Content_Length].to_i
  end

  def read_from_post_request(client, content_length)
    client.read(content_length)
  end

  def word_search(word)
    word_file = File.readlines('/usr/share/dict/words')
    dictionary = word_file.map do |word|
      word.downcase.rstrip
    end
    if dictionary.include?(word)
      "a known"
    else
      "not a known"
    end
  end

  def find_word(lines)
    requested_path(lines)[18..-1]
  end
end
