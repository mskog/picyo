require 'spec_helper'

describe "AlbumImages#index", type: :request do
  Given(:album){create :album}

  When do
    token_auth
    get api_v1_album_images_path(album.hash_id), {}, @env
  end

  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access}

  context "authenticated request" do
    Given(:album){create :album, :with_images}

    Then{expect(parsed_response[:album_images].first[:id]).to eq album.images.first.hash_id}
    And{expect(parsed_response[:album_images].last[:id]).to eq album.images.last.hash_id}
  end
end
