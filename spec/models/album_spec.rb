require 'spec_helper'

describe Album do
  it{is_expected.to have_many :images}
  it{is_expected.to have_many :album_images}
  it{is_expected.to belong_to :user}

  describe "Album hash id" do
    Given(:hash_id){Picyo::Registry.hash_ids_albums.encode(subject.id)}
    subject{described_class.create}

    Then{expect(subject.hash_id).to eq hash_id}

  end
end
