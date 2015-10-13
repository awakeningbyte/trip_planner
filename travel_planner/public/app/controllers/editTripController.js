(function() {
  angular.module("TravePlannerApp.contorller.tripsController").controller("editTripController", [
    '$scope', 'trips', 'tripsService', '$stateParams', '$state', function($scope, trips, tripsService, $stateParams, $state) {
      var idx, t;
      $scope.trips = trips;
      idx = $stateParams.idx;
      t = $scope.trips[idx];
      $scope.edit_trip = {
        id: t.id,
        destination: t.destination,
        startDate: t.startDate,
        endDate: t.endDate,
        comment: t.comment
      };
      return $scope.save = function() {
        var u;
        u = new tripsService($scope.edit_trip);
        return u.$update().then(function() {
          t.destination = $scope.edit_trip.destination;
          t.startDate = $scope.edit_trip.startDate;
          t.endDate = $scope.edit_trip.endDate;
          t.comment = $scope.edit_trip.comment;
          return $state.go('trips');
        });
      };
    }
  ]);

}).call(this);
