import json, os
config_file = "debug_config.json" if os.path.exists("debug_config.json") else "config.json"
try:
    with open(config_file, "r") as f: config = json.load(f)
except:
    config = {"db_host": "localhost", "db_port": "5432", "db_name": "test", "db_user": "test", "db_password": "test"}
