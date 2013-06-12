include ApplicationHelper

def fill_card_form(card)
  fill_in "Name", with: card.name
  fill_in "Cost", with: card.cost
  fill_in "Type", with: card.typeline
  fill_in "Text", with: card.text
  fill_in "Power/Toughness", with: card.power_toughness
end

def mock_image_server
  stub_request(:post, 'http://' + ENV['cloud_image_builder_url'] + ':' + ENV['cloud_image_builder_port'] + '/images')
end

RSpec::Matchers.define :have_title do |title|
  match do |page|
    if title.empty?
      page.should have_selector('title', text: full_title(title)) && have_no_selector('title', text: "|")
    else
      page.should have_selector('title', text: full_title(title))
    end
  end

  failure_message_for_should do |page|
    "should have title #{full_title(title)} but instead has #{page.html}"
  end
end
