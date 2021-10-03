require_relative "../env"

class GPT3Poet
  ENGINE = "davinci" # text generation / compleition / conversation
  # ENGINE = "davinci-codex" # code generation / stackoveflow-like answers / code completion

  # usage: GPT3Poet.new.poem
  # => "Nel mezzo del cammin..."

  def initialize
    # ...
  end

  def poem
    text = FEW_SHOTS_TEXT
    openai_generate_text text: text
  end

  private

  def openai_generate_text(text:)
    resp = GPT3Davinci.new(input: text)
    p resp
    resp = resp.complete
    p resp
    resp
  end

  def format_msg(msg:)
    lines = msg.split "\n"
    strip_lines lines: lines
  end

  def strip_lines(lines:)
    lines.map do |line|
      line.strip
    end.join "\n"
  end
end

if __FILE__ == $0
  # ...
end
