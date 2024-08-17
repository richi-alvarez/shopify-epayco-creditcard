FROM node:21-alpine

EXPOSE 3000

WORKDIR /app
COPY . .

ENV NODE_ENV=production

RUN npm install --omit=dev

CMD ["npm", "run", "docker-start"]
