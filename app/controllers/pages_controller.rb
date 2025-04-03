class PagesController < ApplicationController
  before_action set_page, only: %i[show edit update destroy]
  before_action set_notebook only: %i[ index create new ]

  def index
    if @notebook
      @pages = @notebook.pages
    else
      @pages = Page.all
    end
  end

  def show
  end

  def new
    if @notebook
      @page = @notebook.page.build
    else
      @page = Page.new
    end
  end

  def create
    if @note_book
      @page = @note_book.page.build
    else
      @page = Page.new
    end
    if @page.save
      redirect_to @page, notice: "Page was successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to @page, notice: "Page was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    notebook = @page.notebook
    @page.destroy
    if notebook 
      redirect_to notebook_path(notebook), notice: "Page was successfully deleted"
    else
      redirect_to pages_path(page), notice: "Page was successfully deleted"
    end
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def set_notebook
    @note_book = Notebook.find(params[:notebook_id]) if params[:notebook_id]
  end

  def page_params
    params.require(:page).permit(:title, :content, :emoji_category)
  end
end
