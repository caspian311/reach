function expand_game_details(reach_id) {
   var original_row = $('#' + reach_id)

   if (is_expanded(original_row)) {
      original_row.removeClass('expanded')
      $('.game_details').remove()
   } else {
      original_row.addClass('expanded')

      var new_row_html = '<tr id="#' + reach_id + '_expanded" class="' + original_row.attr('class') + ' game_details"></tr>'
      var new_row = $(new_row_html)
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

   $.ajax({
      url: '/game_details/' + reach_id,
      dataType: 'json',
      success: function(game_details) {
         populate_game_details(details_cell, game_details)
      }, 
      error: function(xhr, ajax_options, thrown_error) {
         alert('ajax fail: ' + thrown_error);
      }
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

         var player_service_tag = "Unknown player"
         if (player) {
            player_service_tag = player["real_name"]
         }

         var player_kills = player_stat["kills"]
         var player_assists = player_stat["assists"]
         var player_deaths = player_stat["deaths"]
         var player_spread = (player_kills * 1) - (player_deaths * 1)

         var player_row_class = (t % 2 == 0) ? 'regular' : 'alternate'

         var player_row = $('<tr class="' + player_row_class + '"></tr>')
         details_table.append(player_row)

         player_row.append($('<td></td>'))
         player_row.append($('<td>' + player_service_tag + '</td>'))
         player_row.append($('<td>' + player_kills + '</td>'))
         player_row.append($('<td>' + player_assists + '</td>'))
         player_row.append($('<td>' + player_deaths + '</td>'))
         player_row.append($('<td>' + player_spread + '</td>'))
      }
   }
}

