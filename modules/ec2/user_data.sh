#!/bin/bash

yum update -y
yum install -y nginx

systemctl start nginx
systemctl enable nginx

echo "<html>
<head>
<title>Hello World</title>
</head>
<body>
<h1>Hello from $(hostname)</h1>
<p>This page is served by Nginx</p>
</body>
</html>" > /usr/share/nginx/html/index.html
