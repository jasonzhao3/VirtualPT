# include ModelModule
require 'json'
string = %Q|{"results":[{"profile":{"__type":"Pointer","className":"Profile","objectId":"hkJIqkIPlw"},"email":"yang@stanford.edu","username":"yang","createdAt":"2014-05-11T18:12:23.554Z","updatedAt":"2014-05-11T18:12:39.834Z","objectId":"O9MmEreORk"},{"profile":null,"username":"eV90K8MvjK2FZhCqRzgLyatfB","createdAt":"2014-05-11T20:00:19.665Z","updatedAt":"2014-05-11T20:00:19.890Z","objectId":"mmoRpN3qDw"},{"username":"gwen","email":"gwen@stanford.edu","profile":{"__type":"Pointer","className":"Profile","objectId":"null"},"createdAt":"2014-05-12T07:08:32.675Z","updatedAt":"2014-05-12T07:08:32.675Z","objectId":"TSTBRJnYrK"},{"username":"gw2en","email":"gwen@stanfor2d.edu","profile":null,"createdAt":"2014-05-12T07:17:30.666Z","updatedAt":"2014-05-12T07:17:30.666Z","objectId":"gVFQLpsjrv"},{"username":"yang2","email":"christine@stanford.edu","profile":{"__type":"Pointer","className":"Profile","objectId":"null"},"createdAt":"2014-05-12T07:21:58.501Z","updatedAt":"2014-05-12T07:21:58.501Z","objectId":"NU40luPTtp"},{"username":"2323","email":"christine@stan2ford.edu","createdAt":"2014-05-12T07:22:54.215Z","updatedAt":"2014-05-12T07:22:54.215Z","objectId":"AocVHBdqD8"}]}
|;
parsed =  JSON.parse(string)
users = Array.new

parsed["results"].each do |user|
	users << user["username"]
end

puts users
