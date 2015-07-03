require 'spec_helper'

describe "AlbumImages#index", type: :request do
  Given(:album){create :album}
  Given(:query_params){{}}

  When do
    token_auth(user)
    get api_v1_album_images_path(album.hash_id), query_params, @env
  end

  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access}

  context "when the user is the owner of the album" do
    context "simple" do
      Given(:user){create :user}
      Given(:album){create :album, :with_images, user: user}

      Then{expect(parsed_response[:album_images].map{|ai| ai['id']}).to eq album.album_images.map(&:id)}
      And{expect(parsed_response[:album_images].first[:image_file_content_type]).to eq 'image/jpeg'}
    end

    context "with pagination" do
      Given(:query_params){{per_page: 2, page: 2}}
      Given(:user){create :user}
      Given(:album){create :album, user: user}
      Given!(:album_images){create_list :album_image, 6, album: album}

      Then{expect(parsed_response[:album_images].length).to eq 2}
      And{expect(parsed_response[:meta][:total_pages]).to eq 3}
    end

    context "with pagination with default per_page" do
      Given(:query_params){{page: 1}}
      Given(:user){create :user}
      Given(:album){create :album, user: user}
      Given!(:album_images){create_list :album_image, 6, album: album}

      Then{expect(parsed_response[:album_images].length).to eq 6}
      And{expect(parsed_response[:meta][:total_pages]).to eq 1}
    end
  end

  context "when the user is not the owner of the album" do
    Given(:user){create :user}
    Given(:album){create :album, :with_images}

    Then{expect(response.status).to eq 401}
  end
end
