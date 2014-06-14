module ModelModule  

require 'net/http'
require 'net/https'
require 'json'

# private

  def self.parseHeader
    {
       "X-Parse-Application-Id" => "L6SLBxrQtNVjvdO8TCaYH7rpMHStR832rJoTloW0",
       "X-Parse-REST-API-Key"=> "zqZskYHskGj6R2eMxBBS7Q4b6eUJ09VJHYVgKrXR",
       "Content-Type" =>"application/json"
    }
  end
  
  def self.parseDomain(ext)
    "https://api.parse.com/1/#{ext}"
  end
 
  def self.constructObjectPostRequest(objectType)
	uri = URI.parse(parseDomain("classes/#{objectType}"))
	# uri = URI.parse("https://api.parse.com/1/classes/MyObject")
	https = Net::HTTP.new(uri.host,uri.port)
	https.use_ssl = true  	
	req = Net::HTTP::Post.new(uri.path, nitheader = parseHeader)
	return https, req
  end

  def self.constructUserPostRequest()
	uri = URI.parse(self.parseDomain("users"))
	# uri = URI.parse("https://api.parse.com/1/classes/MyObject")
	https = Net::HTTP.new(uri.host,uri.port)
	https.use_ssl = true
	req = Net::HTTP::Post.new(uri.path, nitheader = parseHeader)
	return https, req
  end

# TODO: DRY -- reuse more code
  def self.constructUserGetRequest()
  	uri = URI.parse(self.parseDomain("users"))
  	# uri = URI.parse("https://api.parse.com/1/classes/MyObject")
  	https = Net::HTTP.new(uri.host,uri.port)
  	https.use_ssl = true
  	req = Net::HTTP::Get.new(uri.path, nitheader = parseHeader)
  	return https, req
  end

  def self.constructObjectGetRequest(objectType)
    uri = URI.parse(parseDomain("classes/#{objectType}"))
    # uri = URI.parse("https://api.parse.com/1/classes/MyObject")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true    
    req = Net::HTTP::Get.new(uri.path, nitheader = parseHeader)
    return https, req
  end

# public

  def self.createUser(userData)
  	https, req = self.constructUserPostRequest()
  	req.body = userData.to_json
  	res = https.request(req)
  	puts res.body
  	return res.body if res.is_a?(Net::HTTPSuccess)
  end

  def self.createObject(objectType, objectData)
    https, req = constructObjectPostRequest(objectType)
    req.body = objectData.to_json
    res = https.request(req)
    return res.body if res.is_a?(Net::HTTPSuccess)
  end

# return array of users, each of which is a dictionary
  def self.fetchUsers()
 	  https, req = self.constructUserGetRequest()
  	res = https.request(req)
  	parsed = JSON.parse(res.body)
    return parsed["results"]
  end

  def self.fetchObjects(objectType)
    https, req = self.constructObjectGetRequest(objectType)
    res = https.request(req)
    parsed = JSON.parse(res.body)
    return parsed["results"]
  end

end