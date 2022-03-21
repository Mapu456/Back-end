import os
from flask import jsonify
from sqlalchemy.exc import NoResultFound
from models.startup import Startup
from models.user import User
from models.kpiRegister import KpiRegister
from schemas.startupSchema import StartupSchema
from schemas.userSchema import UserSchema
from schemas.kpiRegisterSchema import KpiRegisterSchema


startup_schemas = StartupSchema(many=True)
user_schemas = UserSchema(many=True)
kpi_register_schemas = KpiRegisterSchema(many=True)


def post_register(entity, data):
    table, entity_schemas = get_registers(entity)
    get_column(entity, table, data)

    """ print(data) *list(data.values())"""
    prueba = ["You", "are", "doing", "a", "great", "job"]
    imprimir(*prueba)

def get_column(entity, table, data):
    if (entity == os.environ.get('CUBE_KPI')) or (entity == os.environ.get('CUBE_REG')):
        value = "KpiRegister"
    else:
        value = "{entity.capitalize()}"
    for val in range(len(list(table.__table__._columns))):
        column = str(getattr(table, list(table.__table__._columns)[val].name)).split(".")[1]
    return None

def get_registers(entity):
    if entity == os.environ.get('CUBE_ST'):
        return Startup, startup_schemas
    elif entity == os.environ.get('CUBE_USR'):
        return User, user_schemas
    elif (entity == os.environ.get('CUBE_KPI')) or (entity == os.environ.get('CUBE_REG')):
        return KpiRegister, kpi_register_schemas

""" def fill_tables(entity, data):
     """

def imprimir(a, b, c, d, e, f):
    print(a)
    print(b)
    print(c)
    print(d)
    print(e)
    print(f)
