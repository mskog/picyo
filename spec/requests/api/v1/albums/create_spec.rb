require 'spec_helper'

describe "Albums#create", type: :request do
  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access[:album]}

  context "authenticated request" do
    Given(:user){create :user}
    Given(:params){{album: {name: 'My Album'}}}
    When do
      token_auth(user)
      post api_v1_albums_path(params), {}, @env
    end

    Given(:expected_album){Album.first}

    Then{expect(expected_album.name).to eq params[:album][:name]}
    And{expect(expected_album.user).to eq user}
    And{expect(parsed_response[:name]).to eq params[:album][:name]}
    And{expect(parsed_response[:id]).to eq expected_album.hash_id}
  end
end
