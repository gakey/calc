<!DOCTYPE html>
<html>

<head>
  <script type="text/javascript" src="js/jquery-1.11.3.js"></script>
  <script type="text/javascript">
    $(function(){
      var ws = new WebSocket("ws://localhost:8080/selecttheme/echo");

      ws.onopen = function(){
      };

      ws.onclose = function(){
      };

      ws.onmessage = function(message){
        $("#log").append(message.data).append("<br/>");
        $("#message").val("")
      };

      ws.onerror = function(event){
        alert("error");
      };

      $("#form").submit(function(){
        ws.send($("#message").val());
        return false;
      });
    });
  </script>
</head>

<body>
  <div id="log"></div>
  <form id="form" action="#">
    <input type="text" id="message" /> <input type="submit" id="send" value="submit" />
  </form>
</body>

</html>