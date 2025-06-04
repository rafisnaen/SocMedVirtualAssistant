from flask import Flask, request, jsonify
import google.generativeai as genai
import sounddevice as sd
import queue, json, os, vosk, pyttsx3, threading, time

# === Konfigurasi API Gemini ===
genai.configure(api_key="AIzaSyD5ZTBbura3DVwXJwPvHnGp8kvZZfnkm9E")
model_gemini = genai.GenerativeModel("gemini-pro")

# === Vosk ===
model_path = os.path.join("models", "vosk-model-en-us-0.22")
model_vosk = vosk.Model(model_path)
audio_q = queue.Queue()
listening_event = threading.Event()
listening_event.set()

# === TTS ===
def speak(text):
    listening_event.clear()
    engine = pyttsx3.init()
    engine.setProperty('rate', 130)
    engine.say(text)
    engine.runAndWait()
    time.sleep(0.3)
    listening_event.set()

# === Gemini AI ===
def ask_gemini(prompt):
    try:
        response = model_gemini.generate_content(prompt)
        return response.text
    except Exception as e:
        return f"[Error] {e}"

# === Audio Callback ===
def audio_callback(indata, frames, time_info, status):
    if listening_event.is_set():
        audio_q.put(bytes(indata))

# === Flask App ===
app = Flask(__name__)

@app.route("/api/chat", methods=["POST"])
def chat():
    data = request.json
    prompt = data.get("prompt", "")
    response = ask_gemini(prompt)
    threading.Thread(target=speak, args=(response,)).start()
    return jsonify({"response": response})

@app.route("/api/speech-to-text", methods=["GET"])
def speech_to_text():
    with sd.RawInputStream(samplerate=16000, blocksize=8000, dtype='int16',
                           channels=1, callback=audio_callback):
        recognizer = vosk.KaldiRecognizer(model_vosk, 16000)
        recognizer.SetWords(True)
        start_time = time.time()
        while time.time() - start_time < 5:  # record selama 5 detik
            data = audio_q.get()
            if recognizer.AcceptWaveform(data):
                result = json.loads(recognizer.Result())
                text = result.get("text", "")
                if text:
                    return jsonify({"transcript": text})
        return jsonify({"transcript": ""})

if __name__ == "__main__":
    app.run(port=5000)
