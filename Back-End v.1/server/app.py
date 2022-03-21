from crypt import methods
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from db import app, db
from queries.get_queries import get_entity, get_entity_by_id
from queries.post_queries import post_register


db.create_all()


@app.route('/api/v1/<entity>')
def get_results(entity):
    args = request.args
    if not args:
        return get_entity(entity)

    return get_entity_by_id(entity, args)

@app.route('/api/v1/<entity>', methods=['POST'])
def insert_register(entity):
    data = request.get_json(force=True)
    result = post_register(entity, data)
    
    return result

if __name__ == "__main__":
    app.run(debug=True)
