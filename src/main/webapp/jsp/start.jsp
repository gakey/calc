<!DOCTYPE html>
<html>
<head>
    <title>Calculator App Using Spring 4 WebSocket</title>
    <script src="resources/sockjs-0.3.4.js"></script>
    <script src="resources/stomp.js"></script>
    <script type="text/javascript">

        var stompClient = null;

        function setConnected(connected) {
            document.getElementById('connect').disabled = connected;
            document.getElementById('disconnect').disabled = !connected;
            document.getElementById('calculationDiv').style.visibility = connected ? 'visible' : 'hidden';
            document.getElementById('calResponse').innerHTML = '';
        }

        function connect() {
            var socket = new SockJS('/eclipsesample/add');
			stompClient = Stomp.over(socket);
            stompClient.connect({}, function(frame) {
                setConnected(true);
                console.log('Connected: ' + frame);
                stompClient.subscribe('/topic/showResult', function(calResult){
                	showResult(JSON.parse(calResult.body).result);
                });
            });
        }

        function disconnect() {
            stompClient.disconnect();
            setConnected(false);
            console.log("Disconnected");
        }

        function sendNum() {
            var num1 = document.getElementById('num1').value;
            var num2 = document.getElementById('num2').value;
            stompClient.send("/calcApp/add", {}, JSON.stringify({ 'num1': num1, 'num2': num2 }));
        }

        function showResult(message) {
            var response = document.getElementById('calResponse');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.appendChild(document.createTextNode(message));
            response.appendChild(p);
        }
    </script>
</head>
<body>
<noscript><h2>Calculate Demo</h2></noscript>
<h1>２つの数字の足し算</h1>
<div>
    <div>
        <button id="connect" onclick="connect();">Connect</button>
        <button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button><br/><br/>
    </div>
    <div id="calculationDiv">
        <label>1つめの数字:</label><input type="text" id="num1" /><br/>
        <label>2つめの数字:</label><input type="text" id="num2" /><br/><br/>
        <button id="sendNum" onclick="sendNum();">足し算する</button>
        <p id="calResponse"></p>
    </div>
</div>
</body>
</html>
