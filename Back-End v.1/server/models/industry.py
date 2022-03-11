from flask_sqlalchemy import SQLAlchemy
from models.db import db
from models.startupGeneral import StartupGeneral

# table industry
class Industry(db.Model):
    __tablename__ = 'industry'

    industryId = db.Column(db.String(60), primary_key=True)
    industryName = db.Column(db.String(60))
    startupgenerals = db.relationship('StartupGeneral', backref='industry_id',
                                      lazy=True)

    def __init__(self, industryId, industryName):
        self.industryId = industryId
        self.industryName = industryName
