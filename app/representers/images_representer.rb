class ImagesRepresenter
    def initialize(images)
        @images = images
    end

    def as_json
        images.map do |image|
            {
                id: image.id,
                name: image.title,
                user_name: user_name(image),
                user_age: image.user.age
            }
        end
    end

    private

    attr_reader :images

    def user_name(image)
        "#{image.user.first_name} #{image.user.last_name}"
    end
end