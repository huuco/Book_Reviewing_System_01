class RequestsController < ApplicationController
  before_action :load_request, only: %i(destroy show edit update)
  
  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.build requests_params
    if @request.save
      flash[:success] = t "requests.create_success"
      redirect_to my_requests_url
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @request.update_attributes requests_params
      flash[:success] = t "books.update_success"
      redirect_to my_requests_url
    else
      render :edit
    end
  end

  def destroy
    if @request.destroy
      flash[:success] = t "books.delete_success"
    else
      flash[:danger] = t "delete_faild"
    end
    redirect_to my_requests_url
  end

  private

  def load_request
    @request = Request.find_by id: params[:id]
    render html: (t "not_found") if @request.nil?
  end

  def requests_params
    params.require(:request).permit :name_book, :content
  end
end
