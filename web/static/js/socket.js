// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("room:lobby", {})
let messagesContainer = document.querySelector("#messages")
let chatInput         = document.querySelector("#chat-input")

chatInput.addEventListener("keypress", event => {
  if (event.keyCode === 13){
    channel.push("new_chat_message", {message: chatInput.value})
    chatInput.value = ""
  }
})

channel.on("new_chat_message", payload => {
  let messageItem = document.createElement("li");
  messageItem.classList.add("list-group-item");
  let badgeItem = document.createElement("span");
  badgeItem.classList.add("badge");
  badgeItem.innerText = payload.user;
  messageItem.innerText = payload.message;
  messageItem.appendChild(badgeItem);
  messagesContainer.appendChild(messageItem)
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
