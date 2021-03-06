# gems
require "sinatra"
require "sendgrid-ruby"
include SendGrid

# models

# understand how to construct new object from each class
# start with one, and dry up hard-code with templates as necessary to maintain functionality while allowing for auto-population of catalog
# define a random number price generator with floating numbers, but limit to reasonable price point
class Cookie
  def initialize(name, price, description)
    @name = name
    @price = price
    @description = description
  end
end 

class Muffin
  def initialize(name, price, description)
    @name = name
    @price = price
    @description = description
  end
end 

class Cake
  def initialize(name, price, description)
    @name = name
    @price = price
    @description = description
  end
end 

# endpoints
# to index
get "/" do
  erb :index
end

# to cookies
get "/cookies" do
  erb :cookies
end
# to muffins
get "/muffins" do
  erb :muffins
end
# to cakes
get "/cakes" do
  erb :cakes
end

get "/form" do
  erb :form
end



post "/form" do
  from = SendGrid::Email.new(email: 'janelle.goettl@gmail.com')
  to = SendGrid::Email.new(email: params[:email])
  subject = 'Tall Girl Bakery Catalog'
  content = SendGrid::Content.new(
    type: 'text/html', 
    # for this value, find a way to connect an autogenerated catalog
    # is there a way to link to erb templates or classes?
    value: "<h1>This is our Catalog</h1>"
  )
  
  # create mail object with from, subject, to and content
  mail = SendGrid::Mail.new(from, subject, to, content)
  
  # sets up the api key
  sg = SendGrid::API.new(
    api_key: ENV["SENDGRID_API_KEY"]
  )
  
  # sends the email
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  
  # display http response code
  puts response.status_code
  
  # display http response body
  puts response.body
  
  # display http response headers
  puts response.headers

  erb :form
end