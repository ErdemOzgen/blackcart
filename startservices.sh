#!/bin/sh

# Run your other command here
/work_dir/blackdagger server &

# Run gotty in the foreground
gotty -p 8090 -w --credential blackcart:blackcart /bin/bash
