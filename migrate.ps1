Write-Host "📊 Running Medusa Database Migration..." -ForegroundColor Green

# Set environment variable with proper escaping
$env:DATABASE_URL = "postgres://marketplace_postgres:Vu]Q`"<F^^G2@\sE3@omnibot.cloud:5433/scripts_marketplace"
$env:NODE_ENV = "production"

Write-Host "Database URL set: $env:DATABASE_URL" -ForegroundColor Cyan

# Change to admin directory
Set-Location admin

# Run migration
Write-Host "🔍 Running database migration..." -ForegroundColor Yellow
npx medusa db:migrate

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Database migration completed successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Database migration failed!" -ForegroundColor Red
    exit 1
}

Write-Host "🎉 Migration completed! You can now start your application." -ForegroundColor Green 