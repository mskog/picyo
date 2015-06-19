require 'spec_helper'

describe "Albums#destroy", type: :request do
  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access[:album]}

  context "when the user owns the album" do
    Given(:user){create :user}
    Given(:album){create :album, :with_images, user: user}
    When do
      token_auth(user)
      delete api_v1_album_path(album.hash_id), {}, @env
    end

    Then{expect(Album.count).to eq 0}
    And{expect(AlbumImage.count).to eq 0}
    And{expect(parsed_response[:name]).to eq album.name}
  end

  context "when the user does not own the album" do
    Given(:user){create :user}
    Given(:album){create :album}
    When do
      token_auth(user)
      delete api_v1_album_path(album.hash_id), {}, @env
    end

    Then{expect(Album.count).to eq 1}
    And{expect(response.status).to eq 401}
  end

end
