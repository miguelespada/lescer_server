class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy, :select]
  # before_action :authenticate_user!, except: [:selected]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.asc(:name).paginate(:page => params[:page], :per_page => 20)
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  def select
    Patient.update_all(selected: :false)
    @patient.update(selected: :true)
    redirect_to patients_path
  end

  def selected
    exercice = Exercice.where(selected: :true).first
    exercice = Exercice.last if exercice.nil?

    patient = Patient.where(selected: :true).first
    patient = Patient.last if patient.nil?
  
    json = {:exercice => exercice.name,
            :patient => patient.name,
            :data => "",
            :x => exercice.x || 0,
            :width => exercice.width || 0,
            :y => exercice.y || 0,
            :height =>  exercice.height || 0
          }
    render json: json
  end


  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to patients_path, notice: 'Patient was successfully created.' }
        format.json { render action: 'show', status: :created, location: @patient }
      else
        format.html { render action: 'new' }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patients_path, notice: 'Patient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name)
    end
end
