# http://stackoverflow.com/questions/901115/how-can-i-get-query-string-values-in-javascript
getUrlParams = (a) ->
  a = a.split("&")
  return {} unless a.length
  b = {}

  for p in a
    p = p.split("=")
    continue unless p.length is 2
    b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "))
  return b

# http://stackoverflow.com/questions/1184624/convert-form-data-to-js-object-with-jquery/8407771#8407771
jQuery.fn.serializeObject = ->
  arrayData = @serializeArray()
  objectData = {}

  $.each arrayData, ->
    if @value?
      value = @value
    else
      value = ''

    if objectData[@name]?
      unless objectData[@name].push
        objectData[@name] = [objectData[@name]]

      objectData[@name].push value
    else
      objectData[@name] = value
  return objectData

params = getUrlParams window.location.search.substr(1)
Session.set("email", params.email)

Template.main.helpers
  submitted: -> !!Session.get("submitted")

Template.application.events
  'submit #email-form': (e) ->
    email = $('#email').val()
    Emails.insert(email)
    p = Meteor.call('lookup', email)

    Session.set("email", email)
    Session.set("person", p)
    return false

  'submit #application-form': (e) ->
    app = $('#application-form').serializeObject()
    console.log(app)
    Apps.insert(app)  # should we do this on the server so we can rate limit and shit?
    # reflect that they're done
    Session.set("submitted", true)
    return false

Template.application.helpers
  person: -> Session.get("person") or {email: Session.get("email")}
