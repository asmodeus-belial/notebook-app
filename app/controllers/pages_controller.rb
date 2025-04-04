class PagesController < ApplicationController
  before_action :set_page, only: %i[show edit update destroy]
  before_action :set_notebook, only: %i[index create new]

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
    emoji_category
    if @notebook
      @page = @notebook.page.build
    else
      @page = Page.new
    end
  end

  def create
    if @notebook
      @page = @notebook.page.build(page_params)
    else
      @page = Page.new(page_params)
    end

    if @page.save
      redirect_to @page, notice: "Page was successfully created"
    else
      render :new
    end
  end

  def edit
    emoji_category
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
      redirect_to pages_path, notice: "Page was successfully deleted"
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
    params.require(:page).permit(:title, :context, :emoji_category, :notebook_id)
  end
  def emoji_category
    response_emoji = HTTParty.get("https://emojihub.yurace.pro/api/all")
    @response_emoji = JSON.parse(response_emoji.body)
    # @categories = @_response["categories"]
    @categories = @response_emoji.map { |emoji| emoji["category"] }.uniq
  end
end
