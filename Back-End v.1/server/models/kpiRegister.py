from flask_sqlalchemy import SQLAlchemy
from models.db import db

# table kpiRegister
class KpiRegister(db.Model):
    __tablename__ = 'kpiRegister'

    date = db.Column(db.date)
    startupId = db.Column(db.String(60), db.ForeignKey('startup.startupId'))
    revenue = db.Column(db.float)
    ARR = db.Column(db.float)
    EBITDA = db.Column(db.float)
    GMV = db.Column(db.float)
    numberEmployees = db.Column(db.Integer)
    fundRaising = db.Column(db.float)
    CAC = db.Column(db.float)
    activeClients = db.Column(db.Integer)

    def __init__(self, date, startupId, revenue, ARR, EBITDA, GMV,
                 numberEmployees, fundRaising, CAC, activeClients):

        self.date = date
        self.startupId = startupId
        self.revenue = revenue
        self.ARR = ARR
        self.EBITDA = EBITDA
        self.GMV = GMV
        self.numberEmployees = numberEmployees
        self.fundRaising = fundRaising
        self.CAC = CAC
        self.activeClients = activeClients
