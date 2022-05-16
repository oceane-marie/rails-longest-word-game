require 'json'

class GamesController < ApplicationController
  def new
    # to display a new random grid and a form
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # The form will be submitted (with POST)
    @letters = params[:letters].split
    @word = params[:answer].split('')
    @included = included?(@word, @letters)
    @english = english?(@word)
  end

  private

  def included?(word, letters)
    word.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
