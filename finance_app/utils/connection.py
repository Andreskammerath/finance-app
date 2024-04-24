import asyncpg
import asyncio


async def get_db():
    conn = await asyncpg.connect(
        host="db",
        port=5432,
        user="financial_app_user",
        password="fpassword",
        database="financial_app_db"
    )
    return conn
