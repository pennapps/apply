Meteor.methods
  lookup: (email) ->
    check(email, String)
    People.findOne(email: email)
