require 'spec_helper'

describe "AlbumImages#index", type: :request do
  Given(:album){create :album}

  When do
    token_auth(user)
    get api_v1_album_images_path(album.id), {}, @env
  end

  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access}

  context "when the user is the owner of the album" do
    Given(:user){create :user}
    Given(:album){create :album, :with_images, user: user}

    Then{expect(parsed_response[:album_images].map{|ai| ai['id']}).to eq album.album_images.map(&:id)}
  end

  context "when the user is not the owner of the album" do
    Given(:user){create :user}
    Given(:album){create :album, :with_images}

    Then{expect(response.status).to eq 401}
  end
end
