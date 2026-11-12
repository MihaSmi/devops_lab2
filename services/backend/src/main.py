from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI()

class Note(BaseModel):
    title: str
    content: str

# Храним заметки просто в памяти, чтобы гарантированно работало для скриншота
notes_db = []

@app.get("/")
async def root():
    return {"message": "Backend is running!"}

@app.get("/api/notes")
async def get_notes():
    return notes_db

@app.post("/api/notes")
async def create_note(note: Note):
    notes_db.append(note)
    return {"message": "Заметка успешно добавлена", "note": note}
