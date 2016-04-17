class FruitsController < ApplicationController
  before_action :set_fruit, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @fruits = Fruit.all
    respond_with(@fruits)
  end

  def select
    @fruit = Fruit.all[params["index"].to_i]
    respond_with(@fruit)
  end

  def show
    respond_with(@fruit)
  end

  def new
    @fruit = Fruit.new
    respond_with(@fruit)
  end

  def edit
  end

  def create
    @fruit = Fruit.new(fruit_params)
    @fruit.save
    redirect_to fruits_path
  end

  def update
    @fruit.update(fruit_params)
    redirect_to fruits_path
  end

  def destroy
    @fruit.destroy
    respond_with(@fruit)
  end

  private
    def set_fruit
      @fruit = Fruit.find(params[:id])
    end

    def fruit_params
      params.require(:fruit).permit(:texto, :maximo_tiempo, :numero_frutas, :code, :items_life)
    end
end
