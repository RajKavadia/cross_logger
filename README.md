# 📝 Encrypted Logging Package (Flutter / Dart)

A lightweight, modular logging system for Flutter and Dart applications that supports:

- ✅ **Local storage** via IndexedDB (using `idb_shim`)
- 🔒 **Encryption** using AES (via `encrypt`)
- 🌐 **WebSocket real-time logging**
- ☁️ **HTTP blob upload** support
- 📦 Built for web-first apps with expandability for mobile support

---

## 📦 Installation
Add the following dependencies to your `pubspec.yaml`:

## 🧱 Architecture Overview
- This package is structured with clean architecture principles:
- EncryptionService: Handles AES encryption/decryption.
- LogEntry: Data model with encrypted log message.
- Log: Domain entity.
- LocalDatabase: IndexedDB wrapper for storing logs.
- HTTPHandler: Uploads logs as files to a remote server.
- WebSocketClient: Sends logs over WebSocket.
- LogUseCase: Orchestrates log flow (store, encrypt, send).
- LoggerFacade: One-stop interface to log messages.

## 🚀 Usage
1. Initialize the logger
   final logger = await LoggerFacade.initialize(
   'ws://your-websocket-url',
   true, // encryption enabled
   );
2. await logger.log("Hello, this is a test log!");

## ✅ Features
Feature | Status
Local logging | ✅ Done
AES Encryption | ✅ Done
WebSocket send | ✅ Done
HTTP blob upload | ✅ Done
Test coverage | ✅ Done

## ✨ Contributions
PRs welcome! Feel free to fork, improve, or extend the system with new logging channels (e.g. Firebase, Sentry, etc.)