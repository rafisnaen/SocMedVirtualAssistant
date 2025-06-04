from flask import Flask, request, jsonify
import google.generativeai as genai

genai.configure(api_key="AIzaSyA5pctBTbjcqNG8gxCtpKr7Hpp-_VCDAgM")
models = genai.list_models()
print("Available models:", models)

model = genai.GenerativeModel("gemini-1.5-flash")

app = Flask(__name__)

@app.route("/api/chat", methods=["POST"])
def chat():
    data = request.json
    prompt = data.get("prompt", "")
    try:
        response = model.generate_content(prompt)
        return jsonify({"response": response.text})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

# import google.generativeai as genai
# import os

# # 1. Configuration
# GOOGLE_API_KEY = "AIzaSyA5pctBTbjcqNG8gxCtpKr7Hpp-_VCDAgM"
# genai.configure(api_key=os.getenv(GOOGLE_API_KEY))
# generation_config = {"temperature":1.0, "top_p": 0.95, "top_k": 40, "max_output_tokens": 8192}

# #2. Initialise Model
# model = genai.GenerativeModel("gemini-1.5-flash", generation_config=generation_config)

# #3. Generate content
# response = model.generate_content(["Create a Meal plan for today"])

# print(response.text)

# import google.generativeai as genai

# genai.configure(api_key="AIzaSyA5pctBTbjcqNG8gxCtpKr7Hpp-_VCDAgM")

# models_generator = genai.list_models()  # ini generator yang menghasilkan object Model

# print("Model yang support generateContent:")
# for model in models_generator:
#     print(f"Model ID: {model.name}")
#     # cek apakah ada atribut 'supported_methods' atau serupa
#     # kalau ga ada, coba lihat attributes lain atau print semua atribut dengan vars()
    
#     # misal:
#     if hasattr(model, 'supported_methods'):
#         if "generateContent" in model.supported_methods:
#             print("  -> Support generateContent")
#         else:
#             print("  -> Tidak support generateContent")
#     else:
#         # Jika atribut tidak ada, coba print isi model untuk inspeksi
#         print(f"  -> supported_methods attribute not found")
#         print(vars(model))  # print atribut objek model

# from google.api_core.client_options import ClientOptions
# from google.cloud import generativelanguage_v1beta3 as genlang  # Contoh nama library generatif

# # Setting client untuk API v1beta (ubah sesuai API yang kamu pakai)
# client_options = ClientOptions(api_endpoint="generativelanguage.googleapis.com:443")
# client = genlang.LanguageServiceClient(client_options=client_options)

# # Panggil list_models
# response = client.list_models()

# print("Daftar model yang tersedia:")
# for model in response.models:
#     print(f"Model name: {model.name}")
#     print(f"Supported methods: {model.supported_methods}")
#     print()

