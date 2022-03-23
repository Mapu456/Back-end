from flask import jsonify
from db import db
from sqlalchemy.exc import NoResultFound
from queries.register_functions import get_registers


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

    result = set_values(result, data)

    local_object = db.session.merge(result)
    db.session.commit()
    return entity_schema.jsonify(local_object)

def set_values(result, data):
    valor = list(data.values())
    key = list(data.keys())
    for val in range(1, len(list(result.__table__._columns)), 1):
        exec("%s" % ("result."+key[val-1]+"=valor[val-1]"))
    return result
