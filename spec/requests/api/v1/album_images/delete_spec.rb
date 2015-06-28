require 'spec_helper'

describe "AlbumImages#delete", type: :request do
  Given(:album){create :album}
  Given(:album_image){album.album_images.first}

  When do
    token_auth(user)
    delete api_v1_album_image_path(album.hash_id, album_image), {}, @env
  end

  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access}

  context "when the user is the owner of the album" do
    Given(:user){create :user}
    Given(:album){create :album, :with_images, user: user}

    Then{expect(parsed_response['album_image']['id']).to eq album_image.id}
    And{expect(album.reload.album_images.size).to eq 1}
  end

  context "when the user is not the owner of the album" do
    Given(:user){create :user}
    Given(:album){create :album, :with_images}

    Then{expect(response.status).to eq 401}
  end
end
