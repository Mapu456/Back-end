import os
from flask import jsonify
from db import db
from sqlalchemy.exc import NoResultFound
from models.startup import Startup
from models.user import User
from models.kpiRegister import KpiRegister
from schemas.startupSchema import StartupSchema
from schemas.userSchema import UserSchema
from schemas.kpiRegisterSchema import KpiRegisterSchema


def delete_register(entity, args):
    keys = [*args]
    first_column = keys[0]
    first_id = args.get(keys[0])

    table, entity_schema = get_registers(entity)
    entity_id = getattr(table, list(table.__table__._columns)[0].name)

    try:
        result = table.query.filter(entity_id == first_id).one()
    except NoResultFound:
        return {f"message": f"{entity} could not be found."}, 400
    
    
    local_object = db.session.merge(result)
    db.session.delete(local_object)
    db.session.commit()
    return jsonify({'message' : f'{entity} record has been deleted!'})

def get_registers(entity):
    if entity == os.environ.get('CUBE_ST'):
        return Startup, StartupSchema()
    elif entity == os.environ.get('CUBE_USR'):
        return User, UserSchema()
    elif (entity == os.environ.get('CUBE_KPI')) or (entity == os.environ.get('CUBE_REG')):
        return KpiRegister, KpiRegisterSchema()
