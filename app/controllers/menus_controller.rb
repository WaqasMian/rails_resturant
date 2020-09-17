class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy, :remove, :add, :post_add]
  before_action :authenticate_user!, only: [:edit, :update, :new, :create, :destroy, :show, :add, :remove]
  before_action :is_admin?, only: [:edit, :update, :new, :create, :delete, :add, :remove]
  layout :choose_layout 

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  def add
    @dishes = Dish.all
  end

  def post_add
    @ndish = Dish.find_by(name: params[:dishes][:name])
    if @ndish
      @menu.dishes << @ndish
      @menu.save
      redirect_to @menu, notice: 'A New Dish added in menu'
    else
      redirect_to @menu, notice: "No dish added as dish #{params[:dishes][:name]} doesnt, exists"
    end

    
  end
 
  def remove
    dish_id = params[:dish_id]
    @dish_rem = Dish.find_by(id:dish_id)
    @menu.dishes.delete(@dish_rem)

    redirect_to @menu
  end 
 

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url, notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_params
      params.require(:menu).permit(:name)
    end

    def choose_layout
      if current_user && current_user.admin?
        "admin"
      elsif current_user
        "manager"
      else
        "application"
      end
    end

    def is_admin?
      redirect_to root_path unless current_user.admin?
    end

end
