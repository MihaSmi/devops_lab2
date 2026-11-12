# Простая заглушка для демонстрации работы API без сложной настройки БД
pool = None
async def get_db():
    return "Database connected"
