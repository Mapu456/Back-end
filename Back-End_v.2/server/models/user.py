from flask_sqlalchemy import SQLAlchemy
from models.db import db
from models.role import *
from models.user_role import userRole


# table user
class User(db.Model):
    __tablename__ = 'user'

    userId = db.Column(db.String(60), primary_key=True, autoincrement=False)
    firstname = db.Column(db.String(128))
    lastname = db.Column(db.String(128))
    cityOfResidence = db.Column(db.String(128))
    countryOfResidence = db.Column(db.String(128))
    photoUrl = db.Column(db.String(128))
    phone = db.Column(db.String(128))
    emailAddress = db.Column(db.String(128))
    password = db.Column(db.String(60))
    roles = db.relationship('Role', secondary=userRole, lazy='subquery',
        back_populates="users")

    def __init__(self, userId, firstname, lastname, cityOfResidence,
                 countryOfResidence, photoUrl, phone, emailAddress, password):
        userId = userId
        firstname = firstname
        lastname = lastname
        cityOfResidence = cityOfResidence
        countryOfResidence = countryOfResidence
        photoUrl = photoUrl
        phone = phone
        emailAddress = emailAddress
        password = password
