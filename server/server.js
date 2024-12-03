import { createRequire } from 'module'
const require = createRequire(import.meta.url)
const WebSocket = require('ws') // 使用 require 引入 ws 模組
import express from 'express'
import http from 'http'

const app = express()
const server = http.createServer(app)

// 啟動伺服器
const PORT = 3003
server.listen(PORT, () => {
  console.log(`伺服器正在執行於 http://localhost:${PORT}`)
})

// 初始化 WebSocket Server
const wss = new WebSocket.Server({ server })

// WebSocket 連接處理
wss.on('connection', (ws) => {
  console.log('客戶端已連接')

  // 接收訊息
  ws.on('message', (message) => {
    console.log(`收到訊息: ${message}`)

    let data = message.toString()
    //取得所有連接中的 client
    let clients = wss.clients
    clients.forEach((client) => {
      // 發送至每個 client
      client.send(data)
    })

    // 回傳訊息給客戶端
    // ws.send(`伺服器回應: ${message}`);
  })

  // 連接關閉
  ws.on('close', () => {
    console.log('客戶端已斷開')
  })
})
