require 'rails_helper'

# 'describe' contains all of the tests regarding the images API
# 'it' blocks are for specific tests
describe 'Images API', type: :request do
    let(:first_user) { FactoryBot.create(:user, first_name: "Dusan", last_name: "Boskovic", age: 26) }
    let(:second_user) { FactoryBot.create(:user, first_name: "Salih", last_name: "Sogut", age: 22) }
    describe '/GET images' do

        before do
            FactoryBot.create(:image, title:'Hello there', user: first_user)
            FactoryBot.create(:image, title:'bing boom bam', user: second_user)
        end
        it 'returns all the images' do
            get '/api/v1/images'
    
            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(2)
            expect(response_body).to eq(
                [
                    {
                        "id" => 1,
                        "name" => "Hello there",
                        "user_name" => "Dusan Boskovic", 
                        "user_age" => 26
                    },
                    {
                        "id" => 2,
                        "name" => "bing boom bam",
                        "user_name" => "Salih Sogut", 
                        "user_age" => 22
                    }
                ]
            )
        end

         it 'returns a subset of images based on pagination' do
            get '/api/v1/images', params: { limit: 1 }

            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(1)
            expect(response_body).to eq(
                [
                    {
                        "id" => 1,
                        "name" => "Hello there",
                        "user_name" => "Dusan Boskovic", 
                        "user_age" => 26
                    }
                ]
            )
        end

        it 'returns a limit of images depending on limit and offset' do
            get '/api/v1/images', params: { limit: 1, offset: 1}
            
            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(1)
            expect(response_body).to eq(
                [
                    {
                        "id" => 2,
                        "name" => "bing boom bam",
                        "user_name" => "Salih Sogut", 
                        "user_age" => 22
                    }
                ]
            )
        end
    end



    describe 'POST /images' do
        it 'create new images' do
            expect {
                post '/api/v1/images', params: {
                    image: {title: 'Another test'},
                    user: {first_name: 'big', last_name: 'd', age: 26}
                }
            }.to change { Image.count }.from(0).to(1)
            
            expect(response).to have_http_status(:created)
            expect(User.count).to eq(1)
            expect(response_body).to eq(
                {
                    "id" => 1,
                    "name" => "Another test",
                    "user_name" => "big d", 
                    "user_age" => 26
                }
            )
        end
    end

    describe 'DELETE /images/:id' do
        let!(:image) { FactoryBot.create(:image, title:'Hello there', user: first_user) }
        it 'deletes an image' do
            expect {
                delete "/api/v1/images/#{image.id}"
            }.to change { Image.count }.from(1).to(0)
            

            expect(response).to have_http_status(:no_content)
        end
    end
end