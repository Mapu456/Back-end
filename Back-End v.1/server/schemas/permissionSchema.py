from flask_marshmallow import Marshmallow
from ma import ma


class PermissionSchema(ma.Schema):
    class Meta:
        fields = ("permissionId", "permissionRight")
