class CategoriesController < ApplicationController
  before_action :authorize!
  before_action :set_category, only: %i[ show edit update destroy ]
  #Callback que sirve para comprobar que el usuario utulizado tiene autorizacion para acceder a las categorias

  # GET /categories or /categories.json
  def index
    @categories = Category.all.order(name: :asc)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @category
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: "La categoria ha sido creada exitosamente" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_url, notice: "La categoria se ha actualizado exitosamente" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    #respond_to do |format|
    respond_to do |format|
      format.html { redirect_to categories_url, notice: "La caregoria ha sido eliminada exitosamente" }
    end
  end

  private  
  # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
