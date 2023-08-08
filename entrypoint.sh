#!/bin/bash

# Start the SSH server if needed
# /usr/sbin/sshd -D &
export PATH="/root/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/bin:/usr/bin/core_perl:/usr/games/bin:/root/go/bin:/opt/anaconda3/bin:$PATH"

# If arguments were passed to the container, execute them
if [ $# -gt 0 ]; then
    # Execute the provided command or script
    exec "$@"
else
    # Start an interactive shell if no arguments were provided
    exec /bin/bash
fi
