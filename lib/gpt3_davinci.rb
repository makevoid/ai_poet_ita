class GPT3Davinci
  attr_reader :input

  ENGINE = "davinci" # text generation
  # ENGINE = "davinci-codex" # code generation / stackoveflow-like answers / code completion

  # MAX_TOKENS = 110 # too short - but could be shorter to generate single sentence poems such as - common: `m'illumino d'immenso` or generated: `venite signori si fa tardi a cena` - `la tavola e' in festa, e che festa!` - `azzurro l'autunno io giungo e ti pungo` - `piro piro piro lo - quest'anno forse non ti porto no!` - `vai e vai assai ma mai, avresti pensato che l'universo e' tal`
  MAX_TOKENS = 125
  # MAX_TOKENS = 150 # more like haikus

  STOP_TOKENS = [ # TODO: extract as options
    "\nPoesia:",
    "...\n",
    ".\n",
    "\n\n"
  ]

  def initialize(input:)
    @input = input
  end

  def complete
    bot_api = OpenAI::Client.new access_token: OPENAI_TOKEN
    # puts "Input Text"
    # p input
    # puts "---------"
    response = bot_api.completions(
      engine:     ENGINE,
      parameters: {
        prompt:            input,
        max_tokens:        MAX_TOKENS,
        stop:              STOP_TOKENS,
        # opts:
        temperature:       0.81,
        top_p:             1,
        frequency_penalty: 0,
        presence_penalty:  0.37,
      }
    )
    resp = response.body
    resp = JSON.parse resp
    resp = resp.f "choices"
    resp = resp.f 0
    resp = resp.f "text"
    puts "RESP:"
    p resp
    resp
  end
end
