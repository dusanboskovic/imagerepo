class ApplicationController < ActionController::API
    # any class that inherits this one will return the same logic for a RecordNotDestroyed error 
    rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

    private
    def not_destroyed(e)
        render json: {errors: e.record.errors}, status: :unprocessable_entity
    end
end
