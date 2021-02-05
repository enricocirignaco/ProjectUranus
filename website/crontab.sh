# update and upgrade system on every 1st of the month
0 0 1 * * root (apt -y update && apt -y  upgrade) > /dev/null
