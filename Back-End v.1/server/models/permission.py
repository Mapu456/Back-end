from flask_sqlalchemy import SQLAlchemy
from models.db import db
from models.user import User

# table permission
class Permission(db.Model):
    __tablename__ = 'permission'

    permissionId = db.Column(db.String(60), primary_key=True)
    permissionRight = db.Column(db.String(128))
    users = db.relationship('User', backref='permission_id',
                                      lazy=True)

    def __init__(self, permissionId, permissionRight):
        self.permissionId = permissionId
        self.permissionRight = permissionRight
