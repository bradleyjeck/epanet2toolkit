
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