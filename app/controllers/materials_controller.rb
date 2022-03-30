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
      flash[:success] = "Material created."
      redirect_to materials_path
    else
      flash[:danger] = "#{error_messages(@material.errors.full_messages)}"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @material = material
  end

  def update
    if material.update(material_update_params)
      flash[:success] = "Material edited."
      redirect_to materials_path
    else
      flash[:danger] = "#{error_messages(@material.errors.full_messages)}"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if material.material_logs.empty?
      material.destroy!
      flash[:success] = "Material deleted succesfully."
      redirect_to materials_path
    else
      flash[:danger] = "Material has input/output log, so can't be deleted." 
      redirect_back(fallback_location: root_path)
    end
  end
  
  def add
    @material = material
  end
  
  def input
    if material.update_quantity!("input", material_change_quantity_params[:quantity], current_user)
      flash[:success] = "Material inputed."
      redirect_to materials_path
    else
      flash[:danger] = "#{error_messages(@material.errors.full_messages)}"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def remove
    @material = material
  end
  
  def output
    if material.update_quantity!("output", material_change_quantity_params[:quantity], current_user)
      flash[:success] = "Material outputed."
      redirect_to materials_path
    else
      flash[:danger] = "#{error_messages(@material.errors.full_messages)}"
      redirect_back(fallback_location: root_path)
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
