FROM node:lts as superkit-build

WORKDIR /usr/src/app
COPY . /usr/src/app
RUN npm install && npm run build

FROM node:lts

WORKDIR /usr/src/app
COPY --from=superkit-build /usr/src/app/package.json /usr/src/app/package.json
COPY --from=superkit-build /usr/src/app/package-lock.json /usr/src/app/package-lock.json
COPY --from=superkit-build /usr/src/app/build /usr/src/app/build

EXPOSE 3000
CMD ["node", "build/index.js"]


