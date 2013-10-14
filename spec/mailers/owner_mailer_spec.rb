require "spec_helper"

describe OwnerMailer do
  describe "registration" do
    let(:new_user) { FactoryGirl.create(:owner) }
    let(:mail) { OwnerMailer.registration(new_user) }

    it "renders the headers" do
      mail.subject.should eq("Launch 'n Dine Welcomes You")
      mail.to.should eq([new_user.email])
      mail.from.should eq(["hello@launchndine.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Launch 'n Dine")
    end
  end

end
