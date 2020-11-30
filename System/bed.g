;File     : bed.g
;Effect   : Performs bed-tramming routine
;Use-case : To tram the bed as level as possible 

M561 ; clear any existing bed transform
M98 P"/sys/probe/bed-4point.g"
M98 P"/sys/move/park.g"

;M561                         ; clear any existing bed transform
;G1 Z5						 ; _RRF3_ remove S2 
;M98 P"/sys/bed-3point.g"
;G1 X0 Y0 F5000               ; move the head to the corner (optional)

