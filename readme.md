Mini Job board-Sinatra Mongoid

It is based on a "sinatra-jobs" created by rriggin

Modifications from the original include: 
	use JRuby 9.1.6.0 support mri ruby,
	use mongoid,
	use puma ,
	remove sinatra-authentication.

Todo: 
	need better user account views and authentication, add bootstrapping, etc, 
	fix updated_at timestamp with last update, 
	make contact email field required on create new job function, 
	tie user model to jobs model with one > many relationship, 
	fix responsive layout elements, 
	add a geographic model (areas: i.e, city/state, zip, region) **maybe use tags for this?
	add a featured job banner in home.haml.
