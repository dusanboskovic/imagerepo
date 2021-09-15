require 'rails_helper'

describe 'Authentication', type: :request do
    describe 'POST /authenticate' do
        it 'authenticates the client' do
            post '/api/v1/authenticate', params: { username: "tester11", password: "bingbong2" }

            expect(response).to have_http_status(:created)
            expect(response_body).to eq({
                'token' => '123'
            })
        end

        it 'returns an error when the username is missing' do
            post '/api/v1/authenticate', params: { password: "bingbong2" }

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response_body).to eq({
                "error" => "param is missing or the value is empty: username\nDid you mean?  password\n               controller\n               action"
            })
        end

        it 'returns an error when the password is missing' do
            post '/api/v1/authenticate', params: { username: "tester11" }

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response_body).to eq({
                'error' => "param is missing or the value is empty: password\nDid you mean?  action\n               username\n               controller"
            })
        end
    end

 end