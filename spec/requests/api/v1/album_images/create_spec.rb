require 'spec_helper'

describe "AlbumImages#create", type: :request do
  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access[:image]}
  Given(:album){create :album}

  context "authenticated request" do
    When do
      token_auth
      post api_v1_album_images_path(params), {}, @env
    end

    context "creating by url" do
      Given(:fixture){File.new('spec/fixtures/doll.jpg')}
      Given{stub_request(:get, url).to_return(body: fixture.read, headers: {"content_type" => 'image/jpeg'})}
      Given(:url){'http://www.example.com/doll.jpg'}
      Given(:params){{album_id: album.hash_id, url: url}}

      context "with an image that does not exist yet" do
        Given(:expected_image){Image.first}
        Then{expect(Image.count).to eq 1}
        And{expect(expected_image.file_filename).to eq 'doll.jpg'}
        And{expect(parsed_response[:url]).to eq "http://www.example.com/images/#{expected_image.hash_id}"}
        And{expect(parsed_response[:image_url]).to eq "http://www.example.com/images/#{expected_image.hash_id}.jpg"}
        And{expect(parsed_response[:id]).to eq expected_image.hash_id}
        And{expect(expected_image.albums).to include album}
      end

      context "with async creation" do
        Given{expect(ImageUploadJob).to receive(:perform_later).with(url: url, album_id: album.hash_id)}
        Given(:params){{album_id: album.hash_id, url: url, async: 1}}
        Then{expect(response.status).to eq 200}
      end

      # TODO Should a copy be made of the specific image in this case?
      # Deletion etc might be an issue if not
      context "with an existing image" do
        Given(:fixture){File.new('spec/fixtures/doll.jpg')}
        Given{stub_request(:get, url).to_return(body: fixture.read, headers: {"content_type" => 'image/jpeg'})}
        Given(:url){'http://www.example.com/doll.jpg'}
        Given{Image.create!(file: fixture, original_url: url)}

        Given(:expected_image){Image.first}
        Then{expect(Image.count).to eq 1}
        And{expect(expected_image.albums).to include album}
      end

      context "with an image already in the album" do
        Given(:fixture){File.new('spec/fixtures/doll.jpg')}
        Given!(:image){Image.create!(file: fixture, original_url: url)}
        Given{album.images << image}
        Then{expect(album.reload.images.count).to eq 1}
      end

      context "with a url that 404s" do
        Given{stub_request(:get, url).to_return(status: 404)}
        Then{expect(Image.count).to eq 0}
        And{expect(response.status).to eq 422}
      end
    end
  end
end
