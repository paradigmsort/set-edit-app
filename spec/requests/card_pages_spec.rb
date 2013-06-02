require 'spec_helper'

describe "Card Pages" do
  subject { page }

  describe "Card Index" do
    before do
     5.times { FactoryGirl.create(:card) }
     visit cards_path
   end

    it { should have_title("Cards") }

    it "should list all the cards" do
      Card.all.each do | card |
        page.should have_selector('table tr', text: card.name)
      end
    end

    it { should have_link("New Card") }
  end

  describe "New Card" do
    before { visit new_card_path }
    it { should have_title("New Card") }
    it { should have_field("Name") }
    it { should have_field("Mana Cost") }
    it { should have_field("Type") }
    it { should have_field("Text") }
    it { should have_field("Power/Toughness") }
    it { should have_button("Create") }
  end
end
