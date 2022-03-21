from unicodedata import name
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from connection import get_connection


app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = get_connection()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
