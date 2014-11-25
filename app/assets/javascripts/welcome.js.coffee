# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App = angular.module("deathNotes", ['ui.select2', 'ngRoute', 'templates'])

# App = angular.module("deathNotes", ['Devise'])

# App.config([ '$routeProvider',
#   ($routeProvider)->
#     $routeProvider
#       .when('/',
#         templateUrl: "inbox.html"
#         controller: 'TestCtrl'
#       ).when('/inbox',
#         templateUrl: "inbox.html"
#         controller: 'TestCtrl'
#       ).when('/sent',
#         templateUrl: "sent.html"
#         controller: 'TestCtrl'
#       )
#     console.log "I AM IN App.config"
# ])

App.controller("MessageBoxCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.select2Options = {
        'multiple': true,
        'simple_tags': true,
        'tags': []  # Can be empty list.
    }

  # Json call to load all messages
  $scope.loadMessages = ->
    $http.get('/messages.json')
      .success (data) ->
        # console.log data
        $scope.received_messages = data.received_messages
        $scope.sent_messages = data.sent_messages
        # console.log data.received_messages
      .error (data) ->
        # console.log data

  # Returns Name if exist else returns Email
  $scope.getName = (message) ->
    if message.firstname != null
      message.firstname + " " + message.lastname
    else
      message.email

  # Initialize Values
  $scope.initialize = ->
    $scope.recipient_email_list = []

  # Show unlock Button or not
  $scope.unlockButtonShow = (message) ->
    message.firstname == null


  # Unlock Message
  $scope.unlockMessage = (id) ->
    jsonObj = { message_id: id }
    console.log id
    console.log jsonObj
    jsonObj[$('meta[name=csrf-param]').attr('content')] = $('meta[name=csrf-token]').attr('content')
    $http.post('/messages/unlock.json', jsonObj)
      .success (data) ->
        console.log data
        $scope.loadMessages()
      .error (data) ->
        console.log data

  # Json call to submit a new message
  $scope.composeMessage = ->
    jsonObj = {
      recipient_email_list: $scope.recipient_email_list.join(),
      title: $scope.title,
      content: $scope.content
    }
    jsonObj[$('meta[name=csrf-param]').attr('content')] = $('meta[name=csrf-token]').attr('content')
    console.log jsonObj
    $http.post('/messages.json', jsonObj)
      .success (data) ->
        # console.log data
        $scope.loadMessages()
        $scope.initialize()
      .error (data) ->
        console.log data

  $scope.loadMessages()
  $scope.initialize()
])

App.controller("TestCtrl", [ '$scope', '$location', ($scope,$routeParams,$location)->
  console.log "I AM IN TestCtrl"
])