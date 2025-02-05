# 🚀 JavaScript & CSS Minification & Obfuscation API

This project provides a **Docker-based API** for **minifying and obfuscating JavaScript and CSS**. It allows you to send raw code and receive an optimized version using a simple **REST API**.

## 🛠 Features
✅ **Minifies JavaScript**  
✅ **Obfuscates JavaScript**  
✅ **Minifies CSS**  
✅ **Runs in Docker with `docker-compose`**  
✅ **Easy-to-use API**

---

## 📦 Setup & Installation

### **1️⃣ Clone the Repository**
```bash
git clone https://github.com/miloskec/mini-obfuscator-container.git
cd minify-obfuscate-api
```

### **2️⃣ Build and Start the Docker Container**
```bash
docker-compose up -d --build
```
🔹 `-d` → Runs in **detached mode**  
🔹 `--build` → Ensures **image rebuilds**  

✅ The API will now be available at:  
**`http://localhost:3000`**

### **3️⃣ Check Running Containers**
```bash
docker ps
```
Look for the container named **`minify-obfuscator-api`**.

---

## 🚀 API Endpoints

### **🔹 Minify & Obfuscate JavaScript**
📌 **Send JavaScript code for minification & obfuscation**
```bash
curl -X POST "http://localhost:3000/process-js" \
     -H "Content-Type: application/json" \
     -d '{"code": "function test(){ console.log(\"Hello World\"); }"}'
```
🔹 **Returns:** Minified & obfuscated JavaScript.

---

### **🔹 Minify CSS**
📌 **Send CSS code for minification**
```bash
curl -X POST "http://localhost:3000/process-css" \
     -H "Content-Type: application/json" \
     -d '{"code": "body { margin: 0; padding: 0; }"}'
```
🔹 **Returns:** Minified CSS.

---

## 🚀 Example usage from the project 

### **1️⃣ copy process-files.sh and file-paths.txt to your project 
### **2️⃣ add filepaths to the file-paths.txt
### **3️⃣ chmod +x process-files.sh
### **4️⃣ ./process-files.sh

#### process-files.sh
Bash script that will:
- ✅ Read a list of JavaScript (.js) and CSS (.css) file paths from a given file.
- ✅ Send each file’s content in a POST request to the Minification & Obfuscation API using curl.
- ✅ Save the processed (minified/obfuscated) output to new .min.js or .min.css files.
---

## 🔄 Managing the API

### **Stop & Remove the Container**
```bash
docker-compose down
```

### **Restart the Service**
```bash
docker-compose restart
```

### **View Container Logs**
```bash
docker logs -f minify-obfuscator-api
```

---

## 🎯 Example Responses

### ✅ **Minified & Obfuscated JavaScript Response**
```json
{
  "minified": "var _0x1234=['log','Hello World'];(function(_0x5678){console[_0x5678[0]](_0x5678[1])})(_0x1234);"
}
```

### ✅ **Minified CSS Response**
```json
{
  "minified": "body{margin:0;padding:0}"
}
```

---

## 📜 Notes
- **JS Obfuscation** uses `javascript-obfuscator` for extra security.
- **JS Minification** uses `terser` to compress the script.
- **CSS Minification** uses `clean-css` for optimized styles.

---

## 🤝 Contributing
Pull requests are welcome! If you have ideas for improvements, feel free to submit an issue or PR.

---

## ⚖️ License
This project is **MIT Licensed**. Feel free to modify and use it in your own projects.

🚀 **Happy coding!** 🎉
