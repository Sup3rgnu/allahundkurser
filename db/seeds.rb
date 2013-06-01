# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Seeds for allahundkurser, run with 'rake db:seeds'

orgs = Org.create([{name: 'Daniels kurser', description: 'Lorem Ipsum', url: 'www.daniel.se'}, 
	{name: 'Zlatans hundskola', description: 'Lorem Ipsum', url: 'www.zlatan.com'}])

tags = Tag.create([{name: 'Valp'}, {name: 'Kamp'}])

locations = Location.create([{name: 'Humlegarden', lat: 59.339799, lng: 18.072853},
	{name: 'Ralis', lat: 59.328527, lng: 18.024788}])

courses = Course.create([
	{name: 'valpkurs', price: 1500, province: 'Blekinge', org_id: orgs.first.id, 
	location_id: locations.first.id, sessions: 2, participants: 4, desc: 'Lorem Ipsum'},
	{name: 'kampkurs', price: 2000, province: 'Blekinge', org_id: orgs.first.id, 
	location_id: locations.first.id, sessions: 2, participants: 4, desc: 'Lorem Ipsum'},
	])

CourseTag.create([{course_id: Course.first.id, tag_id: Tag.first.id},
	{course_id: Course.last.id, tag_id: Tag.last.id}])
