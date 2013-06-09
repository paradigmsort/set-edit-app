class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(params[:card])
    if @card.save
      flash[:success] = "Added " + @card.name
      redirect_to @card
    else
      render 'new'
    end
  end

  def show
    @card = Card.find(params[:id])
  end
end
