from flask_marshmallow import Marshmallow
from ma import ma


class IndustrySchema(ma.Schema):
    class Meta:
        fields = ("industryId", "industryName")
