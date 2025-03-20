//+------------------------------------------------------------------+
//|                                                      Defines.mqh |
//|                                   Copyright 2025, Milad Alizade. |
//|                   https://www.mql5.com/en/users/MiladAlizade2559 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, Milad Alizade."
#property link      "https://www.mql5.com/en/users/MiladAlizade2559"
//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include <Base/SBase.mqh>
//+------------------------------------------------------------------+
//| Structs                                                          |
//+------------------------------------------------------------------+
struct SChartTick : public SBase
   {
    double           Bid;
    double           Ask;
    int              Spread;
    datetime         Time;
    int              Variables(const ENUM_VARIABLES_FLAGS flag,string &array[],const bool compact_objs = false);
   };
//+------------------------------------------------------------------+
//| Setting variables                                                |
//+------------------------------------------------------------------+
int SChartTick::Variables(const ENUM_VARIABLES_FLAGS flag,string &array[],const bool compact_objs = false)
   {
    SBase::Variables(flag,array,compact_objs);
    _double(Bid);
    _double(Ask);
    _int(Spread);
    _datetime(Time);
    return(SBase::Variables(array));
   }
//+------------------------------------------------------------------+
