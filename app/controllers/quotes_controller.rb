class QuotesController < ApplicationController
  before_action :quote, only: [:show, :edit]

  def index
    @quotes = Quote.all
  end

  def show; end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      redirect_to quotes_path, notice: "Quote was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if quote.update(quote_params)
      redirect_to quotes_path, notice: "Quote was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    quote.destroy
    redirect_to quotes_path, notice: "Quote was successfully destroyed."
  end

  private

  def quote
    @quote ||= Quote.find(params[:id])
  end

  def quote_params
    @quote_params ||= params.require(:quote).permit(:name)
  end
end
