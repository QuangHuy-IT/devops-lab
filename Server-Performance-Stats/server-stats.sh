#get total CPU usage

#get_cpu_usage()
get_cpu_usage() {
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)" | \
    sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
    awk '{print "CPU Load: " (100 - $1) "%"}'
}

#get total memory usage
get_memory_usage() {
    echo "Memory Usage:"
    free -m | awk '/Mem:/ {printf "Used: %dMB / Total: %dMB (%.2f%%)\n", $3, $2, $3/$2 * 100}'
}

#get total disk usage
get_disk_usage() {
    echo "Disk Usage:"
    df -h --total | awk '/total/ {print "Used: "$3" / Total: "$2" ("$5")"}'
}

#get Top 5 processes by CPU usage
get_top_processes() {
    echo "Top 5 processes by CPU usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n6
}

#get Top 5 processes by memory usage
get_top_memory_processes() {
    echo "Top 5 processes by Memory usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n6
}

#Main function to call all stats
main() {
    echo "Server Performance Statistics"
    echo "=============================="

    get_cpu_usage
    echo ""
    get_memory_usage
    echo ""
    get_disk_usage
    echo ""
    get_top_processes
    echo ""
    get_top_memory_processes
}
main