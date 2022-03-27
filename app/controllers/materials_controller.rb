class MaterialsController < ApplicationController
  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)

    if @material.save
      flash[:notice] = "Material created."
      redirect_to materials_path
    else
      render :new
    end
  end

  def index
    @materials = Material.order(:name).page params[:page]
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])

    if @material.update(material_update_params)
      flash[:notice] = "Material edited."
      redirect_to materials_path
    else
      render :edit
    end
  end

  private

  def material_params
    params.require(:material).permit(:name, :description, :quantity)
  end

  def material_update_params
    params.require(:material).permit(:name, :description)
  end
end
