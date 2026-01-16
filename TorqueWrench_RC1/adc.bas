' adc.bas - Filtered Analog Input

DIM ADC_History(ADC_FILTER_SIZE)
ADC_Index = 0
ADC_Offset = 0 ' Loaded from EEPROM

FUNCTION ReadCurrent()
    ' 1. Read Raw
    raw_val = ADCRead(0)
    
    ' 2. Update Moving Average Buffer
    ADC_History(ADC_Index) = raw_val
    ADC_Index = (ADC_Index + 1) MOD ADC_FILTER_SIZE

    ' 3. Calculate Average
    ADC_Sum = 0
    FOR i = 0 TO ADC_FILTER_SIZE - 1
        ADC_Sum = ADC_Sum + ADC_History(i)
    NEXT i
    ADC_Avg = ADC_Sum / ADC_FILTER_SIZE

    ' 4. Apply Zero Offset
    ADC_Corrected = ADC_Avg - ADC_Offset
    
    ' 5. Convert to Amps
    V_shunt_val = ADC_Corrected * Vref / 1023
    I_motor = V_shunt_val / R_shunt
    
    RETURN I_motor
END FUNCTION
