require "prawn"

class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :pdf]
  # GET /companies
  # GET /companies.json
  def index
    @company = Company.new
    @companies = Company.all
    @@comment = ""
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.time=Time.now
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to edit_company_path(@company), notice: 'Company was successfully created.' }
        CompanyMailer.welcome_email(@company)
      #  format.json { render action: 'show', status: :created, location: @company }
      else
        format.html { render action: 'new' }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
        params.each do |key,value|
  Rails.logger.warn "Param #{key}: #{value}"
end
       @@comment=params[:comment]
      else
        format.html { render action: 'edit' }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end

     def pdf

    @@myname=@company['contact_name'].to_s
    @@email=@company['email'].to_s
    @@company=@company['company_name'].to_s
    @@address=@company['address'].to_s
    @@date=@company['date'].to_s
    @@time=@company['time'].to_s

     send_data generate_pdf(@company),
              filename: "generalforsamling.pdf",
              type: "application/pdf"
    end

def generate_pdf(user)
    Prawn::Document.new do
      
      font_size(14) do
        text "Eksempel på innkalling til ordinær generalforsamling "
      end

      font_size(10) do
        text "Det presiseres at dette dokumentet er av generell art, og at teksten må tilpasses den enkeltes virksomhet."
      end

      stroke_horizontal_rule
      move_down 5
      font_size(8) do
        text "Innledning – utdrag av aksjeloven:", :color => "FF0000"  
        text "§ 5-10. Krav til innkallingen " 
        text "(1) Generalforsamlingen innkalles ved skriftlig henvendelse til alle aksjeeiere med kjent adresse. Innkallingen skal angi tid og sted for møtet. "
        text "(2) Innkalling til generalforsamlingen skal være sendt senest en uke før møtet skal holdes, om ikke vedtektene setter en lengre frist. En slik vedtektsbestemmelse gjelder ikke ved innkalling som foretas på bakgrunn av krav etter § 5-6 annet ledd. "
        text "(3) Innkallingen skal bestemt angi de saker som skal behandles på generalforsamlingen. Forslag om å endre vedtektene skal gjengis i innkallingen. Styret skal utarbeide forslag til dagsorden i samsvar med det som er bestemt i loven og vedtektene. "
        move_down 10
        text "§ 5-11. Aksjeeieres rett til å få saker behandlet på generalforsamlingen"
        text "En aksjeeier har rett til å få behandlet spørsmål på generalforsamlingen som han eller hun melder skriftlig til styret i så god tid at det kan tas med i innkallingen. Har innkallingen allerede funnet sted, skal det sendes ut ny innkalling dersom det er minst en uke igjen til generalforsamlingen skal holdes."
        move_down 10
        text "§5-11 b. Adgangen til elektronisk deltakelse på generalforsamlingen og til å bruke forhåndsstemme." 
        text "1) Med mindre noe annet følger av selskapets vedtekter, kan styret beslutte at aksjeeierne skal kunne delta på generalforsamlingen ved bruk av elektroniske hjelpemidler, herunder at de kan utøve sine rettigheter som aksjeeiere elektronisk."
        text "(2)Det kan fastsettes i vedtektene at aksjeeierne skal kunne avgi sin stemme skriftlig, herunder ved bruk av elektronisk kommunikasjon, i en periode før generalforsamlingen. For slik stemmegiving skal det benyttes en betryggende metode for å autentisere avsenderen. Vedtektene kan fastsette nærmere krav til slik stemmegiving"

      end
     
      stroke_horizontal_rule
           move_down 15
 font_size(11) do
          text "Til aksjeeiere i: "+@@company
          move_down 15
          text "Innkalling til ordinær generalforsamling i "+@@company
          text "(jf. aksjeloven § 5-5 og 5-10)"
          move_down 15
          text "Aksjeeierne i "+@@company+" innkalles til ordinær generalforsamling "+@@date
          text "Tidspunkt:"+@@time
          text "Møtested:"+@@address
          move_down 15
          text "Dagsorden:"
          move_down 15
          
          text @@comment
        end
          move_down 15
          text "Aksjeeiere kan la seg representere ved fullmektig. Fullmektigen må fremlegge skriftlig fullmakt."
           move_down 25
          text "Med vennlig hilsen"
          text "for styret i "+@@company
          text @@myname  
          text @@email  
          text @@address

          time1 = Time.new
           move_down 10
           stroke_horizontal_rule
            move_down 5
            font_size(11) do
             text "Generated on: "+time1.inspect
        end
           move_down 5
          stroke_horizontal_rule
    end.render
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:email, :company_name, :contact_name, :date, :time, :address, :details)
    end
end

