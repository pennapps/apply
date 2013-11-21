NonEmptyString = Match.Where (x) ->
  check(x, String)
  return x.length > 0

Meteor.publish "lookup", (email) ->
  check(email, NonEmptyString)
  return People.find(email: email)

Meteor.methods
  apply: (app) ->
    check app,
      Match.ObjectIncluding
        email: NonEmptyString
        additional_info: NonEmptyString
        github: NonEmptyString
        linkedin: NonEmptyString
        name: NonEmptyString
        school: NonEmptyString
        team_info: String
        ts: Match.Any
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
