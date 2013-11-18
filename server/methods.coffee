Meteor.startup ->
  if People.find().count() == 0
    Converter = Meteor.require("csvtojson").core.Converter
    csvConverter = new Converter()
    fn = Meteor.bindEnvironment ((jsonObj) ->
      for row in jsonObj.csvRows
        People.insert(row)), console.log
    csvConverter.on "end_parsed", fn
    csvConverter.from "/home/geoff/Code/apply/public/people.csv"

Meteor.publish "lookup", (email) ->
  NonEmptyString = Match.Where (x) ->
    check(x, String)
    return x.length > 0
  check(email, NonEmptyString)
  return People.find(email: email)
