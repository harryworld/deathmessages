# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App = angular.module("deathNotes", ['ui.select2', 'ngRoute', 'templates', 'ngAnimate'])

# App = angular.module("deathNotes", ['Devise'])

App.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "inbox.html",
        controller: 'TestCtrl'
      ).when('/sent',
        templateUrl: "sent.html",
        controller: 'TestCtrl'
      ).when('/drafts',
        template: 'not done yet'
      ).when('/messages/:id',
        template: 'not done yet'
      )

    console.log "I AM IN App.config"
])

App.controller("MessageBoxCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.select2Options = {
        'multiple': true,
        'simple_tags': true,
        'tags': []  # Can be empty list.
    }

  # Json call to load current user details
  $scope.loadCurrentUser = ->
    $http.get('/currentuser.json')
      .success (data) ->
        # console.log data
        $scope.current_user_firstname = data.current_user.firstname
        $scope.current_user_lastname = data.current_user.lastname
        $scope.current_user_email = data.current_user.email
        $scope.current_user_credit = data.current_user.credit
      .error (data) ->
        console.log data

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
  $scope.initializeMessage = ->
    $scope.recipient_email_list = []
    $scope.title = ""
    $scope.content = ""

  # Load Message Content
  $scope.loadMessageContent = (id) ->
    $scope.recipient_email_list = []
    for i in [0...$scope.sent_messages.length]
      message = $scope.sent_messages[i] if $scope.sent_messages[i].id == id
    for i in [0...message.recipients.length]
      $scope.recipient_email_list[i] = message.recipients[i].email
    $scope.title = message.title
    $scope.content = message.content
    $scope.message_id = id

  # Returns true if
  $scope.unlockButtonShow = (message, credit_cost) ->
    message.firstname == null && $scope.current_user_credit >= credit_cost

  # Unlock Message
  $scope.unlockMessage = (id) ->
    jsonObj = { message_id: id }
    console.log id
    console.log jsonObj
    jsonObj[$('meta[name=csrf-param]').attr('content')] = $('meta[name=csrf-token]').attr('content')
    $http.post('/messages/unlockMessage.json', jsonObj)
      .success (data) ->
        console.log data
        $scope.loadCurrentUser()
        $scope.loadMessages()
      .error (data) ->
        console.log data

  # Json call to edit a new message
  $scope.editMessage = ->
    jsonObj = {
      recipient_email_list: $scope.recipient_email_list.join(),
      title: $scope.title,
      content: $scope.content
      message_id : $scope.message_id
    }
    jsonObj[$('meta[name=csrf-param]').attr('content')] = $('meta[name=csrf-token]').attr('content')
    console.log jsonObj
    $http.post('/messages/editMessage.json', jsonObj)
      .success (data) ->
        console.log data
        $scope.loadCurrentUser()
        $scope.loadMessages()
        $scope.initializeMessage()
        console.log "New Message Success"
      .error (data) ->
        console.log data
        console.log "New Message Fail"

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
        console.log data
        $scope.loadCurrentUser()
        $scope.loadMessages()
        $scope.initializeMessage()
        console.log "New Message Success"
      .error (data) ->
        console.log data
        console.log "New Message Fail"

  $scope.loadCurrentUser()
  $scope.loadMessages()
  $scope.initializeMessage()
])

App.controller("TestCtrl", [ '$scope', '$location', ($scope,$location)->
  console.log "I AM IN TestCtrl"
])
