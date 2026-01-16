' kernel.bas - Deterministic Scheduler

sys_tick = 0
last_pid_time = 0
last_safety_time = 0
last_log_time = 0
last_comms_time = 0

' Intervals (ms)
PID_INTERVAL = 1       ' 1kHz Control Loop (Critical)
SAFETY_INTERVAL = 10   ' 100Hz Safety Check (High)
LOG_INTERVAL = 20      ' 50Hz Logging (Medium)
COMMS_INTERVAL = 50    ' 20Hz Comms (Low)

' --- Timer Interrupt (Hardware Timer @ 1kHz) ---
SUB Timer_ISR()
    sys_tick = sys_tick + 1
END SUB

SUB RunKernel()
    ' 1. Critical Control (1kHz)
    IF (sys_tick - last_pid_time) >= PID_INTERVAL THEN
        RunControlLoop()
        last_pid_time = sys_tick
    END IF

    ' 2. Safety (100Hz)
    IF (sys_tick - last_safety_time) >= SAFETY_INTERVAL THEN
        CheckSafetyConditions()
        last_safety_time = sys_tick
    END IF

    ' 3. Data Logging (50Hz)
    IF (sys_tick - last_log_time) >= LOG_INTERVAL THEN
        ProcessLogBuffer()
        last_log_time = sys_tick
    END IF

    ' 4. Communication (20Hz)
    IF (sys_tick - last_comms_time) >= COMMS_INTERVAL THEN
        ProcessIncomingCommands()
        last_comms_time = sys_tick
    END IF
END SUB
