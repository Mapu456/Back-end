from flask import jsonify
from db import db
from sqlalchemy.exc import NoResultFound
import uuid
from queries.register_functions import get_registers


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
