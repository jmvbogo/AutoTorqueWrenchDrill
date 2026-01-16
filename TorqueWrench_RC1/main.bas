' main.bas - System Entry Point

' --- Init Hardware ---
InitADC()
InitPWM()
InitEncoder()
InitEEPROM()
InitUART() ' Serial Port for Comms

' --- Load Production Data ---
LoadEEPROMData() 
' Checks CRC and loads calibrated Kt and Offset

' --- Main Execution ---
PRINT "System Ready. Mode: INDUSTRIAL RC1"
StopMotor()

DO
    RunKernel()
    
    ' Hardware Watchdog Reset (Crucial for production)
    WatchdogReset()
LOOP
