from flask_sqlalchemy import SQLAlchemy
from models.db import db
from models.user import User
from models.kpiRegister import KpiRegister


# table startup
class Startup(db.Model):
    __tablename__ = 'startup'

    startupId = db.Column(db.String(60), primary_key=True)
    name = db.Column(db.String(128))
    photoUrl = db.Column(db.String(128))
    country = db.Column(db.String(60))
    city = db.Column(db.String(60))
    emailAddress = db.Column(db.String(60))
    phone = db.Column(db.String(60))
    femaleFounders = db.Column(db.Integer)
    founders = db.Column(db.Integer)
    industry = db.Column(db.String(60), db.ForeignKey('industry.industryId'))
    active = db.Column(db.Boolean)
    users = db.relationship('User', backref='startup_id', lazy=True)
    registers = db.relationship('KpiRegister', backref='startup_id', lazy=True)

    def __init__(self, startupId, name, photoUrl, country, city,
                 emailAddress, phone, founders, femaleFounders, industry,
                 active):
        self.startupId = startupId
        self.name = name
        self.photoUrl = photoUrl
        self.country = country
        self.city = city
        self.emailAddress = emailAddress
        self.phone = phone
        self.founders = founders
        self.femaleFounders = femaleFounders
        self.industry = industry
        self.active = active
