class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]
  before_action :check_status, only: [:index, :show, :edit, :update]
  before_action :check_super, only: [:destroy]
  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.all
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
  end

  # POST /staffs
  # POST /staffs.json
  def create
    params_cp = staff_params
    params_cp['isadmin'] = false
    params_cp['issuper'] = false
    params_cp['isactive'] = false
    thisstaff = Staff.find_by(user_id: current_user.id, isactive: true)
    if thisstaff.nil? || (not (thisstaff.isadmin || thisstaff.issuper))
      params_cp['user_id'] = current_user.id
    end

    @staff = Staff.new(params_cp)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to edit_user_registration_path, notice: 'Staff was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { redirect_to edit_user_registration_path, notice: 'Something goes wrong... Perhaps you have applied for teacher status before?' }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    params_cp = staff_params
    current_staff = Staff.find_by(user_id: current_user.id)
    if current_staff.nil?
      format.html { redirect_to root_path, notice: 'You are not a teacher?' }
    else
      if current_staff.isactive && current_staff.isadmin && (not current_staff.issuper)
        params_cp.delete('issuper')
      elsif (current_staff.isactive && current_staff.issuper)
      else
        format.html { redirect_to root_path, notice: 'You are not admin yet.' }
      end

      params_cp.delete('user_id')
      respond_to do |format|
        if @staff.update(staff_params)
          format.html { redirect_to staffs_url, notice: 'Staff was successfully updated.' }
          format.json { render :show, status: :ok, location: @staff }
        else
          format.html { render :edit }
          format.json { render json: @staff.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    def check_status
      thisstaff = Staff.find_by(user_id: current_user.id, isactive: true)
      if thisstaff.nil?
        redirect_to root_path, notice: "Oooops, you need your admin & teacher status be both ON to see this page. Please contact dipterix@mail.ustc.edu.cn"
      elsif not (thisstaff.isadmin || thisstaff.issuper)
        redirect_to edit_user_registration_path
      end
    end


    def check_super
      if Staff.find_by(user_id: current_user.id, isactive: true, issuper: true).nil?
        format.html { redirect_to staffs_url, notice: "You are not a super administrator, you can only deactivate, not delete." }
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params.require(:staff).permit(:user_id, :isactive, :issuper, :isadmin)
    end
end
