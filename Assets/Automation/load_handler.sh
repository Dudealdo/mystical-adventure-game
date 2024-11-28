#!/bin/bash

# Enhanced Load Handler Script

# Log file configuration
LOAD_HANDLER_LOG="$HOME/LoadHandler.log"
LOG_TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Default thresholds
CPU_THRESHOLD=${1:-70.0}  # CPU usage threshold
MEM_THRESHOLD=${2:-75.0}  # Memory usage threshold

# Function to write log entries
log() {
    echo "$LOG_TIMESTAMP - [INFO] $1" | tee -a "$LOAD_HANDLER_LOG"
}

# Function to check dependencies
check_dependencies() {
    log "Checking required dependencies..."
    for cmd in top free bc pgrep renice find; do
        if ! command -v $cmd &>/dev/null; then
            log "Error: Required command '$cmd' not found."
            exit 1
        fi
    done
    log "All dependencies are available."
}

# Function to check system load
check_system_load() {
    log "Checking system load..."

    # Get average CPU usage of the last minute
    CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    # Get memory usage
    MEM_LOAD=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

    log "Current CPU Load: ${CPU_LOAD}%"
    log "Current Memory Load: ${MEM_LOAD}%"

    # If CPU or memory is beyond thresholds, trigger load management
    if (( $(echo "$CPU_LOAD > $CPU_THRESHOLD" | bc -l) )) || (( $(echo "$MEM_LOAD > $MEM_THRESHOLD" | bc -l) )); then
        log "High system load detected. Triggering load handling procedures..."
        manage_high_load
    else
        log "System load is within acceptable limits."
    fi
}

# Function to manage high system load
manage_high_load() {
    log "Managing high system load..."

    # Get top 5 CPU consuming processes
    TOP_PROCESSES=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6 | tail -n 5)
    log "Top 5 CPU consuming processes:\n$TOP_PROCESSES"

    # Loop through each process and adjust its priority
    while read -r line; do
        PID=$(echo $line | awk '{print $1}')
        CMD=$(echo $line | awk '{print $3}')
        if [[ "$CMD" != "" ]]; then
            log "Adjusting priority of process PID: $PID ($CMD)"
            renice +10 -p $PID >> "$LOAD_HANDLER_LOG" 2>&1
            if [ $? -eq 0 ]; then
                log "Priority adjusted for PID: $PID"
            else
                log "Failed to adjust priority for PID: $PID"
            fi
        fi
    done <<< "$TOP_PROCESSES"

    # Adjust priority of specific processes
    log "Adjusting priority of Firefox and Isolate processes if running..."
    for process in Isolate firefox; do
        if pgrep $process &>/dev/null; then
            renice +10 -p $(pgrep $process) >> "$LOAD_HANDLER_LOG" 2>&1
            log "Priority adjusted for $process."
        fi
    done

    log "Waiting for cooldown before re-checking system load..."
    sleep 30  # Cooldown period
}

# Function to clean up log files
cleanup_logs() {
    log "Cleaning up old log files in the home directory..."
    LOGS_ARCHIVE_DIR="$HOME/logs_archive"
    mkdir -p "$LOGS_ARCHIVE_DIR"

    # Move log files older than 7 days to archive
    find "$HOME" -maxdepth 1 -type f -name "*.log" -mtime +7 -exec mv {} "$LOGS_ARCHIVE_DIR/" \;
    log "Old log files moved to $LOGS_ARCHIVE_DIR"
}

# Main execution
log "Starting Enhanced Load Handler operations..."
check_dependencies
mkdir -p "$HOME/logs"  # Ensure logs directory exists
check_system_load
cleanup_logs
log "Load Handler operations completed."

