from flask_marshmallow import Marshmallow
from schemas.ma import ma


class AdminSchema(ma.Schema):
    class Meta:
        fields = ("adminId", "name", "photoUrl", "country", "city",
                  "emailAddress", "phone")
