<template>
  <div>
    <h1>WebSocket 範例</h1>
    <div style="display: flex">
      <input v-model="message" placeholder="輸入訊息" />
      <button @click="sendMessage">送出</button>
      <button @click="connect">連線</button>
      <button @click="disconnect">離線</button>
    </div>
    <ul>
      <li v-for="(msg, index) in messages" :key="index">
        {{ msg }}
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from "vue";

const socket = ref(null);
const message = ref("");
const messages = ref([]);
const url = "ws://localhost:3003";

const connectWebSocket = () => {
  // 連接 WebSocket
  socket.value = new WebSocket(url);

  // 監聽訊息
  socket.value.onmessage = (event) => {
    messages.value.push(event.data);
  };

  // 連線開啟
  socket.value.onopen = () => {
    console.log("WebSocket 已連接");
  };

  // 連線關閉
  socket.value.onclose = () => {
    console.log("WebSocket 已關閉");
  };
};

const sendMessage = () => {
  if (socket.value && socket.value.readyState === WebSocket.OPEN) {
    socket.value.send(message.value);
    message.value = "";
  } else {
    alert("WebSocket 尚未連接");
  }
};

const connect = () => {
  socket.value = new WebSocket(url);
  socket.value.onopen = () => alert("WebSocket 重新連線");
  socket.value.onmessage = (event) => messages.value.push(event.data);
};

const disconnect = () => {
  socket.value.close();
  socket.value.onclose = () => alert("WebSocket 斷開連線");
};

onMounted(() => {
  connectWebSocket();
});

onBeforeUnmount(() => {
  if (socket.value) {
    socket.value.close();
  }
});
</script>

<style scoped></style>
