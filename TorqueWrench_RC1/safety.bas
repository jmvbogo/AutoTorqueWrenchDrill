' safety.bas - Active Safety

SUB CheckSafetyConditions()
    I_curr = ReadCurrent()
    
    ' Overcurrent check
    IF I_curr > I_max THEN
        EmergencyStop("OVERCURRENT")
    END IF
    
    ' Overtemperature check
    IF ReadMotorTemp() > temp_max THEN
        EmergencyStop("OVERTEMP")
    END IF
    
    ' Stall detection would go here (requires tracking angle change vs current)
END SUB

FUNCTION ReadMotorTemp()
    ' Placeholder: Connect to NTC Thermistor ADC pin
    ' val = ADCRead(TEMP_PIN)
    ' Return ConvertToCelsius(val)
    RETURN 45.0 ' Safe dummy value for compilation
END FUNCTION

SUB EmergencyStop(reason$)
    StopMotor()
    PRINT "EMERGENCY STOP: "; reason$
    ' Lock system until hardware reset
    DO
        SetPWM(0)
        WatchdogReset()
    LOOP
END SUB
