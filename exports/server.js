const https = require("https");
const fs = require("fs");
const path = require("path");
const { URL } = require("url");

const server = https.createServer(
  {
    key: fs.readFileSync("key.pem"),
    cert: fs.readFileSync("cert.pem"),
  },
  (req, res) => {
    res.setHeader("Cross-Origin-Opener-Policy", "same-origin");
    res.setHeader("Cross-Origin-Embedder-Policy", "require-corp");

    let filePath;
    try {
      const parsedUrl = new URL(req.url, `http://${req.headers.host}`);
      filePath = path.join(
        process.cwd(),
        parsedUrl.pathname === "/" ? "/index.html" : parsedUrl.pathname,
      );
    } catch (err) {
      res.writeHead(400);
      res.end("Bad Request");
      return;
    }

    fs.readFile(filePath, (err, data) => {
      if (err) {
        res.writeHead(404);
        res.end("Not Found");
        return;
      }
      const ext = path.extname(filePath);
      const contentType =
        ext === ".html"
          ? "text/html"
          : ext === ".js"
            ? "application/javascript"
            : ext === ".wasm"
              ? "application/wasm"
              : "application/octet-stream";
      res.setHeader("Content-Type", contentType);
      res.end(data);
    });
  },
);

server.listen(8081, () => {
  console.log("Serving at https://localhost:8081");
});
