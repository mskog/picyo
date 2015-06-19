require 'spec_helper'

describe "Albums#update", type: :request do
  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access[:album]}

  context "when the current user owns the album" do
    Given(:user){create :user}
    Given(:album){create :album, user: user}
    Given(:params){{album: {name: 'My Album'}}}
    When do
      token_auth(user)
      patch api_v1_album_path(album.hash_id, params), {}, @env
    end

    Given(:reloaded_album){album.reload}

    Then{expect(reloaded_album.name).to eq params[:album][:name]}
    And{expect(parsed_response[:name]).to eq params[:album][:name]}
  end

  context "when the current user does not own the album" do
    Given(:user){create :user}
    Given(:album){create :album, name: 'album'}
    Given(:params){{album: {name: 'My Album'}}}
    When do
      token_auth(user)
      patch api_v1_album_path(album.hash_id, params), {}, @env
    end

    Given(:reloaded_album){album.reload}

    Then{expect(reloaded_album.name).to eq 'album'}
    And{expect(response.status).to eq 401}
  end
end
