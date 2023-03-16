from fastapi import APIRouter, Depends, HTTPException

from finance_app.api.security.auth import get_current_active_user
from finance_app.schemas.categories import CategoryCreate
from finance_app.utils.connection import get_db
from finance_app.utils.normalization import normalize_string
from asyncpg import Record
router = APIRouter()


@router.get("/")
async def get_categories(user=Depends(get_current_active_user), db=Depends(get_db)):
    query = "SELECT * FROM categories ORDER BY id;"
    result = await db.fetch(query)
    return result


@router.post("/")
async def create_category(category: CategoryCreate, user=Depends(get_current_active_user), db=Depends(get_db)):
    query = "INSERT INTO categories (name) VALUES ($1) RETURNING id, name;"
    normalized_name = normalize_string(category.name)
    result = await db.fetch(query, normalized_name)
    return result
