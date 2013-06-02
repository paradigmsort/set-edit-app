require 'spec_helper'

describe ApplicationHelper do
  describe "full_title" do
    it "should start with the base title" do
      full_title("foo").should =~ /^Set Editor/
    end

    it "should include the page title" do
      full_title("foo").should =~ /foo/
    end

    it "should not include a bar for pages with unspecialized names" do
      full_title("").should_not =~ /\|/
    end  
  end
end