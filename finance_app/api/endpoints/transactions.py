import calendar
from datetime import date, datetime
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException
from fastapi.responses import JSONResponse

from finance_app.api.security.auth import get_current_active_user
from finance_app.schemas.transactions import TransactionCreate, TransactionUpdate
from finance_app.utils.connection import get_db

router = APIRouter()


@router.get("/")
async def get_transactions(period: Optional[str] = None, user=Depends(get_current_active_user), db=Depends(get_db)):
    if not period:
        # use the current month as the default period
        current_date = date.today()
        start_of_month = date(current_date.year, current_date.month, 1)
        end_of_month = date(current_date.year, current_date.month, calendar.monthrange(current_date.year, current_date.month)[1])
    else:
        try:
            # attempt to parse the provided period
            period_date = datetime.strptime(period, "%m-%Y").date()
            start_of_month = date(period_date.year, period_date.month, 1)
            end_of_month = date(period_date.year, period_date.month, calendar.monthrange(period_date.year, period_date.month)[1])
        except (ValueError, IndexError):
            # return an error response if the provided period is invalid
            return JSONResponse(status_code=400, content={"message": "Invalid period format. Use 'mm-YYYY'."})
    query = "SELECT * FROM transactions WHERE user_email=$1 AND date >= $2 AND date <= $3 ORDER BY date DESC"
    result = await db.fetch(query, user.email, start_of_month, end_of_month)
    return result


@router.post("/")
async def create_transaction(transaction: TransactionCreate, user=Depends(get_current_active_user), db=Depends(get_db)):
    query = "INSERT INTO transactions (type, description, amount, date, category_id, user_email)" \
            " VALUES ($1, $2, $3, $4, $5, $6) RETURNING *"
    result = await db.fetchrow(query, transaction.type, transaction.description, transaction.curated_amount, transaction.date,
                               transaction.category_id, user.email)
    transaction_id = result["id"]
    return {"id": str(transaction_id)}


"""@router.get("/{transaction_id}")
async def get_transaction(transaction_id: str, db=Depends(get_db)):
    transaction = await db.transactions.find_one({"_id": transaction_id})
    if not transaction:
        raise HTTPException(status_code=404, detail="Transaction not found")
    return transaction


@router.put("/{transaction_id}")
async def update_transaction(transaction_id: str, transaction: TransactionUpdate, db=Depends(get_db)):
    result = await db.transactions.update_one({"_id": transaction_id}, {"$set": transaction.dict()})
    if result.modified_count == 0:
        raise HTTPException(status_code=404, detail="Transaction not found")
    return {"message": "Transaction updated"}


@router.delete("/{transaction_id}")
async def delete_transaction(transaction_id: str, db=Depends(get_db)):
    result = await db.transactions.delete_one({"_id": transaction_id})
    if result.deleted_count == 0:
        raise HTTPException(status_code=404, detail="Transaction not found")
    return {"message": "Transaction deleted"}"""
