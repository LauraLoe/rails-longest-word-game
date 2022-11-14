class GamesController < ApplicationController

  def new
    charset = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << charset.sample
    end
  end

  def score
    if word_from_grid?(params[:letters].split, params[:word]) & valid?(params[:word])
      @result = "Congratulations! #{params[:word]} is a valid English word!"
    elsif word_from_grid?(params[:letters].split, params[:word]) & !valid?(params[:word])
      @result = "Sorry but #{params[:word]} does not seem to be a valid English word.."
    else
      @result = "Sorry but #{params[:word]} can't be built out of #{params[:letters]}"
    end
  end

  private

  def word_from_grid?(grid, word)
    check = true
    word.chars.each do |char|
      grid.include?(char.upcase) ? grid.delete_at(grid.index(char.upcase)) : check = false
    end
    return check
  end

  def valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    result = JSON.parse(word_serialized)
    result['found']
  end

end
