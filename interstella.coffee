angular.module('interstella', [])
  .controller('interstellaController', ($scope, $interval) ->
    $scope.currentNames = ["asl", "eyoung"]
    $scope.team = [{
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
    }]

    $scope.pollAudio = () ->
      now = $("#audio")[0].currentTime
      console.log(now)
      #if we aren't in the correct timing, go to
      console.log($scope.timings[$scope.currentTimingIndex].time)
      if $scope.timings[$scope.currentTimingIndex+1] && $scope.timings[$scope.currentTimingIndex+1].time < now
        $scope.currentTimingIndex +=1
        $scope.doTransition()

    $scope.doTransition = () ->
      console.log("Transform")
      $scope.currentNames = $scope.timings[$scope.currentTimingIndex].names
    $scope.nameFilter = (member) ->
      $scope.currentNames.indexOf(member.name) != -1
    $scope.timings = []
    $scope.currentTimingIndex = 0
    $.get 'timings.txt', (data) ->
      lines = data.split("\n");
      console.log(lines)
      $.each lines, (n, elem) ->
        console.log(elem)
        if elem
          i = elem.indexOf(',')
          time = elem.slice(0, i)
          $scope.timings.push({time: parseFloat(time), names: JSON.parse(elem.slice(i+1))})
          $interval $scope.pollAudio, 500
)
