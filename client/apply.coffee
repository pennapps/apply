Template.application.events
  'submit #email-form': (e) ->
    email = $('#email').val()
    Emails.insert(email)
    p = Meteor.call('lookup', email)

    Session.set("email", email)
    Session.set("person", p)
    return false

  'submit #application-form': (e) ->
    return false

Template.application.helpers
  person: -> Session.get("person")
  email: -> Session.get("email")
  submittedEmail: -> !!Session.get("email")
