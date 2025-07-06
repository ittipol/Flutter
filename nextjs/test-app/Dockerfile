###################
# BUILD FOR LOCAL DEVELOPMENT
###################

FROM node:20-alpine AS development

WORKDIR /var/www/nextjs-app

COPY package*.json ./

RUN npm ci

###################
# BUILD FOR PRODUCTION
###################

FROM node:20-alpine AS build

WORKDIR /var/www/nextjs-app

COPY package*.json ./

COPY --from=development /var/www/nextjs-app/node_modules ./node_modules 

COPY . .

RUN npm run build

ENV NODE_ENV production

RUN npm ci --omit=dev && npm cache clean --force

###################
# PRODUCTION
###################

FROM node:20-alpine AS production

WORKDIR /var/www/nextjs-app

COPY --from=build /var/www/nextjs-app/node_modules ./node_modules
COPY --from=build /var/www/nextjs-app/package*.json ./
COPY --from=build /var/www/nextjs-app/.next ./.next

EXPOSE 5055

CMD [ "npm", "start" ]