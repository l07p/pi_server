#!/bin/bash

# Start PostgreSQL
service postgresql start

# Start Tomcat
/opt/tomcat/bin/startup.sh

# Start Jenkins
service jenkins start

# Keep the container running
tail -f /dev/null
