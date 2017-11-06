Projet THL
===========
Une calculette !

## Compilation

Il est nécessaire d'avoir flex, bison, node, npm et un compilateur C++ installé.

```
npm install
make
node-gyp configure
node-gyp build
node index.js
```
On peut maintenant ouvrir son navigateur sur http://localhost:3000