//+------------------------------------------------------------------+
//|                                                    ChartData.mqh |
//|                                   Copyright 2025, Milad Alizade. |
//|                   https://www.mql5.com/en/users/MiladAlizade2559 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, Milad Alizade."
#property link      "https://www.mql5.com/en/users/MiladAlizade2559"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include <Base/CBase.mqh>
#include <../Defines.mqh>
//+------------------------------------------------------------------+
//| Class CChartData                                                 |
//| Usage: Control working with chart data                           |
//+------------------------------------------------------------------+
class CChartData : public CBase
   {
private:
    string           m_symbol_name;    // symbol name
    SChartTick       m_ticks[];        // object array for saving 2 ticks end in chart
    int              m_ticks_total;    // size m_ticks array
public:
                     CChartData(void);
                     CChartData(const string symbol_name,const int ticks = 2);
                    ~CChartData(void);
    //--- Functions to control working with variables
    int              Variables(const ENUM_VARIABLES_FLAGS flag,string &array[],const bool compact_objs = false);
    void             Symbol(const string symbol_name)             {m_symbol_name = symbol_name;    }  // set symbol name
    string           Symbol(void)                                 {return(m_symbol_name);          }  // get symbol name
    void             Tick(SChartTick &value,const int index = 0)  {value = m_ticks[index];         }  // get tick values
    void             TickResize(const int size);
    int              TickSize(void)                               {return(m_ticks_total);          }  // get ticks total
    double           Bid(const int index = 0)                     {return(m_ticks[index].Bid);     }  // get bid tick
    double           Ask(const int index = 0)                     {return(m_ticks[index].Ask);     }  // get ask tick
    int              Spread(const int index = 0)                  {return(m_ticks[index].Spread);  }  // get spread tick
    datetime         Time(const int index = 0)                    {return(m_ticks[index].Time);    }  // get time tick
    void             Update(void);
   };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CChartData::CChartData(void)
   {
   }
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CChartData::CChartData(const string symbol_name,const int ticks = 2) : m_symbol_name(symbol_name), m_ticks_total(ticks)
   {
    ArrayResize(m_ticks,m_ticks_total);
   }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CChartData::~CChartData(void)
   {
   }
//+------------------------------------------------------------------+
//| Setting variables                                                |
//+------------------------------------------------------------------+
int CChartData::Variables(const ENUM_VARIABLES_FLAGS flag,string &array[],const bool compact_objs = false)
   {
    CBase::Variables(flag,array,compact_objs);
    _struct_array(m_ticks);
    return(CBase::Variables(array));
   }
//+------------------------------------------------------------------+
//| Resize ticks array                                               |
//+------------------------------------------------------------------+
void CChartData::TickResize(const int size)
   {
    m_ticks_total = size;
    ArrayResize(m_ticks,m_ticks_total);
   }
//+------------------------------------------------------------------+
//| Update data                                                      |
//+------------------------------------------------------------------+
void CChartData::Update(void)
   {
    for(int i = m_ticks_total - 1;i > 0;i--)
       {
        m_ticks[i] = m_ticks[i - 1];
       }
    m_ticks[0].Bid = SymbolInfoDouble(m_symbol_name,SYMBOL_BID);
    m_ticks[0].Ask = SymbolInfoDouble(m_symbol_name,SYMBOL_ASK);
    m_ticks[0].Spread = (int)SymbolInfoInteger(m_symbol_name,SYMBOL_SPREAD);
    m_ticks[0].Time = (datetime)SymbolInfoInteger(m_symbol_name,SYMBOL_TIME);
   }
//+------------------------------------------------------------------+
