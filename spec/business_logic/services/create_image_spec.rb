require 'spec_helper'

describe Services::CreateImage do
  subject{described_class.new(params)}

  context "#perform_later" do
    Given{expect(ImageUploadJob).to receive(:perform_later).with(params)}
    Given(:params){{url: 'test', album_id: 'test2'}}
    When{subject.perform_async}
    Then{}
  end

  describe "#perform" do
    Given(:url){'http://www.example.com/image.jpg'}
    Given(:fixture){File.new('spec/fixtures/doll.jpg')}
    Given{stub_request(:get, url).to_return(body: fixture.read, headers: {"content_type" => 'image/jpeg'})}
    When(:result){subject.perform}

    context "with a new image" do
      context "with no album" do
        Given(:params){{url: url}}
        Then{expect(result).to be_a(Image)}
        And{expect(Image.count).to eq 1}
        And{expect(result.albums).to be_empty}
      end

      context "with an album" do
        Given(:params){{url: url, album_id: album.hash_id}}
        Given(:album){create :album}
        Then{expect(result).to be_a(AlbumImage)}
        And{expect(Image.count).to eq 1}
        And{expect(result.album).to eq album}
        And{expect(result.image.original_url).to eq url}
      end
    end
  end
end
