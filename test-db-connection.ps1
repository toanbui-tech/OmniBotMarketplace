Write-Host "🔍 Testing Database Connection..." -ForegroundColor Green

# Set environment variables
$env:DATABASE_URL = "postgres://marketplace_postgres:Vu]Q"<F^^G2@\sE3@omnibot.cloud:5433/scripts_marketplace"
$env:NODE_ENV = "production"

Write-Host "Database URL: $env:DATABASE_URL" -ForegroundColor Cyan

# Change to admin directory
cd admin

# Test connection using psql if available
Write-Host "🔍 Testing with psql..." -ForegroundColor Yellow
try {
    $psqlTest = psql -h omnibot.cloud -p 5433 -U marketplace_postgres -d scripts_marketplace -c "SELECT version();" 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Direct psql connection successful!" -ForegroundColor Green
        Write-Host $psqlTest
    } else {
        Write-Host "❌ Direct psql connection failed!" -ForegroundColor Red
        Write-Host $psqlTest
    }
} catch {
    Write-Host "⚠️  psql not available, skipping direct test" -ForegroundColor Yellow
}

# Test with Medusa
Write-Host "🔍 Testing with Medusa..." -ForegroundColor Yellow
try {
    $medusaTest = npx medusa db:check 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Medusa database connection successful!" -ForegroundColor Green
        Write-Host $medusaTest
    } else {
        Write-Host "❌ Medusa database connection failed!" -ForegroundColor Red
        Write-Host $medusaTest
    }
} catch {
    Write-Host "❌ Error testing Medusa connection: $_" -ForegroundColor Red
}

Write-Host "🎉 Database connection test completed!" -ForegroundColor Green 