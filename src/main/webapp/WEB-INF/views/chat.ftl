<#import "/spring.ftl" as spring/>


<html>
<head>
    <title>Chat WebSocket</title>
    <script src="../../assets/js/sockjs-0.3.4.js"></script>
    <script src="../../assets/js/stomp.js"></script>
    <script type="text/javascript">
        var stompClient = null;

        function setConnected(connected) {
            document.getElementById('connect').disabled = connected;
            document.getElementById('disconnect').disabled = !connected;
            document.getElementById('conversationDiv').style.visibility
                = connected ? 'visible' : 'hidden';
            document.getElementById('response').innerHTML = '';
            if (connected) {
                document.getElementById('from').readOnly = true;
            } else {
                document.getElementById('from').readOnly = false;
            }
        }

        function connect() {
            console.log("connect");
            var socket = new SockJS('http://localhost:8080/chat');
            console.log(socket);
            stompClient = Stomp.over(socket);
            console.log(stompClient);
            stompClient.connect({}, function (frame) {
                setConnected(true);
                console.log('Connected: ' + frame);
                stompClient.subscribe('/topic/messages', function (messageOutput) {
                    showMessageOutput(JSON.parse(messageOutput.body));
                });
            });
        }

        function disconnect() {
            if (stompClient != null) {
                stompClient.disconnect();
            }
            setConnected(false);
            console.log("Disconnected");
        }

        function sendMessage() {
            var from = document.getElementById('from').value;
            var text = document.getElementById('text').value;
            stompClient.send("/app/chat", {},
                JSON.stringify({from: from, text: text, chat_id: from}));
            document.getElementById('text').value = ''
        }

        function showMessageOutput(messageOutput) {
            var response = document.getElementById('response');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.appendChild(document.createTextNode(messageOutput.username + ": "
                + messageOutput.text + " (" + messageOutput.dateTime + ")"));
            response.appendChild(p);
        }
    </script>
</head>
<body onload="disconnect()">
<div>
    <div>
        <#--<input type="text" id="from" placeholder="Choose a nickname"/>-->
        <input type="hidden" id="from" value="${user.username}">
    </div>
    <br/>
    <div>
        <button id="connect" onclick="connect();">Connect</button>
        <button id="disconnect" disabled="disabled" onclick="disconnect();">
            Disconnect
        </button>
    </div>
    <br/>
    <div id="conversationDiv">
        <input type="text" id="text" placeholder="Write a message..."/>
        <button id="sendMessage" onclick="sendMessage();">Send</button>
        <p id="response"></p>
    </div>
</div>
</body>
</html>