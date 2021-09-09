require 'rails_helper'

# 'describe' contains all of the tests regarding the images API
# 'it' blocks are for specific tests
describe 'Images API', type: :request do
    describe '/GET images' do
        before do
            FactoryBot.create(:image, title:'Hello there', user:"Dusan")
            FactoryBot.create(:image, title:'bing boom bam', user:"BIG MAN")
        end
        it 'returns all the images' do
            get '/api/v1/images'
    
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe 'POST /images' do
        it 'create new images' do
            expect {
                post '/api/v1/images', params: {image: {title: 'Another test', user: 'big d'}}
            }.to change { Image.count }.from(0).to(1)
            
            expect(response).to have_http_status(:created)
        end
    end

    describe 'DELETE /images/:id' do
        let!(:image) { FactoryBot.create(:image, title:'Hello there', user:"Dusan") }
        it 'deletes an image' do
            expect {
                delete "/api/v1/images/#{image.id}"
            }.to change { Image.count }.from(1).to(0)
            

            expect(response).to have_http_status(:no_content)
        end
    end
end