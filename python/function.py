from flask import Flask, request
from flask_executor import Executor
from datetime import datetime, timedelta
import time
import requests
 
app = Flask(__name__)
executor = Executor(app)
 
url_create = f'https://api.github.com/repos/edgarflores33/terraform/actions/workflows/create.yaml/dispatches'
url_delete = f'https://api.github.com/repos/edgarflores33/terraform/actions/workflows/delete.yaml/dispatches'
headers = {
    "Authorization": "token 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",
    'Accept': 'application/vnd.github.v3+json'
}
 
params = {
    'ref': 'main',  # Reemplaza con la rama donde quieres ejecutar el workflow
}
 
def delete(segundos:int):
    print(segundos)
    #Wait 5 minutes
    time.sleep(segundos) # 5 minutes
    # time.sleep(8 * 60 * 60) # 8 hours
    response = requests.post(url_delete, headers=headers, json=params)
    #Check the response
    if response.status_code == 204:
        print("Event dispatched successfully.")
    else:
        print(f"Failed to dispatch event: {response.content}")
 
@app.route('/webhook', methods=['POST'])
def handle_webhook():
    data = request.get_json()
    status = data["issue"]["fields"]["status"]["name"]
    if status == 'Done':
        response = requests.post(url_create, headers=headers, json=params)
        #Check the response
        if response.status_code == 204:
            print("Event dispatched successfully.")
        else:
            print(f"Failed to dispatch event: {response.content}")
        
        # Get the current date and time
        start_date = datetime.now()        
        # Add 8 hours to the current date and time
        end_date = datetime.strptime('2024-06-03 11:20', '%Y-%m-%d %H:%M')        
        # Calculate the difference between the two dates
        difference = end_date - start_date        
        # Get the difference in seconds
        difference_in_seconds :int = difference.total_seconds()        
        print(f"Difference in seconds: {difference_in_seconds}")
        # segundos = 30
        executor.submit(delete(difference_in_seconds))
        return '', 200       
    else:
        return '', 200
if __name__ == '__main__':
    app.run(port=5000,debug=True)