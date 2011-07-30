require 'spec_helper'

describe "Medals" do
   fixtures :all

   before do
      @medal1_id = medals(:medal1).id
      @medal2_id = medals(:medal2).id
   end

   describe "medals page for medal 1" do
      it "should have the name and description" do
         get fetch_page_for_medal(@medal1_id)

         response.should have_selector("div.main-column div.title") do |div|
            div.should contain("Medals: Medal One")
         end

         response.should have_selector("div.main-column div.content") do |div|
            div.should contain("This is the first medal")
         end
      end
   end

   describe "medals page for medal 2" do
      it "should have the name and description" do
         get fetch_page_for_medal(@medal2_id)

         response.should have_selector("div.main-column div.title") do |div|
            div.should contain("Medals: Medal Two")
         end

         response.should have_selector("div.main-column div.content") do |div|
            div.should contain("This is the second medal")
         end
      end
   end

   describe "fetching all player counts for medal1" do
      it "a ordered list of all the players who have gotten medal 1" do
         get fetch_page_for_medal(@medal1_id)

         response.should have_selector("table tr", :count => 5)

         response.should have_selector("table tr:nth-child(2)") do |tr|
            tr.should have_selector("td:nth-child(1)", :content=> "Player Three")
            tr.should have_selector("td:nth-child(2)", :content=> "3")
         end

         response.should have_selector("table tr:nth-child(3)") do |tr|
            tr.should have_selector("td:nth-child(1)", :content=> "Player Two")
            tr.should have_selector("td:nth-child(2)", :content=> "2")
         end

         response.should have_selector("table tr:nth-child(4)") do |tr|
            tr.should have_selector("td:nth-child(1)", :content=> "Player Four")
            tr.should have_selector("td:nth-child(2)", :content=> "2")
         end

         response.should have_selector("table tr:nth-child(5)") do |tr|
            tr.should have_selector("td:nth-child(1)", :content=> "Player One")
            tr.should have_selector("td:nth-child(2)", :content=> "1")
         end
      end
   end
   
   describe "fetching all player counts for medal2" do
      it "a ordered list of all the players who have gotten medal 2" do
         get fetch_page_for_medal(@medal2_id)

         response.should have_selector("table tr", :count => 2)

         response.should have_selector("table tr:nth-child(2)") do |tr|
            tr.should have_selector("td:nth-child(1)", :content=> "Player Three")
            tr.should have_selector("td:nth-child(2)", :content=> "2")
         end
      end
   end

   def fetch_page_for_medal(medal_id)
      "/medals/#{medal_id}"
   end
end


