Write-Host "🚀 Starting Medusa Deployment..." -ForegroundColor Green

# Load database configuration
$dbConfig = node -e "console.log(JSON.stringify(require('./database-config.js')))" | ConvertFrom-Json
$DATABASE_URL = $dbConfig.DATABASE_URL

Write-Host "📊 Database Configuration:" -ForegroundColor Cyan
Write-Host "Host: omnibot.cloud" -ForegroundColor White
Write-Host "Port: 5433" -ForegroundColor White
Write-Host "Database: scripts_marketplace" -ForegroundColor White
Write-Host "User: marketplace_postgres" -ForegroundColor White

# Set environment variables
$env:DATABASE_URL = $DATABASE_URL
$env:NODE_ENV = "production"

# Change to admin directory
Set-Location admin

# Install dependencies if needed
if (-not (Test-Path "node_modules")) {
    Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
    npm install
}

# Run database migration
Write-Host "🔍 Running database migration..." -ForegroundColor Yellow
try {
    npx medusa db:migrate
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Database migration completed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Database migration failed!" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Error running migration: $_" -ForegroundColor Red
    exit 1
}

# Build the application
Write-Host "🔨 Building application..." -ForegroundColor Yellow
try {
    npm run build
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Application built successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Build failed!" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Error building application: $_" -ForegroundColor Red
    exit 1
}

Write-Host "🎉 Deployment completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Next steps:" -ForegroundColor Cyan
Write-Host "1. Start the application: npm run dev"
Write-Host "2. Admin panel will be available at: http://localhost:7000"
Write-Host "3. API will be available at: http://localhost:9000"
Write-Host ""
Write-Host "🔧 To start manually:" -ForegroundColor Cyan
Write-Host "   npm run dev" 