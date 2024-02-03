//+------------------------------------------------------------------+

//|                                                      PinBars.mq4 |

//|                                               Krzysztof Kamiński |

//|                                      https://www.QuantTrader.pl/ |

//+------------------------------------------------------------------+

#property copyright "Krzysztof Kamiński"

#property link      "https://www.QuantTrader.pl/"

#property version   "1.00"

#property strict

#property indicator_chart_window

//+------------------------------------------------------------------+

//| Custom indicator initialization function                         |

//+------------------------------------------------------------------+

int OnInit()

  {

//--- indicator buffers mapping



//---

   return(INIT_SUCCEEDED);

  }

 void OnDeinit(const int reason)

   {

    ObjectsDeleteAll(0,OBJ_ARROW);

   }

//+------------------------------------------------------------------+

//| Custom indicator iteration function                              |

//+------------------------------------------------------------------+

int OnCalculate(const int rates_total,

                const int prev_calculated,

                const datetime &time[],

                const double &open[],

                const double &high[],

                const double &low[],

                const double &close[],

                const long &tick_volume[],

                const long &volume[],

                const int &spread[])

  {

//---

//down_shade>corps_height*2 && up_shade<corps_height (up PinBar)

//up_shade>corps_height*2 && down_shade <corps_height (down PinBar)

   double down_shade =0.0;

   double up_shade =0.0;

   double corps_height =0.0;

   bool up_candle;

   for(int i=1; i<Bars; i++)

     {

      up_candle =Close[i]>Open[i];

      if(up_candle)

        {

         down_shade =Open[i]-Low[i];

         up_shade =High[i]-Close[i];

         corps_height =Close[i]-Open[i];

        }

      else

        {

         down_shade =Open[i]-Low[i];

         up_shade =High[i]-Close[i];

         corps_height =Open[i]-Close[i];

        }

      if(down_shade> corps_height*2 && up_shade <corps_height)

         ObjectCreate("PinBarUp "+IntegerToString(i),OBJ_ARROW_UP,0,Time[i],Low[i]);

      else

         if(up_shade> corps_height*2 && down_shade <corps_height)

            ObjectCreate("PinBarDown "+IntegerToString(i),OBJ_ARROW_DOWN,0,Time[i],High[i]);

     }

//--- return value of prev_calculated for next call

   return(rates_total);

  }

//+------------------------------------------------------------------+

