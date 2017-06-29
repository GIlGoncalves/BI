# -*- coding: UTF-8 -*-
from datetime import datetime

malePopulation = 0.45

NUtilizadores = 100
NJogos = 200
NCompras = 400

#DesvioVendasDia = AVGVendasDia/4
DiasEntreRemessas = 2

initialBalance = [9000]

fstSell = datetime.strptime('2014-01-01', "%Y-%m-%d").date()
lstBuy = datetime.strptime('2016-12-31', "%Y-%m-%d").date()
sellingPeriod = lstBuy - fstSell

lstBornDate = datetime.strptime('1999-04-30', "%Y-%m-%d").date()
fstBornDate = datetime.strptime('1932-04-30', "%Y-%m-%d").date()
bornPeriod = lstBornDate - fstBornDate

lstRegDate = datetime.strptime('2017-06-30', "%Y-%m-%d").date()
fstRegDate = datetime.strptime('2013-01-04', "%Y-%m-%d").date()
regPeriod = lstRegDate - fstRegDate

male = ["Joaquim", "Júlio", "Artur", "João", "Miguel", "Leonardo", "José", "Carlos", "Alexandre", "Bernardo", "Daniel", "Eduardo", "Fernando", "Gabriel", "Hugo", "Ivo", "Luís", "Manuel", "Nuno", "Otávio", "Pedro", "Xavier", "Rui"]

female = ["Andreia", "Ana", "Filipa", "Beatriz", "Carolina", "Daniela", "Eduarda", "Fátima", "Gabriela", "Helena", "Ivone", "Joana", "Luísa", "Manuela", "Natália", "Patrícia", "Rita", "Sandra", "Vânia"]

gameNameL = ["Dead","Futebol", "fight","combat","race", "matrix","legendary", "ww2","cs","pie","recruta","stickman","ultimate","sayid","lost", "jiu jitsu","bruxedo","emails"]

gameNameF = ["Power", "magic", "mike", "inferno", "dust", "panqueca", "banana split", "soccer", "sacholas", "Ville", "lucifer","arrow", "spider man", "iBad", "RedFaced", "TUM", " marrown", "kratos" ]

surname = ["Abreu", "Aarão", "Alves", "Barros", "Campos", "Delgado", "Esteves", "Fernandes", "Gomes", "Henriques", "Infante", "Jesus", "Lima", "Lobo", "Machado", "Nestor", "Novais", "Nogueira", "Oliveira", "Pinto", "Pontes", "Pereira", "Rebelo", "Silva", "Raminhos", "Sá", "Rua", "Torres", "Teixeira", "Veiga", "Viana", "Vidal", "Xisto"]

sCharsReplacement = [("ã", "a"), ("â", "a"), ("á", "a"), ("é", "e"), ("ê", "e"), ("í", "i"), ("ó", "o"), ("ú", "u"), ("ç", "c")]

mailserver = ["gmail.com", "hotmail.com", "sapo.pt", "iol.pt", "outlook.com", "live.com.pt", "yahoo.com"]

machineModel = [("Cortex A", 18), ("Makita Serie 45", 23), ("StormKey", 16)]

machineRent = ["100", "200", "300", "250"]

country = ["Germany",
           "Italy",
           "France",
           "Portugal",
           "Montenegro",
           "Belgium",
           "Colombia",
           "United States",
           "Australia",
           "Canada"
           ]

cityGermany1 = ["Berlin"] + ["Hamburg"] + ["Munich"]

cityItaly2 = ["Rome"] + ["Milan"] + ["Florence"] + ["Naples"]

cityFrance3 = ["Paris"] + ["Bordeaux"]

cityPortugal4 = ["Lisbon"] + ["Porto"] + ["Braga"] + ["Vila Real"] + ["Trofa"] + ["Vizela"]

cityMontenegro5 = ["Podgorica"]

cityBelgium6 = ["Antwerp"]

cityColombia7 = ["Bogotá"] + ["Medellín"]

cityUS8 = ["New York"] + ["Los Angeles"] + ["Houston"]

cityAustralia9 = ["Sydney"] + ["Broken Hill"]

cityCanada10 = ["Toronto"] + ["Montreal"]

produtors =  ['Capcom']+['Square Enix'] + ['Konami']+['Ubisoft']+ ['SEGA'] + ['Activision Blizzard'] + ['Nintendo'] + ['Sony'] + ['Microsoft'] +['Electronic Arts']

categorias = ['Acao','Aventura','Estrategia','RPG','Desporto','Corrida','Quebra-Cabeca','Simulacao']