require 'spec_helper'

describe "Album#show", type: :request do
  When do
    token_auth(user)
    get api_v1_album_path(album.hash_id), {}, @env
  end

  Given(:parsed_response){JSON.parse(response.body)}

  context "when the user owns the album" do
    Given(:user){create :user}
    Given(:album){create :album, :with_images, user: user}

    Then{expect(parsed_response['album']["name"]).to eq album.name}
  end

  context "when the user does not own the album" do
    Given(:user){create :user}
    Given(:album){create :album}
    Then{expect(response.status).to eq 401}
  end
end
