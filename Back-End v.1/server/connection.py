import os


def get_connection():
    return ("mysql+pymysql://" + os.environ.get('CUBE_HOST') +
            ":" + os.environ.get('CUBE_PWD') +
            os.environ.get('CUBE_PATH')+":" + os.environ.get('CUBE_PORT') +
            "/" + os.environ.get('CUBE_DATABASE'))
