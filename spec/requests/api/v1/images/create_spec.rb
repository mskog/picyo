require 'spec_helper'

describe "Images#create", type: :request do
  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access[:image]}

  context "authenticated request" do
    When do
      token_auth
      post api_v1_images_path(params), {}, @env
    end

    context "creating by url" do
      Given(:fixture){File.new('spec/fixtures/doll.jpg')}
      Given{stub_request(:get, url).to_return(body: fixture.read, headers: {"content_type" => 'image/jpeg'})}
      Given(:url){'http://www.example.com/doll.jpg'}
      Given(:params){{url: url}}

      context "with an image that does not exist yet" do
        Given(:expected_image){Image.first}
        Then{expect(Image.count).to eq 1}
        And{expect(expected_image.file_filename).to eq 'doll.jpg'}
        And{expect(parsed_response[:url]).to eq "http://www.example.com/images/#{expected_image.hash_id}"}
        And{expect(parsed_response[:image_url]).to eq "http://www.example.com/#{expected_image.hash_id}.jpg"}
        And{expect(parsed_response[:file_size]).to eq 13951}
        And{expect(parsed_response[:file_content_type]).to eq "image/jpeg"}
        And{expect(parsed_response[:width]).to eq 239}
        And{expect(parsed_response[:height]).to eq 180}
        And{expect(parsed_response[:id]).to eq expected_image.hash_id}
      end

      context "with an existing image" do
        Given(:fixture){File.new('spec/fixtures/doll.jpg')}
        Given{stub_request(:get, url).to_return(body: fixture.read, headers: {"content_type" => 'image/jpeg'})}
        Given(:url){'http://www.example.com/doll.jpg'}
        Given{Image.create!(file: fixture, original_url: url)}

        Given(:expected_image){Image.first}
        Then{expect(Image.count).to eq 1}
      end

      context "with a url that 404s" do
        Given{stub_request(:get, url).to_return(status: 404)}
        Then{expect(Image.count).to eq 0}
        And{expect(response.status).to eq 422}
      end
    end
  end
end
