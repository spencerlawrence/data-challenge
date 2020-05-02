import names
from sqlalchemy import create_engine

# secrets
username = "username"
password = "password"
host = "localhost"
port = 3306
db = "dermstore"
url = f"mysql+mysqlconnector://{username}:{password}@{host}:{port}/{db}"

# create engine
engine = create_engine(url)

for x in range(0, 5):
    # generate random name and email
    first_name, last_name = names.get_first_name(), names.get_last_name()
    email = f"{first_name}.{last_name}@gmail.com".lower()

    # generate insert statement
    sql = (
    	f"insert into dermstore.customers "
    	f"(customer_firstname, customer_lastname, customer_email) "
    	f"values ('{first_name}', '{last_name}', '{email}')"
    )
    print(sql)

    # execute sql
    engine.execute(sql)
