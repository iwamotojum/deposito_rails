class MaterialsController < ApplicationController
  before_action :find_material!, except: [:index, :new, :create]

  attr_accessor :material

  def index
    @q = Material.ransack(params[:q])
    @materials = @q.result(distinct: true).page(params[:page]).order(:name)
  end

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

  def edit
    @material = material
  end

  def update
    if material.update(material_update_params)
      flash[:notice] = "Material edited."
      redirect_to materials_path
    else
      render :edit
    end
  end

  def destroy
    if !material.material_logs.empty?
      flash[:alert] = "Material has input/output log, so can't be deleted." 
      render :index
    else
      material.destroy!
      flash[:notice] = "Material deleted succesfully."
      redirect_to materials_path
    end
  end
  
  def add
    @material = material
  end
  
  def input
    if material.update_quantity!("input", material_change_quantity_params[:quantity], current_user)
      flash[:notice] = "Material inputed."
      redirect_to materials_path
    else
      render :add
    end
  end
  
  def remove
    @material = material
  end
  
  def output
    if material.update_quantity!("output", material_change_quantity_params[:quantity], current_user)
      flash[:notice] = "Material outputed."
      redirect_to materials_path
    else
      render :remove
    end
  end

  def logs
    @material = material
    @logs = material.material_logs
  end

  private

  def find_material!
    @material = Material.find(params[:id])
  end

  def material_params
    params.require(:material).permit(:name, :description, :quantity)
  end

  def material_update_params
    params.require(:material).permit(:name, :description)
  end

  def material_change_quantity_params
    params.require(:material).permit(:quantity)
  end
end
