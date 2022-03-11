from unicodedata import name
from flask import Flask
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
uri = 'mysql+pymysql://root:@localhost:3306/cubeTestDb'
app.config['SQLALCHEMY_DATABASE_URI'] = uri
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
