#!/usr/bin/env node

// Set environment variables
process.env.NODE_ENV = 'production';
process.env.PORT = process.env.PORT || 9000;

// Completely disable admin frontend
process.env.MEDUSA_ADMIN_DISABLE = 'true';
process.env.MEDUSA_ADMIN_SERVE = 'false';
process.env.MEDUSA_ADMIN_AUTO_REBUILD = 'false';

console.log('Starting Medusa API server only...');
console.log('Port:', process.env.PORT);
console.log('Database URL:', process.env.DATABASE_URL ? 'Set' : 'Not set');
console.log('Admin disabled:', process.env.MEDUSA_ADMIN_DISABLE);

// Import and start Medusa directly without admin
const { MedusaApp } = require('@medusajs/medusa');
const { loadConfig } = require('@medusajs/framework/utils');

async function startServer() {
  try {
    console.log('Loading Medusa configuration...');
    const config = await loadConfig();
    
    console.log('Starting Medusa application...');
    const app = await MedusaApp(config);
    
    console.log('Medusa server started successfully!');
    console.log(`Server running on port ${process.env.PORT}`);
    
    // Keep the process alive
    process.on('SIGINT', () => {
      console.log('Shutting down...');
      process.exit(0);
    });
    
  } catch (error) {
    console.error('Failed to start Medusa:', error);
    process.exit(1);
  }
}

startServer(); 