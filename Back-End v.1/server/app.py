from crypt import methods
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from db import app, db
from queries.get_queries import get_entity, get_entity_by_id
from queries.post_queries import post_register


@app.route('/api/v1/<entity>')
def get_results(entity):
    args = request.args
    if not args:
        return get_entity(entity)

    return get_entity_by_id(entity, args)

@app.route('/api/v1/<entity>', methods=['POST'])
def insert_register(entity):
    data = request.get_json(force=True)

    post_register(entity, data)
    """ cat_nom = data['cat_nom']
    cat_desp = data['cat_desp']

    new_register = Category(cat_nom, cat_desp)

    db.session.add(new_register)
    db.session.commit()
    return category_schema.jsonify(new_register) """
    return data

if __name__ == "__main__":
    db.create_all()
    app.run(debug=True)
