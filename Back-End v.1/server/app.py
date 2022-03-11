from json.tool import main
from crypt import methods
from unicodedata import name
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from models.db import app, db
from models.admin import Admin
from models.industry import Industry
from models.startupGeneral import StartupGeneral
from models.permission import Permission
from models.user import User
import json

ma = Marshmallow(app)
db.create_all()


class StartupGeneralSchema(ma.Schema):
    class Meta:
        fields = ('startupId', 'name', 'photoUrl', 'country', 'city',
                  'emailAddress', 'phone', 'founders', 'femaleFounders',
                  'industry', 'active')


class UserSchema(ma.Schema):
    class Meta:
        fields = ("id", "firstname", "lastname", "cityOfResidence",
                 "countryOfResidence", "photoUrl", "phone", "emailAddress", "right",
                 "userBasicId", "accessUser", "password")

# One response
startup_general_schema = StartupGeneralSchema()
user_schema = UserSchema()

# Many responses
startup_general_schemas = StartupGeneralSchema(many=True)
user_schemas = UserSchema(many=True)

# GET x ID
@app.route('/startups/<id>', methods=['GET'])
def get_startup_by_id(id):
    one_startup = StartupGeneral.query.get(id)
    return startup_general_schema.jsonify(one_startup)

@app.route('/user/<id>', methods=['GET'])
def get_user_by_id(id):
    one_user = User.query.get(id)
    return user_schema.jsonify(one_user)

# GET
@app.route('/startups', methods=['GET'])
def get_startups():
    all_startups = StartupGeneral.query.all()
    result = startup_general_schemas.dump(all_startups)
    return jsonify(results=result)

@app.route('/user', methods=['GET'])
def get_users():
    all_users = User.query.all()
    user_result = user_schemas.dump(all_users)
    return jsonify(user_result)

@app.route('/user_pyme/<id>', methods=['GET'])
def get_user_pyme(id):
    id_user = User.query.get(id) # returns an User object
    result = user_schema.dump(id_user) # return a writable json
    pyme_result = StartupGeneral.query.get(result["userBasicId"])
    [result.pop(key) for key in ['accessUser', 'password']]
    result_dict = startup_general_schema.dump(pyme_result)
    [result_dict.pop(key) for key in ['founders', 'femaleFounders', 'industry']]
    result['pyme'] = result_dict
    return result

if __name__ == "__main__":
    app.run(debug=True)