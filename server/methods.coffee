Meteor.startup ->
  if People.find().count() == 0
    Converter = Meteor.require("csvtojson").core.Converter
    csvConverter = new Converter()
    fn = Meteor.bindEnvironment ((jsonObj) ->
      for row in jsonObj.csvRows
        People.insert(row)), (e) -> console.log e
    csvConverter.on "end_parsed", fn
    csvConverter.from "/home/geoff/Code/apply/public/people.csv"

Meteor.publish "lookup", (email) ->
  check(email, String)
  return People.find(email: email)
