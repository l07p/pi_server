#!/bin/bash

# Start PostgreSQL
service postgresql start

# Start Tomcat
service tomcat9 start

# Start Jenkins
service jenkins start

# Keep the container running
tail -f /dev/null
