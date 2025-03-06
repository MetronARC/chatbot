document.getElementById('send-btn').addEventListener('click', sendMessage);
document.getElementById('user-input').addEventListener('keypress', function(event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
});

function sendMessage() {
    const inputField = document.getElementById('user-input');
    const userText = inputField.value.trim();
    if (!userText) return;

    addMessage("You: " + userText, "user");
    inputField.value = '';

    fetch('http://localhost:11434/api/generate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            model: "deepseek-r1:1.5b",
            prompt: userText,
            stream: false
        })
    })
    .then(response => response.json())
    .then(data => {
        addMessage("Bot: " + (data.response || "No response"), "bot");
    })
    .catch(error => {
        console.error("Error:", error);
        addMessage("Error: Failed to connect to Ollama", "bot");
    });
}

function addMessage(text, sender) {
    const chatBox = document.getElementById('chat-box');
    const messageDiv = document.createElement('div');
    messageDiv.classList.add(sender);
    messageDiv.textContent = text;
    chatBox.appendChild(messageDiv);
    chatBox.scrollTop = chatBox.scrollHeight;
}
