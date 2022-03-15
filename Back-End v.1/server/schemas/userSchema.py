from flask_marshmallow import Marshmallow
from schemas.ma import ma
from schemas.startupSchema import StartupSchema


class UserSchema(ma.Schema):
    class Meta:
        fields = ("userId", "firstname", "lastname", "cityOfResidence",
                  "countryOfResidence", "photoUrl", "phone", "emailAddress",
                  "right", "userBasicId", "accessUser", "password")

    pyme = ma.Nested(StartupSchema)
