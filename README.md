# Financial App - by Andy Kammerath
Project structure:
```shell
my_project/
├── app/
│   ├── api/
│   │   ├── __init__.py
│   │   ├── endpoints/
│   │   │   ├── __init__.py
│   │   │   ├── transactions.py
│   │   │   ├── budgets.py
│   │   │   └── ...
│   │   └── routers.py
│   ├── models/
│   │   ├── __init__.py
│   │   ├── transactions.py
│   │   ├── budgets.py
│   │   └── ...
│   ├── schemas/
│   │   ├── __init__.py
│   │   ├── transactions.py
│   │   ├── budgets.py
│   │   └── ...
│   └── utils/
│       ├── __init__.py
│       └── ...
├── tests/
│   ├── test_transactions.py
│   ├── test_budgets.py
│   └── ...
├── main.py
├── .env
├── requirements.txt
└── README.md
```  
### explanation: 
* **my_project/**: The root directory of the project.


* **app/**: The directory containing the main application code.


* **app/api/**: This directory contains the code for the API endpoints, which handle incoming requests and return responses.


* **app/api/endpoints/**: This directory contains the code for defining the individual API endpoints. Each endpoint is represented by a separate module, such as transactions.py or budgets.py.


* **app/api/routers.py**: This module defines the API routes, which map URLs to endpoint functions.


* **app/models/**: This directory contains the code for the data models, which define the structure of the data used by the application. Each data model is represented by a separate module, such as transactions.py or budgets.py.


* **app/schemas/**: This directory contains code for the Pydantic models, which are used to validate and serialize incoming request data and outgoing response data.


* **app/utils/**: This directory contains code for any utility functions or helper classes used by the application.


* **tests/**: This directory contains unit tests for the different parts of the application. Each test module corresponds to a specific aspect of the application, such as test_transactions.py or test_budgets.py.


* **main.py**: The entry point of the application, which initializes the API and starts the web server.


* **.env**: This file contains environment variables, such as the database URL or secret keys.


* **requirements.txt**: This file contains the dependencies for the project, which can be installed using pip.


* **README.md**: This file provides an overview of the project and instructions for how to run and test it.  

## DataBase models  
```shell
users:
  - id: serial (primary key)
  - email: varchar(255) (unique)
  - password_hash: varchar(255)
  - name: varchar(255)
  
categories:
  - id: serial (primary key)
  - name: varchar(255)
  
transactions:
  - id: serial (primary key)
  - type: varchar(10) (either "income" or "expense")
  - description: varchar(255)
  - amount: decimal
  - date: date
  - category_id: int (foreign key referencing categories.id)
  - user_email: varchar(255) (foreign key referencing users.email)
  
budgets:
  - id: serial (primary key)
  - category_id: int (foreign key referencing categories.id)
  - user_email: varchar(255) (foreign key referencing users.email)
  - amount: decimal
  - start_date: date
  - end_date: date
```