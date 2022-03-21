from flask_marshmallow import Marshmallow
from ma import ma


class AdminSchema(ma.Schema):
    class Meta:
        fields = ("adminId", "name", "photoUrl", "country", "city",
                  "emailAddress", "phone")
