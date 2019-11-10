# -- coding: utf-8 --
from faker import Faker
import time
import random
import json
from datetime import datetime

lines_per_file=100000
init_file_counter=500
end_file_counter=600
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
    out_file_path='./dados/'+i+'.json'


    with open(out_file_path, 'a') as out_file:
        for _ in range(lines_per_file):
            value = {}

            #oper_ts
            value['oper_ts'] = str(fake.date_time_ad(end_datetime=end_datetime, start_datetime=init_datetime).isoformat()) +'Z'
            #value['oper_ts'] = str(fake.date_between_dates(date_start=init_datetime, date_end=end_datetime))

            #nome
            value['nome'] = fake.name()

            #cpf
            value['cpf'] = str(random.randint(1, 1000000000)).zfill(11)

            #email
            value['email'] = fake.email()

            #idade_cliente
            value['idade_cliente'] = str(random.randint(20, 70))

            #cidade
            value['idade_cliente'] = fake.city()

            #cep
            value['cep'] = str(random.randint(1, 1000000)).zfill(7)

            #numero_endereco
            value['numero_endereco'] = str(random.randint(1, 1000))

            #regiao
            value['regiao'] = lista_regiao[random.randint(0, len(lista_regiao) - 1)]

            #credito
            value['credito'] = lista_sim_nao[random.randint(0, len(lista_sim_nao) - 1)]

            #risco_serasa
            value['risco_serasa'] = lista_graduacao[random.randint(0, len(lista_graduacao) - 1)]

            #tipo_de_pessoa
            value['tipo_de_pessoa'] = lista_tipo_pessoa[random.randint(0, len(lista_tipo_pessoa) - 1)]
            
            #marca
            value['marca'] = lista_marca_carros[random.randint(0, len(lista_marca_carros) - 1)]

            #modelo
            value['modelo'] = lista_carros[random.randint(0, len(lista_carros) - 1)]

            #valor_venda
            value['valor_venda'] = random.randint(20000, 1000000)

            #comissao
            value['comissao'] = random.randint(20000, 1000000)

            #json.dump(value, out_file, ensure_ascii=False, indent=4)
            #print(value)
            out_file.write(json.dumps(value, separators=(',', ':')) + '\n')
            