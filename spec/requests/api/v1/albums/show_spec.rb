require 'spec_helper'

describe "Album#show", type: :request do
  When do
    token_auth
    get api_v1_album_path(album.hash_id), {}, @env
  end

  Given(:parsed_response){JSON.parse(response.body)}

  context "authenticated request" do
    Given(:album){create :album, :with_images}

    Then{expect(parsed_response['album']["name"]).to eq album.name}
    And{expect(parsed_response['album']['album_image_ids']).to eq (album.album_images.map(&:id))}
  end
end
