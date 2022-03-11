from flask_sqlalchemy import SQLAlchemy
from models.db import db


# table user
class User(db.Model):
    __tablename__ = 'user'

    id = db.Column(db.String(60), primary_key=True)
    firstname = db.Column(db.String(128))
    lastname = db.Column(db.String(128))
    cityOfResidence = db.Column(db.String(128))
    countryOfResidence = db.Column(db.String(128))
    photoUrl = db.Column(db.String(128))
    phone = db.Column(db.String(128))
    emailAddress = db.Column(db.String(128))
    right = db.Column(db.String(60), db.ForeignKey('permission.permissionId'))
    userBasicId = db.Column(db.String(60), db.ForeignKey('startupGeneral.
                                                         startupId'))
    accessUser = db.Column(db.String(128))
    password = db.Column(db.String(60))

    def __init__(self, id, firstname, lastname, cityOfResidence,
                 countryOfResidence, photoUrl, phone, emailAddress, right,
                 userBasicId, accessUser, password):
        id = id
        firstname = firstname
        lastname = lastname
        cityOfResidence = cityOfResidence
        countryOfResidence = countryOfResidence
        photoUrl = photoUrl
        phone = phone
        emailAddress = emailAddress
        right = right
        userBasicId = userBasicId
        accessUser = accessUser
        password = password
