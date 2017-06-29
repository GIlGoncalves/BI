# -*- coding: UTF-8 -*-
from config import *
import random
import sys
import string
from datetime import *

allNames = set()
addCount = 0


def getRandomUniqName(s):
    name = getRandomName(s)

    while (name in allNames):
        name = getRandomName(s)

    allNames.add(name)
    return name


def getRandomName(s):
    if (s == 'M'):
        return ' '.join(random.sample(male, 2)) + ' ' + ' '.join(random.sample(surname, 2))
    else:
        return ' '.join(random.sample(female, 2)) + ' ' + ' '.join(random.sample(surname, 2))

def getRandomGameName():
    return ' '.join(random.sample(gameNameL, 2)) + ' ' + ' '.join(random.sample(gameNameF, 2))


def getMailFromName(n):
    mail = "_".join(map(lambda x: cleanName(x), n.split(" ")))
    domain = random.choice(mailserver)

    return mail + "@" + domain


def cleanName(n):
    n = n.lower()
    for r in sCharsReplacement:
        n = n.replace(r[0], r[1])
    return n


def randomPassword():
    return ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(10))


def genAge():
    return fstBornDate + timedelta(days=int(bornPeriod.days * random.normalvariate(0.5, 0.12)))

def genDataReg():
    return fstRegDate + timedelta(days=int(regPeriod.days * random.normalvariate(0.5,0.12)))

def genPhoneNumer():
    first = str(random.randint(100,999))
    second = str(random.randint(1,888)).zfill(3)

    last = (str(random.randint(1,999)).zfill(3))
    while last in ['111','222','333','444','555','666','777','888']:
        last = (str(random.randint(1,999)).zfill(3))

    return '{}-{}-{}'.format(first,second, last)


