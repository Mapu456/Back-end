from flask import jsonify
from db import db
from sqlalchemy.exc import NoResultFound
import uuid
from werkzeug.security import generate_password_hash as gen_pass
from queries.register_functions import get_registers
from queries.register_functions import set_values


def post_register(entity, data):
    table, entity_schema = get_registers(entity)
    first_column = list(table.__table__._columns)[0].name
    data[first_column] = str(uuid.uuid4())
    if 'password' in data:
        data['password'] = gen_pass(data['password'], method='sha256')
    
    value = []
    for s in range(len(list(table.__table__._columns))):
        value.append(None)
    entity_id = getattr(table, list(table.__table__._columns)[0].name)

    try:
        result = table.query.filter(entity_id == value[0]).one()
        if not result:
            raise NoResultFound()

    except NoResultFound:
        new_register = table(*value)
        new_register = set_values(new_register, data)

        local_object = db.session.merge(new_register)
        db.session.add(local_object)
        db.session.commit()
        return entity_schema.jsonify(new_register)
    
    return jsonify({'message' : f'{entity} already exists'}), 400
