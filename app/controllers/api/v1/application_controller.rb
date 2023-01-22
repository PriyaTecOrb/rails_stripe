class Api::V1::ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token


	def doorkeeper_unauthorized_render_options(error: nil)
		{ json: { errors: error.description } }
	end

	def render_error(errors, status = :unprocessable_entity)
		render json: { errors: errors, }, status: status
	end
end
