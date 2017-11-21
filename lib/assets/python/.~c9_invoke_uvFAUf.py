import json
import sys

def test():
    json_data = sys.argv[1]
    data = json.loads(json_data)
    return "vix: " +json_data["vix"] +  ",   fvm: " json_data["fvmean"]
    
    return "vix: " + data["vix"] + ", fvix: " + data["fvmean"]
    
    


print test()