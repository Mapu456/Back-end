from flask import jsonify
from db import db
from sqlalchemy.exc import NoResultFound
from queries.register_functions import get_registers


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
