# 使用 Node.js 作為基礎映像
FROM node:18 AS build

# 設定工作目錄
WORKDIR /app

# 複製 package.json 和 package-lock.json
COPY package*.json ./

# 安裝依賴
RUN npm install

# 複製應用程式原始碼
COPY . .

# 建立應用程式
RUN npm run build

# 使用 Nginx 作為基礎映像來提供應用
FROM nginx:alpine

# 移除預設的 Nginx 配置檔案
RUN rm /etc/nginx/conf.d/default.conf

# 複製自定義的 Nginx 配置檔案
COPY nginx.conf /etc/nginx/conf.d

# 複製建構後的檔案到 Nginx 的靜態檔案目錄
COPY --from=build /app/dist /usr/share/nginx/html

# 暴露容器的 80 埠
EXPOSE 80

# 啟動 Nginx
CMD ["nginx", "-g", "daemon off;"]
