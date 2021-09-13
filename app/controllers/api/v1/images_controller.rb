module Api
  module V1
    class ImagesController < ApplicationController
      MAX_PAGINATION_LIMIT = 100 

      def index
        images = Image.limit(limit).offset(params[:offset])

        render json: ImagesRepresenter.new(images).as_json
      end

      def create
        # we are going to be using the new method instead of the create method so that we can confirm
        # and check whether the newly created entry to the db is valid
        # ALso using the image_params private method described below
        user = User.create!(user_params)
        # we cannot pass the user as another argument to the below call - new function expects just 1 hash
        # we need to merge the object using a key (primary/foreign key concept)
        image = Image.new(image_params.merge(user_id: user.id))

        if image.save
          # using the status: :create to return a 201 code (which means that the record was successfully created) instead of the default 200 code (which means OK)
          render json: ImageRepresenter.new(image).as_json, status: :created # same as directly writing 201
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

      def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
          MAX_PAGINATION_LIMIT
        ].min
      end
      # this is needed so that we can only pass in these params to the POST (create) method
      def image_params
        params.require(:image).permit(:title)
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :age)
      end
    end
  end
end
