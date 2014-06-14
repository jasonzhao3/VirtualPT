class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # helper_method :parseHeader
  # helper_method :parseDomain
  # helper_method :createObject

require 'net/http'
require 'net/https'

  def parseHeader
    {
       "X-Parse-Application-Id" => "L6SLBxrQtNVjvdO8TCaYH7rpMHStR832rJoTloW0",
       "X-Parse-REST-API-Key"=> "zqZskYHskGj6R2eMxBBS7Q4b6eUJ09VJHYVgKrXR",
       "Content-Type" =>"application/json"
    }
  end
  
  def parseDomain(ext)
    "https://api.parse.com/1/#{ext}"
  end
 
  def constructObjectPostRequest(objectType)
	uri = URI.parse(parseDomain("classes/#{objectType}"))
	# uri = URI.parse("https://api.parse.com/1/classes/MyObject")
	https = Net::HTTP.new(uri.host,uri.port)
	https.use_ssl = true  	
	req = Net::HTTP::Post.new(uri.path, nitheader = parseHeader)
	return https, req
  end

 
  def constructUserPostRequest()
	uri = URI.parse(parseDomain("users"))
	# uri = URI.parse("https://api.parse.com/1/classes/MyObject")
	https = Net::HTTP.new(uri.host,uri.port)
	https.use_ssl = true
	req = Net::HTTP::Post.new(uri.path, nitheader = parseHeader)
	return https, req
  end

# TODO: DRY -- reuse more code
  def constructUserGetRequest()
  	uri = URI.parse(parseDomain("users"))
	# uri = URI.parse("https://api.parse.com/1/classes/MyObject")
	https = Net::HTTP.new(uri.host,uri.port)
	https.use_ssl = true
	req = Net::HTTP::Get.new(uri.path, nitheader = parseHeader)
	return https, req
end


 def createObject(objectType, objectData)
    https, req = constructObjectPostRequest(objectType)
    req.body = objectData.to_json
    res = https.request(req)
    puts res.body
    return res.is_a?(Net::HTTPSuccess), res.body

    # puts parseDomain("classes/#{objectType}");
    # Nestful.post parseDomain("classes/#{objectType}"), :format => :json, :headers => parseHeader, :params => objectData
    
    # Nestful::Request.new("https://api.parse.com/1/Object2", :method => :post, :params => objectData, :headers => parseHeader, :format => :json).execute
  end

  def createUser(userData)
  	https, req = constructUserPostRequest()
  	req.body = userData.to_json
  	res = https.request(req)
  	puts res.body
    puts ">>>>>>>>>>>>>>response status**********"
    puts res.is_a?(Net::HTTPSuccess)
  	return res.is_a?(Net::HTTPSuccess), res.body
  end


end
