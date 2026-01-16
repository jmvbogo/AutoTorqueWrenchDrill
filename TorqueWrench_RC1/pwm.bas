' pwm.bas - Motor Actuation

SUB SetPWM(duty)
    ' Handle Direction
    IF duty >= 0 THEN
        DigitalWrite(DIR_PIN, 1)
    ELSE
        DigitalWrite(DIR_PIN, 0)
        duty = -duty
    END IF

    ' Safety Clamp
    IF duty > PWM_max THEN duty = PWM_max
    
    PWMWrite(PWM_PIN, duty)
END SUB

SUB StopMotor()
    SetPWM(0)
END SUB
