$(function() {
  var sourcePointsDiv = document.getElementById('source-points');
  var source = Elm.embed(Elm.Points, sourcePointsDiv);
  source.ports.points.subscribe(setSourcePoints);

  var targetPointsDiv = document.getElementById('target-points');
  var target = Elm.embed(Elm.Points, targetPointsDiv);
  target.ports.points.subscribe(setTargetPoints);

  var image = $('img').get(0);
  var canvas = $('#transformed-image canvas').get(0)

  var sourcePoints = [], targetPoints = [];

  function setSourcePoints(pts) {
    sourcePoints = pts;
    checkIfDone();
  }

  function setTargetPoints(pts) {
    targetPoints = pts;
    checkIfDone();
  }

  function checkIfDone() {
    if(sourcePoints.length < 4 || targetPoints.length < 4) return;
    setTimeout(function() { renderHomography(sourcePoints, targetPoints, image, canvas) }, 0);
  }
});
