#! /usr/bin/env python2
from subprocess import check_output

def get_field(account,field):
    if field == 'pass':
        return check_output(['pass',account]).split('\n')[0]
    else:
        field += ': '
        letters = len( field )
        datas = check_output(['pass',account]).split('\n')
        index = [i for i in range(len(datas)) if datas[i][:letters] == field][0]
        return datas[index][letters:]
