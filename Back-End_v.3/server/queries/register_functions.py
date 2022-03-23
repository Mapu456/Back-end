import os
from models.startup import Startup
from models.user import User
from models.kpiRegister import KpiRegister
from schemas.startupSchema import StartupSchema
from schemas.userSchema import UserSchema
from schemas.kpiRegisterSchema import KpiRegisterSchema

def get_registers(entity):
    if entity == os.environ.get('CUBE_ST'):
        return Startup, StartupSchema()
    elif entity == os.environ.get('CUBE_USR'):
        return User, UserSchema()
    elif (entity == os.environ.get('CUBE_KPI')) or (entity == os.environ.get('CUBE_REG')):
        return KpiRegister, KpiRegisterSchema()

def get_many_registers(entity):
    if entity == os.environ.get('CUBE_ST'):
        return Startup, StartupSchema(many=True)
    elif entity == os.environ.get('CUBE_USR'):
        return User, UserSchema(many=True)
    elif (entity == os.environ.get('CUBE_KPI')) or (entity == os.environ.get('CUBE_REG')):
        return KpiRegister, KpiRegisterSchema(many=True)
