require 'spec_helper'

describe AlbumPolicy, type: :policy do
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

  context "Permissions" do
    subject { described_class.new(user, album) }

    context "when the user owns the album" do
      Given(:user){build_stubbed :user}
      Given(:album){build_stubbed :album, user: user}

      Then{expect(subject.update?).to be_truthy}
      And{expect(subject.destroy?).to be_truthy}
      And{expect(subject.show?).to be_truthy}
    end

    context "when the user does not own the album" do
      Given(:user){build_stubbed :user}
      Given(:album){build_stubbed :album}

      Then{expect(subject.update?).to be_falsy}
      And{expect(subject.destroy?).to be_falsy}
      And{expect(subject.show?).to be_falsy}
    end

    context "with no user" do
      Given(:user){nil}
      Given(:album){build_stubbed :album}

      Then{expect(subject.update?).to be_falsy}
      And{expect(subject.destroy?).to be_falsy}
      And{expect(subject.show?).to be_falsy}
    end
  end
end
