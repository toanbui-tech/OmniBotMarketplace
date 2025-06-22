#!/usr/bin/env node

// Set environment variables
process.env.NODE_ENV = 'production';
process.env.PORT = process.env.PORT || 9000;

// Enable admin frontend for deployment
process.env.MEDUSA_ADMIN_DISABLE = 'false';
process.env.MEDUSA_ADMIN_SERVE = 'true';

console.log('Starting Medusa backend...');
console.log('Port:', process.env.PORT);
console.log('Database URL:', process.env.DATABASE_URL ? 'Set' : 'Not set');
console.log('Admin disabled:', process.env.MEDUSA_ADMIN_DISABLE);

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