class ZombiesController < ApplicationController
  # GET /zombies
  # GET /zombies.json
  def index
    @zombies = Zombie.includes(:brain).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @zombies }
    end
  end

  # GET /zombies/1
  # GET /zombies/1.json
  def show
    if !Zombie.exists?(params[:id])
      redirect_to new_zombie_path
      flash[:error] = "User not found"
    else
      @zombie = Zombie.find(params[:id])
      @roles = @zombie.roles.map { |role| "#{role.title}"}
      @roles_choice = Roles.where('title not in (?)',@zombie.roles.map { |role| "#{role.title}"})
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @zombie }
      end
    end
  end

  # GET /zombies/new
  # GET /zombies/new.json
  def new
    @zombie = Zombie.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @zombie }
    end
  end

  # GET /zombies/1/edit
  def edit
    @zombie = Zombie.find(params[:id])
  end

  # POST /zombies
  # POST /zombies.json
  def create
    @zombie = Zombie.new(params[:zombie])

    respond_to do |format|
      if @zombie.save
        flash[:success] = 'Zombie was successfully created.'
        format.html { redirect_to @zombie }
        format.json { render json: @zombie, status: :created, location: @zombie }
      else
        format.html { render action: "new" }
        format.json { render json: @zombie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /zombies/1
  # PUT /zombies/1.json
  def update
    @zombie = Zombie.find(params[:id])

    respond_to do |format|
      if @zombie.update_attributes(params[:zombie])
        flash[:success] ='Zombie was successfully updated.'
        format.html { redirect_to @zombie }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @zombie.errors, status: :unprocessable_entity }
      end
    end
  end

def add_role
  @role_update = @zombie.roles << Role.find_by_title()
end


  # DELETE /zombies/1
  # DELETE /zombies/1.json
  def destroy
    @zombie = Zombie.find(params[:id])
    @zombie.destroy

    respond_to do |format|
      format.html { redirect_to zombies_url }
      format.json { head :no_content }
    end
  end
end
