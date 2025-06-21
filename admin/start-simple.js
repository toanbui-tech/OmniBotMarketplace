#!/usr/bin/env node

// Set environment variables
process.env.NODE_ENV = 'production';
process.env.PORT = process.env.PORT || 9000;

// Disable admin frontend completely
process.env.MEDUSA_ADMIN_DISABLE = 'true';
process.env.MEDUSA_ADMIN_SERVE = 'false';

console.log('Starting Medusa backend...');
console.log('Port:', process.env.PORT);
console.log('Database URL:', process.env.DATABASE_URL ? 'Set' : 'Not set');
console.log('Admin disabled:', process.env.MEDUSA_ADMIN_DISABLE);

// Remove admin build directory to avoid index.html error
const fs = require('fs');
const path = require('path');

const adminBuildPath = path.join(__dirname, '.medusa', 'client');
if (fs.existsSync(adminBuildPath)) {
  console.log('Removing admin build directory...');
  fs.rmSync(adminBuildPath, { recursive: true, force: true });
}

// Start Medusa
const { spawn } = require('child_process');

const medusaProcess = spawn('npx', ['medusa', 'start'], {
  stdio: 'inherit',
  env: process.env
});

medusaProcess.on('error', (error) => {
  console.error('Failed to start Medusa:', error);
  process.exit(1);
});

medusaProcess.on('exit', (code) => {
  console.log('Medusa process exited with code:', code);
  process.exit(code);
}); 