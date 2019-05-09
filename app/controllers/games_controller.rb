require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @userInput = params["userInput"].upcase
    @letters = params["letters"].split(" ")
    if included?(@userInput, @letters)
      if english_word?(@userInput)
        @answer = "Congratulations, #{@userInput} is a valid English word!"
      else
        @answer = "SORRY but #{@userInput} does not seem to be a valid english word"
      end
    else
      @answer = "SORRY but #{@userInput} can't be built out of #{@letters}"
    end
  end

  def included?(userInput, letters)
    userInput.chars.all? { |letter| userInput.count(letter) <= @letters.count(letter) }
  end

  def english_word?(userInput)
      response = open("https://wagon-dictionary.herokuapp.com/#{@userInput}")
      json = JSON.parse(response.read)
    return json['found']
  end
end
