from flask_marshmallow import Marshmallow
from ma import ma


class User_roleSchema(ma.Schema):
    class Meta:
        fields = ("userId", "roleId")

