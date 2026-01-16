' comms.bas - Serial Interface

SUB ProcessIncomingCommands()
    IF SerialAvailable() THEN
        cmd$ = ReadSerialString()
        
        IF cmd$ = "GET_LOGS" THEN
            DumpLogData()
        ELSE IF cmd$ = "CALIBRATE" THEN
            RunCalibration(50)
        ELSE IF Left$(cmd$, 10) = "SET_TORQUE" THEN
            ' Parsing logic here
            PRINT "Torque Updated"
        ELSE IF cmd$ = "UPDATE_FW" THEN
            EnterBootloader()
        END IF
    END IF
END SUB
