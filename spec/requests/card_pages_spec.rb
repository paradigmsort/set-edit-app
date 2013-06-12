require 'spec_helper'

describe "Card Pages" do
  subject { page }
  before { mock_image_server }

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

    describe "with empty form" do
      it "should not create a new card" do
        expect { click_button "Create" }.not_to change(Card, :count)
      end

      describe "after submission" do
        before { click_button "Create" }

        it { should have_title("New Card") }
        it { should have_content("error") }
      end
    end

    describe "with correct form" do
      before { fill_card_form(FactoryGirl.create(:card)) }

      it "should create a new card" do
        expect { click_button "Create" }.to change(Card, :count).by(1)
      end

      describe "after submission" do
        before { click_button("Create") }
        it { should have_title("")}
        it { should have_content("Added")}
      end
    end
  end

  describe "Card Page" do
    let(:card) { FactoryGirl.create(:card) }
    before { visit cards_path(card) }

    it { should have_content(card.name) }
  end
end
