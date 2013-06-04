class DogsController < ApplicationController
  include DogsHelper
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
    redirect_to dogs_path
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
    b = p[:birthday]
    @dog = current_user.dogs.build( :name => p[:name],
                                    :birthday => parse_birthday(b),
                                    :sex => p[:sex],
                                    :skill_ids => parse_skills(p[:skill_ids]) )
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

    dog = params[:dog]
    dog[:skill_ids] = parse_skills(dog[:skill_ids])
    dog[:birthday] = parse_birthday(dog[:birthday])
    dog[:picture] = parse_picture(dog[:picture])

    respond_to do |format|
      if @dog.update_attributes(dog)
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

  def parse_skills(skills)
    if skills.nil?
      return nil
    end
    skills = skills.gsub(/[\[\]]*/,"")
    return skills.split(",") if skills.length>0
    []
  end

  def parse_birthday(b)
    return (b.nil? || b.empty?) ? nil : Date.parse(b)
  end

  def parse_picture(p)
    return (p.nil? || p.empty?) ? nil : p;
  end
end
