
Then /^I should see the following table data:$/ do |table|
   table.hashes.each_with_index do |data, index|
      wait_until do 
         first_element = table.raw[0][0]
         page.has_xpath?("//td[@class='#{first_element}']")
      end

      data.keys.each do |class_name|
         value = data[class_name]
         node = all("td.#{class_name}")[index]
         
         node.should have_content(value)
      end
   end
end

