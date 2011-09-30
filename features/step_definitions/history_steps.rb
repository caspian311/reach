
Then /^I should see the following table data:$/ do |table|
   table.hashes.each do |row|
      row.keys.each do |header|
         value = row[header]
         find("td.#{header}").should have_content(value)
      end
   end
end

