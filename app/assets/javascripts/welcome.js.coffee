# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App = angular.module("deathNotes", ['ui.select2', 'ngRoute', 'templates', 'ngAnimate'])

App.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "inbox.html"
      ).when('/sent',
        templateUrl: "sent.html"
      ).when('/drafts',
        template: 'not done yet'
      ).when('/sentmessages/:id',
        templateUrl: 'sentmessage.html'
      ).when('/inboxmessages/:id',
        templateUrl: 'inboxmessage.html'
      )
])

App.controller("MessageBoxCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.toDos = [
    {'description': 'Wash the car', 'dueBy': Date.now()},
    {'description': 'Try out Angular.js on CodePen', 'dueBy': Date.now()}
  ]

  $scope.addToDo = ->
    formattedDate = Date.parse($scope.formDueDate)
    $scope.toDos.push({description:$scope.formToDo, dueBy: formattedDate})
    $scope.formToDo = ''
    $scope.formDueDate = ''

  $scope.removeToDo = (toDo) ->
    index = $scope.toDos.indexOf(toDo)
    $scope.toDos.splice(index, 1)


  # UI select2 options for New/Edit Message Modal
  $scope.select2Options = {
        'multiple': true,
        'simple_tags': true,
        'tags': [] # Can be empty list.
    }

  # Initialize Side Tabs
  $scope.initTabs = ->
    $scope.tabClasses = ["","",""]

  # Get Current Tab Class
  $scope.getTabClass =  (tabNum) ->
    return $scope.tabClasses[tabNum]

  # Set Active Side Tab
  $scope.setActiveTab = (tabNum) ->
    $scope.initTabs()
    $scope.tabClasses[tabNum] = "active"

  # Json call to load current user details
  $scope.loadCurrentUser = ->
    $http.get('/currentuser.json')
      .success (data) ->
        $scope.current_user_firstname = data.current_user.firstname
        $scope.current_user_lastname = data.current_user.lastname
        $scope.current_user_email = data.current_user.email
        $scope.current_user_credit = data.current_user.credit
      .error (data) ->
        console.log "error: ", data

  # Json call to load all messages
  $scope.loadMessages = ->
    $http.get('/messages.json')
      .success (data) ->
        $scope.received_messages = data.received_messages
        $scope.sent_messages = data.sent_messages
      .error (data) ->
        console.log "error: ", data

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

  # Load Sent Message Content
  $scope.loadMessageContent = (id) ->
    $scope.recipient_email_list = []
    for i in [0...$scope.sent_messages.length]
      message = $scope.sent_messages[i] if $scope.sent_messages[i].id == id
    for i in [0...message.recipients.length]
      $scope.recipient_email_list[i] = message.recipients[i].email
    $scope.title = message.title
    $scope.content = message.content
    $scope.message_id = id
    $scope.created_at = message.created_at

  # Load Inbox Message Content
  $scope.loadInboxMessageContent = (id) ->
    $http.get("/messages/#{id}.json")
      .success (data) ->
        $scope.message_id = data.id
        $scope.title = data.title
        $scope.content = data.content
        $scope.created_at = data.created_at
        $scope.sender_firstname = data.sender_firstname
        $scope.sender_lastname = data.sender_lastname
        $scope.sender_email = data.sender_email
      .error (data) ->
        console.log "error: ", data

  # Returns true if
  $scope.unlockButtonShow = (message, credit_cost) ->
    message.firstname == null && $scope.current_user_credit >= credit_cost

  # Unlock Message
  $scope.unlockMessage = (id) ->
    jsonObj = { message_id: id }

    jsonObj[$('meta[name=csrf-param]').attr('content')] = $('meta[name=csrf-token]').attr('content')
    $http.post('/messages/unlockMessage.json', jsonObj)
      .success (data) ->
        $scope.loadCurrentUser()
        $scope.loadMessages()
      .error (data) ->
        console.log "error: ", data

  # Json call to edit a new message
  $scope.editMessage = ->
    jsonObj = {
      recipient_email_list: $scope.recipient_email_list.join(),
      title: $scope.title,
      content: $scope.content
      message_id : $scope.message_id
    }
    jsonObj[$('meta[name=csrf-param]').attr('content')] = $('meta[name=csrf-token]').attr('content')

    $http.post('/messages/editMessage.json', jsonObj)
      .success (data) ->
        $scope.loadCurrentUser()
        $scope.loadMessages()
        $scope.initializeMessage()
      .error (data) ->
        console.log "error: ", data

  # Json call to submit a new message
  $scope.composeMessage = ->
    jsonObj = {
      recipient_email_list: $scope.recipient_email_list.join(),
      title: $scope.title,
      content: $scope.content
    }
    jsonObj[$('meta[name=csrf-param]').attr('content')] = $('meta[name=csrf-token]').attr('content')

    $http.post('/messages.json', jsonObj)
      .success (data) ->
        $scope.loadCurrentUser()
        $scope.loadMessages()
        $scope.initializeMessage()
      .error (data) ->
        console.log "error: ", data

  $scope.loadCurrentUser()
  $scope.loadMessages()
  $scope.initializeMessage()
  $scope.initTabs()
  $scope.setActiveTab(1)
])
