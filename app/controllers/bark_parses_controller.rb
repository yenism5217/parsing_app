class BarkParsesController < ApplicationController
  # GET /bark_parses
  # GET /bark_parses.json
  def index
    @bark_parses = BarkParse.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bark_parses }
    end
  end

  # GET /bark_parses/1
  # GET /bark_parses/1.json
  def show
    @bark_parse = BarkParse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bark_parse }
    end
  end

  # GET /bark_parses/new
  # GET /bark_parses/new.json
  def new
    @bark_parse = BarkParse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bark_parse }
    end
  end

  # GET /bark_parses/1/edit
  def edit
    @bark_parse = BarkParse.find(params[:id])
  end

  # POST /bark_parses
  # POST /bark_parses.json
  def create
    @bark_parse = BarkParse.new(params[:bark_parse])

    respond_to do |format|
      if @bark_parse.save
        format.html { redirect_to @bark_parse, notice: 'Bark parse was successfully created.' }
        format.json { render json: @bark_parse, status: :created, location: @bark_parse }
      else
        format.html { render action: "new" }
        format.json { render json: @bark_parse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bark_parses/1
  # PUT /bark_parses/1.json
  def update
    @bark_parse = BarkParse.find(params[:id])

    respond_to do |format|
      if @bark_parse.update_attributes(params[:bark_parse])
        format.html { redirect_to @bark_parse, notice: 'Bark parse was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bark_parse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bark_parses/1
  # DELETE /bark_parses/1.json
  def destroy
    @bark_parse = BarkParse.find(params[:id])
    @bark_parse.destroy

    respond_to do |format|
      format.html { redirect_to bark_parses_url }
      format.json { head :no_content }
    end
  end
end
