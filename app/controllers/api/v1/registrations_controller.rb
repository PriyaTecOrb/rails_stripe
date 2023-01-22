class Api::V1::RegistrationsController < Api::V1::ApplicationController

	def create
		@user = User.new(user_params)
		if @user.save
			render json: @user.decorate, serializer: UserSerializer
		else
			render_error @user.errors.full_messages
		end  
	end

	private
	def user_params
		params.permit(:email, :password, :full_name, :country_code, :contact)
	end
end
