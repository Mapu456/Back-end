from crypt import methods
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from db import app, db
from models.industry import Industry
from models.startup import Startup
from models.user import User
from models.kpiRegister import KpiRegister
from models.permission import Permission
from models.role import Role
from queries.get_queries import get_entity, get_entity_by_id
from queries.post_queries import post_register
from queries.put_queries import put_register
from queries.delete_queries import delete_register


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

    return post_register(entity, data)


@app.route('/api/v1/<entity>', methods=['PUT'])
def update_register(entity):
    args = request.args
    data = request.get_json(force=True)

    return put_register(entity, args, data)


@app.route('/api/v1/<entity>', methods=['DELETE'])
def remove_register(entity):
    args = request.args

    return delete_register(entity, args)


if __name__ == "__main__":
    app.run(debug=True)
