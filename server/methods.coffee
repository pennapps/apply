Meteor.startup ->
  if People.find().count() == 0
    console.log 'there are no people'
    Converter = Meteor.require("csvtojson").core.Converter
    csvConverter = new Converter()
    csvConverter.on "end_parsed", (jsonObj) ->
      #People.insert(jsonObj.csvRows)
    csvConverter.from "/home/geoff/Code/apply/public/people.csv"

Meteor.methods
  lookup: (email) ->
    check(email, String)
    People.findOne(email: email)
