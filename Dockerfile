# 使用官方 Nginx 映像作為基礎
FROM nginx:alpine

# 設定工作目錄
WORKDIR /usr/share/nginx/html

# 清空預設的 Nginx 靜態檔案
RUN rm -rf ./*

# 複製打包好的靜態檔案到 Nginx 根目錄
COPY dist/ /usr/share/nginx/html/

# (選擇性) 覆蓋 Nginx 預設配置檔
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露 HTTP 埠
EXPOSE 80

# 啟動 Nginx
CMD ["nginx", "-g", "daemon off;"]