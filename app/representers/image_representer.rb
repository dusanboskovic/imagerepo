class ImageRepresenter
    def initialize(image)
        @image = image
    end

    def as_json
        {
            id: image.id,
            name: image.title,
            user_name: user_name(image),
            user_age: image.user.age
        }
    end

    private

    attr_reader :image

    def user_name(image)
        "#{image.user.first_name} #{image.user.last_name}"
    end
end