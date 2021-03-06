require 'spec_helper'

describe "Images#index with url", type: :request do
  When do
    get images_path(url: url)
  end

  context "with a url that works" do
    Given(:url){'http://www.example.com/image.jpg'}
    Given{stub_request(:get, url).to_return(headers: {content_type: 'image/jpeg'}, body: File.new('spec/fixtures/doll.jpg').read)}
    Then{expect(response).to redirect_to raw_image_path(Image.last.hash_filename)}
  end

  context "with a url that 404s" do
    Given(:url){'http://www.example.com/image.jpg'}
    Given{stub_request(:get, url).to_return(body: "some error", status: 404, headers: {content_type: 'text/html'})}
    Then{expect(response.status).to eq 404}
  end
end
