<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setAttribute("userID", "Manager");	// 先寫死
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="./css/friendchat.css" type="text/css" />
<style type="text/css">
.green{
	border: 1px solid green;
}
</style>
<title>Manager 聊天室(幾乎不用動)</title>
</head>
<body onload="connect();" onunload="disconnect();">
	<h3 id="statusOutput" class="statusOutput"></h3>
	<div id="row"></div>
	<div id="messagesArea" class="panel message-area" ></div>
	<div class="panel input-area">
		<input id="message" class="text-field" type="text" placeholder="Message" onkeydown="if (event.keyCode == 13) sendMessage();" /> 
		<input type="submit" id="sendMessage" class="button" value="Send" onclick="sendMessage();" /> 
		<input type="button" id="connect" class="button" value="Connect" onclick="connect();" /> 
		<input type="button" id="disconnect" class="button" value="Disconnect" onclick="disconnect();" />
	</div>
</body>
<script>
	var MyPoint = "/CustomerServiceWS/${userID}";	// java EL，可以改成 roomID 跟 session 等，變成發送給特定對象(一對一的聊天室)
	var host = window.location.host;  		// 取得目前造訪網頁的主機名稱(hostname), 包含port
	var path = window.location.pathname;	// 取得目前造訪網頁的路徑(呼叫路徑)
	var webCtx = path.substring(0, path.indexOf('/', 1));	// 取得UnderWaterProject
	var endPointURL = "ws://" + host + webCtx + MyPoint;	// ws://localhost:8081/WebSocketChatWeb/FriendWS/katy

	var statusOutput = document.getElementById("statusOutput");
	var messagesArea = document.getElementById("messagesArea");
	var self = '${userID}';
	var webSocket;

	function connect() {
		// create a websocket
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {	
			console.log("Connect Success!");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
			
		};

		webSocket.onmessage = function(event) {
			var jsonObj = JSON.parse(event.data);
			
			if ("open" === jsonObj.type) {
				refreshFriendList(jsonObj);
			} else if ("history" === jsonObj.type) {
				
				
				var repeat = false;
				var row = document.getElementById("row");
				var receivers = row.childNodes;
				if(row.childNodes.length == 0) {
					row.innerHTML +='<div onclick="heyYo(this)" id='+ jsonObj.receiver +' class="column" name="friendName" value=' + jsonObj.receiver + ' ><h2>' + jsonObj.receiver + '</h2></div>';
				}
				for(var i = 0; i < row.childNodes.length; i++) {
					if(receivers[i].getAttribute("id") == jsonObj.receiver ) {
						repeat = true;
						break;
					}
				}
				if(repeat == false) {
					row.innerHTML +='<div onclick="heyYo(this)" id='+ jsonObj.receiver +' class="column" name="friendName" value=' + jsonObj.receiver + ' ><h2>' + jsonObj.receiver + '</h2></div>';
				}
				
				messagesArea.innerHTML = '';
				var ul = document.createElement('ul');
				ul.id = "area";
				messagesArea.appendChild(ul);
				// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
				var messages = JSON.parse(jsonObj.message);
				for (var i = 0; i < messages.length; i++) {
					var historyData = JSON.parse(messages[i]);
					var showMsg = historyData.message;
					var li = document.createElement('li');
					// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
					historyData.sender === self ? li.className += 'me' : li.className += 'friend';
					li.innerHTML = showMsg;
					ul.appendChild(li);
				}
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("chat" === jsonObj.type) {
				var li = document.createElement('li');
				jsonObj.sender === self ? li.className += 'me' : li.className += 'friend';
				li.innerHTML = jsonObj.message;
				console.log(li);
				document.getElementById("area").appendChild(li);
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("close" === jsonObj.type) {
				refreshFriendList(jsonObj);
			}
			
		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	
	function sendMessage() {
		var inputMessage = document.getElementById("message");
		var friend = statusOutput.textContent;
		var message = inputMessage.value.trim();

		if (message === "") {
			alert("Input a message");
			inputMessage.focus();
		} else if (friend === "") {
			alert("Choose a friend");
		} else {
			var jsonObj = {
				"type" : "chat",
				"sender" : self,
				"receiver" : friend,
				"message" : message
			};
			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
	}
	
	// 有好友上線或離線就更新列表
	function refreshFriendList(jsonObj) {
		var friends = jsonObj.users;
		var row = document.getElementById("row");
		var receivers = row.childNodes;
		var isMe = false;
		var repeat = false;
// 		row.innerHTML = '';	// 離線也不要清空
		
		for (var i = 0; i < friends.length; i++) {
			// 自己的聊天室不需要新增
			if (friends[i] === self) { isMe = true; }
			// 歷史訊息已有的聊天室不需要新增
			for(var j = 0; j < row.childNodes.length; j++) {	
				if (receivers[j].getAttribute("id") == friends[i]) { repeat = true; }
			}
			if(repeat == false && isMe == false) {
				row.innerHTML +='<div onclick="heyYo(this)" id=' + friends[i] + ' class="column" name="friendName" value=' + friends[i] + ' ><h2>' + friends[i] + '</h2></div>';
			}else if(repeat == true) {
				console.log("repeat");
				document.getElementById(friends[i]).setAttribute("class","green column");
			}
		}
		addListener(jsonObj);
	}

	
	// 註冊列表點擊事件並抓取好友名字以取得歷史訊息
	function addListener(jsonObj) {
		var container = document.getElementById("row");	
// 		heyYo();
		
// 		container.addEventListener("click", function(e) {
// 			console.log("1 : 是你嗎");
// 				var friend = e.srcElement.textContent;	///// div id 已有的值才可以
// ///		
// 				console.log(friend);
// 				var check = document.getElementById("row").childNodes;
// 				var exist = false;
// 				for(var i = 0; i < container.childNodes.length; i++) {
// 					if(check[i].getAttribute("id") != friend) {
// 						console.log("2 : "+check[i].getAttribute("id"));
// 						exist = true;
// 					}
// 				}
// 				if(exist = true) {
// 					console.log("3 : exist = true");
// 					updateFriendName(friend);
// 					var jsonObj = {
// 							"type" : "history",		
// 							"sender" : self,
// 							"receiver" : friend,
// 							"message" : ""
// 						};
// 					webSocket.send(JSON.stringify(jsonObj));
					
// 				}
// 		});
	}
	
	function heyYo(e) {
		console.log("heyYo");
		console.log(e.id);
// 		var container = document.getElementById("row");
// 		var list = container.childNodes;
// 		list.forEach(element =
	//> element.addEventListener("click", function() {
				var friend = e.id;
				updateFriendName(friend);
				var jsonObj = {
						"type" : "history",		
						"sender" : self,
						"receiver" : friend,
						"message" : ""
					};
				webSocket.send(JSON.stringify(jsonObj));
// 		}));
	}
	
	
	function disconnect() {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
	}
	
	function updateFriendName(name) {
		statusOutput.innerHTML = name;
	}
</script>
</html>