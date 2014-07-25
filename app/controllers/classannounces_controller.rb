class ClassannouncesController < ApplicationController
  before_action :set_classannounce, only: [:show, :edit, :update, :destroy]
  before_action :correct_announcer, only: [:new]
  before_action :no_body_could_edit, only: [:edit, :update, :destroy]

  # GET /classannounces
  # GET /classannounces.json
  def index
    @classannounces = Classannounce.all.order("created_at DESC")
  end

  # GET /classannounces/1
  # GET /classannounces/1.json
  def show
  end

  # GET /classannounces/new
  def new
    @classannounce = current_user.classannounces.build
    @classroom = Classroom.find_by(id: params[:classroom])
  end

  # GET /classannounces/1/edit
  def edit
  end

  # POST /classannounces
  # POST /classannounces.json
  def create
    @classannounce = current_user.classannounces.build(classannounce_params)

    respond_to do |format|
      if @classannounce.save
        format.html { redirect_to @classannounce }
        format.json { render :show, status: :created, location: @classannounce }
      else
        format.html { render :new }
        format.json { render json: @classannounce.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classannounces/1
  # PATCH/PUT /classannounces/1.json
  def update
    respond_to do |format|
      if @classannounce.update(classannounce_params)
        format.html { redirect_to @classannounce, notice: 'Classannounce was successfully updated.' }
        format.json { render :show, status: :ok, location: @classannounce }
      else
        format.html { render :edit }
        format.json { render json: @classannounce.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classannounces/1
  # DELETE /classannounces/1.json
  def destroy
    @classannounce.destroy
    respond_to do |format|
      format.html { redirect_to classannounces_url, notice: 'Classannounce was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classannounce
      @classannounce = Classannounce.find(params[:id])
    end

    def correct_announcer
      @classroom = Classroom.find_by(id: params[:classroom])
      @classroom_id = params[:classroom]
      if @classroom.user != current_user &&
        Classenroll.find_by(ista: true, ispassed: true,classroom_id: @classroom.id, 
          user_id: current_user.id).nil?
        redirect_to blank_path
      end
    end

    def no_body_could_edit
      redirect_to blank_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classannounce_params
      params.require(:classannounce).permit(:user_id, :classroom_id, :content)
    end
end
