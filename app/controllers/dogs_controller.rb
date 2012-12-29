class DogsController < ApplicationController
  # GET /dogs
  # GET /dogs.json
  def index
    if current_user.nil?
      redirect_to users_path
    else
      @dogs = current_user.dogs

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @dogs }
      end
    end
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
    @dog = Dog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dog }
    end
  end

  # GET /dogs/new
  # GET /dogs/new.json
  def new
    @dog = Dog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dog }
    end
  end

  # GET /dogs/1/edit
  def edit
    @dog = Dog.find(params[:id])
  end

  # POST /dogs
  # POST /dogs.json
  def create
    p = params[:dog]
    dat = nil
    if( p["birthday(1i)"] && p["birthday(2i)"] && p["birthday(3i)"] )
      dat = Date::civil(p["birthday(1i)"].to_i, p["birthday(2i)"].to_i, p["birthday(3i)"].to_i)
    end
    @dog = current_user.dogs.build( :name => p[:name], :birthday => dat )
    if @dog.save
      flash[:notice] = "Dog created!"
      redirect_to dogs_path
    else
      flash[:error] = "Dog couldn't be created."
      render 'new'
    end
  end

  # PUT /dogs/1
  # PUT /dogs/1.json
  def update
    @dog = Dog.find(params[:id])

    respond_to do |format|
      if @dog.update_attributes(params[:dog])
        format.html { redirect_to dogs_path, notice: 'Dog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog = Dog.find(params[:id])
    @dog.destroy

    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
