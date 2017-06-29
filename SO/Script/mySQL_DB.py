import pymysql


class DataBaseMySQL():

    def __init__(self):
        # Connect to the database
        self.db = pymysql.connect(host='localhost', user='root', password='1234', database='sitexxi',
                             use_unicode=True, charset="utf8")

        # prepare a cursor object using cursor() method
        self.cursor = self.db.cursor()

        # Enforce UTF-8 for the connection.
        self.cursor.execute('SET NAMES utf8mb4')
        self.cursor.execute("SET CHARACTER SET utf8mb4")
        self.cursor.execute("SET character_set_connection=utf8mb4")


    def add_Pais(self,name):

        ###MYSQL####3
        insertPais = ("""INSERT INTO sitexxi.Pais
                                     (nome)
                                     VALUES (%s);""")

        try:
            # Execute the SQL command
            self.cursor.execute(insertPais, (name))
            # Commit your changes in the database
            self.db.commit()
            print("INSERI NA BASE DE DADOS")
        except:
            # Rollback in case there is any error
            print("ENTREI AQUI: NÃO INSERIU NA BASE DE DADOS")
            self.db.rollback()
        return True

    def add_Cidade(self,name,idPais):

        ###MYSQL####3
        insertCidade = ("""INSERT INTO sitexxi.Cidade
                                    (nome,id_pais)
                                     VALUES (%s,%s);""")

        try:
            # Execute the SQL command
            self.cursor.execute(insertCidade, (name,idPais))
            # Commit your changes in the database
            self.db.commit()
            print("INSERI NA BASE DE DADOS")
        except:
            # Rollback in case there is any error
            print("ENTREI AQUI: NÃO INSERIU NA BASE DE DADOS")
            self.db.rollback()
        return True


    def add_Cliente(self, nome,email,data_nascimento,sexo,nr_telemovel,data_registo,id_cidade):

        ###MYSQL####3
        insertCliente = ("""INSERT INTO sitexxi.Cliente
                                    (nome,email,data_nascimento,sexo,nr_telemovel,data_registo,id_cidade)
                                     VALUES (%s,%s,%s,%s,%s,%s,%s);""")

        try:
            # Execute the SQL command
            self.cursor.execute(insertCliente, (nome,email,data_nascimento,sexo,nr_telemovel,data_registo,id_cidade))
            # Commit your changes in the database
            self.db.commit()
            print("INSERI NA BASE DE DADOS")
        except:
            # Rollback in case there is any error
            print("ENTREI AQUI: NÃO INSERIU NA BASE DE DADOS")
            self.db.rollback()
        return True


    def add_Produtor(self,name):

        ###MYSQL####3
        insertProdutor = ("""INSERT INTO sitexxi.Produtor
                                    (nome)
                                     VALUES (%s);""")

        try:
            # Execute the SQL command
            self.cursor.execute(insertProdutor, (name))
            # Commit your changes in the database
            self.db.commit()
            print("INSERI NA BASE DE DADOS")
        except:
            # Rollback in case there is any error
            print("ENTREI AQUI: NÃO INSERIU NA BASE DE DADOS")
            self.db.rollback()
        return True

    def add_Jogo(self,nome,data_lancamento,idade_minima,stock,preco,desconto,id_produtor):

        ###MYSQL####3
        insertJogo = ("""INSERT INTO sitexxi.Jogo
                     (nome,data_lancamento,idade_minima,stock,preco,desconto,id_produtor)
                                     VALUES (%s,%s,%s,%s,%s,%s,%s);""")

        try:
            # Execute the SQL command
            self.cursor.execute(insertJogo, (nome,data_lancamento,idade_minima,stock,preco,desconto,id_produtor))
            # Commit your changes in the database
            self.db.commit()
            print("INSERI NA BASE DE DADOS")
        except:
            # Rollback in case there is any error
            print("ENTREI AQUI: NÃO INSERIU NA BASE DE DADOS")
            self.db.rollback()
        return True


    def add_jogoCategoria(self,id_jogo,id_categoria):

        ###MYSQL####3
        insertJogoCategoria = ("""INSERT INTO sitexxi.JogoCategoria
                                    (id_jogo,id_categoria)
                                     VALUES (%s,%s);""")

        try:
            # Execute the SQL command
            self.cursor.execute(insertJogoCategoria, (id_jogo,id_categoria))
            # Commit your changes in the database
            self.db.commit()
            print("INSERI NA BASE DE DADOS")
        except:
            # Rollback in case there is any error
            print("ENTREI AQUI: NÃO INSERIU NA BASE DE DADOS")
            self.db.rollback()
        return True

    def add_Compra(self,id_cliente,id_jogo,quantidade,preco,desconto,data_compra):

        ###MYSQL####3
        insertCompra = ("""INSERT INTO sitexxi.Compra
                                    (id_cliente,id_jogo,quantidade,preco,desconto,data_compra)
                                     VALUES (%s,%s,%s,%s,%s,%s);""")

        try:
            # Execute the SQL command
            self.cursor.execute(insertCompra, (id_cliente,id_jogo,quantidade,preco,desconto,data_compra))
            # Commit your changes in the database
            self.db.commit()
            print("INSERI NA BASE DE DADOS")
        except:
            # Rollback in case there is any error
            print("ENTREI AQUI: NÃO INSERIU NA BASE DE DADOS")
            self.db.rollback()
        return True

    def add_Categoria(self,categoria):

        ###MYSQL####3
        insertAvaliacao = ("""INSERT INTO sitexxi.Categoria
                                    (nome)
                                     VALUES (%s);""")

        try:
            # Execute the SQL command
            self.cursor.execute(insertAvaliacao, (categoria))
            # Commit your changes in the database
            self.db.commit()
            print("INSERI NA BASE DE DADOS")
        except:
            # Rollback in case there is any error
            print("ENTREI AQUI: NÃO INSERIU NA BASE DE DADOS")
            self.db.rollback()
        return True

    def add_Avaliacao(self,id_cliente,id_jogo,avaliacao,descricao,data_avaliacao):

        ###MYSQL####3
        insertAvaliacao = ("""INSERT INTO sitexxi.Avaliacao
                                    (id_cliente,id_jogo,avaliacao,descricao,data_avaliacao)
                                     VALUES (%s,%s,%s,%s,%s);""")

        try:
            # Execute the SQL command
            self.cursor.execute(insertAvaliacao, (id_cliente,id_jogo,avaliacao,descricao,data_avaliacao))
            # Commit your changes in the database
            self.db.commit()
            print("INSERI NA BASE DE DADOS")
        except:
            # Rollback in case there is any error
            print("ENTREI AQUI: NÃO INSERIU NA BASE DE DADOS")
            self.db.rollback()
        return True

    def disconnect(self):
        return self.db.close()


