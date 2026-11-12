<template>
  <div id="app">
    <h1>My Notes</h1>
    <div class="add-note">
      <input v-model="newTitle" placeholder="Заголовок заметки" />
      <input v-model="newContent" placeholder="Текст заметки" />
      <button @click="addNote">Добавить</button>
    </div>
    <ul>
      <li v-for="(note, index) in notes" :key="index">
        <strong>{{ note.title }}</strong>: {{ note.content }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      notes: [],
      newTitle: '',
      newContent: ''
    }
  },
  methods: {
    async addNote() {
      if (!this.newTitle || !this.newContent) return
      try {
        const response = await fetch('http://localhost:5000/api/notes', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ title: this.newTitle, content: this.newContent })
        })
        const data = await response.json()
        this.notes.push(data.note)
        this.newTitle = ''
        this.newContent = ''
      } catch (e) {
        alert('Ошибка при добавлении заметки: ' + e.message)
      }
    }
  }
}
</script>

<style>
#app { font-family: Arial; max-width: 600px; margin: 40px auto; }
.add-note { display: flex; gap: 10px; margin-bottom: 20px; }
input { padding: 8px; flex: 1; }
button { padding: 8px 16px; cursor: pointer; }
li { padding: 8px; border-bottom: 1px solid #eee; }
</style>
