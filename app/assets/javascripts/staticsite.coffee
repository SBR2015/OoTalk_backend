## Place all the behaviors and hooks related to the matching controller here.
## All this logic will automatically be available in application.js.
## You can use CoffeeScript in this file: http://coffeescript.org/
#
##https://developer.github.com/v3/orgs/#list-user-organizations
## -> SBR2015 all user
## https://developer.github.com/v3/users/#get-a-single-user
#
$ ->
  $.ajax
    url: 'https://api.github.com/orgs/SBR2015/members'
    type:'GET'
    dataType: 'json'
    success: (data) ->
      line = ""
      for m_data in data
        img = "<img src=" + m_data.avatar_url + "/>"
        name = "<div id ='name'>" + m_data.login + "</div>"
        url = "<a href =" + m_data.html_url + ">" + img + name + "</a>"
        line += "<div id='profile-photo'>" + url + "</div>"
      $("#team-members").append(line)

    error: (XMLHttpRequest, textStatus, errorThrown) ->
      $("#team-info").append(m_info)
      console.log "Error"
