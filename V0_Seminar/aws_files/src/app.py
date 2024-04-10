from flask import Flask, request,render_template
from flasgger import Swagger #To help dev


app = Flask(__name__, template_folder='templates')

swagger = Swagger(app)

@app.route('/')
def display_root():
    """
    A simple addition API
    ---
    parameters:
      - name: var_a
        in: query
        type: integer
        required: true
      - name: var_b
        in: query
        type: integer
        required: true
    responses:
      200:
        description: The result of the addition
    """
    # HTML content with a button to navigate to the Swagger UI documentation
    return render_template('index.html')

@app.route('/sum')
def add():
    """
    A simple addition API
    ---
    parameters:
      - name: var_a
        in: query
        type: integer
        required: true
      - name: var_b
        in: query
        type: integer
        required: true
    responses:
      200:
        description: The result of the addition
    """
    var_a = request.args.get('var_a', default=0, type=int)
    var_b = request.args.get('var_b', default=0, type=int)
    result = var_a + var_b
    return f'The sum of {var_a} and {var_b} is {result}'



if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
