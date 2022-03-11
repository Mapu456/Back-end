from flask_marshmallow import Marshmallow
from dbSchemas.ma import ma


class StartupGeneralSchema(ma.Schema):
    class Meta:
        fields = ('startupId', 'name', 'photoUrl', 'country', 'city',
                  'emailAddress', 'phone', 'founders', 'femaleFounders',
                  'industry', 'active')
