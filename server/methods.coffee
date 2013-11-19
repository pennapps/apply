Meteor.publish "lookup", (email) ->
  NonEmptyString = Match.Where (x) ->
    check(x, String)
    return x.length > 0
  check(email, NonEmptyString)
  return People.find(email: email)

Apps.allow
  insert: -> true
  update: -> false
  remove: -> false
