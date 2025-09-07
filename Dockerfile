# Multi-stage build for Flutter web app
FROM nginx:alpine

# Copy built web app to nginx html directory
COPY build/web /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

