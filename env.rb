# require bundler

Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8

require "bundler/setup"
Bundler.require :default

PATH = File.expand_path "../", __FILE__

unless ENV["DOCKER"] == "1"
  require_relative "env_secret"
else
  OPENAI_TOKEN = ENV["OPENAI_TOKEN"]
end

require_relative "lib/monkeypatches"
require_relative "lib/gpt3_davinci"
require_relative "lib/gpt3_poet"

def load_few_shots_text
  text = File.read "#{PATH}/few_shots_learning_text.txt"
  text.strip
end

FEW_SHOTS_TEXT = load_few_shots_text

OPENAI_TOKEN
