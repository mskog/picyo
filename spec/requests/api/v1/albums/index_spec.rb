require 'spec_helper'

describe "AlbumImages#index", type: :request do
  Given(:user){create :user}
  When do
    token_auth(user)
    get api_v1_albums_path, {}, @env
  end

  Given(:parsed_response){JSON.parse(response.body)}

  context "authenticated request" do
    Given!(:album){create :album, user: user}
    Given(:other_user){create :user}
    Given!(:other_album){create :album, user: other_user}
    Then{expect(parsed_response['albums'].count).to eq 1}
    And{expect(parsed_response['albums'].first["id"]).to eq album.hash_id}
  end
end
