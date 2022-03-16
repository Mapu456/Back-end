from json.tool import main
from crypt import methods
from unicodedata import name
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.exc import NoResultFound
from flask_marshmallow import Marshmallow
from models.db import app, db
from models.admin import Admin
from models.industry import Industry
from models.startup import Startup
from models.permission import Permission
from models.user import User
from models.kpiRegister import KpiRegister
from schemas.ma import ma
from schemas.startupSchema import StartupSchema
from schemas.adminSchema import AdminSchema
from schemas.industrySchema import IndustrySchema
from schemas.permissionSchema import PermissionSchema
from schemas.userSchema import UserSchema
from schemas.kpiRegisterSchema import KpiRegisterSchema
import json


db.create_all()


# One response
startup_schema = StartupSchema()
user_schema = UserSchema()
kpi_register_schema = KpiRegisterSchema()

# Many responses
startup_schemas = StartupSchema(many=True)
user_schemas = UserSchema(many=True)
kpi_register_schemas = KpiRegisterSchema(many=True)

# GET x ID

@app.route('/<val>/<id>', methods=['GET'])
def get_register_by_id(val, id):
    if val == "startup":
        table = Startup
        val_schema = startup_schema
        val_id = table.startupId
    elif val == "user":
        table = User
        val_schema = user_schema
        val_id = table.userId
    elif val == "kpi":
        table = KpiRegister
        val_schema = kpi_register_schema
        val_id = table.kpiId
    try:
        result = table.query.filter(val_id == id).one()
    except NoResultFound:
        return {"message": "{} could not be found.".format(val)}, 400
    return val_schema.jsonify(result)


# GET

@app.route('/<val>', methods=['GET'])
def get_registers(val):
    if val == "startup":
        table = Startup
        val_schemas = startup_schemas
    elif val == "user":
        table = User
        val_schemas = user_schemas
    elif val == "kpi":
        table = KpiRegister
        val_schemas = kpi_register_schemas
    
    val_id = exec("%s" % ("table."+val+"Id"))
    results = table.query.all()
    val_results = val_schemas.dump(results)
    return jsonify(val_results)


@app.route('/user_pyme/<id>', methods=['GET'])
def get_user_pyme(id):
    try:
        user = User.query.filter(User.userId == id).one()
    except NoResultFound:
        return {"message": "User could not be found."}, 400
    result = user_schema.dump(user)  # return a writable json
    pyme_result = Startup.query.get(result["userBasicId"])
    [result.pop(key) for key in ['accessUser', 'password']]
    result_dict = startup_schema.dump(pyme_result)
    [result_dict.pop(key) for key in ['founders', 'femaleFounders',
                                      'industry']]
    result['pyme'] = result_dict

    return result


if __name__ == "__main__":
    app.run(debug=True)
