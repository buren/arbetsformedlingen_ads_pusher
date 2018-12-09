require 'sinatra'
require 'date'
require 'arbetsformedlingen'
include Arbetsformedlingen # just for brevity

get '/' do
  erb :index
end

post '/ad' do
  content_type :json

  document = Document.new(
    customer_id: 'XXXYYYZZZ',
    email: 'a@example.com'
  )

  company = Company.new(
    name: 'ACME AB',
    cin: 'XXYYZZXXYY',
    description: 'A company description',
    address: {
      country_code: 'SE',
      zip: '11356',
      municipality: 'Stockholm',
      street: 'Birger Jarlsgatan 57',
      city: 'stockholm'
    }
  )

  publication = Publication.new(
    publish_at: Date.today,
    unpublish_at: Date.today + 21,
    name: 'John Doe',
    email: 'john@example.com'
  )

  schedule = Schedule.new(
    full_time: false,
    summary: '3 days a week 8.00-17.00',
    start_date: Date.today,
    end_date: nil
  )

  salary = Salary.new(
    currency: 'SEK',
    type: :fixed, # :fixed, :fixed_and_commission, :commission
    summary: 'Your salary will be...'
  )

  qualifications = []
  qualifications << Qualification.new(
    summary: 'A summary', # optional, but recommended field
    required: true,
    experience: true,
    drivers_license: 'B,C1',
    car: true
  )

  qualifications << Qualification.new(
    summary: 'A summary', # optional, but recommended field
    required: false
  )

  application_method = ApplicationMethod.new(
    external: true, # applications are not made through AF
    url: 'https://example.com',
    summary: 'Goto our website'
  )

  position = Position.new(
    company: company,
    schedule: schedule,
    salary: salary,
    qualifications: qualifications,
    application_method: application_method,
    attributes: {
      title: 'A title',
      purpose: 'A purpose',
      address: {
        country_code: 'SE',
        zip: '11356',
        municipality: 'Stockholm',
        street: 'Birger Jarlsgatan 57',
        city: 'stockholm'
      }
    }
  )

  packet = Packet.new(
    publication: publication,
    document: document,
    position: position,
    attributes: {
      active: true,
      job_id: 1,
      number_to_fill: 1,
      occupation: '4896'
    }
  )

  # client = API::Client.new(locale: 'sv')
  # client.create_ad(packet)

  errors = [
    salary,
    schedule,
    publication,
    document,
    company,
    application_method,
    position,
    packet
  ].map(&:errors).flatten(1).reject(&:empty?)

  { errors: errors }.to_json
end
