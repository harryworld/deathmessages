# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App = angular.module("deathNotes", ['ui.select', 'ngRoute'])

# App = angular.module("deathNotes", ['Devise'])

App.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "/messages"
        controller: 'TestCtrl'
      ).when('/inbox',
        templateUrl: "/messages"
        controller: 'TestCtrl'
      ).when('/sent',
        templateUrl: "/messages/sent.html"
        controller: 'TestCtrl'
      )
    console.log "I AM IN App.config"
])

App.controller("MessageBoxCtrl", ["$scope", "$http", ($scope, $http) ->
  $scope.availableColors = ['Red','Green','Blue','Yellow','Magenta','Maroon','Umbra','Turquoise'];

  $scope.multipleDemo = {};
  $scope.multipleDemo.colors = ['Blue','Red'];

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
  $scope.getName = (m) ->
    if m.firstname != null
      m.firstname + " " + m.lastname
    else
      m.email

  # Json call to submit a new message
  $scope.composeMessage = ->
    jsonObj = {
      recipient_email_list: $scope.recipient_email_list,
      title: $scope.title,
      content: $scope.content
    }
    jsonObj[$('meta[name=csrf-param]').attr('content')] = $('meta[name=csrf-token]').attr('content')
    # console.log jsonObj
    $http.post('/messages.json', jsonObj)
      .success (data) ->
        # console.log data
        $scope.loadMessages()
      .error (data) ->
        console.log data

  $scope.loadMessages()
])

App.controller("TestCtrl", [ '$scope', '$location', ($scope,$routeParams,$location)->
  console.log "I AM IN TestCtrl"
])