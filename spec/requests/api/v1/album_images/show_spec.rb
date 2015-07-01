require 'spec_helper'

describe "AlbumImages#show", type: :request do
  Given(:album){create :album}

  Given(:parsed_response){JSON.parse(response.body).with_indifferent_access}

  shared_examples 'album image' do
    context "when the user is the owner of the album" do
      Given(:user){create :user}
      Given(:image){create :image}
      Given(:album){create :album, images: [image], user: user}
      Then{expect(parsed_response[:album_image]['id']).to eq album.album_images.first.id}
      And{expect(parsed_response[:album_image]['image_id']).to eq image.hash_id}
    end

    context "when the user is not the owner of the album" do
      Given(:user){create :user}
      Given(:album){create :album, :with_images}

      Then{expect(response.status).to eq 401}
    end
  end

  context "with the nested route" do
    When do
      token_auth(user)
      get api_v1_album_image_path(album.id, album.album_images.first.id), {}, @env
    end

    include_examples 'album image'
  end

  context "with a flat route" do
    When do
      token_auth(user)
      get "/api/v1/album_images/#{album.album_images.first.id}", {}, @env
    end

    include_examples 'album image'
  end
end
