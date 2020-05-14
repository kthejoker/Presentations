import pickle, json
from azureml.core.model import Model
import pandas as pd
import numpy as np

from inference_schema.schema_decorators import input_schema, output_schema
from inference_schema.parameter_types.numpy_parameter_type import NumpyParameterType
from inference_schema.parameter_types.pandas_parameter_type import PandasParameterType
from sklearn.externals import joblib

def init():
    global titanic_classifier
    model_path = Model.get_model_path(model_name = "titanic_classifier_model")
    titanic_classifier = joblib.load(model_path)

input_sample = pd.DataFrame(data=[{
    "age": 20,
    "pclass": 1,
    "unaccompanied" : 0,
    "sex" : 0
}])

output_sample = np.array([0])

@input_schema('data', PandasParameterType(input_sample))
@output_schema(NumpyParameterType(output_sample))
def run(data):
    try:
        result = titanic_classifier.predict(data)
        return result.tolist()
    except Exception as e:
        result = str(e)
        return error
