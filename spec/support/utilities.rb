include ApplicationHelper

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