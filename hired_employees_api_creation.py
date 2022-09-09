from concurrent.futures import thread
from multiprocessing import process
from flask import Flask, jsonify, request
from flask_restful import Resource, Api, reqparse
import pandas as pd
import ast
from flask_mysqldb import MySQL
app = Flask(__name__)
api = Api(app)

class DevelopmentConfig():
    DEBUG=True
    MYSQL_HOST='localhost'
    MYSQL_USER='root'
    MYSQL_PASSWORD='12345'
    MYSQL_DB='api_globant'

  

config={
    'development': DevelopmentConfig
}

app=Flask(__name__)
conexion=MySQL(app)

@app.route('/departments', methods=['POST'])
def add_departments():
    try:
        cursor=conexion.connection.cursor()
        sql="""INSERT INTO departments (id, name, datetime, department_id, job_id) 
        VALUES ({},'{}','{}', {}, {})""".format(request.json['id'],request.json['name'],
                                                request.json['datetime'],request.json['department_id'],
                                                request.json['job_id'])
        cursor.execute(sql)
        conexion.connection.commit()
        return jsonify({'mensaje': "Department added."})
    except Exception as ex:
            return jsonify({'mensaje': "Error al intentar la solicitud"})

def pagina_no_encontrada(error):
    return "<h1>The page you are looking for does not exists. Please try again. </h1>", 404

if __name__=='__main__':
    app.config.from_object(config['development'])
    app.register_error_handler(404, pagina_no_encontrada)
    app.run(threaded=True)
