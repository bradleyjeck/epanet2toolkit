
actionTypes <- c("EN_UNCONDITIONAL", "EN_CONDITIONAL")


linkTypes <- c(
 "EN_CVPIPE",#      = 0,  //!< Pipe with check valve
 "EN_PIPE",#      = 1,  //!< Pipe
 "EN_PUMP",#      = 2,  //!< Pump
 "EN_PRV",#      = 3,  //!< Pressure reducing valve
 "EN_PSV",#      = 4,  //!< Pressure sustaining valve
 "EN_PBV",#      = 5,  //!< Pressure breaker valve
 "EN_FCV",#      = 6,  //!< Flow control valve
 "EN_TCV",#      = 7,  //!< Throttle control valve
 "EN_GPV")#      = 8   //!< General purpose valve

EN_PumpType <-c(
  "EN_CONST_HP",#    = 0,   //!< Constant horsepower
  "EN_POWER_FUNC",#  = 1,   //!< Power function
  "EN_CUSTOM",#      = 2,   //!< User-defined custom curve
  "EN_NOCURVE")#     = 3    //!< No curve

EN_CurveType <- c(
 "EN_VOLUME_CURVE",#  = 0,   //!< Tank volume v. depth curve
 "EN_PUMP_CURVE",#    = 1,   //!< Pump head v. flow curve
 "EN_EFFIC_CURVE",#   = 2,   //!< Pump efficiency v. flow curve
 "EN_HLOSS_CURVE",#   = 3,   //!< Valve head loss v. flow curve
 "EN_GENERIC_CURVE")# = 4    //!< Generic curve

EN_MAXID <- as.integer(31)

EN_ControlType <- c(
 "EN_LOWLEVEL",#    = 0,   //!< Act when pressure or tank level drops below a setpoint
 "EN_HILEVEL",#     = 1,   //!< Act when pressure or tank level rises above a setpoint
 "EN_TIMER",#       = 2,   //!< Act at a prescribed elapsed amount of time
 "EN_TIMEOFDAY"#   = 3    //!< Act at a particular time of day
)