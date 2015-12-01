class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy, :select, :csv]
  # before_action :authenticate_user!, except: [:upload, :download]

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.desc(:created_at).paginate(:page => params[:page], :per_page => 30)
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  def csv
    send_data @session.data
  end

  def select
    select_session @session
    redirect_to sessions_path
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new(session_params)

    respond_to do |format|
      if @session.save
        format.html { redirect_to @session, notice: 'Session was successfully created.' }
        format.json { render action: 'show', status: :created, location: @session }
      else
        format.html { render action: 'new' }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload
    timestamp =  params["timestamp"]
    @session = Session.where(timestamp: timestamp).first
    if @session.nil?
      last = Session.last
      @session = Session.new()
      @session.patient = Patient.selected
      @session.exercice = Exercice.selected 
    end
    @session.data = params["data"]
    @session.timestamp = timestamp
    @session.ref_x = params["ref_x"]
    @session.ref_y = params["ref_y"]
    @session.ref_z = params["ref_z"]
    select_session @session
    render json: @session
  end

  def selected
    @session = Session.where(selected: :true).first
    @session = Session.last if @session.nil?
    json = {:data => @session.data,
      :timestamp => @session.timestamp,
      :patient => @session.patient.name,
      :exercice => @session.exercice.name,
      :ref_x => @session.ref_x,
      :ref_y => @session.ref_y,
      :ref_z => @session.ref_z}
    render json: json
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url }
      format.json { head :no_content }
    end
  end

  private
    def set_session
      @session = Session.find(params[:id])
    end

    def session_params
      params.require(:session).permit(:data, :patient_id, :exercice_id, :ref_x, :ref_y, :ref_z)
    end

    def select_session session
      Session.update_all(selected: :false)
      session.update(selected: :true)
    end
end
