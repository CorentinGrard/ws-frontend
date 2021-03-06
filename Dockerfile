FROM node:lts-alpine
# définit le dossier 'app' comme dossier de travail
WORKDIR /app
ENV NUXT_HOST=0.0.0.0 NUXT_PORT=3000
# copie 'package.json' et 'package-lock.json' (si disponible)
COPY package*.json ./

# installe les dépendances du projet
RUN npm install

# copie les fichiers et dossiers du projet dans le dossier de travail (par exemple : le dossier 'app')
COPY . .

# construit l'app pour la production en la minifiant
RUN npm run build

EXPOSE 3000
CMD [ "npm", "start"]