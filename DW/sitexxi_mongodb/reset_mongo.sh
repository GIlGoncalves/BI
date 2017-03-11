#!/bin/bash

echo -e "use sitexxi_mongodb \n db.dropDatabase()" | mongo

mongoimport --db sitexxi_mongodb --collection avaliacoes --drop --file avaliacoes
mongoimport --db sitexxi_mongodb --collection clientes --drop --file clientes
mongoimport --db sitexxi_mongodb --collection jogos --drop --file jogos
mongoimport --db sitexxi_mongodb --collection compras --drop --file compras
