from flask_marshmallow import Marshmallow
from dbSchemas.ma import ma


class UserSchema(ma.Schema):
    class Meta:
        fields = ("id", "firstname", "lastname", "cityOfResidence",
                  "countryOfResidence", "photoUrl", "phone", "emailAddress",
                  "right", "userBasicId", "accessUser", "password")
