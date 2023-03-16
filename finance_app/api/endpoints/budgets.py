import calendar
import sys
from datetime import date, datetime
from typing import List

from fastapi import Depends, APIRouter, HTTPException, Query

from finance_app.api.security.auth import get_current_active_user
from finance_app.schemas.budgets import BudgetCreate
from finance_app.utils.connection import get_db


router = APIRouter()


@router.get("/")
async def get_budgets(
    start_date: date = Query(date.today().replace(day=1)),
    end_date: date = Query(date.today().replace(day=calendar.monthrange(date.today().year, date.today().month)[1])),
    user=Depends(get_current_active_user),
    db=Depends(get_db)
):
    query = """SELECT * FROM budgets WHERE user_email = $1 AND start_date = $2 AND end_date = $3 order by amount desc"""
    params = [user.email, start_date, end_date]

    result = await db.fetch(query, *params)
    return result


@router.post("/")
async def create_budget(
    budget: BudgetCreate,
    user=Depends(get_current_active_user),
    db=Depends(get_db)
):
    period_start = datetime.strptime(budget.start_date, '%Y-%m-%d')
    period_end = datetime.strptime(budget.end_date, '%Y-%m-%d')
    query = """INSERT INTO budgets (category_id, user_email, amount, start_date, end_date) VALUES ($1, $2, $3, $4, $5) RETURNING *"""
    params = [budget.category_id, user.email, budget.amount, period_start, period_end]
    result = await db.fetchrow(query, *params)
    if not result:
        raise HTTPException(status_code=400, detail="Failed to create budget record")
    return result
