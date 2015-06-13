require 'spec_helper'
require 'digest/md5'

describe "Images#show_raw", type: :request do
  When do
    get raw_image_path(hash_filename)
  end

  context "an existing image" do
    Given!(:image){create :image}
    Given(:hash_filename){image.hash_filename}
    Then{expect(Digest::MD5.hexdigest(response.body)).to eq Digest::MD5.hexdigest(File.read('spec/fixtures/doll.jpg'))}
    And{expect(response['Content-Type']).to eq image.file_content_type}
  end

  context "an image that does not exist" do
    Given(:hash_filename){'something.jpg'}
    Then{expect(response.status).to eq 404}
  end
end
