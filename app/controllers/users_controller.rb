module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_request!, except: [
      :create,
      :confirm,
      :login,
      :check_email_used,
      :api_test
    ]

    def api_test
      puts "API test request processing..."
      render json: {status: 'Api working and accessible'}, status: :ok
    end

    def create
      user = User.new(user_params)

      if user.save
        # Send confirmation email
        # https://www.sitepoint.com/authenticate-your-rails-api-with-jwt-from-scratch/
        render json: {status: 'User created successfully'}, status: :created
      else
        render json: { errors: user.errors.messages }, status: :bad_request
      end
    end

    def confirm
      token = params[:token].to_s

      user = User.find_by(confirmation_token: token)

      if user.present? && user.confirmation_token_valid?
        user.mark_as_confirmed!
        render json: {status: 'User confirmed successfully'}, status: :ok
      else
        render json: {status: 'Invalid token'}, status: :not_found
      end
    end

    def login
      user = User.find_by(email: params[:email].to_s.downcase)

      if user && user.authenticate(params[:password])
        if user.confirmed_at?
          auth_token = JsonWebToken.encode({user_id: user.id})
          render json: {auth_token: auth_token}, status: :ok
        else
          render json: {error: 'Please verify your email address' }, status: :unauthorized
        end
      else
        render json: {error: 'Invalid username and password combination'}, status: :unauthorized
      end
    end

    def check_email_used
      user = User.find_by(email: params[:email].to_s.downcase)
      if user
        render json: {email_in_use: true}
      else
        render json: {email_in_use: false}
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end
end
