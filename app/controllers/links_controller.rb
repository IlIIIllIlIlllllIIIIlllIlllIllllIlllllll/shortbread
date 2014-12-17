class LinksController < ApplicationController

require 'pry'

  def index
    redirect_to links_new_path
  end

  def retrieve
    if @link = Link.find_by(short_url: params[:unknown])
      forward(@link)
    else
      redirect_to root_path
    end
  end

  def forward(link)
    link.times_visited += 1
    link.save!
    redirect_to link.original_url
  end

  def new
    @link = Link.new
    @links = Link.all
  end

  def create
    @link = Link.new(link_params)
    verified_link = @link.create_short_url(@link)
    
    respond_to do |format|
      if @link.save
        format.html { redirect_to link_path(verified_link), notice: 'Link was successfully created.' }
        format.json
      else
        format.html { render action: 'new' }
        format.json { render :json => { :error => @link.errors.full_messages }, :status => 422 }
      end
    end
  end

  def show
    @link = Link.find(params[:id])
  end

  def top
    @links = Link.all
  end

  private

  def link_params
    params.require(:link).permit(:original_url)
  end

end
