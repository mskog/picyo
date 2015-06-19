require 'spec_helper'

describe "Albums#update", type: :request do
  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access[:album]}

  context "authenticated request" do
    Given(:user){create :user}
    Given(:album){create :album}
    Given(:params){{album: {name: 'My Album'}}}
    When do
      token_auth(user)
      patch api_v1_album_path(album.hash_id, params), {}, @env
    end

    Given(:reloaded_album){album.reload}

    Then{expect(reloaded_album.name).to eq params[:album][:name]}
    And{expect(parsed_response[:name]).to eq params[:album][:name]}
  end
end
