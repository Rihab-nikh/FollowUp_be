@echo off
REM Docker build and run script for FollowUp Backend (Windows)

echo Building FollowUp Backend Docker image...
docker build -t followup-backend:latest .

if %ERRORLEVEL% neq 0 (
    echo Build failed!
    pause
    exit /b 1
)

echo Running FollowUp Backend container...
docker run -d ^
  --name followup-backend ^
  -p 8000:8000 ^
  -e FLASK_ENV=production ^
  -e SECRET_KEY=your-super-secret-key-here-change-in-production ^
  -e JWT_SECRET_KEY=your-jwt-secret-key-change-in-production ^
  -e MONGO_URI=mongodb://localhost:27017/followup_db ^
  -e FRONTEND_ORIGINS=http://localhost:3000 ^
  --restart unless-stopped ^
  followup-backend:latest

if %ERRORLEVEL% neq 0 (
    echo Failed to start container!
    pause
    exit /b 1
)

echo Container started successfully!
echo Access your app at: http://localhost:8000
echo Health check: http://localhost:8000/api/health
echo.
echo To view logs: docker logs followup-backend
echo To stop: docker stop followup-backend
echo To remove: docker rm followup-backend
pause