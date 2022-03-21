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


def get_entity(entity):
    table, entity_schemas = get_registers(entity)

    results = table.query.all()
    entity_results = entity_schemas.dump(results)
    return jsonify(entity_results)


def get_entity_by_id(entity, args):
    keys = [*args]
    first_column = keys[0]
    first_id = args.get(keys[0])

    table, entity_schema = get_registers(entity)
    entity_id = get_column(entity, table, first_column)

    try:
        tmp_result = table.query.filter(entity_id == first_id).all()
        if len(tmp_result) == 0:
            raise NoResultFound("could not be found")

    except NoResultFound as e:
        return {f"message": f"{entity} {e}."}, 400

    """ if len(args) > 1:
        result = entity_schema.dump(tmp_result)
        user_result = Startup.query.get(result["userBasicId"]) """
    return jsonify(entity_schema.dump(tmp_result))


def get_registers(entity):
    if entity == os.environ.get('CUBE_ST'):
        return Startup, startup_schemas
    elif entity == os.environ.get('CUBE_USR'):
        return User, user_schemas
    elif (entity == os.environ.get('CUBE_KPI')) or (entity == os.environ.get('CUBE_REG')):
        return KpiRegister, kpi_register_schemas


def get_column(entity, table, first_column):
    if (entity == os.environ.get('CUBE_KPI')) or (entity == os.environ.get('CUBE_REG')):
        value = f"KpiRegister.{first_column}"
    else:
        value = f"{entity.capitalize()}.{first_column}"
    for val in range(len(list(table.__table__._columns))):
        if value == str(getattr(table,
                                list(table.__table__._columns)[val].name)):
            return getattr(table, list(table.__table__._columns)[val].name)
