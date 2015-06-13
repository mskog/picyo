require 'spec_helper'

describe "AlbumImages#show", type: :request do
  When do
    token_auth
    get api_v1_album_path(album.hash_id), {}, @env
  end

  Given(:parsed_response){JSON.parse(response.body)}

  context "authenticated request" do
    Given(:album){create :album, :with_images}

    Then{expect(parsed_response['album']["name"]).to eq album.name}
    And{expect(parsed_response['album']['image_ids']).to eq (album.images.map(&:hash_id))}
    And{expect(parsed_response["images"].first["id"]).to eq album.images.first.hash_id}
    And{expect(parsed_response["images"].last["id"]).to eq album.images.last.hash_id}
  end
end
