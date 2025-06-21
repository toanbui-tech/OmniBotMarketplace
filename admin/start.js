#!/usr/bin/env node

// Set port for Render
process.env.PORT = process.env.PORT || 9000;

// Start Medusa
require('@medusajs/medusa/dist/commands/start').default(); 