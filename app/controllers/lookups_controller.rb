class LookupsController < ApplicationController
  def lookup
    url = Lookup.where('token = ?', request.params['path']).first.try(:url)

    if url.nil?
      flash[:notice] = 'Url not found'
      @lookup = Lookup.new
      render :new and return
    end

    redirect_to url
  end

  def show
    @lookup = Lookup.where('token = ?', params["token"]).first
  end

  # GET /lookups/new
  def new
    @lookup = Lookup.new
  end

  def create
    mode = params[:mode]
    @lookup = Lookup.new(lookup_params)
    @lookup.token = @lookup.shortify if mode == 'shortify'

    respond_to do |format|
      if @lookup.save
        format.html { redirect_to "/lookup/#{@lookup.token}" }
        format.json { render :show, status: :created, location: @lookup }
      else
        format.html { render :new }
        format.json { render json: @lookup.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def lookup_params
    params.permit(:token, :url)
  end
end
