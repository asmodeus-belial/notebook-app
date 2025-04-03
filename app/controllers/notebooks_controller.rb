class NotebooksController < ApplicationController
  before_action :set_notebook, only: %i[ show edit update destroy ]

  def index
    @notebooks = Notebook.all
  end

  def show
  end

  def new
    @notebook = Notebook.new
  end

  def create
    @notebook = Notebook.new(notebook_params)
    if @notebook.save
      redirect_to @notebook, notice: "Notebook was successfully created!"
    else
      render :new
    end
  end

  def edit;end

  def update
    if @notebook.update(notebook_params)
      redirect_to @notebook, notice: "Notebook was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @notebook.destroy
    redirect_to notice: "Notebook was successfully deleted"
  end

  private

  def set_notebook
    @notebook = Notebook.find(params[:id])
  end

  def notebook_params
    params.require(:notebook).permit(:title, :description)
  end
end
