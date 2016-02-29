angular.module('interstella', [])
  .controller('interstellaController', ($scope, $interval) ->
    $scope.lastNames = []
    $scope.nextNames = []
    $scope.team = $scope.currentNames = ["asl","eyoung","pmumma","lbrown","jpincar","avolkovitsky","krichert","jhancock","kstewart","jstoecker","estrom","dryan","jdhague","dcameron","iharlow","mlooney"]

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
      $scope.lastNames = $scope.currentNames
      $scope.currentNames = $scope.timings[$scope.currentTimingIndex].names
      $scope.nextNames = $scope.timings[$scope.currentTimingIndex+1].names if $scope.timings[$scope.currentTimingIndex+1]
      $.each $scope.lastNames, (index, name) ->
        $("#"+name).removeClass()
        $("#"+name).addClass("last")
      $.each $scope.currentNames, (index, name) ->
        $("#"+name).removeClass()
        $("#"+name).addClass("current")
      $.each $scope.nextNames, (index, name) ->
        $("#"+name).removeClass()
        $("#"+name).addClass("next")
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
          $interval $scope.pollAudio, 500, 100
)
