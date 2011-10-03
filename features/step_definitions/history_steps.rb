
Then /^I should see the following table data:$/ do |table|
   table.hashes.each_with_index do |data, index|
      data.keys.each do |type|
         wait_until { page.has_xpath?("//td[@class='#{type}']") }
         all("td.#{type}")[index].should have_content(data[type])
      end
   end
end

