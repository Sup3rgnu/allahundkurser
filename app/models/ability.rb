class Ability 
	include CanCan::Ability

	def initialize(user)

		user ||= User.new #guest user

		can :read, :all
		cannot :read, User

		if user.role == 'superuser'
			can :manage, :all

		elsif user.role == 'admin'
			
			can :create, [Org, Course, Location]

			can [:update, :destroy], Org do |org|				
				org.try(:user) == user
			end
			
			can [:update, :destroy], Course do |course|
				course.org.try(:user) == user
			end

			can :update,  CourseTag do |ct|
				ct.course.org.try(:user) == user
			end
		end
	end
end