' logging.bas - Circular Buffer Logger

CONST BUFFER_SIZE = 50
DIM Log_Torque(BUFFER_SIZE)
DIM Log_Angle(BUFFER_SIZE)
Head = 0
Tail = 0
Count = 0

SUB LogData_Fast(t_val, a_val)
    IF Count < BUFFER_SIZE THEN
        Log_Torque(Head) = t_val
        Log_Angle(Head) = a_val
        Head = (Head + 1) MOD BUFFER_SIZE
        Count = Count + 1
    END IF
END SUB

SUB ProcessLogBuffer()
    IF Count > 0 THEN
        ' Write to EEPROM (Slow Operation)
        ' Note: Writing floats needs the wrapper from eeprom.bas
        WriteFloatEEPROM(ADDR_LOG_START + Tail, Log_Torque(Tail))
        
        Tail = (Tail + 1) MOD BUFFER_SIZE
        Count = Count - 1
    END IF
END SUB

SUB DumpLogData()
    ' Output logs to Serial Port for external tool
    PRINT "--- LOG START ---"
    FOR i = 0 TO 50
        val = ReadFloatEEPROM(ADDR_LOG_START + i)
        PRINT i; ","; val
    NEXT i
    PRINT "--- LOG END ---"
END SUB
