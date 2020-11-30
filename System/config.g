; #######################################################################
; ###### RRF3 Configuration file for RailcoreII ZL Series Printers ######
; #######################################################################
; Ulbrich Nov 28, 2020
; Duet G-code:               https://duet3d.dozuki.com/Wiki/Gcode
; RRF3 G-code meta commands: https://duet3d.dozuki.com/Wiki/GCode_Meta_Commands
; RRF3 Object model:         https://duet3d.dozuki.com/Wiki/Object_Model_of_RepRapFirmware
; RRF3 Pin Names:            https://duet3d.dozuki.com/Wiki/RepRapFirmware_3_overview#Section_Pin_names_for_Duet_2_WiFi_Ethernet

; #### Debugging
M111 S0                     ; Debug off
M929 P"eventlog.txt" S1     ; Start logging to file eventlog.txt
M550 P"Duet"                ; Machine name and Netbios name (can be anything you like)
M552 S1                     ; Enable networking
M552 P0.0.0.0               ; Use DHCP

; #### General preferences
M555 P0                     ; Set output to look like RepRap_Firmware
;M575 P1 B57600 S1          ; Comms parameters for PanelDue (not installed)
G21                         ; Work in millimetres
G90                         ; Send absolute coordinates...
M83                         ; ...but relative extruder moves

; #### Networking and Communications
M552 S1                     ; Enable WiFi
M586 P1 S1                  ; Enable FTP
;M551 P"myrap"              ; Machine password (used for FTP), leave disabled for anonymous login on a local network.
M586 P2 S1                  ; Enable Telnet

; #### Axis and motor configuration
M669 K1                     ; CoreXY mode
M92 X200 Y200               ; Set 200 steps/mm for XY (0.9 deg/step . 16 tooth pulley and GT2 belt)

; #### Drives
M584 X0.2 Y0.1 Z0.5:4:3 E0.0  ; Map Z to drivers 3, 4, 5. Define unused drivers 3,4,8 and 9 as extruders
M350 X16 Y16 Z16 E16 I1     ; Set 16x microstepping for axes & extruder, with interpolation.
M569 P0.0 S0                  ; Drive 0 goes forwards (change to S0 to reverse it)| Extruder S1 for Bondtech, S0 for Titan 
M569 P0.1 S1                  ; Drive 1 goes backwards(change to S1 to reverse it)| Y Stepper
M569 P0.2 S0                  ; Drive 2 goes forwards                             | X stepper
M569 P0.3 S0                  ; Drive 3 goes forwards                             | Right Z
M569 P0.4 S0                  ; Drive 4 goes forwards                             | Rear Left Z
M569 P0.5 S0                  ; Drive 5 goes backwards                            | Front Left Z
M569 P0.6 S1                  ; Drive 6 goes backwards                            | 
M569 P0.7 S1                  ; Drive 7 goes backwards                            | 

; #### Leadscrew locations
;Front left,(-10,22.5) Rear Left (-10.,227.5) , Right (333,160) S10 is the max correction - measure your own offsets, to the bolt for the yoke of each leadscrew
M671 X-15:-15:280  Y15:240:110 S7.5  


; #### Endstop Configuration - microswitches
M574 X1 S1 P"io0.in"                      ; _RRF3_ set X endstop to xstop port (switch/active high)
M574 Y1 S1 P"io3.in"                      ; _RRF3_ set Y endstop to ystop port (switch/active high)
M574 Z1 S2								  ; configure Z-probe endstop for low end on Z


; #### Z probe ############
; BLTouch -
; ########################
M950 S0 C"io7.out"                           ; create servo pin 0 for BLTouch
M558 P9 C"^io7.in" H10 F300 T9000            ; _RRF3_ BLTouch connected to Z probe IN pin
G31 P500 X-6.2 Y31 Z2.96 P25                    ; Customize your offsets appropriately - do a paper test, and put the probed value in the Z value here

; ##### Mesh
;M557 X50:200 Y50:200 S150 S150             ; Set Default Mesh (conservative)
M557 X35:280 Y35:280 P9                     ; Set Mesh for probe

; #### Current, speeds and Z/E step settings
; ##########################################
; Conservative speeds for commissioning
M906 X1150 Y1150 Z900 E560 I60   ; Motor currents (mA) - WARNING: Conservative - May trigger stallguard (and prematurely during homing) if sensorless.
M201 X1000 Y1000 Z30 E500        ; Accelerations (mm/s^2) - WARNING: Conservative
M203 X3000 Y3000 Z50 E1800       ; Maximum speeds (mm/min) - WARNING: Conservative
M566 X300 Y300 Z30 E500          ; Maximum jerk speeds mm/minute - WARNING: Conservative
M203 X18000 Y18000 Z300 E3600     ; Maximum speeds (mm/min)

; Fully commissioned speeds.
;M906 X1400 Y1400 Z1000 E560 I25   ; Set motor currents (mA) and idle at 25%
;M201 X2500 Y2500 Z100 E1500       ; Accelerations (mm/s^2)
;M203 X18000 Y18000 Z900 E3600     ; Maximum speeds (mm/min)
;M566 X500 Y500 Z100 E1500         ; Maximum jerk speeds mm/minute

M92 Z1600                         ; Leadscrew motor axis steps/mm for Z - TR8*2 / 1.8 deg stepper or TR8*4 / 0.9 deg stepper
M92 E402                          ; Extruder steps/mm - 1.8 deg/step Steps/mm (Standard BMG pancake stepper 17HS10-0704S)
M204 T3000                        ; Set travel acceleration
M558 T18000 F150                  ; Set Z probe Travel speed


; ####  Set axis minima:maxima switch positions
; Adjust to suit your machine and to make X=0 and Y=0 the edges of the bed
;M208 X0:250 Y0:250 Z-0.2:230      ; Conservative 300ZL/T settings (or 250ZL) ; These values are conservative to start with, adjust during commissioning.
M208 X-20:280 Y-10:265 Z0:600        ; 300ZL

; #### Tool definitions
; #####################
; #### Tool E0 / Heater 1 

;########################################
; FANS
:########################################

M950 F0 C"out7" Q500                                                              ; Set Fan 0 on "Duet2 Fan 0" for Part Cooling fan
M106 P0 C"Layer Fan" S0 H-1                                                       ; set fan 0 value. Thermostatic control is turned off

M950 F1 C"out8" Q500                                                              ; Set Fan 1 on "Duex2 Fan 1" for Hotend Fan. Use the FAN1 connector for a thermostatically-controlled 
M106 P1 S255 H1 T3                                                                ; hot end fan, because on the Duet 2 it defaults to being on at power up, to provide maximum safety 
                                                                                  ; if you restart your Duet when the hot end is hot.

M308 S1 P"temp0" Y"thermistor" A"e1_heat" T100000 B4725 C7.06e-8 H0 L0            ; E0 thermistor,
M950 H1 C"out2" T1                                                                ; create nozzle heater output on out2 and map it to sensor 1
M563 P0 S"Hemera" D0 H1 F0                                                        ; Define tool 0 uses extruder 0, heater 1 ,Fan 1
M143 H1 S285                                                                      ; Maximum Extruder 0 temperature (E3D requires 285C to change nozzle)
M106 P0 S0 H-1                                                                    ; (Part cooling fan) Set fan 0 value, Thermostatic control is OFF
M106 P1 S1 H1 T45 C"Hotend"                                                       ; Set fan 1. Thermostatic control is ON for Heater 1 (Hotend fan)


G10 P0 X0 Y0 Z0 S-273.1 R-273.1                                                   ; Set tool 0 axis offsets and operating and standby temperatures
M143 H1 S290                                                                      ; Maximum Extruder 0 temperature (E3D requires 285C to change nozzle)
M570 H1 P5 T15                                                                    ; Configure heater fault detection
                                                                                  ; Hnnn Heater number
                                                                                  ; Pnnn Time in seconds for which a temperature anomaly must persist
                                                                                  ; on this heater before raising a heater fault.
                                                                                  ; Tnnn Permitted temperature excursion from the setpoint for this heater (default 15C);
M308 S2 P"mcu-temp" Y"mcu-temp" A"Duet Board" ; Configure MCU sensor

; #### Filament options
; #####################
; M200 D1.75                                  ; Set filament diameter for future volumetric extrusion.
; Volumetric extrusion is an option you can set in some slicers whereby all extrusion amounts are specified in mm3 (cubic millimetres) of filament instead of mm of filament. 
; This makes the gcode independent of the filament diameter, potentially allowing the same gcode to run on different printers.

; #### Filament runout for E0
; M591 D0 P1 C3 S1                          ; Enable Sunhokey filament sensor runout (disabled)
; Configure filament sensing
; D0 - Extruder 0
; P - Sensor type - 1=simple sensor (high signal when filament present)
; C - Which input the filament sensor is connected to. On Duet electronics: 3=E0 endstop input
; S - 1 = enable filament monitoring when printing from SD card.




; #### Bed - Heater 0

M308 S0 P"temp2" Y"thermistor" A"bed_heat" T100000 B3950 R4700 H0 L0         ;_RRF3_ Bed thermistor, connected to x6 on Duet2
M950 H0 C"out0" T0                                                           ;_RRF3_ define Bed heater is on bedheat **
M140 H0                                      ; map heated bed to heater 0
M143 H0 S120                                 ; set temperature limit for heater 0 to 120C

;M308 S8 P"temp2" Y"thermistor" A"keenovo" T100000 B3950 R4700  H0 L0        ; Silicone heater thermistor on x7
M570 S360                       ; Print will be terminated if a heater fault is not reset within 360 minutes.


M308 S10 Y"mcu-temp" A"mcu-temp" ; Set MCU on Sensor 10
;M106 P7 T35:55 H10 C"Elec.Cab.1" ; Electronics cooling fan that starts to turn on when the MCU temperature (virtual heater 100) reaches 45C
;M106 P8 T35:55 H10 C"Elec.Cab.2" ; and reaches full speed when the MCU temperature reaches 55C or if any TMC2660 drivers
                                 ; (N.B. If a fan is configured to trigger on a virtual heater whose sensor represents TMC2660 driver over-temperature
                                 ; flags, then when the fan turns on it will delay the reporting of an over-temperature warning for the corresponding drivers
                                 ; for a few seconds, to give the fan time to cool the driver down.)

; #### Compensation
M579 X1.0027 Y1.0027 Z1.0011              ; Scale Cartesian axes
;M556 S80 X0.8 Y0.3 Z0.72                 ; Axis compensation (measured with Orthangonal Axis Compensation piece)
M572 D0 S0.05                             ; Default Pressure Advance compensation

; #### Default heater model (Overridden by config-override.g, but here in case config-override.g fails)
;M307 H0 A270.7 C90.4 D6.7 B0 S1.0          ; 700W Bed Heater settings.
M307 H0 A186.9 C972.5 D5.3 S1.00 V24.2 B0   ; 300W Bed Heater settings.
M307 H1 A508.1 C249.0 D3.8 S1.00 V24.2 B0   ; E3D Gold hotend settings.

M501                              ; Load saved parameters from non-volatile memory

; #### FINISH STARTUP.
;#### Custom area

; Ensure all temperatures are off and cleared.
M140 S0 R0               ; clear temperatures from DWC
M140 S-273.1 R0 	     ; Standby and initial Temp for bed as "off" (-273 = "off")
G10 P0 R0 S0                                 ; set initial tool 0 active and standby temperatures to 0C


G91                               ; Send relative coordinates.
G1 Z0.001 F99999 H2               ; Engage motors to prevent bed from moving after power on.
G90                               ; Send absolute coordinates.



