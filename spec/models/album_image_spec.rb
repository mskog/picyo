require 'spec_helper'

describe AlbumImage do
  it{is_expected.to belong_to :album}
  it{is_expected.to belong_to :image}
end
