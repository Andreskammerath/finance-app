from fastapi import FastAPI


def setup_routes(app: FastAPI):
    from .endpoints import transactions, budgets, categories
    from .security import auth

    app.include_router(auth.router, prefix="/auth", tags=["auth"])
    app.include_router(categories.router, prefix="/categories", tags=["categories"])
    app.include_router(transactions.router, prefix="/transactions", tags=["transactions"])
    app.include_router(budgets.router, prefix="/budgets", tags=["budgets"])
