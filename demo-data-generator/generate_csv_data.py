# -- coding: utf-8 --
from faker import Faker
import time
import random
from datetime import datetime

lines_per_file=10000
init_file_counter=0
end_file_counter=2
separator=','

init_datetime = datetime.strptime('2019/01/01 00:00:00', "%Y/%m/%d %H:%M:%S")
end_datetime = datetime.strptime('2019/12/31 23:59:59', "%Y/%m/%d %H:%M:%S")
fake = Faker('pt_BR')

lista_regiao = ['CENTRO','NORTE','SUL','LESTE','OESTE','SUDESTE','NORDESTE']
lista_sim_nao = ['SIM', 'NAO']
lista_graduacao = ['BAIXO', 'MEDIO','ALTO']
lista_tipo_pessoa = ['PF', 'PJ','FUNCIONARIO']
lista_marca_carros=['VOLKSWAGEN','CHEVROLET','FORD','FIAT']
lista_carros=['FOX','ASTRA','GOL','FOCUS','UNO','POLO','KA']
lista_valores=['100','500', '1000', '5000']


for i in range(init_file_counter,end_file_counter):
    i = str(i).zfill(4)
    out_file_path='./dados/'+i+'.csv'


    with open(out_file_path, 'a') as out_file:
        for _ in range(lines_per_file):
            value = []

            #oper_ts
            #value.append(str(fake.unix_time(end_datetime=end_datetime, start_datetime=init_datetime)))
            value.append(str(fake.date_time_ad(end_datetime=end_datetime, start_datetime=init_datetime).isoformat()) +'Z')

            #nome
            value.append(fake.name())

            #cpf
            value.append(str(random.randint(1, 1000000000)).zfill(11))

            #email
            value.append(fake.email())

            #idade_cliente
            value.append(str(random.randint(20, 70)))

            #cidade
            value.append(fake.city())

            #cep
            value.append(str(random.randint(1, 1000000)).zfill(7))

            #numero_endereco
            value.append(str(random.randint(1, 1000)))

            #regiao
            value.append(lista_regiao[random.randint(0, len(lista_regiao) - 1)])

            #credito
            value.append(lista_sim_nao[random.randint(0, len(lista_sim_nao) - 1)])

            #risco_serasa
            value.append(lista_graduacao[random.randint(0, len(lista_graduacao) - 1)])

            #tipo_de_pessoa
            value.append(lista_tipo_pessoa[random.randint(0, len(lista_tipo_pessoa) - 1)])
            
            #marca
            value.append(lista_marca_carros[random.randint(0, len(lista_marca_carros) - 1)])

            #modelo
            value.append(lista_carros[random.randint(0, len(lista_carros) - 1)])

            #valor_venda
            value.append(str(random.randint(20000, 1000000)).zfill(7))

            #comissao
            value.append(lista_valores[random.randint(0, len(lista_valores) - 1)])
            
            out_file.write((separator.join(value)+'\n'))