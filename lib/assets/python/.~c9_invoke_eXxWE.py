import json
import sys

def test():
    json_data = sys.argv[1]
    data = json.loads(json_data)
    
    
    return "vix: " + data["vix"] + ", fvix: " + data["fvmean"]
    
    


print test()



















