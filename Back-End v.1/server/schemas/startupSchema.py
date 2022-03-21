from flask_marshmallow import Marshmallow
from ma import ma


class StartupSchema(ma.Schema):
    class Meta:
        fields = ('startupId', 'name', 'photoUrl', 'country', 'city',
                  'emailAddress', 'phone', 'founders', 'femaleFounders',
                  'industry', 'active')
