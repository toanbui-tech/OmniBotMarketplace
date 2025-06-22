// Database configuration for Medusa
const config = {
  database: {
    host: 'omnibot.cloud',
    port: 5433,
    database: 'scripts_marketplace',
    username: 'marketplace_postgres',
    password: 'Vu]Q"<F^^G2@\\sE3'
  }
};

// Build DATABASE_URL
const { host, port, database, username, password } = config.database;
const DATABASE_URL = `postgres://${username}:${password}@${host}:${port}/${database}`;

console.log('Database Configuration:');
console.log('Host:', host);
console.log('Port:', port);
console.log('Database:', database);
console.log('Username:', username);
console.log('DATABASE_URL:', DATABASE_URL);

// Export for use in scripts
if (typeof module !== 'undefined' && module.exports) {
  module.exports = { DATABASE_URL, config };
} 