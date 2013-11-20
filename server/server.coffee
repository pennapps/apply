NonEmptyString = Match.Where (x) ->
  check(x, String)
  return x.length > 0

Meteor.publish "lookup", (email) ->
  check(email, NonEmptyString)
  return People.find(email: email)

Meteor.methods
  apply: (app) ->
    check(app, Object)
    Apps.insert(app)
    # need to set MAIL_URL
    ###
    Email.send
      to: app.email
      from: "contact@pennapps.com"
      subject: "[PennApps] It's a date!"
      text: "Thanks for applying"
    ###

Emails.allow
  insert: -> true
  update: -> false
  remove: -> false
