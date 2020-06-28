from pymongo import MongoClient
from pprint import pprint
from dotenv import load_dotenv

import os
from pathlib import Path

env_path = os.path.join(Path.cwd(),'\..','dev.env')

load_dotenv(dotenv_path=env_path)

mongoURL = os.getenv("MONGODB_URL")

client = MongoClient(mongoURL)
db=client.admin
serverStatusResult=db.command("serverStatus")
pprint(serverStatusResult)