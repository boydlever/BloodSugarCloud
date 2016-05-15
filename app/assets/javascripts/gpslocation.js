//var get_location = function(url) {
var currPosition;
navigator.geolocation.getCurrentPosition(function(position) {
	updatePosition(position);
		console.log("running getCurrentPosition...");
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;
		console.log("lat=" + lat + ", lng=" + lng);
		x = url + "&lat=" + lat + "&lng=" + lng;
//			url = "<%= update_bg_measurement_location %>" + "?lat=" + lat + "&lng=" + lng;
		console.log("about to try to run an ajax request using this url: " + url);
		$.getJSON(x, function(data) {
			data = data.table;
			console.log(data);
		});

}, errorCallback);

function updatePosition(position) {
	currPosition = position;
}

function errorCallback(error) {
	var msg = "Cand get your location. Error = ";
	if (error.code == 1)
		msg += "PERMISSION DENIED";
	else if (error.code == 2)
		msg += "POSITION UNAVAILABLE";
	else if (error.code == 3)
		msg += "TIMEOUT";
	msg += ", msg = "+error.message;
	alert(msg);
}