import json
import sys

def test():
    
    data = json.loads(json_data)
    
    
    return "vix: " + data["vix"] + ", fvix: " + data["fvmean"]
    
    


print test()