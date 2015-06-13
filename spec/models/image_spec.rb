require 'spec_helper'

describe Image do
  it{is_expected.to have_many :album_images}
  it{is_expected.to have_many :albums}

  describe "Creating an Image" do
    context "with an image file" do
      Given(:file){File.new('spec/fixtures/doll.jpg')}
      Given(:hash_id){Picyo::Registry.hash_ids_images.encode(subject.id)}
      subject{described_class.create(file: file)}

      Then{expect(subject.file_size).to eq 13951}
      And{expect(subject.hash_id).to eq hash_id}
      And{expect(subject.file_content_type).to eq 'image/jpeg'}
      And{expect(subject.file_filename).to eq 'doll.jpg'}
      And{expect(subject.hash_filename).to eq "#{hash_id}.jpg"}
      And{expect(subject.width).to eq 239}
      And{expect(subject.height).to eq 180}
    end

    context "with a non image file" do
      Given(:file){File.new('spec/fixtures/test.txt')}
      subject{described_class.create(file: file)}
      Then{expect(subject).to be_invalid}
      And{expect(subject).to_not be_persisted}
    end
  end
end
