class WorksController < ApplicationController
  before_action :set_current_user
  def index
    @works = @user.works
  end

  def new
    @work = @user.works.build
  end

  def edit
    @work = @user.works.find params[:id]
  end

  def update
    @work = @user.works.find params[:id]

    benchmark "Updating file" do
      @work.update_attributes work_params(params)
    end

    redirect_to user_works_path(@user)
  end

  def create
    @work = @user.works.build work_params(params)

    benchmark 'Saving uploaded file' do
      if @work.save
        flash[:success] = "Created work successfully!"
        redirect_to user_works_path(@user)
      else
        flash[:alert] = "Failed!"
        render 'new'
      end
    end
  end

  def destroy
    @work = @user.works.find params[:id]
    @work.destroy
    redirect_to user_works_path(@user)
  end

  private
  def set_current_user
    @user = User.find params[:user_id]
  end

  def work_params(params)
    params.require(:work).permit(:name, :attachment)
  end
end
