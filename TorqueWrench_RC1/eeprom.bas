' eeprom.bas - Secure Storage & Float Wrappers

' --- Float Wrappers ---
SUB WriteFloatEEPROM(addr, val)
    int_val = INT(val * EEPROM_FLOAT_SCALE)
    EEPROMWrite(addr, int_val)
END SUB

FUNCTION ReadFloatEEPROM(addr)
    int_val = EEPROMRead(addr)
    RETURN int_val / EEPROM_FLOAT_SCALE
END FUNCTION

' --- CRC & Integrity ---
FUNCTION CalculateCRC(val1, val2)
    RETURN (val1 * 3 + val2 * 5) + 1
END FUNCTION

SUB WriteCriticalConstants(kt_val, offset_val)
    kt_scaled = INT(kt_val * EEPROM_FLOAT_SCALE)
    EEPROMWrite(ADDR_KT_MOTOR, kt_scaled)
    EEPROMWrite(ADDR_ADC_OFFSET, offset_val) ' Offset is usually int
    EEPROMWrite(ADDR_FIRMWARE_CRC, CalculateCRC(kt_scaled, offset_val))
END SUB

SUB LoadEEPROMData()
    Kt_motor_stored = ReadTorqueEEPROM(ADDR_KT_MOTOR)
    ADC_Offset_stored = ReadTorqueEEPROM(ADDR_ADC_OFFSET)
    CRC_stored = ReadTorqueEEPROM(ADDR_FIRMWARE_CRC)

    IF CRC_stored = CalculateCRC(Kt_motor_stored, ADC_Offset_stored) THEN
        Kt_motor = Kt_motor_stored / EEPROM_FLOAT_SCALE
        ADC_Offset = ADC_Offset_stored
        PRINT "EEPROM: Verified."
    ELSE
        PRINT "EEPROM: CORRUPT/EMPTY. Using Defaults."
        ' Default Kt_motor set in config.bas
        ADC_Offset = 0
    END IF
END SUB

SUB WriteTorqueEEPROM(address, value)
    EEPROMWrite(address, value)
END SUB

FUNCTION ReadTorqueEEPROM(address)
    RETURN EEPROMRead(address)
END FUNCTION
