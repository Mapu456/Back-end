from flask_sqlalchemy import SQLAlchemy
from models.db import db

# table admin
class Admin(db.Model):
    __tablename__ = 'admin'
    
    adminId = db.Column(db.String(60), primary_key=True)
    name = db.Column(db.String(128))
    photoUrl = db.Column(db.String(128))
    country = db.Column(db.String(60))
    city = db.Column(db.String(60))
    emailAddress = db.Column(db.String(60))
    phone = db.Column(db.String(60))
    """ users = db.relationship('User', backref='admin_id', lazy=True) """

    def __init__(self, adminId, name, photoUrl, country, city, emailAddress, phone):
        self.adminId  = adminId
        self.name  = name
        self.photoUrl  = photoUrl
        self.country  = country
        self.city  = city
        self.emailAddress  = emailAddress
        self.phone  = phone
