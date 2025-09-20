import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "prompt", "chatBox", "imageGallery", "generateImage", "generateVoice",
    "characterName", "characterDescription", "characterAppearance"
  ]

  connect() {
    this.promptTarget.addEventListener("keydown", (event) => {
      if (event.key === "Enter" && !event.shiftKey) {
        event.preventDefault()
        this.submit(event)
      }
    })
  }

  submit(event) {
    event.preventDefault()

    const userMessage = this.promptTarget.value
    const wantsImage = this.generateImageTarget.checked
    const wantsVoice = this.generateVoiceTarget.checked

    const name = this.characterNameTarget.value
    const desc = this.characterDescriptionTarget.value
    const look = this.characterAppearanceTarget.value

    const prompt = `
You are a fictional Telugu character named ${name}.
Your personality: ${desc}.
Your appearance is always: ${look}.
Speak in emotional English like you're acting in a movie.

User says: ${userMessage}
    `.trim()

    fetch("/chat", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        prompt: prompt,
        generate_image: wantsImage,
        generate_voice: wantsVoice,
        character_name: name,
        character_description: desc,
        character_appearance: look
      })      
    })
    .then(response => response.json())
    .then(data => {
      const messageEl = document.createElement("div")
      messageEl.style = "padding: 10px; background: #fff; border-radius: 6px; margin-bottom: 10px;"

      messageEl.innerHTML = `
        <strong>🧠 AI Reply:</strong><br>
        <p style="margin: 5px 0;">${data.reply}</p>
      `

      if (data.voice_url) {
        const audio = document.createElement("audio")
        audio.controls = true
        audio.src = `${data.voice_url}&t=${Date.now()}`
        audio.style = "margin-top: 10px; width: 100%;"
        messageEl.appendChild(audio)
      }

      this.chatBoxTarget.prepend(messageEl)

      if (data.image_url) {
        const imgWrapper = document.createElement("div")
        imgWrapper.style = `
          padding: 8px;
          background: #fff;
          border: 1px solid #ccc;
          border-radius: 8px;
          box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        `
      
        const img = document.createElement("img")
        img.src = data.image_url
        img.alt = "Generated image"
        img.style = `
          width: 100%;
          height: auto;
          max-height: 400px;
          object-fit: cover;
          border-radius: 6px;
        `
      
        img.onerror = () => {
          img.alt = "⚠️ Could not load image"
        }
      
        imgWrapper.appendChild(img)
        this.imageGalleryTarget.prepend(imgWrapper)
      }                  

      this.promptTarget.value = ""
    })
    .catch(error => {
      const errEl = document.createElement("div")
      errEl.innerHTML = `<div style="color: red;">⚠️ Error: ${error}</div>`
      this.chatBoxTarget.prepend(errEl)
    })
  }
}
