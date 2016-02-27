// Generated by CoffeeScript 1.10.0
(function() {
  angular.module('interstella', []).controller('interstellaController', function($scope, $interval) {
    $scope.currentNames = ["asl", "eyoung"];
    $scope.team = [
      {
        name: "asl"
      }, {
        name: "eyoung"
      }, {
        name: "pmumma"
      }, {
        name: "lbrown"
      }, {
        name: "jpincar"
      }, {
        name: "avolkovitsky"
      }, {
        name: "krichert"
      }, {
        name: "jhancock"
      }, {
        name: "kstewart"
      }, {
        name: "jstoecker"
      }, {
        name: "estrom"
      }, {
        name: "dryan"
      }, {
        name: "jdhague"
      }, {
        name: "dcameron"
      }, {
        name: "iharlow"
      }, {
        name: "mlooney"
      }
    ];
    $scope.pollAudio = function() {
      var now;
      now = $("#audio")[0].currentTime;
      console.log(now);
      console.log($scope.timings[$scope.currentTimingIndex].time);
      if ($scope.timings[$scope.currentTimingIndex + 1] && $scope.timings[$scope.currentTimingIndex + 1].time < now) {
        $scope.currentTimingIndex += 1;
        return $scope.doTransition();
      }
    };
    $scope.doTransition = function() {
      console.log("Transform");
      return $scope.currentNames = $scope.timings[$scope.currentTimingIndex].names;
    };
    $scope.nameFilter = function(member) {
      return $scope.currentNames.indexOf(member.name) !== -1;
    };
    $scope.timings = [];
    $scope.currentTimingIndex = 0;
    return $.get('timings.txt', function(data) {
      var lines;
      lines = data.split("\n");
      console.log(lines);
      return $.each(lines, function(n, elem) {
        var i, time;
        console.log(elem);
        if (elem) {
          i = elem.indexOf(',');
          time = elem.slice(0, i);
          $scope.timings.push({
            time: parseFloat(time),
            names: JSON.parse(elem.slice(i + 1))
          });
          return $interval($scope.pollAudio, 500);
        }
      });
    });
  });

}).call(this);