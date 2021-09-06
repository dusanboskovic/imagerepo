module Api
  module V1
    class ImagesController < ApplicationController
      
      def index
        render json: Image.all
      end

      def create
        # we are going to be using the new method instead of the create method so that we can confirm
        # and check whether the newly created entry to the db is valid
        # ALso using the image_params private method described below
        image = Image.new(image_params)

        if image.save
          # using the status: :create to return a 201 code (which means that the record was successfully created) instead of the default 200 code (which means OK)
          render json: image, status: :created # same as directly writing 201
        else
          render json: image.errors, status: :unprocessable_entity
        end
      end

      def destroy
        # Using destroy! which will return true if successful, otherwise return exception. To be handled later 
        Image.find(params[:id]).destroy!

        # we are just gonna return a header with no body unlike the create method
        head :no_content
      end

      private
      # this is needed so that we can only pass in these 2 params to the POST (create) method
      def image_params
        params.require(:image).permit(:title, :user)
      end
    end
  end
end
