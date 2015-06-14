require 'spec_helper'

describe AlbumPolicy do

  subject { described_class.new(user,) }

  describe "Scope" do
    subject{AlbumPolicy::Scope.new(user,Album)}

    When(:result){subject.resolve}

    context "for the owner" do
      Given(:user){create :user}
      Given(:album){create :album, user: user}
      Given!(:other_album){create :album, user: create(:user)}

      Then{expect(result).to contain_exactly(album)}
    end
  end
end
