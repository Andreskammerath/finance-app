{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhQGEuY29tIiwiZXhwIjoxNzEzNTU1MDQ0fQ.EgBdS5ng0rTf1dtvBQXw7qfOd42jIwMnBLH-l8PPV_I",
  "token_type": "bearer"
}

{
  "username": "andy",
  "email": "a@a.com",
  "full_name": "andy k",
  "password": "password.123"
}

Example calls to API
# Create an User
curl 'http://localhost:8000/auth/sign-up' \
  -H 'Accept-Language: en-US,en;q=0.9,es;q=0.8' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Origin: http://localhost:8000' \
  -H 'Referer: http://localhost:8000/docs' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36' \
  -H 'accept: application/json' \
  -H 'sec-ch-ua: "Chromium";v="122", "Not(A:Brand";v="24", "Google Chrome";v="122"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  --data-raw $'{\n  "username": "andy",\n  "email": "a@a.com",\n  "full_name": "andy",\n  "password": "andy123"\n}'


curl 'http://localhost:8000/auth/login' \
  -H 'Accept-Language: en-US,en;q=0.9,es;q=0.8' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Origin: http://localhost:8000' \
  -H 'Referer: http://localhost:8000/docs' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36' \
  -H 'accept: application/json' \
  -H 'sec-ch-ua: "Chromium";v="122", "Not(A:Brand";v="24", "Google Chrome";v="122"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  --data-raw $'{\n  "email": "a@a.com",\n  "password": "andy123"\n}'


curl -X 'POST' \
  'http://localhost:8000/categories/' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhQGEuY29tIiwiZXhwIjoxNzE0MjUyMDA4fQ._EnHS-WA0TwIbEvs4Zjk0kv4DwXLsok3dyKEyw8yjKY' \
  -d '{
  "name": "Salario"
}'


# Create Budgets
curl -X 'POST' \
  'http://localhost:8000/budgets/' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhQGEuY29tIiwiZXhwIjoxNzE0MjUyMDA4fQ._EnHS-WA0TwIbEvs4Zjk0kv4DwXLsok3dyKEyw8yjKY' \
  -d '{
  "category_id": 1,
  "amount": 1000000,
  "start_date": "2024-04-01",
  "end_date": "2024-04-30"
}'


# Create a Transaction
curl -X 'POST' \
  'http://localhost:8000/transactions/' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhQGEuY29tIiwiZXhwIjoxNzE0MjUyMDA4fQ._EnHS-WA0TwIbEvs4Zjk0kv4DwXLsok3dyKEyw8yjKY' \
  -d '{
  "amount": 900000,
  "description": "Salario Andres",
  "date": "2024-04-19",
  "category_id": 1,
  "type": "income"
}'
# Get Transactions
curl 'http://localhost:8000/transactions/?period=04-2024' \
  -H 'Accept-Language: en-US,en;q=0.9,es;q=0.8' \
  -H 'Connection: keep-alive' \
  -H 'Referer: http://localhost:8000/docs' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhQGEuY29tIiwiZXhwIjoxNzE0NjA0MTg5fQ.w1wGnAb43O4tkOKa1nWI0xCZPm_qFyS6vSWWGqInh2M' \
  -H 'sec-ch-ua: "Chromium";v="122", "Not(A:Brand";v="24", "Google Chrome";v="122"'

curl 'http://localhost:8000/transactions/?period=04-2024' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.9,es;q=0.8' \
  -H 'Authorization: Bearer undefined' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Origin: http://localhost:3000' \
  -H 'Referer: http://localhost:3000/' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua: "Chromium";v="122", "Not(A:Brand";v="24", "Google Chrome";v="122"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"'