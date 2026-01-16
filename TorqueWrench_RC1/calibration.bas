' calibration.bas - Two-Point Calibration

SUB RunCalibration(reference_torque)
    PRINT "Starting Two-Point Calibration..."

    ' --- STEP 1: ZERO OFFSET ---
    PRINT "Measure Zero Offset..."
    WAIT 1000
    
    Sum = 0
    FOR i = 1 TO 32
        Sum = Sum + ADCRead(0)
        WAIT 5
    NEXT i
    ADC_Offset_new = Sum / 32
    PRINT "Offset: "; ADC_Offset_new

    ' --- STEP 2: LOAD REFERENCE ---
    PRINT "Apply Reference Torque: "; reference_torque
    ADC_Offset = ADC_Offset_new ' Apply temp offset for reading
    
    SetPWM(20) ' Slow pull
    WAIT 1000 ' Wait for torque to stabilize
    
    I_meas = ReadCurrent()
    StopMotor()
    
    IF I_meas > 0 THEN
        Kt_motor_new = reference_torque / (I_meas * gear_ratio * efficiency)
        
        ' Save to EEPROM with CRC
        WriteCriticalConstants(Kt_motor_new, ADC_Offset_new)
        
        Kt_motor = Kt_motor_new
        PRINT "Success. New Kt: "; Kt_motor
    ELSE
        PRINT "Error: No Current Detected."
    END IF
END SUB
