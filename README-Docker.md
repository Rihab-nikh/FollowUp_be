# FollowUp Backend - Docker Setup

This Flask application is containerized using Docker for easy deployment and development.

## Prerequisites

- Docker installed on your system
- Docker Compose (optional, for running with MongoDB and Redis)

## Quick Start

### Option 1: Using Docker Run Script

**Windows:**
```bash
docker-run.bat
```

**Linux/macOS:**
```bash
chmod +x docker-run.sh
./docker-run.sh
```

### Option 2: Manual Docker Commands

**Build the image:**
```bash
docker build -t followup-backend:latest .
```

**Run the container:**
```bash
docker run -d \
  --name followup-backend \
  -p 8000:8000 \
  -e FLASK_ENV=production \
  -e SECRET_KEY=your-super-secret-key-here-change-in-production \
  -e JWT_SECRET_KEY=your-jwt-secret-key-change-in-production \
  -e MONGO_URI=mongodb://localhost:27017/followup_db \
  followup-backend:latest
```

### Option 3: Using Docker Compose (Recommended)

This will start the Flask app, MongoDB, and Redis services:

```bash
docker-compose up -d
```

To stop all services:
```bash
docker-compose down
```

To view logs:
```bash
docker-compose logs -f
```

## Configuration

### Environment Variables

Set these environment variables when running the container:

**Required:**
- `SECRET_KEY` - Flask secret key
- `JWT_SECRET_KEY` - JWT token secret
- `MONGO_URI` - MongoDB connection string

**Optional:**
- `FLASK_ENV` - Environment (development/production)
- `FRONTEND_ORIGINS` - Allowed CORS origins
- `GEMINI_API_KEY` - AI integration key
- `LOG_LEVEL` - Logging level (INFO, DEBUG, etc.)

### Example with custom environment variables:

```bash
docker run -d \
  --name followup-backend \
  -p 8000:8000 \
  -e FLASK_ENV=production \
  -e SECRET_KEY=my-super-secret-key \
  -e JWT_SECRET_KEY=my-jwt-secret \
  -e MONGO_URI=mongodb://myuser:mypass@host:port/database \
  -e FRONTEND_ORIGINS=https://mydomain.com,http://localhost:3000 \
  followup-backend:latest
```

## Accessing the Application

- **API Base URL:** http://localhost:8000
- **Health Check:** http://localhost:8000/api/health
- **API Documentation:** Available through the API endpoints

## Docker Commands Reference

**View running containers:**
```bash
docker ps
```

**View application logs:**
```bash
docker logs followup-backend
```

**Stop the container:**
```bash
docker stop followup-backend
```

**Remove the container:**
```bash
docker rm followup-backend
```

**Remove the image:**
```bash
docker rmi followup-backend:latest
```

**Access container shell:**
```bash
docker exec -it followup-backend /bin/bash
```

## Production Deployment

For production deployment, consider:

1. **Use secrets management** for sensitive environment variables
2. **Set up persistent storage** for MongoDB data
3. **Configure reverse proxy** (Nginx) for SSL termination
4. **Set up monitoring** and log aggregation
5. **Use Docker Swarm or Kubernetes** for orchestration

## Troubleshooting

**Container won't start:**
- Check Docker logs: `docker logs followup-backend`
- Verify environment variables are set correctly
- Ensure ports aren't already in use

**Database connection issues:**
- Verify MongoDB is accessible from the container
- Check MONGO_URI format and credentials
- If using Docker Compose, ensure services are connected

**Health check failing:**
- Verify the Flask app is running on port 8000
- Check if `/api/health` endpoint is accessible
- Review application logs for errors