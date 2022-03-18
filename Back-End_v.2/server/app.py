from json.tool import main
from crypt import methods
from unicodedata import name
from flask import Flask, jsonify, request, make_response
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.exc import NoResultFound
from flask_marshmallow import Marshmallow
from models.db import app, db
from models.industry import Industry
from models.role import Role
from models.startup import Startup
from models.permission import Permission
from models.user import *
from models.kpiRegister import KpiRegister
from schemas.ma import ma
from schemas.industrySchema import IndustrySchema
from schemas.roleSchema import RoleSchema
from schemas.startupSchema import StartupSchema
from schemas.permissionSchema import PermissionSchema
from schemas.userSchema import UserSchema
from schemas.kpiRegisterSchema import KpiRegisterSchema
from schemas.role_permissionSchema import Role_permissionSchema
from schemas.user_roleSchema import User_roleSchema
from sqlalchemy import exc
import json
import uuid
from werkzeug.security import generate_password_hash, check_password_hash
import jwt
import datetime
from functools import wraps

app.config['SECRET_KEY'] = 'thisissecret'

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


#create new user

@app.route('/user', methods=['POST'])
def create_user():
    #if not current_user.admin:
    #    return jsonify({'message' : 'Cannot perform that function!'})

    #print(request.json)
    data = request.get_json()
    #print(data)

    hashed_password = generate_password_hash(data['password'], method='sha256')

    print(hashed_password)

    print(data['emailAddress'])
    print(data['phone'])
    print(data['firstname'])


    new_user = User(userId =str(uuid.uuid4()), password=hashed_password, cityOfResidence=data['cityOfResidence'],
                countryOfResidence=data['countryOfResidence'], emailAddress=data['emailAddress'], firstname=data['firstname'],
                lastname=data['lastname'], phone=data['phone'], photoUrl=data['photoUrl'])
    db.session.add(new_user)
    db.session.commit()

    return jsonify({'message' : 'New user created!'})

#delete user
@app.route('/user/<userId>', methods=['DELETE'])
def delete_user(userId):
    #if not current_user.admin:
    #    return jsonify({'message' : 'Cannot perform that function!'})

    user = User.query.filter_by(userId=userId).first()

    if not user:
        return jsonify({'message' : 'No user found!'})

    db.session.delete(user)
    db.session.commit()

    return jsonify({'message' : 'The user has been deleted!'})

@app.route('/login')
def login():
    auth = request.authorization

    if not auth or not auth.username or not auth.password:
        return make_response('Could not verify', 401, {'WWW-Authenticate' : 'Basic realm="Login required!"'})

    user = User.query.filter_by(userId=auth.username).first()

    if not user:
        return make_response('Could not verify', 401, {'WWW-Authenticate' : 'Basic realm="Login required!"'})

    if check_password_hash(user.password, auth.password):
        token = jwt.encode({'userId' : user.userId, 'exp' : datetime.datetime.utcnow() + datetime.timedelta(minutes=30)}, app.config['SECRET_KEY'])

        return jsonify({'token' : token.decode('UTF-8')})

    return make_response('Could not verify', 401, {'WWW-Authenticate' : 'Basic realm="Login required!"'})


if __name__ == "__main__":
    app.run(debug=True)
