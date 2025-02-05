const express = require("express");
const bodyParser = require("body-parser");
const JavaScriptObfuscator = require("javascript-obfuscator");
const Terser = require("terser");
const CleanCSS = require("clean-css");

const app = express();
app.use(bodyParser.json());

// Minifikacija i obfuskovanje JavaScript-a
app.post("/process-js", async (req, res) => {
    try {
        if (!req.body.code) return res.status(400).json({ error: "Code is required" });

        const obfuscated = JavaScriptObfuscator.obfuscate(req.body.code, {
            compact: true,
            controlFlowFlattening: true,
            deadCodeInjection: true,
            debugProtection: true,
            identifierNamesGenerator: "hexadecimal",
            stringArray: true,
            stringArrayEncoding: ["base64"],
        }).getObfuscatedCode();

        const minified = await Terser.minify(obfuscated);
        if (minified.error) throw minified.error;

        res.json({ minified: minified.code });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Minifikacija CSS-a
app.post("/process-css", (req, res) => {
    try {
        if (!req.body.code) return res.status(400).json({ error: "Code is required" });

        const minifiedCSS = new CleanCSS({ level: 2 }).minify(req.body.code);
        if (minifiedCSS.errors.length > 0) throw minifiedCSS.errors;

        res.json({ minified: minifiedCSS.styles });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Pokretanje servera
const PORT = 3000;
app.listen(PORT, () => console.log(`🚀 API running on http://localhost:${PORT}`));
