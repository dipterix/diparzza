class ClassenrollsController < ApplicationController
  before_action :set_classenroll, only: [:show, :edit, :update, :destroy]
  before_action :corrent_user_enroll, only: [:show, :edit, :update, :destroy]

  # GET /classenrolls
  # GET /classenrolls.json
  def index
    @classenrolls = Classenroll.all
  end

  # GET /classenrolls/1
  # GET /classenrolls/1.json
  def show
  end

  # GET /classenrolls/new
  def new
    @classenroll = current_user.classenrolls.build
    @classroom = Classroom.find_by(id:params[:classroom])
  end

  # GET /classenrolls/1/edit
  def edit

  end

  # POST /classenrolls
  # POST /classenrolls.json
  def create
    build_params = classenroll_params
    build_params['user_id'] = current_user.id
    build_params['ista'] = false
    @classroom = Classroom.find_by(id: build_params['classroom_id'])
    if @classroom.ispublic or (current_user.email.include? @classroom.condition)
      build_params['ispassed'] = true
      notice = 'Congratulations! You have successfully applied for this class :)'
    else
      build_params['ispassed'] = false
      notice = 'You have successfully applied for this class. Wait for the teacher/TAs to confirm enrollment :)'
    end
    @classenroll = current_user.classenrolls.build(build_params)

    respond_to do |format|
      if @classenroll.save
        format.html { redirect_to classrooms_path, notice: notice }
        format.json { render :show, status: :created, location: @classenroll }
      else
        format.html { render :new }
        format.json { render json: @classenroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classenrolls/1
  # PATCH/PUT /classenrolls/1.json
  def update
    update_params = classenroll_params
    user_id = update_params.delete('user_id')
    classroom_id = update_params.delete('classroom_id')
    @class_ta = Classenroll.find_by(user_id: current_user.id, ista: true, ispassed: true, classroom_id: @classenroll.classroom.id)
    if @class_ta || @classenroll.classroom.user==current_user
      # Teacher / TA, authorized to change status
      respond_to do |format|
        if @classenroll.update(update_params)
          format.html { redirect_to classroom_path(classroom_id), 
            notice: 'Student enrollment status was successfully updated. :)' }
          format.json { render :show, status: :ok, location: @classenroll }
        else
          format.html { render :edit }
          format.json { render json: @classenroll.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to classroom_path(classroom_id), 
              notice: 'Status not changed because you are not TA nor the owner of this class :(' }
        format.json { render :show, status: :ok, location: @classenroll }
      end
    end
    
  end

  # DELETE /classenrolls/1
  # DELETE /classenrolls/1.json
  def destroy
    if (@classenroll.user_id == current_user.id)
      @classenroll.destroy
      respond_to do |format|
        format.html { redirect_to classrooms_path, notice: 'Classenroll was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to classrooms_path, notice: "Not Authorized to do so."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classenroll
      @classenroll = Classenroll.find(params[:id])
    end

    def enrolled_student
      @classenroll = current_user.classenrolls.find_by(user_id:params[:user_id])
      redirect_to classrooms_path, notice: "Not enrolled by this class yet, please wait until your teacher's confirm" if @classenroll.nil?
    end


    # TODO: a user could help himself/herself to be enrolled
    def corrent_user_enroll
      #@class_student = current_user.classenrolls.find_by(user_id:params[:user_id])
      #@class_teacher = @classenroll.classroom.user

      classroom_id = params[:classroom_id] unless params[:classroom_id]==nil?
      user_id = params[:user_id] unless params[:user_id]==nil?

      @class_teacher = nil
      @class_student = current_user.classenrolls.find_by(user_id: user_id)

      if (current_user.status)
        @class_teacher = current_user.classrooms.find_by(id: classroom_id)
      end
      if (@class_teacher && @class_teacher.nil && @class_student.nil)
        redirect_to classrooms_path, notice: "Not enrolled by this class yet, please wait until your teacher's confirm"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classenroll_params
      params.require(:classenroll).permit(:user_id, :classroom_id, :ista, :ispassed)
    end
end
