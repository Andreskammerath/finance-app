from datetime import date

from pydantic import BaseModel, validator


class TransactionCreate(BaseModel):
    amount: float
    description: str
    date: date
    category_id: int
    type: str

    @property
    def curated_amount(self):
        if self.type == "expense":
            return -1 * abs(self.amount)
        else:
            return self.amount


class TransactionUpdate(BaseModel):
    amount: float = None
    description: str = None
    date: date = None
    category_id: int = None
