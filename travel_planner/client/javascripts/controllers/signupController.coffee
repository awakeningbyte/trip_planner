angular.module("TravePlannerApp.contorller.signupController",[])
.controller("signupController", ['$state', '$scope', '$http', '$stateParams', 'users', ($state, $scope, $http, $stateParams, data)->
  $scope.data = {}
  target = {}
  if $stateParams.idx
    target = data.users[$stateParams.idx]
    $scope.data.username = target.username
    $scope.data.firstname = target.firstname
    $scope.data.lastname = target.lastname
    $scope.data.email = target.email
    $scope.data.id = target.id

  $scope.isValid = ->
    !!($scope.data.firstname and $scope.data.lastname and $scope.data.username and $scope.data.password and $scope.data.password_confirmation and $scope.data.email and ($scope.data.password == $scope.data.password_confirmation))
  
  $scope.signup = ->
    if $stateParams.idx
      $http
      .put '/users/'+$scope.data.id, { user: $scope.data }
      .then (result) ->
        target.username = $scope.data.username 
        target.firstname = $scope.data.firstname
        target.lastname = $scope.data.lastname
        target.email = $scope.data.email
        $state.go( $stateParams.call_back || "login", {message: "User account has been updated successfully!"})
      .catch (err)  -> 
            $scope.errors =[err.data.message]
    else
      $http
      .post '/users', { user: $scope.data }
      .then (result) ->
            $state.go( $stateParams.call_back || "login", {message: "User account has been created successfully!"})
      .catch (err)  -> 
            $scope.errors =[err.data.message]
    true
  $scope.cancel = ->
      $state.go( $stateParams.call_back || "welcome")
  $scope.match_password = ->
    'ng-invalid-pattern' unless $scope.data.password == $scope.data.password_confirmation
  true
    
])