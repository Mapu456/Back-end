from flask_sqlalchemy import SQLAlchemy
from db import db


# table user
class User(db.Model):
    __tablename__ = 'user'

    userId = db.Column(db.String(60), primary_key=True)
    firstname = db.Column(db.String(128))
    lastname = db.Column(db.String(128))
    cityOfResidence = db.Column(db.String(128))
    countryOfResidence = db.Column(db.String(128))
    photoUrl = db.Column(db.String(128))
    phone = db.Column(db.String(128))
    emailAddress = db.Column(db.String(128))
    right = db.Column(db.String(60), db.ForeignKey('permission.permissionId'))
    userBasicId = db.Column(db.String(60),
                            db.ForeignKey('startup.startupId'))
    accessUser = db.Column(db.String(128))
    password = db.Column(db.String(60))

    def __init__(self, userId, firstname, lastname, cityOfResidence,
                 countryOfResidence, photoUrl, phone, emailAddress, right,
                 userBasicId, accessUser, password):
        self.userId = userId
        self.firstname = firstname
        self.lastname = lastname
        self.cityOfResidence = cityOfResidence
        self.countryOfResidence = countryOfResidence
        self.photoUrl = photoUrl
        self.phone = phone
        self.emailAddress = emailAddress
        self.right = right
        self.userBasicId = userBasicId
        self.accessUser = accessUser
        self.password = password
