# Firstly, we are going to be using firebase_admin library to interface with our database, so need to import these.
# We will make sure we import the jsonify methods from Flask

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from flask import Flask
from flask import jsonify

# We need to create a link between our app and the Firestore database.  

app = Flask(__name__)
firebase_admin.initialize_app()
db = firestore.client()
ref =db.collection(u'WebsiteData').document('ViewingData')

# We want to use the POST HTTP method. 
# I set the method in the route and define a function named view_count

@app.route("/",methods=['POST'])
@cross_origin()
def view_count():
    # Increment the value in our document
    ref.update({"ViewCount": firestore.Increment(1)})

    # Retrieve the count
    viewcount = ref.get().to_dict()['ViewCount']

    # Change it to a JSON format and print what we are returning for logging purpose and return it from the function
    response = jsonify({'ViewCount':viewcount})
    print("Returning:",response)
    return response

if __name__ == "__main__":
    app.run(debug=True,host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))