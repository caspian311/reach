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

function fetch_game_details(details_cell, game_id) {
   details_cell.append('<div style="text-align: center">Loading...</div>')

   $.getJSON('/game_details/' + game_id, function(data){
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

         var player_row_class = (t % 2 == 0) ? 'alternate' : 'regular'

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

      var tabs_container = $('<div id="' + player_stat_id + '-tabs-container" class="tabs-container"></div>')
      var tabs_labels = $('<div class="tabs-labels"></div>')
      var carnage_report_tab = $('<div id="' + player_stat_id + '-carnage-report-tab" class="tab">Carnage Report</div>')
      var medals_tab = $('<div id="' + player_stat_id + '-medals-tab" class="tab">Medals</div>')

      var tabs_bodies = $('<div id="' + player_stat_id + '-tabs-bodies" class="tabs-bodies"></div>')
      var carnage_report_body = $('<div id="' + player_stat_id + '-carnage-report-body" class="tab-content"></div>')
      var medals_body = $('<div id="' + player_stat_id + '-medals-body" class="tab-content"></div>')
      
      medals_tab.click(function() {
         populate_medals(player_stat_id)
      })
      carnage_report_tab.click(function() {
         populate_carnage_report(player_stat_id)
      })

      tabs_container.append(tabs_labels)
      tabs_labels.append(carnage_report_tab).append(medals_tab)
      tabs_bodies.append(carnage_report_body).append(medals_body)
      tabs_container.append(tabs_bodies)

      new_cell.append(tabs_container)

      populate_carnage_report(player_stat_id);
   }
}

function populate_medals(player_stat_id) {
   $('#' + player_stat_id + '-tabs-container .tab').removeClass('selected')
   $('#' + player_stat_id + '-tabs-container .tab-content').removeClass('selected')
   $('#' + player_stat_id + '-medals-tab').addClass('selected')
   $('#' + player_stat_id + '-medals-body').addClass('selected')

   $('#' + player_stat_id + '-medals-body').append('<div style="text-align:center">Loading...</div>')

   $.getJSON('/medals_history/' + player_stat_id, function(data) {
      var medals_table = $('<table></table>')
      var header_row = $('<tr></tr>')
      header_row.append('<th>Medal</th>')
      header_row.append('<th>Count</th>')
      medals_table.append(header_row)

      for (var i=0; i<data.length; i++) {
         var medal = data[i]['reach_player_medal']['medal']['name']
         var description = data[i]['reach_player_medal']['medal']['description']
         var image = data[i]['reach_player_medal']['medal']['image']
         var count = data[i]['reach_player_medal']['count']

         var medal_row = $('<tr></tr>')
         medal_row.addClass(i % 2 == 0 ? 'alternate' : 'regular')

         var medal_cell = $('<td></td>')
         medal_cell.append('<input name="name" type="hidden" value="' + medal + '" />')
         medal_cell.append('<input name="description" type="hidden" value="' + description + '" />')
         medal_cell.append('<img class="medal" src="/images/medals/' + image + '.png" title="' + medal + '" />')
         medal_cell.css('cursor', 'pointer')
         medal_cell.click(function(event) {
            var medal_name = $('input[name="name"]', this).val()
            var medal_description = $('input[name="description"]', this).val()

            show_description_window(medal_name, medal_description, event.pageX, event.pageY)
         })
         medal_row.append(medal_cell)
         medal_row.append('<td>' + count + '</td>')

         medals_table.append(medal_row)
      }

      $('#' + player_stat_id + '-medals-body').empty().append(medals_table)
   })
}

function populate_carnage_report(player_stat_id) {
   $('#' + player_stat_id + '-tabs-container .tab').removeClass('selected')
   $('#' + player_stat_id + '-tabs-container .tab-content').removeClass('selected')
   $('#' + player_stat_id + '-carnage-report-tab').addClass('selected')
   $('#' + player_stat_id + '-carnage-report-body').addClass('selected')

   $('#' + player_stat_id + '-carnage-report-body').append("<div style=\"text-align:center\">Loading...</div>")
   $.getJSON('/carnage_report/' + player_stat_id, function(data) {
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
            var weapon_image = data[i]['reach_weapon_carnage_report']['weapon']['image']
            var kills = data[i]['reach_weapon_carnage_report']['kills']
            var deaths = data[i]['reach_weapon_carnage_report']['deaths']
            var headshots = data[i]['reach_weapon_carnage_report']['head_shots']
            var penalties = data[i]['reach_weapon_carnage_report']['penalties']

            var detail_row = $('<tr></tr>')
            detail_row.addClass(i % 2 == 0 ? 'alternate' : 'regular')

            var weapon_cell = $('<td></td>')
            weapon_cell.append('<div class="reach_weapons ' + weapon_image + '"></div>')
            weapon_cell.append('<div>' + weapon + '</div>')
            weapon_cell.append('<input name="name" type="hidden" value="' + weapon + '" />')
            weapon_cell.append('<input name="description" type="hidden" value="' + weapon_description + '" />')

            weapon_cell.css('cursor', 'pointer')
            weapon_cell.click(function(event) {
               var weapon = $('input[name="name"]', this).val()
               var weapon_description = $('input[name="description"]', this).val()

               show_description_window(weapon, weapon_description, event.pageX, event.pageY)
            })
            detail_row.append(weapon_cell)
            detail_row.append('<td>' + kills + '</td>')
            detail_row.append('<td>' + deaths + '</td>')
            detail_row.append('<td>' + headshots + '</td>')
            detail_row.append('<td>' + penalties + '</td>')

            carnage_report_table.append(detail_row)
      }
      $('#' + player_stat_id + '-carnage-report-body').empty().append(carnage_report_table)
   })
}

function show_description_window(title, body, left, top) {
   $('#description_header').empty().append(title)
   $('#description_body').empty().append(body)
   $('#description_window').css('left', left).css('top', top).fadeIn()
   $('#description_close').click(function() {
      $('#description_window').fadeOut()
   })
}
