' control.bas - PID Logic

' PID Constants
Kp = 2.0
Ki = 0.05
Kd = 0.1
error_integral = 0
T_prev = 0

SUB RunControlLoop()
    ' 1. Get Filtered Data
    I_motor = ReadCurrent()
    angle_now = GetAngle()

    ' 2. Calculate Torque
    T_out = I_motor * Kt_motor * gear_ratio * efficiency
    
    ' 3. Get Target (From User Settings)
    T_target = GetUserTorque(1) ' Assuming single step for now

    ' 4. PID Math with Anti-Windup
    T_error = T_target - T_out
    
    ' Anti-windup: Only integrate if not saturated
    IF (PWM_duty < PWM_max) AND (PWM_duty > -PWM_max) THEN
        error_integral = error_integral + T_error
    END IF
    
    error_derivative = T_error - T_prev
    PWM_duty = Kp*T_error + Ki*error_integral + Kd*error_derivative
    T_prev = T_error

    ' 5. Feed Data Logger (Producer)
    LogData_Fast(T_out, angle_now)

    ' 6. Actuate
    SetPWM(PWM_duty)
END SUB
