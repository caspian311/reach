function expand_game_details(reach_id) {
   var original_row = $('#' + reach_id)

   if (is_expanded(original_row)) {
      original_row.removeClass('expanded')
      $('#' + reach_id +'_game_details').remove()
   } else {
      original_row.addClass('expanded')

      var new_row = $('<tr id="' + reach_id + '_game_details" class="' + original_row.attr('class') + ' game_details"></tr>')
      new_row.append('<td></td>')

      var details_cell = $('<td colspan="4"></td>')

      new_row.append(details_cell)
      new_row.insertAfter(original_row)

      fetch_game_details(details_cell, reach_id)
   }
}

function is_expanded(row) {
   var row_class = row.attr('class')
   return row_class.indexOf('expanded') != -1
}

function fetch_game_details(details_cell, reach_id) {
   details_cell.append('<div style="text-align: center">Loading...</div>')

   $.getJSON('/game_details/' + reach_id, function(data){
      populate_game_details(details_cell, data)
   })
}

function populate_game_details(details_cell, game_details) {
   details_cell.empty()

   var details_table = $('<table></table>')
   details_cell.append(details_table)

   for (var i=0; i<game_details["reach_game"]["reach_teams"].length; i++) {
      var team = game_details["reach_game"]["reach_teams"][i]

      var team_id = team["team_id"]
      var team_score = team["score"]

      var team_row = $('<tr></tr>')
      details_table.append(team_row)

      team_row.append($('<th>Team ' + ((team_id * 1) + 1) + '</th>'))
      team_row.append($('<th>' + team_score + '</th>'))
      team_row.append($('<th>Kills</th>'))
      team_row.append($('<th>Assists</th>'))
      team_row.append($('<th>Deaths</th>'))
      team_row.append($('<th>Spread</th>'))

      for (var t=0; t<team["reach_player_stats"].length; t++) {
         var player_stat = team["reach_player_stats"][t]
         var player = player_stat["player"]

         var player_name = "Unknown player"
         if (player) {
            player_name = player["real_name"]
         }

         var player_kills = player_stat["kills"]
         var player_assists = player_stat["assists"]
         var player_deaths = player_stat["deaths"]
         var player_spread = (player_kills * 1) - (player_deaths * 1)

         var player_row_class = (t % 2 == 0) ? 'regular' : 'alternate'

         var player_stat_id = player_stat['id']

         var player_row = $('<tr id="' + player_stat_id + '_player_details" class="' + player_row_class + '"></tr>')
         details_table.append(player_row)

         player_row.append($('<td></td>'))
         player_row.append($('<td><a href="#" onclick="expand_player_carnage_report(' + player_stat_id + ')">' + player_name + '</a></td>'))
         player_row.append($('<td>' + player_kills + '</td>'))
         player_row.append($('<td>' + player_assists + '</td>'))
         player_row.append($('<td>' + player_deaths + '</td>'))
         player_row.append($('<td>' + player_spread + '</td>'))
      }
   }
}

function expand_player_carnage_report(player_stat_id) {
   var original_row = $('#' + player_stat_id + '_player_details')

   if (is_expanded(original_row)) {
      original_row.removeClass('expanded')
      $('#' + player_stat_id +'_weapon_details').remove()
   } else {
      original_row.addClass('expanded')

      var new_row = $('<tr id="' + player_stat_id + '_weapon_details" class="' + original_row.attr('class') + '"></tr>')

      var new_cell = $('<td colspan="5"></td>')
      new_row.append('<td></td>')      
      new_row.append(new_cell)
      new_row.insertAfter(original_row)

      var tabs_container = $('<div class="tabs-container"></div>')
      var tabs_labels = $('<div class="tabs-labels"></div>')
      var carnage_report_tab = $('<div class="tab selected">Carnage Report</div>')
      var medals_tab = $('<div class="tab">Medals</div>')

      tabs_container.append(tabs_labels)
      tabs_labels.append(carnage_report_tab).append(medals_tab)

      var tabs_bodies = $('<div class="tabs-bodies"></div>')
      var carnage_report_body = $('<div class="tab-content selected"></div>')
      var medals_body = $('<div class="tab-content"></div>')
      
      tabs_bodies.append(carnage_report_body).append(medals_body)
      tabs_container.append(tabs_bodies)

      new_cell.append(tabs_container)

      populate_player_carnage_report(carnage_report_body, player_stat_id);
   }
}

function populate_player_carnage_report(new_cell, player_stat_id) {
   new_cell.append("<div style=\"text-align:center\">Loading...</div>")
   $.getJSON('/carnage_report/' + player_stat_id, function(data) {
      new_cell.empty()
      var carnage_report_table = $("<table></table>")
      var header_row = $('<tr></tr>')
      header_row.append('<th>Weapon</th>')
      header_row.append('<th>Kills</th>')
      header_row.append('<th>Deaths</th>')
      header_row.append('<th>Headshots</th>')
      header_row.append('<th>Penalties</th>')
      carnage_report_table.append(header_row)
      for (var i=0; i<data.length; i++) {
            var weapon = data[i]['reach_weapon_carnage_report']['weapon']['name']
            var weapon_description = data[i]['reach_weapon_carnage_report']['weapon']['description']
            var kills = data[i]['reach_weapon_carnage_report']['kills']
            var deaths = data[i]['reach_weapon_carnage_report']['deaths']
            var headshots = data[i]['reach_weapon_carnage_report']['head_shots']
            var penalties = data[i]['reach_weapon_carnage_report']['penalties']

            var row_class = i % 2 == 0 ? 'regular' : 'alternate'

            var detail_row = $('<tr class="' + row_class + '"></tr>')
            var weapon_cell = $('<td id="weapon_cell_' + i + '"></td>')
            weapon_cell.append(weapon)
            weapon_cell.append('<input id="weapon_description_' + i + '" type="hidden" value="' + weapon_description + '" />')

            weapon_cell.css('cursor', 'pointer')
            weapon_cell.click(function(event) {
               var hidden_input = $('td#' + event.target.id + ' input')
               var weapon_description = hidden_input.val()
               $('#weapon_description_body').empty().append(weapon_description)
               $('#weapon_description_window').css('left', event.pageX).css('top', event.pageY).fadeIn()
               $('#weapon_description_close').click(function() {
                  $('#weapon_description_window').fadeOut()
               })
            })
            detail_row.append(weapon_cell)
            detail_row.append('<td>' + kills + '</td>')
            detail_row.append('<td>' + deaths + '</td>')
            detail_row.append('<td>' + headshots + '</td>')
            detail_row.append('<td>' + penalties + '</td>')

            carnage_report_table.append(detail_row)
      }
      new_cell.append(carnage_report_table)
   })
}
