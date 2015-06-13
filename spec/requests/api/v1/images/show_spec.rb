require 'spec_helper'

describe "Images#show", type: :request do
  When do
    token_auth
    get api_v1_image_path(hash_id), {}, @env
  end

  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access[:image]}

  context "authenticated request" do
    context "an existing image" do
      Given(:image){create :image}
      Given(:hash_id){image.hash_id}
      Then{expect(parsed_response[:id]).to eq image.hash_id}
      And{expect(parsed_response[:url]).to eq "http://www.example.com/images/#{image.hash_id}"}
      And{expect(parsed_response[:image_url]).to eq "http://www.example.com/images/#{image.hash_id}.jpg"}
      And{expect(parsed_response[:file_size]).to eq 13951}
      And{expect(parsed_response[:file_content_type]).to eq "image/jpeg"}
      And{expect(parsed_response[:width]).to eq 239}
      And{expect(parsed_response[:height]).to eq 180}
    end

    context "an image that does not exist" do
      Given(:hash_id){'something.jpg'}
      Then{expect(response.status).to eq 404}
    end
  end
end
