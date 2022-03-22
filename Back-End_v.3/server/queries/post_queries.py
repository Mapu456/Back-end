import os
from flask import jsonify
from db import db
from sqlalchemy.exc import NoResultFound
import uuid
from models.startup import Startup
from models.user import User
from models.kpiRegister import KpiRegister
from schemas.startupSchema import StartupSchema
from schemas.userSchema import UserSchema
from schemas.kpiRegisterSchema import KpiRegisterSchema


def post_register(entity, data):
    table, entity_schema = get_registers(entity)
    value = list(data.values())
    value.insert(0, str(uuid.uuid4()))
    entity_id = getattr(table, list(table.__table__._columns)[0].name)

    try:
        result = table.query.filter(entity_id == value[0]).one()
        if not result:
            raise NoResultFound()

    except NoResultFound:
        new_register = table(*value)

        local_object = db.session.merge(new_register)
        db.session.add(local_object)
        db.session.commit()
        return entity_schema.jsonify(new_register)
    
    return jsonify({'message' : f'{entity} already exists'}), 400


def get_registers(entity):
    if entity == os.environ.get('CUBE_ST'):
        return Startup, StartupSchema()
    elif entity == os.environ.get('CUBE_USR'):
        return User, UserSchema()
    elif (entity == os.environ.get('CUBE_KPI')) or (entity == os.environ.get('CUBE_REG')):
        return KpiRegister, KpiRegisterSchema()
