#from faker import Faker
import mySQL_DB
from config import *
from idGenerator import *
from random import randint

#fake = Faker()


mySqlDB = mySQL_DB.DataBaseMySQL()


##### INSERIR PAIS

def insertPais():
    i=0
    while(i<len(country)):
        mySqlDB.add_Pais(country[i])
        i = i + 1

#### INSERIR CIDADE
def insertCityInCountry():
    #Germany
    i = 0
    while (i < len(cityGermany1)):
        mySqlDB.add_Cidade(cityGermany1[i],1)
        i = i + 1

    #Italia
    i = 0
    while (i < len(cityItaly2)):
        mySqlDB.add_Cidade(cityItaly2[i], 2)
        i = i + 1

    # Franca
    i = 0
    while (i < len(cityFrance3)):
        mySqlDB.add_Cidade(cityFrance3[i], 3)
        i = i + 1

    # Portugal
    i = 0
    while (i < len(cityPortugal4)):
        mySqlDB.add_Cidade(cityPortugal4[i], 4)
        i = i + 1

    # Montenegro
    i = 0
    while (i < len(cityMontenegro5)):
        mySqlDB.add_Cidade(cityMontenegro5[i], 5)
        i = i + 1

    # Belgium
    i = 0
    while (i < len(cityBelgium6)):
        mySqlDB.add_Cidade(cityBelgium6[i], 6)
        i = i + 1

    # Colombia
    i = 0
    while (i < len(cityColombia7)):
        mySqlDB.add_Cidade(cityColombia7[i], 7)
        i = i + 1

    # US8
    i = 0
    while (i < len(cityUS8)):
        mySqlDB.add_Cidade(cityUS8[i], 8)
        i = i + 1

    # Australia
    i = 0
    while (i < len(cityAustralia9)):
        mySqlDB.add_Cidade(cityAustralia9[i], 9)
        i = i + 1

    # Canada
    i = 0
    while (i < len(cityCanada10)):
        mySqlDB.add_Cidade(cityCanada10[i], 10)
        i = i + 1


#insert cliente

def insertCliente():
    i=0
    while(i<NUtilizadores):
        if (random.random() > malePopulation):
            sex = 'F'
        else:
            sex = 'M'
        name = getRandomName(sex)
        dataNascimento = genAge()
        dataRegisto = genDataReg()
        email = getMailFromName(name)
        phoneNumber = genPhoneNumer()
        cidade = randint(1,26)
        mySqlDB.add_Cliente(name,email,dataNascimento,sex,phoneNumber,dataRegisto,cidade)
        i = i +1 


# inserir produtor

def insertProdutoras():
    i = 0
    while(i<len(produtors)):
        mySqlDB.add_Produtor(produtors[i])
        i = i + 1

 # inserir categorias

def insertCategorias():
    i=0
    while(i<len(categorias)):
        mySqlDB.add_Categoria(categorias[i])
        i = i + 1


# inserir jogo

def insertProdutor():
    #def add_Jogo(self, nome, data_lancamento, idade_minima, stock, preco, desconto, id_produtor):
    i = 0
    while(i< NJogos):
     name = getRandomGameName()
     dataLançamento = genDataReg()
     idadeMinima = randint(8,18)
     stock = int(randint(1000,8999))
     preco = randint(15,80)
     desconto = random.uniform(0, 1)
     idProdutor = int(randint(1,8))
     mySqlDB.add_Jogo(name,dataLançamento,idadeMinima,stock,preco,desconto,idProdutor)
     i = i + 1

# inserir Compras e avaliacao

def insertCompras():
    #   def add_Compra(self,id_cliente,id_jogo,quantidade,preco,desconto,data_compra):
    i = 0
    while (i < NCompras):
        cliente = random.normalvariate(80,200)%NUtilizadores
        jogo = random.normalvariate(10,80)%NJogos
        quantidade = random.normalvariate(1,2)%6 + 1
        preco = randint(15, 80)
        desconto = random.uniform(0, 1)
        dataCompra = genDataReg()
        avaliacao = randint(1,9)
        mySqlDB.add_Compra(cliente,jogo,quantidade,preco,desconto,dataCompra)
        # inserir avaliacao
        mySqlDB.add_Avaliacao(cliente,jogo,avaliacao," ",dataCompra)
        i = i + 1


def insertJogoCategoria():
    i = 0
    while(i<NJogos):
        mySqlDB.add_jogoCategoria(i,randint(1,8))
        i = i + 1


if __name__ == "__main__":
    # execute only if run as a script
   insertPais()
   insertCityInCountry()
   insertCliente()
   insertProdutoras()
   insertCategorias()
   insertProdutor()
   insertCompras()
   insertJogoCategoria()
