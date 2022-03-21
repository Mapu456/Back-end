import os
from flask import jsonify
from db import db
from sqlalchemy.exc import NoResultFound
from models.startup import Startup
from models.user import User
from models.permission import Permission
from models.kpiRegister import KpiRegister
from schemas.startupSchema import StartupSchema
from schemas.userSchema import UserSchema
from schemas.kpiRegisterSchema import KpiRegisterSchema


startup_schema = StartupSchema()
user_schema = UserSchema()
kpi_register_schema = KpiRegisterSchema()
startup_schemas = StartupSchema(many=True)
user_schemas = UserSchema(many=True)
kpi_register_schemas = KpiRegisterSchema(many=True)


def post_register(entity, data):
    table, entity_schema, entity_schemas = get_registers(entity)
    get_column(entity, table, data)

    new_register = table(*list(data.values()))

    db.session.add(new_register)
    db.session.commit()
    return entity_schema.jsonify(new_register)

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
        return Startup, startup_schema, startup_schemas
    elif entity == os.environ.get('CUBE_USR'):
        return User, user_schema, user_schemas
    elif (entity == os.environ.get('CUBE_KPI')) or (entity == os.environ.get('CUBE_REG')):
        return KpiRegister, kpi_register_schema, kpi_register_schemas
