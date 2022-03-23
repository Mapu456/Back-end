from flask import jsonify
from db import db
from sqlalchemy.exc import NoResultFound
from werkzeug.security import generate_password_hash as gen_pass
from queries.register_functions import get_registers
from queries.register_functions import set_values


def put_register(entity, args, data):
    keys = [*args]
    first_column = keys[0]
    first_id = args.get(keys[0])

    table, entity_schema = get_registers(entity)
    entity_id = getattr(table, list(table.__table__._columns)[0].name)

    try:
        result = table.query.filter(entity_id == first_id).one()
    except NoResultFound:
        return {f"message": f"{entity} could not be found."}, 400

    if 'password' in data:
        data['password'] = gen_pass(data['password'], method='sha256')
    result = set_values(result, data)

    local_object = db.session.merge(result)
    db.session.commit()
    return entity_schema.jsonify(local_object)
