class TasksController < ApplicationController
  before_filter :authenticate_user!, :except => :index
  
  # GET /tasks
  # GET /tasks.json
  # all incomplete tasks
  def index
    if user_signed_in?
      @tasks = Task.paginate(:conditions => {:user_id => current_user.id, :complete => false},
        :order => "due_date ASC", :page => params[:page], :per_page => 4)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end
  
  # all complete tasks
  def complete
    if user_signed_in?
      @tasks = Task.paginate(:conditions => {:user_id => current_user.id, :complete => true},
        :order => "updated_at DESC", :page => params[:page], :per_page => 4)
    end

    respond_to do |format|
      format.html # complete.html.erb
      format.json { render json: @tasks }
    end
  end
  
  # high priority
  def high_priority
    if user_signed_in?
      @tasks = Task.paginate(:conditions => {:user_id => current_user.id, :complete => false, :priority => 'High'},
        :order => "due_date ASC", :page => params[:page], :per_page => 4)
    end

    respond_to do |format|
      format.html # high_priority.html.erb
      format.json { render json: @tasks }
    end
  end
  
  # medium priority
  def medium_priority
    if user_signed_in?
      @tasks = Task.paginate(:conditions => {:user_id => current_user.id, :complete => false, :priority => 'Medium'},
        :order => "due_date ASC", :page => params[:page], :per_page => 4)
    end

    respond_to do |format|
      format.html # medium_priority.html.erb
      format.json { render json: @tasks }
    end
  end
  
  # low priority
  def low_priority
    if user_signed_in?
      @tasks = Task.paginate(:conditions => {:user_id => current_user.id, :complete => false, :priority => 'Low'},
        :order => "due_date ASC", :page => params[:page], :per_page => 4)
    end

    respond_to do |format|
      format.html # low_priority.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.new(params[:task])
    @task.user_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_url, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
