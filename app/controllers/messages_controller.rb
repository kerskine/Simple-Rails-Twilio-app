class MessagesController < ApplicationController

require 'twiliolib'

    # Twilio REST API version
    API_VERSION = '2008-08-01'

    # Twilio AccountSid and AuthToken
    ACCOUNT_SID = 'AC8eddd770e69ad61de3fef0b4671bd62d'
    ACCOUNT_TOKEN = 'f1b8d4fa45a5b275494be3b1abf14f2b'

  # GET /messages
  # GET /messages.xml
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new(:From => "9785719921")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])

    # Create a Twilio REST account object using your Twilio account ID and token
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)

    d = { 'From' => @message.From, 'To' => @message.To, 'Body' => @message.Body }

    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', d)
    resp.error! unless resp.kind_of? Net::HTTPSuccess
    puts "code: %s\nbody: %s" % [resp.code, resp.body]

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(@message) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(@message) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end

  def twilio_create
    @message = Message.new(:SmsMessageSid => params[:SmsMessageSid], :AccountSid => params[:AccountSid], :Body => params[:Body], :From => params[:From], :To =>params[:To])
    
    respond_to do |format|
      if @message.save
        format.xml { head :ok }
      else
        format.xml { render :xml => @message.errors, :status => :unprocessable_entiity }
      end
    end
  end

  def twilio_update
    @message = Message.find(:SmsMessageSid => params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.xml  { head :ok }
      else
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end


end
