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
      let(:card) { FactoryGirl.create(:card) }
      before { fill_card_form(card) }

      it "should create a new card" do
        expect { click_button "Create" }.to change(Card, :count).by(1)
      end

      describe "after submission" do
        before { click_button("Create") }
        it { should have_title(card.name) }
        it { should have_content("Added") }
      end
    end
  end

  describe "Card Page" do
    let(:card) { FactoryGirl.create(:card) }
    let(:comment) { FactoryGirl.create(:comment, card: card) }
    before do
      comment.save
      visit card_path(card)
    end

    it { should have_selector("img", alt: card.name) }
    it { should have_content(comment.content) }
    it { should have_link ("Back to set") }
    it { should have_link("Edit card", path: edit_card_path(card)) }

    describe "when not signed in" do
      it { should have_content("Sign in to comment") }
    end

    describe "when signed in" do
      before do
        @user = FactoryGirl.create(:user)
        sign_in @user
        visit card_path(card)
      end

      it { should_not have_content("Sign in") }
      it { should have_button("Comment") }

      describe "submitting empty form" do
        it "should not create a comment" do
          expect { click_button "Comment" }.not_to change(Comment, :count)
        end
      end

      describe "submitting valid form" do
        before { fill_comment_form(FactoryGirl.create(:comment, card: card, user: @user)) }
        it "should create a comment" do
          expect { click_button "Comment" }.to change(Comment, :count).by(1)
        end
      end
    end
  end

  describe "Edit card page" do
    let(:card) { FactoryGirl.create(:card) }
    before { visit edit_card_path(card) }

    it { should have_title("Edit Card") }
    it { should have_field("Name", text: card.name) }
    it { should have_field("Mana Cost", text: card.cost) }
    it { should have_field("Type", text: card.typeline) }
    it { should have_field("Text", text: card.text) }
    it { should have_field("Power/Toughness", text: card.power_toughness) }
    it { should have_button("Update") }

    describe "when contents are changed" do
      before do
        card.name = "New Name"
        fill_in "Name", with: card.name
      end
      describe "for commentless card" do
        it "should not create a new card" do
          expect { click_button "Update"}.not_to change(Card, :count)
        end

        describe "on submission" do
          before { click_button "Update" }

          it { should have_title(card.name) }
          it { should have_content("Updated") }
        end
      end
    end
  end
end
