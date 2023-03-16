from datetime import datetime
from pydantic import BaseModel, validator


class BudgetCreate(BaseModel):
    category_id: int
    amount: float
    start_date: str
    end_date: str

    @validator('start_date')
    def validate_start_date(cls, v):
        try:
            datetime.strptime(v, '%Y-%m-%d')
            return v
        except ValueError:
            raise ValueError('Incorrect start_date format, should be YYYY-MM-DD')

    @validator('end_date')
    def validate_end_date(cls, v, values, **kwargs):
        try:
            datetime.strptime(v, '%Y-%m-%d')
            if 'start_date' in values and datetime.strptime(values['start_date'], '%Y-%m-%d') > datetime.strptime(v,
                                                                                                                  '%Y-%m-%d'):
                raise ValueError('end_date must be greater than or equal to start_date')
            return v
        except ValueError:
            raise ValueError('Incorrect end_date format, should be YYYY-MM-DD')


class BudgetStatus(BaseModel):
    total_budget: float
    spent: float
    remaining: float
