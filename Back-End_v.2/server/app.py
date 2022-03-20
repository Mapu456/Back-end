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
from models.user_role import userRole
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


def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None

        if 'x-access-token' in request.headers:
            token = request.headers['x-access-token']

        if not token:
            return jsonify({'message' : 'Token is missing!'}), 401

        try: 
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256', ])
            #print(type(data))
            #print(data)
            current_user = User.query.filter_by(emailAddress=data['emailAddress']).first()
            #print(type(current_user))      
            #print(current_user)
            #print(current_user.emailAddress)   
        except:
            return jsonify({'message' : 'Token is invalid!'}), 401

        return f(current_user, *args, **kwargs)

    return decorated

@app.route('/unprotected')
def unprotected():
    return jsonify({'message' : 'Anyone can view this!'})

@app.route('/protected')
@token_required
def protected(current_user):
    return jsonify({'message' : 'This is on available for people with valid tokens.'})


# GET x ID

@app.route('/<val>/<id>', methods=['GET'])
@token_required
def get_register_by_id(current_user, val, id):
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
@token_required
def get_registers(current_user, val):
    if val == "startup":
        table = Startup
        val_schemas = startup_schemas
    elif val == "user":
        table = User
        val_schemas = user_schemas
    elif val == "kpi":
        table = KpiRegister
        val_schemas = kpi_register_schemas
    
    #val_id = exec("%s" % ("table."+val+"Id"))
    results = table.query.all()
    val_results = val_schemas.dump(results)

    print(type(userRole))
    testing = userRole
    print(testing)
    return jsonify(val_results)


@app.route('/user_pyme/<id>', methods=['GET'])
@token_required
def get_user_pyme(current_user, id):
    try:
        user = User.query.filter(User.userId == id).one()
    except NoResultFound:
        return {"message": "User could not be found."}, 400
    result = user_schema.dump(user)  # return a writable json
    startup_result = Startup.query.filter(Startup.userId == result["userId"]).one()
    [result.pop(key) for key in ['userId', 'password']]
    result_dict = startup_schema.dump(startup_result)
    [result_dict.pop(key) for key in ['founders', 'femaleFounders',
                                      'industry', 'userId']]
    result['startup'] = result_dict

    return result


#create new user

@app.route('/user', methods=['POST'])
@token_required
def create_user(current_user):
    #if not current_user.admin:
    #    return jsonify({'message' : 'Cannot perform that function!'})

    #print(request.json)
    data = request.get_json()
    #print(data)

    hashed_password = generate_password_hash(data['password'], method='sha256')

    new_user = User(userId =str(uuid.uuid4()), password=hashed_password, cityOfResidence=data['cityOfResidence'],
                countryOfResidence=data['countryOfResidence'], emailAddress=data['emailAddress'], firstname=data['firstname'],
                lastname=data['lastname'], phone=data['phone'], photoUrl=data['photoUrl'])
    db.session.add(new_user)
    db.session.commit()

    return jsonify({'message' : 'New user created!'})

#delete user
@app.route('/user/<userId>', methods=['DELETE'])
@token_required
def delete_user(current_user, userId):
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

    user = User.query.filter_by(emailAddress=auth.username).first()

    if not user:
        return make_response('Could not verify', 401, {'WWW-Authenticate' : 'Basic realm="Login required!"'})

    if check_password_hash(user.password, auth.password):
        token = jwt.encode({'emailAddress' : user.emailAddress, 'exp' : datetime.datetime.utcnow() + datetime.timedelta(minutes=30)}, app.config['SECRET_KEY'])

        return jsonify({'token' : token})

    return make_response('Could not verify', 401, {'WWW-Authenticate' : 'Basic realm="Login required!"'})


#create new startup

@app.route('/startup', methods=['POST'])
@token_required
def create_startup(current_user):
    #if not current_user.admin:
    #    return jsonify({'message' : 'Cannot perform that function!'})

    #print(request.json)
    data = request.get_json()
    #print(data)

    new_startup = Startup(startupId = data['startupId'], userId=data['userId'], name=data['name'],
        photoUrl=data['photoUrl'], country=data['country'], city=data['city'],
        emailAddress=data['emailAddress'], phone=data['phone'], founders=data['founders'],
        femaleFounders=data['femaleFounders'], industry=data['industry'], active=data['active'])
    db.session.add(new_startup)
    db.session.commit()

    return jsonify({'message' : 'New startup created!'})




#create new kpi

@app.route('/kpi', methods=['POST'])
@token_required
def kpi_register(current_user):
    #if not current_user.admin:
    #    return jsonify({'message' : 'Cannot perform that function!'})

    data = request.get_json()

    new_kpi = KpiRegister(kpiId = data['kpiId'], date=data['date'], startupId=data['startupId'],
        revenue=data['revenue'], ARR=data['ARR'], EBITDA=data['EBITDA'], GMV=data['GMV'],
        numberEmployees=data['numberEmployees'], fundRaising=data['fundRaising'], CAC=data['CAC'],
        activeClients=data['activeClients'])
    db.session.add(new_kpi)
    db.session.commit()

    return jsonify({'message' : 'New kpi register created!'})


if __name__ == "__main__":
    app.run(debug=True)
