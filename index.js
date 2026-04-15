#!/usr/bin/env node
/**
 * MRC Data — stdio MCP Server (thin client)
 * Proxies MCP requests to https://api.meacheal.ai/mcp
 * Data stays on the remote server.
 *
 * Usage: MRC_API_KEY=mrc_xxx npx mrc-data
 */
const https = require("https");

const API = "https://api.meacheal.ai/mcp";
const KEY = process.env.MRC_API_KEY || "";
let sid = null;
let pending = 0;
let stdinClosed = false;

if (!KEY) process.stderr.write("[mrc-data] Warning: Set MRC_API_KEY. Get key: https://api.meacheal.ai/apply\n");
process.stderr.write("[mrc-data] stdio proxy → api.meacheal.ai/mcp\n");

function forward(msg) {
  pending++;
  const body = JSON.stringify(msg);
  const h = { "Content-Type": "application/json", "Accept": "application/json, text/event-stream", "Content-Length": Buffer.byteLength(body) };
  if (KEY) h["Authorization"] = "Bearer " + KEY;
  if (sid) h["Mcp-Session-Id"] = sid;

  const req = https.request({ hostname: "api.meacheal.ai", port: 443, path: "/mcp", method: "POST", headers: h }, (res) => {
    if (res.headers["mcp-session-id"]) sid = res.headers["mcp-session-id"];
    let data = "";
    res.on("data", (c) => { data += c; });
    res.on("end", () => {
      for (const line of data.split("\n")) {
        if (line.startsWith("data: ")) {
          const j = line.slice(6).trim();
          if (j) process.stdout.write(j + "\n");
        } else if (line.trim().startsWith("{")) {
          process.stdout.write(line.trim() + "\n");
        }
      }
      pending--;
      if (stdinClosed && pending === 0) process.exit(0);
    });
  });
  req.on("error", (e) => {
    if (msg.id != null) {
      process.stdout.write(JSON.stringify({ jsonrpc: "2.0", id: msg.id, error: { code: -32603, message: e.message } }) + "\n");
    }
    pending--;
    if (stdinClosed && pending === 0) process.exit(0);
  });
  req.write(body);
  req.end();
}

let buf = "";
process.stdin.on("data", (chunk) => {
  buf += chunk;
  let i;
  while ((i = buf.indexOf("\n")) >= 0) {
    const line = buf.slice(0, i).trim();
    buf = buf.slice(i + 1);
    if (!line) continue;
    try { forward(JSON.parse(line)); } catch {}
  }
});
process.stdin.on("end", () => {
  stdinClosed = true;
  if (pending === 0) process.exit(0);
});
