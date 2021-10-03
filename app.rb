# roda applicaiton
require_relative "env"

class App < Roda
  plugin :render, engine: "haml"
  plugin :public
  plugin :all_verbs
  plugin :json
  plugin :error_handler
  plugin :common_logger
  # plugin :assets, css: "style.css", js: "app.js"

  route do |r|
    r.root do
      poem = nil
      view "index", locals: { poem: poem }
    end

    r.on "poems" do
      r.post do
        bot = GPT3Poet.new
        poem = bot.poem
        view "index", locals: { poem: poem }
      end

      r.get do
        r.redirect "/"
      end
    end

    # TODO: add redis

    r.on "few-shots-add" do
      r.post do
        question = r.params["question"]
        answer = r.params["answer"]
        question = FewShotsAdd.new question: question, answer: answer
        view "question-added", locals: { question: question, answer: answer }
      end
    end

    r.on "text" do
      r.get "few-shots" do
        File.read "./public/text/few-shots.txt"
      end

      r.get "training-data" do
        File.read "./public/text/training-data.txt"
      end
    end

    r.public
  end
end
